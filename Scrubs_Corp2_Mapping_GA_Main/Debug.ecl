+++Line:325:RIDField is now compulsory for full adl matching!!!
// Various routines to assist in debugging
 
IMPORT SALT34,ut,std;
EXPORT Debug(DATASET(layout_in_file) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  unsigned6 left_dt_vendor_first_reported;
  INTEGER1 dt_vendor_first_reported_year_match_code;
  INTEGER1 dt_vendor_first_reported_month_match_code;
  INTEGER1 dt_vendor_first_reported_day_match_code;
  INTEGER1 dt_vendor_first_reported_match_code;
  INTEGER2 dt_vendor_first_reported_score;
  unsigned6 right_dt_vendor_first_reported;
  unsigned6 left_dt_vendor_last_reported;
  INTEGER1 dt_vendor_last_reported_year_match_code;
  INTEGER1 dt_vendor_last_reported_month_match_code;
  INTEGER1 dt_vendor_last_reported_day_match_code;
  INTEGER1 dt_vendor_last_reported_match_code;
  INTEGER2 dt_vendor_last_reported_score;
  unsigned6 right_dt_vendor_last_reported;
  unsigned6 left_dt_first_seen;
  INTEGER1 dt_first_seen_year_match_code;
  INTEGER1 dt_first_seen_month_match_code;
  INTEGER1 dt_first_seen_day_match_code;
  INTEGER1 dt_first_seen_match_code;
  INTEGER2 dt_first_seen_score;
  unsigned6 right_dt_first_seen;
  unsigned6 left_dt_last_seen;
  INTEGER1 dt_last_seen_year_match_code;
  INTEGER1 dt_last_seen_month_match_code;
  INTEGER1 dt_last_seen_day_match_code;
  INTEGER1 dt_last_seen_match_code;
  INTEGER2 dt_last_seen_score;
  unsigned6 right_dt_last_seen;
  unsigned6 left_corp_ra_dt_first_seen;
  INTEGER1 corp_ra_dt_first_seen_year_match_code;
  INTEGER1 corp_ra_dt_first_seen_month_match_code;
  INTEGER1 corp_ra_dt_first_seen_day_match_code;
  INTEGER1 corp_ra_dt_first_seen_match_code;
  INTEGER2 corp_ra_dt_first_seen_score;
  unsigned6 right_corp_ra_dt_first_seen;
  unsigned6 left_corp_ra_dt_last_seen;
  INTEGER1 corp_ra_dt_last_seen_year_match_code;
  INTEGER1 corp_ra_dt_last_seen_month_match_code;
  INTEGER1 corp_ra_dt_last_seen_day_match_code;
  INTEGER1 corp_ra_dt_last_seen_match_code;
  INTEGER2 corp_ra_dt_last_seen_score;
  unsigned6 right_corp_ra_dt_last_seen;
  TYPEOF(h.corp_key) left_corp_key;
  INTEGER1 corp_key_match_code;
  INTEGER2 corp_key_score;
  TYPEOF(h.corp_key) right_corp_key;
  TYPEOF(h.corp_supp_key) left_corp_supp_key;
  INTEGER1 corp_supp_key_match_code;
  INTEGER2 corp_supp_key_score;
  TYPEOF(h.corp_supp_key) right_corp_supp_key;
  TYPEOF(h.corp_vendor) left_corp_vendor;
  INTEGER1 corp_vendor_match_code;
  INTEGER2 corp_vendor_score;
  TYPEOF(h.corp_vendor) right_corp_vendor;
  TYPEOF(h.corp_vendor_county) left_corp_vendor_county;
  INTEGER1 corp_vendor_county_match_code;
  INTEGER2 corp_vendor_county_score;
  TYPEOF(h.corp_vendor_county) right_corp_vendor_county;
  TYPEOF(h.corp_vendor_subcode) left_corp_vendor_subcode;
  INTEGER1 corp_vendor_subcode_match_code;
  INTEGER2 corp_vendor_subcode_score;
  TYPEOF(h.corp_vendor_subcode) right_corp_vendor_subcode;
  TYPEOF(h.corp_state_origin) left_corp_state_origin;
  INTEGER1 corp_state_origin_match_code;
  INTEGER2 corp_state_origin_score;
  TYPEOF(h.corp_state_origin) right_corp_state_origin;
  unsigned6 left_corp_process_date;
  INTEGER1 corp_process_date_year_match_code;
  INTEGER1 corp_process_date_month_match_code;
  INTEGER1 corp_process_date_day_match_code;
  INTEGER1 corp_process_date_match_code;
  INTEGER2 corp_process_date_score;
  unsigned6 right_corp_process_date;
  TYPEOF(h.corp_orig_sos_charter_nbr) left_corp_orig_sos_charter_nbr;
  INTEGER1 corp_orig_sos_charter_nbr_match_code;
  INTEGER2 corp_orig_sos_charter_nbr_score;
  TYPEOF(h.corp_orig_sos_charter_nbr) right_corp_orig_sos_charter_nbr;
  TYPEOF(h.corp_legal_name) left_corp_legal_name;
  INTEGER1 corp_legal_name_match_code;
  INTEGER2 corp_legal_name_score;
  TYPEOF(h.corp_legal_name) right_corp_legal_name;
  TYPEOF(h.corp_ln_name_type_cd) left_corp_ln_name_type_cd;
  INTEGER1 corp_ln_name_type_cd_match_code;
  INTEGER2 corp_ln_name_type_cd_score;
  TYPEOF(h.corp_ln_name_type_cd) right_corp_ln_name_type_cd;
  TYPEOF(h.corp_ln_name_type_desc) left_corp_ln_name_type_desc;
  INTEGER1 corp_ln_name_type_desc_match_code;
  INTEGER2 corp_ln_name_type_desc_score;
  TYPEOF(h.corp_ln_name_type_desc) right_corp_ln_name_type_desc;
  TYPEOF(h.corp_supp_nbr) left_corp_supp_nbr;
  INTEGER1 corp_supp_nbr_match_code;
  INTEGER2 corp_supp_nbr_score;
  TYPEOF(h.corp_supp_nbr) right_corp_supp_nbr;
  TYPEOF(h.corp_name_comment) left_corp_name_comment;
  INTEGER1 corp_name_comment_match_code;
  INTEGER2 corp_name_comment_score;
  TYPEOF(h.corp_name_comment) right_corp_name_comment;
  TYPEOF(h.corp_address1_type_cd) left_corp_address1_type_cd;
  INTEGER1 corp_address1_type_cd_match_code;
  INTEGER2 corp_address1_type_cd_score;
  TYPEOF(h.corp_address1_type_cd) right_corp_address1_type_cd;
  TYPEOF(h.corp_address1_type_desc) left_corp_address1_type_desc;
  INTEGER1 corp_address1_type_desc_match_code;
  INTEGER2 corp_address1_type_desc_score;
  TYPEOF(h.corp_address1_type_desc) right_corp_address1_type_desc;
  TYPEOF(h.corp_address1_line1) left_corp_address1_line1;
  INTEGER1 corp_address1_line1_match_code;
  INTEGER2 corp_address1_line1_score;
  TYPEOF(h.corp_address1_line1) right_corp_address1_line1;
  TYPEOF(h.corp_address1_line2) left_corp_address1_line2;
  INTEGER1 corp_address1_line2_match_code;
  INTEGER2 corp_address1_line2_score;
  TYPEOF(h.corp_address1_line2) right_corp_address1_line2;
  TYPEOF(h.corp_address1_line3) left_corp_address1_line3;
  INTEGER1 corp_address1_line3_match_code;
  INTEGER2 corp_address1_line3_score;
  TYPEOF(h.corp_address1_line3) right_corp_address1_line3;
  TYPEOF(h.corp_address1_effective_date) left_corp_address1_effective_date;
  INTEGER1 corp_address1_effective_date_match_code;
  INTEGER2 corp_address1_effective_date_score;
  TYPEOF(h.corp_address1_effective_date) right_corp_address1_effective_date;
  TYPEOF(h.corp_address2_type_cd) left_corp_address2_type_cd;
  INTEGER1 corp_address2_type_cd_match_code;
  INTEGER2 corp_address2_type_cd_score;
  TYPEOF(h.corp_address2_type_cd) right_corp_address2_type_cd;
  TYPEOF(h.corp_address2_type_desc) left_corp_address2_type_desc;
  INTEGER1 corp_address2_type_desc_match_code;
  INTEGER2 corp_address2_type_desc_score;
  TYPEOF(h.corp_address2_type_desc) right_corp_address2_type_desc;
  TYPEOF(h.corp_address2_line1) left_corp_address2_line1;
  INTEGER1 corp_address2_line1_match_code;
  INTEGER2 corp_address2_line1_score;
  TYPEOF(h.corp_address2_line1) right_corp_address2_line1;
  TYPEOF(h.corp_address2_line2) left_corp_address2_line2;
  INTEGER1 corp_address2_line2_match_code;
  INTEGER2 corp_address2_line2_score;
  TYPEOF(h.corp_address2_line2) right_corp_address2_line2;
  TYPEOF(h.corp_address2_line3) left_corp_address2_line3;
  INTEGER1 corp_address2_line3_match_code;
  INTEGER2 corp_address2_line3_score;
  TYPEOF(h.corp_address2_line3) right_corp_address2_line3;
  TYPEOF(h.corp_address2_effective_date) left_corp_address2_effective_date;
  INTEGER1 corp_address2_effective_date_match_code;
  INTEGER2 corp_address2_effective_date_score;
  TYPEOF(h.corp_address2_effective_date) right_corp_address2_effective_date;
  TYPEOF(h.corp_phone_number) left_corp_phone_number;
  INTEGER1 corp_phone_number_match_code;
  INTEGER2 corp_phone_number_score;
  TYPEOF(h.corp_phone_number) right_corp_phone_number;
  TYPEOF(h.corp_phone_number_type_cd) left_corp_phone_number_type_cd;
  INTEGER1 corp_phone_number_type_cd_match_code;
  INTEGER2 corp_phone_number_type_cd_score;
  TYPEOF(h.corp_phone_number_type_cd) right_corp_phone_number_type_cd;
  TYPEOF(h.corp_phone_number_type_desc) left_corp_phone_number_type_desc;
  INTEGER1 corp_phone_number_type_desc_match_code;
  INTEGER2 corp_phone_number_type_desc_score;
  TYPEOF(h.corp_phone_number_type_desc) right_corp_phone_number_type_desc;
  TYPEOF(h.corp_fax_nbr) left_corp_fax_nbr;
  INTEGER1 corp_fax_nbr_match_code;
  INTEGER2 corp_fax_nbr_score;
  TYPEOF(h.corp_fax_nbr) right_corp_fax_nbr;
  TYPEOF(h.corp_email_address) left_corp_email_address;
  INTEGER1 corp_email_address_match_code;
  INTEGER2 corp_email_address_score;
  TYPEOF(h.corp_email_address) right_corp_email_address;
  TYPEOF(h.corp_web_address) left_corp_web_address;
  INTEGER1 corp_web_address_match_code;
  INTEGER2 corp_web_address_score;
  TYPEOF(h.corp_web_address) right_corp_web_address;
  TYPEOF(h.corp_filing_reference_nbr) left_corp_filing_reference_nbr;
  INTEGER1 corp_filing_reference_nbr_match_code;
  INTEGER2 corp_filing_reference_nbr_score;
  TYPEOF(h.corp_filing_reference_nbr) right_corp_filing_reference_nbr;
  TYPEOF(h.corp_filing_date) left_corp_filing_date;
  INTEGER1 corp_filing_date_match_code;
  INTEGER2 corp_filing_date_score;
  TYPEOF(h.corp_filing_date) right_corp_filing_date;
  TYPEOF(h.corp_filing_cd) left_corp_filing_cd;
  INTEGER1 corp_filing_cd_match_code;
  INTEGER2 corp_filing_cd_score;
  TYPEOF(h.corp_filing_cd) right_corp_filing_cd;
  TYPEOF(h.corp_filing_desc) left_corp_filing_desc;
  INTEGER1 corp_filing_desc_match_code;
  INTEGER2 corp_filing_desc_score;
  TYPEOF(h.corp_filing_desc) right_corp_filing_desc;
  TYPEOF(h.corp_status_cd) left_corp_status_cd;
  INTEGER1 corp_status_cd_match_code;
  INTEGER2 corp_status_cd_score;
  TYPEOF(h.corp_status_cd) right_corp_status_cd;
  TYPEOF(h.corp_status_desc) left_corp_status_desc;
  INTEGER1 corp_status_desc_match_code;
  INTEGER2 corp_status_desc_score;
  TYPEOF(h.corp_status_desc) right_corp_status_desc;
  TYPEOF(h.corp_status_date) left_corp_status_date;
  INTEGER1 corp_status_date_match_code;
  INTEGER2 corp_status_date_score;
  TYPEOF(h.corp_status_date) right_corp_status_date;
  TYPEOF(h.corp_standing) left_corp_standing;
  INTEGER1 corp_standing_match_code;
  INTEGER2 corp_standing_score;
  TYPEOF(h.corp_standing) right_corp_standing;
  TYPEOF(h.corp_status_comment) left_corp_status_comment;
  INTEGER1 corp_status_comment_match_code;
  INTEGER2 corp_status_comment_score;
  TYPEOF(h.corp_status_comment) right_corp_status_comment;
  TYPEOF(h.corp_ticker_symbol) left_corp_ticker_symbol;
  INTEGER1 corp_ticker_symbol_match_code;
  INTEGER2 corp_ticker_symbol_score;
  TYPEOF(h.corp_ticker_symbol) right_corp_ticker_symbol;
  TYPEOF(h.corp_stock_exchange) left_corp_stock_exchange;
  INTEGER1 corp_stock_exchange_match_code;
  INTEGER2 corp_stock_exchange_score;
  TYPEOF(h.corp_stock_exchange) right_corp_stock_exchange;
  TYPEOF(h.corp_inc_state) left_corp_inc_state;
  INTEGER1 corp_inc_state_match_code;
  INTEGER2 corp_inc_state_score;
  TYPEOF(h.corp_inc_state) right_corp_inc_state;
  TYPEOF(h.corp_inc_county) left_corp_inc_county;
  INTEGER1 corp_inc_county_match_code;
  INTEGER2 corp_inc_county_score;
  TYPEOF(h.corp_inc_county) right_corp_inc_county;
  TYPEOF(h.corp_inc_date) left_corp_inc_date;
  INTEGER1 corp_inc_date_match_code;
  INTEGER2 corp_inc_date_score;
  TYPEOF(h.corp_inc_date) right_corp_inc_date;
  TYPEOF(h.corp_anniversary_month) left_corp_anniversary_month;
  INTEGER1 corp_anniversary_month_match_code;
  INTEGER2 corp_anniversary_month_score;
  TYPEOF(h.corp_anniversary_month) right_corp_anniversary_month;
  TYPEOF(h.corp_fed_tax_id) left_corp_fed_tax_id;
  INTEGER1 corp_fed_tax_id_match_code;
  INTEGER2 corp_fed_tax_id_score;
  TYPEOF(h.corp_fed_tax_id) right_corp_fed_tax_id;
  TYPEOF(h.corp_state_tax_id) left_corp_state_tax_id;
  INTEGER1 corp_state_tax_id_match_code;
  INTEGER2 corp_state_tax_id_score;
  TYPEOF(h.corp_state_tax_id) right_corp_state_tax_id;
  TYPEOF(h.corp_term_exist_cd) left_corp_term_exist_cd;
  INTEGER1 corp_term_exist_cd_match_code;
  INTEGER2 corp_term_exist_cd_score;
  TYPEOF(h.corp_term_exist_cd) right_corp_term_exist_cd;
  TYPEOF(h.corp_term_exist_exp) left_corp_term_exist_exp;
  INTEGER1 corp_term_exist_exp_match_code;
  INTEGER2 corp_term_exist_exp_score;
  TYPEOF(h.corp_term_exist_exp) right_corp_term_exist_exp;
  TYPEOF(h.corp_term_exist_desc) left_corp_term_exist_desc;
  INTEGER1 corp_term_exist_desc_match_code;
  INTEGER2 corp_term_exist_desc_score;
  TYPEOF(h.corp_term_exist_desc) right_corp_term_exist_desc;
  TYPEOF(h.corp_foreign_domestic_ind) left_corp_foreign_domestic_ind;
  INTEGER1 corp_foreign_domestic_ind_match_code;
  INTEGER2 corp_foreign_domestic_ind_score;
  TYPEOF(h.corp_foreign_domestic_ind) right_corp_foreign_domestic_ind;
  TYPEOF(h.corp_forgn_state_cd) left_corp_forgn_state_cd;
  INTEGER1 corp_forgn_state_cd_match_code;
  INTEGER2 corp_forgn_state_cd_score;
  TYPEOF(h.corp_forgn_state_cd) right_corp_forgn_state_cd;
  TYPEOF(h.corp_forgn_state_desc) left_corp_forgn_state_desc;
  INTEGER1 corp_forgn_state_desc_match_code;
  INTEGER2 corp_forgn_state_desc_score;
  TYPEOF(h.corp_forgn_state_desc) right_corp_forgn_state_desc;
  TYPEOF(h.corp_forgn_sos_charter_nbr) left_corp_forgn_sos_charter_nbr;
  INTEGER1 corp_forgn_sos_charter_nbr_match_code;
  INTEGER2 corp_forgn_sos_charter_nbr_score;
  TYPEOF(h.corp_forgn_sos_charter_nbr) right_corp_forgn_sos_charter_nbr;
  TYPEOF(h.corp_forgn_date) left_corp_forgn_date;
  INTEGER1 corp_forgn_date_match_code;
  INTEGER2 corp_forgn_date_score;
  TYPEOF(h.corp_forgn_date) right_corp_forgn_date;
  TYPEOF(h.corp_forgn_fed_tax_id) left_corp_forgn_fed_tax_id;
  INTEGER1 corp_forgn_fed_tax_id_match_code;
  INTEGER2 corp_forgn_fed_tax_id_score;
  TYPEOF(h.corp_forgn_fed_tax_id) right_corp_forgn_fed_tax_id;
  TYPEOF(h.corp_forgn_state_tax_id) left_corp_forgn_state_tax_id;
  INTEGER1 corp_forgn_state_tax_id_match_code;
  INTEGER2 corp_forgn_state_tax_id_score;
  TYPEOF(h.corp_forgn_state_tax_id) right_corp_forgn_state_tax_id;
  TYPEOF(h.corp_forgn_term_exist_cd) left_corp_forgn_term_exist_cd;
  INTEGER1 corp_forgn_term_exist_cd_match_code;
  INTEGER2 corp_forgn_term_exist_cd_score;
  TYPEOF(h.corp_forgn_term_exist_cd) right_corp_forgn_term_exist_cd;
  TYPEOF(h.corp_forgn_term_exist_exp) left_corp_forgn_term_exist_exp;
  INTEGER1 corp_forgn_term_exist_exp_match_code;
  INTEGER2 corp_forgn_term_exist_exp_score;
  TYPEOF(h.corp_forgn_term_exist_exp) right_corp_forgn_term_exist_exp;
  TYPEOF(h.corp_forgn_term_exist_desc) left_corp_forgn_term_exist_desc;
  INTEGER1 corp_forgn_term_exist_desc_match_code;
  INTEGER2 corp_forgn_term_exist_desc_score;
  TYPEOF(h.corp_forgn_term_exist_desc) right_corp_forgn_term_exist_desc;
  TYPEOF(h.corp_orig_org_structure_cd) left_corp_orig_org_structure_cd;
  INTEGER1 corp_orig_org_structure_cd_match_code;
  INTEGER2 corp_orig_org_structure_cd_score;
  TYPEOF(h.corp_orig_org_structure_cd) right_corp_orig_org_structure_cd;
  TYPEOF(h.corp_orig_org_structure_desc) left_corp_orig_org_structure_desc;
  INTEGER1 corp_orig_org_structure_desc_match_code;
  INTEGER2 corp_orig_org_structure_desc_score;
  TYPEOF(h.corp_orig_org_structure_desc) right_corp_orig_org_structure_desc;
  TYPEOF(h.corp_for_profit_ind) left_corp_for_profit_ind;
  INTEGER1 corp_for_profit_ind_match_code;
  INTEGER2 corp_for_profit_ind_score;
  TYPEOF(h.corp_for_profit_ind) right_corp_for_profit_ind;
  TYPEOF(h.corp_public_or_private_ind) left_corp_public_or_private_ind;
  INTEGER1 corp_public_or_private_ind_match_code;
  INTEGER2 corp_public_or_private_ind_score;
  TYPEOF(h.corp_public_or_private_ind) right_corp_public_or_private_ind;
  TYPEOF(h.corp_sic_code) left_corp_sic_code;
  INTEGER1 corp_sic_code_match_code;
  INTEGER2 corp_sic_code_score;
  TYPEOF(h.corp_sic_code) right_corp_sic_code;
  TYPEOF(h.corp_naic_code) left_corp_naic_code;
  INTEGER1 corp_naic_code_match_code;
  INTEGER2 corp_naic_code_score;
  TYPEOF(h.corp_naic_code) right_corp_naic_code;
  TYPEOF(h.corp_orig_bus_type_cd) left_corp_orig_bus_type_cd;
  INTEGER1 corp_orig_bus_type_cd_match_code;
  INTEGER2 corp_orig_bus_type_cd_score;
  TYPEOF(h.corp_orig_bus_type_cd) right_corp_orig_bus_type_cd;
  TYPEOF(h.corp_orig_bus_type_desc) left_corp_orig_bus_type_desc;
  INTEGER1 corp_orig_bus_type_desc_match_code;
  INTEGER2 corp_orig_bus_type_desc_score;
  TYPEOF(h.corp_orig_bus_type_desc) right_corp_orig_bus_type_desc;
  TYPEOF(h.corp_entity_desc) left_corp_entity_desc;
  INTEGER1 corp_entity_desc_match_code;
  INTEGER2 corp_entity_desc_score;
  TYPEOF(h.corp_entity_desc) right_corp_entity_desc;
  TYPEOF(h.corp_certificate_nbr) left_corp_certificate_nbr;
  INTEGER1 corp_certificate_nbr_match_code;
  INTEGER2 corp_certificate_nbr_score;
  TYPEOF(h.corp_certificate_nbr) right_corp_certificate_nbr;
  TYPEOF(h.corp_internal_nbr) left_corp_internal_nbr;
  INTEGER1 corp_internal_nbr_match_code;
  INTEGER2 corp_internal_nbr_score;
  TYPEOF(h.corp_internal_nbr) right_corp_internal_nbr;
  TYPEOF(h.corp_previous_nbr) left_corp_previous_nbr;
  INTEGER1 corp_previous_nbr_match_code;
  INTEGER2 corp_previous_nbr_score;
  TYPEOF(h.corp_previous_nbr) right_corp_previous_nbr;
  TYPEOF(h.corp_microfilm_nbr) left_corp_microfilm_nbr;
  INTEGER1 corp_microfilm_nbr_match_code;
  INTEGER2 corp_microfilm_nbr_score;
  TYPEOF(h.corp_microfilm_nbr) right_corp_microfilm_nbr;
  TYPEOF(h.corp_amendments_filed) left_corp_amendments_filed;
  INTEGER1 corp_amendments_filed_match_code;
  INTEGER2 corp_amendments_filed_score;
  TYPEOF(h.corp_amendments_filed) right_corp_amendments_filed;
  TYPEOF(h.corp_acts) left_corp_acts;
  INTEGER1 corp_acts_match_code;
  INTEGER2 corp_acts_score;
  TYPEOF(h.corp_acts) right_corp_acts;
  TYPEOF(h.corp_partnership_ind) left_corp_partnership_ind;
  INTEGER1 corp_partnership_ind_match_code;
  INTEGER2 corp_partnership_ind_score;
  TYPEOF(h.corp_partnership_ind) right_corp_partnership_ind;
  TYPEOF(h.corp_mfg_ind) left_corp_mfg_ind;
  INTEGER1 corp_mfg_ind_match_code;
  INTEGER2 corp_mfg_ind_score;
  TYPEOF(h.corp_mfg_ind) right_corp_mfg_ind;
  TYPEOF(h.corp_addl_info) left_corp_addl_info;
  INTEGER1 corp_addl_info_match_code;
  INTEGER2 corp_addl_info_score;
  TYPEOF(h.corp_addl_info) right_corp_addl_info;
  TYPEOF(h.corp_taxes) left_corp_taxes;
  INTEGER1 corp_taxes_match_code;
  INTEGER2 corp_taxes_score;
  TYPEOF(h.corp_taxes) right_corp_taxes;
  TYPEOF(h.corp_franchise_taxes) left_corp_franchise_taxes;
  INTEGER1 corp_franchise_taxes_match_code;
  INTEGER2 corp_franchise_taxes_score;
  TYPEOF(h.corp_franchise_taxes) right_corp_franchise_taxes;
  TYPEOF(h.corp_tax_program_cd) left_corp_tax_program_cd;
  INTEGER1 corp_tax_program_cd_match_code;
  INTEGER2 corp_tax_program_cd_score;
  TYPEOF(h.corp_tax_program_cd) right_corp_tax_program_cd;
  TYPEOF(h.corp_tax_program_desc) left_corp_tax_program_desc;
  INTEGER1 corp_tax_program_desc_match_code;
  INTEGER2 corp_tax_program_desc_score;
  TYPEOF(h.corp_tax_program_desc) right_corp_tax_program_desc;
  TYPEOF(h.corp_ra_full_name) left_corp_ra_full_name;
  INTEGER1 corp_ra_full_name_match_code;
  INTEGER2 corp_ra_full_name_score;
  TYPEOF(h.corp_ra_full_name) right_corp_ra_full_name;
  TYPEOF(h.corp_ra_fname) left_corp_ra_fname;
  INTEGER1 corp_ra_fname_match_code;
  INTEGER2 corp_ra_fname_score;
  TYPEOF(h.corp_ra_fname) right_corp_ra_fname;
  TYPEOF(h.corp_ra_mname) left_corp_ra_mname;
  INTEGER1 corp_ra_mname_match_code;
  INTEGER2 corp_ra_mname_score;
  TYPEOF(h.corp_ra_mname) right_corp_ra_mname;
  TYPEOF(h.corp_ra_lname) left_corp_ra_lname;
  INTEGER1 corp_ra_lname_match_code;
  INTEGER2 corp_ra_lname_score;
  TYPEOF(h.corp_ra_lname) right_corp_ra_lname;
  TYPEOF(h.corp_ra_suffix) left_corp_ra_suffix;
  INTEGER1 corp_ra_suffix_match_code;
  INTEGER2 corp_ra_suffix_score;
  TYPEOF(h.corp_ra_suffix) right_corp_ra_suffix;
  TYPEOF(h.corp_ra_title_cd) left_corp_ra_title_cd;
  INTEGER1 corp_ra_title_cd_match_code;
  INTEGER2 corp_ra_title_cd_score;
  TYPEOF(h.corp_ra_title_cd) right_corp_ra_title_cd;
  TYPEOF(h.corp_ra_title_desc) left_corp_ra_title_desc;
  INTEGER1 corp_ra_title_desc_match_code;
  INTEGER2 corp_ra_title_desc_score;
  TYPEOF(h.corp_ra_title_desc) right_corp_ra_title_desc;
  TYPEOF(h.corp_ra_fein) left_corp_ra_fein;
  INTEGER1 corp_ra_fein_match_code;
  INTEGER2 corp_ra_fein_score;
  TYPEOF(h.corp_ra_fein) right_corp_ra_fein;
  TYPEOF(h.corp_ra_ssn) left_corp_ra_ssn;
  INTEGER1 corp_ra_ssn_match_code;
  INTEGER2 corp_ra_ssn_score;
  TYPEOF(h.corp_ra_ssn) right_corp_ra_ssn;
  TYPEOF(h.corp_ra_dob) left_corp_ra_dob;
  INTEGER1 corp_ra_dob_match_code;
  INTEGER2 corp_ra_dob_score;
  TYPEOF(h.corp_ra_dob) right_corp_ra_dob;
  TYPEOF(h.corp_ra_effective_date) left_corp_ra_effective_date;
  INTEGER1 corp_ra_effective_date_match_code;
  INTEGER2 corp_ra_effective_date_score;
  TYPEOF(h.corp_ra_effective_date) right_corp_ra_effective_date;
  TYPEOF(h.corp_ra_resign_date) left_corp_ra_resign_date;
  INTEGER1 corp_ra_resign_date_match_code;
  INTEGER2 corp_ra_resign_date_score;
  TYPEOF(h.corp_ra_resign_date) right_corp_ra_resign_date;
  TYPEOF(h.corp_ra_no_comp) left_corp_ra_no_comp;
  INTEGER1 corp_ra_no_comp_match_code;
  INTEGER2 corp_ra_no_comp_score;
  TYPEOF(h.corp_ra_no_comp) right_corp_ra_no_comp;
  TYPEOF(h.corp_ra_no_comp_igs) left_corp_ra_no_comp_igs;
  INTEGER1 corp_ra_no_comp_igs_match_code;
  INTEGER2 corp_ra_no_comp_igs_score;
  TYPEOF(h.corp_ra_no_comp_igs) right_corp_ra_no_comp_igs;
  TYPEOF(h.corp_ra_addl_info) left_corp_ra_addl_info;
  INTEGER1 corp_ra_addl_info_match_code;
  INTEGER2 corp_ra_addl_info_score;
  TYPEOF(h.corp_ra_addl_info) right_corp_ra_addl_info;
  TYPEOF(h.corp_ra_address_type_cd) left_corp_ra_address_type_cd;
  INTEGER1 corp_ra_address_type_cd_match_code;
  INTEGER2 corp_ra_address_type_cd_score;
  TYPEOF(h.corp_ra_address_type_cd) right_corp_ra_address_type_cd;
  TYPEOF(h.corp_ra_address_type_desc) left_corp_ra_address_type_desc;
  INTEGER1 corp_ra_address_type_desc_match_code;
  INTEGER2 corp_ra_address_type_desc_score;
  TYPEOF(h.corp_ra_address_type_desc) right_corp_ra_address_type_desc;
  TYPEOF(h.corp_ra_address_line1) left_corp_ra_address_line1;
  INTEGER1 corp_ra_address_line1_match_code;
  INTEGER2 corp_ra_address_line1_score;
  TYPEOF(h.corp_ra_address_line1) right_corp_ra_address_line1;
  TYPEOF(h.corp_ra_address_line2) left_corp_ra_address_line2;
  INTEGER1 corp_ra_address_line2_match_code;
  INTEGER2 corp_ra_address_line2_score;
  TYPEOF(h.corp_ra_address_line2) right_corp_ra_address_line2;
  TYPEOF(h.corp_ra_address_line3) left_corp_ra_address_line3;
  INTEGER1 corp_ra_address_line3_match_code;
  INTEGER2 corp_ra_address_line3_score;
  TYPEOF(h.corp_ra_address_line3) right_corp_ra_address_line3;
  TYPEOF(h.corp_ra_phone_number) left_corp_ra_phone_number;
  INTEGER1 corp_ra_phone_number_match_code;
  INTEGER2 corp_ra_phone_number_score;
  TYPEOF(h.corp_ra_phone_number) right_corp_ra_phone_number;
  TYPEOF(h.corp_ra_phone_number_type_cd) left_corp_ra_phone_number_type_cd;
  INTEGER1 corp_ra_phone_number_type_cd_match_code;
  INTEGER2 corp_ra_phone_number_type_cd_score;
  TYPEOF(h.corp_ra_phone_number_type_cd) right_corp_ra_phone_number_type_cd;
  TYPEOF(h.corp_ra_phone_number_type_desc) left_corp_ra_phone_number_type_desc;
  INTEGER1 corp_ra_phone_number_type_desc_match_code;
  INTEGER2 corp_ra_phone_number_type_desc_score;
  TYPEOF(h.corp_ra_phone_number_type_desc) right_corp_ra_phone_number_type_desc;
  TYPEOF(h.corp_ra_fax_nbr) left_corp_ra_fax_nbr;
  INTEGER1 corp_ra_fax_nbr_match_code;
  INTEGER2 corp_ra_fax_nbr_score;
  TYPEOF(h.corp_ra_fax_nbr) right_corp_ra_fax_nbr;
  TYPEOF(h.corp_ra_email_address) left_corp_ra_email_address;
  INTEGER1 corp_ra_email_address_match_code;
  INTEGER2 corp_ra_email_address_score;
  TYPEOF(h.corp_ra_email_address) right_corp_ra_email_address;
  TYPEOF(h.corp_ra_web_address) left_corp_ra_web_address;
  INTEGER1 corp_ra_web_address_match_code;
  INTEGER2 corp_ra_web_address_score;
  TYPEOF(h.corp_ra_web_address) right_corp_ra_web_address;
  TYPEOF(h.corp_prep_addr1_line1) left_corp_prep_addr1_line1;
  INTEGER1 corp_prep_addr1_line1_match_code;
  INTEGER2 corp_prep_addr1_line1_score;
  TYPEOF(h.corp_prep_addr1_line1) right_corp_prep_addr1_line1;
  TYPEOF(h.corp_prep_addr1_last_line) left_corp_prep_addr1_last_line;
  INTEGER1 corp_prep_addr1_last_line_match_code;
  INTEGER2 corp_prep_addr1_last_line_score;
  TYPEOF(h.corp_prep_addr1_last_line) right_corp_prep_addr1_last_line;
  TYPEOF(h.corp_prep_addr2_line1) left_corp_prep_addr2_line1;
  INTEGER1 corp_prep_addr2_line1_match_code;
  INTEGER2 corp_prep_addr2_line1_score;
  TYPEOF(h.corp_prep_addr2_line1) right_corp_prep_addr2_line1;
  TYPEOF(h.corp_prep_addr2_last_line) left_corp_prep_addr2_last_line;
  INTEGER1 corp_prep_addr2_last_line_match_code;
  INTEGER2 corp_prep_addr2_last_line_score;
  TYPEOF(h.corp_prep_addr2_last_line) right_corp_prep_addr2_last_line;
  TYPEOF(h.ra_prep_addr_line1) left_ra_prep_addr_line1;
  INTEGER1 ra_prep_addr_line1_match_code;
  INTEGER2 ra_prep_addr_line1_score;
  TYPEOF(h.ra_prep_addr_line1) right_ra_prep_addr_line1;
  TYPEOF(h.ra_prep_addr_last_line) left_ra_prep_addr_last_line;
  INTEGER1 ra_prep_addr_last_line_match_code;
  INTEGER2 ra_prep_addr_last_line_score;
  TYPEOF(h.ra_prep_addr_last_line) right_ra_prep_addr_last_line;
  TYPEOF(h.cont_filing_reference_nbr) left_cont_filing_reference_nbr;
  INTEGER1 cont_filing_reference_nbr_match_code;
  INTEGER2 cont_filing_reference_nbr_score;
  TYPEOF(h.cont_filing_reference_nbr) right_cont_filing_reference_nbr;
  TYPEOF(h.cont_filing_date) left_cont_filing_date;
  INTEGER1 cont_filing_date_match_code;
  INTEGER2 cont_filing_date_score;
  TYPEOF(h.cont_filing_date) right_cont_filing_date;
  TYPEOF(h.cont_filing_cd) left_cont_filing_cd;
  INTEGER1 cont_filing_cd_match_code;
  INTEGER2 cont_filing_cd_score;
  TYPEOF(h.cont_filing_cd) right_cont_filing_cd;
  TYPEOF(h.cont_filing_desc) left_cont_filing_desc;
  INTEGER1 cont_filing_desc_match_code;
  INTEGER2 cont_filing_desc_score;
  TYPEOF(h.cont_filing_desc) right_cont_filing_desc;
  TYPEOF(h.cont_type_cd) left_cont_type_cd;
  INTEGER1 cont_type_cd_match_code;
  INTEGER2 cont_type_cd_score;
  TYPEOF(h.cont_type_cd) right_cont_type_cd;
  TYPEOF(h.cont_type_desc) left_cont_type_desc;
  INTEGER1 cont_type_desc_match_code;
  INTEGER2 cont_type_desc_score;
  TYPEOF(h.cont_type_desc) right_cont_type_desc;
  TYPEOF(h.cont_full_name) left_cont_full_name;
  INTEGER1 cont_full_name_match_code;
  INTEGER2 cont_full_name_score;
  TYPEOF(h.cont_full_name) right_cont_full_name;
  TYPEOF(h.cont_fname) left_cont_fname;
  INTEGER1 cont_fname_match_code;
  INTEGER2 cont_fname_score;
  TYPEOF(h.cont_fname) right_cont_fname;
  TYPEOF(h.cont_mname) left_cont_mname;
  INTEGER1 cont_mname_match_code;
  INTEGER2 cont_mname_score;
  TYPEOF(h.cont_mname) right_cont_mname;
  TYPEOF(h.cont_lname) left_cont_lname;
  INTEGER1 cont_lname_match_code;
  INTEGER2 cont_lname_score;
  TYPEOF(h.cont_lname) right_cont_lname;
  TYPEOF(h.cont_suffix) left_cont_suffix;
  INTEGER1 cont_suffix_match_code;
  INTEGER2 cont_suffix_score;
  TYPEOF(h.cont_suffix) right_cont_suffix;
  TYPEOF(h.cont_title1_desc) left_cont_title1_desc;
  INTEGER1 cont_title1_desc_match_code;
  INTEGER2 cont_title1_desc_score;
  TYPEOF(h.cont_title1_desc) right_cont_title1_desc;
  TYPEOF(h.cont_title2_desc) left_cont_title2_desc;
  INTEGER1 cont_title2_desc_match_code;
  INTEGER2 cont_title2_desc_score;
  TYPEOF(h.cont_title2_desc) right_cont_title2_desc;
  TYPEOF(h.cont_title3_desc) left_cont_title3_desc;
  INTEGER1 cont_title3_desc_match_code;
  INTEGER2 cont_title3_desc_score;
  TYPEOF(h.cont_title3_desc) right_cont_title3_desc;
  TYPEOF(h.cont_title4_desc) left_cont_title4_desc;
  INTEGER1 cont_title4_desc_match_code;
  INTEGER2 cont_title4_desc_score;
  TYPEOF(h.cont_title4_desc) right_cont_title4_desc;
  TYPEOF(h.cont_title5_desc) left_cont_title5_desc;
  INTEGER1 cont_title5_desc_match_code;
  INTEGER2 cont_title5_desc_score;
  TYPEOF(h.cont_title5_desc) right_cont_title5_desc;
  TYPEOF(h.cont_fein) left_cont_fein;
  INTEGER1 cont_fein_match_code;
  INTEGER2 cont_fein_score;
  TYPEOF(h.cont_fein) right_cont_fein;
  TYPEOF(h.cont_ssn) left_cont_ssn;
  INTEGER1 cont_ssn_match_code;
  INTEGER2 cont_ssn_score;
  TYPEOF(h.cont_ssn) right_cont_ssn;
  TYPEOF(h.cont_dob) left_cont_dob;
  INTEGER1 cont_dob_match_code;
  INTEGER2 cont_dob_score;
  TYPEOF(h.cont_dob) right_cont_dob;
  TYPEOF(h.cont_status_cd) left_cont_status_cd;
  INTEGER1 cont_status_cd_match_code;
  INTEGER2 cont_status_cd_score;
  TYPEOF(h.cont_status_cd) right_cont_status_cd;
  TYPEOF(h.cont_status_desc) left_cont_status_desc;
  INTEGER1 cont_status_desc_match_code;
  INTEGER2 cont_status_desc_score;
  TYPEOF(h.cont_status_desc) right_cont_status_desc;
  TYPEOF(h.cont_effective_date) left_cont_effective_date;
  INTEGER1 cont_effective_date_match_code;
  INTEGER2 cont_effective_date_score;
  TYPEOF(h.cont_effective_date) right_cont_effective_date;
  TYPEOF(h.cont_effective_cd) left_cont_effective_cd;
  INTEGER1 cont_effective_cd_match_code;
  INTEGER2 cont_effective_cd_score;
  TYPEOF(h.cont_effective_cd) right_cont_effective_cd;
  TYPEOF(h.cont_effective_desc) left_cont_effective_desc;
  INTEGER1 cont_effective_desc_match_code;
  INTEGER2 cont_effective_desc_score;
  TYPEOF(h.cont_effective_desc) right_cont_effective_desc;
  TYPEOF(h.cont_addl_info) left_cont_addl_info;
  INTEGER1 cont_addl_info_match_code;
  INTEGER2 cont_addl_info_score;
  TYPEOF(h.cont_addl_info) right_cont_addl_info;
  TYPEOF(h.cont_address_type_cd) left_cont_address_type_cd;
  INTEGER1 cont_address_type_cd_match_code;
  INTEGER2 cont_address_type_cd_score;
  TYPEOF(h.cont_address_type_cd) right_cont_address_type_cd;
  TYPEOF(h.cont_address_type_desc) left_cont_address_type_desc;
  INTEGER1 cont_address_type_desc_match_code;
  INTEGER2 cont_address_type_desc_score;
  TYPEOF(h.cont_address_type_desc) right_cont_address_type_desc;
  TYPEOF(h.cont_address_line1) left_cont_address_line1;
  INTEGER1 cont_address_line1_match_code;
  INTEGER2 cont_address_line1_score;
  TYPEOF(h.cont_address_line1) right_cont_address_line1;
  TYPEOF(h.cont_address_line2) left_cont_address_line2;
  INTEGER1 cont_address_line2_match_code;
  INTEGER2 cont_address_line2_score;
  TYPEOF(h.cont_address_line2) right_cont_address_line2;
  TYPEOF(h.cont_address_line3) left_cont_address_line3;
  INTEGER1 cont_address_line3_match_code;
  INTEGER2 cont_address_line3_score;
  TYPEOF(h.cont_address_line3) right_cont_address_line3;
  TYPEOF(h.cont_address_effective_date) left_cont_address_effective_date;
  INTEGER1 cont_address_effective_date_match_code;
  INTEGER2 cont_address_effective_date_score;
  TYPEOF(h.cont_address_effective_date) right_cont_address_effective_date;
  TYPEOF(h.cont_address_county) left_cont_address_county;
  INTEGER1 cont_address_county_match_code;
  INTEGER2 cont_address_county_score;
  TYPEOF(h.cont_address_county) right_cont_address_county;
  TYPEOF(h.cont_phone_number) left_cont_phone_number;
  INTEGER1 cont_phone_number_match_code;
  INTEGER2 cont_phone_number_score;
  TYPEOF(h.cont_phone_number) right_cont_phone_number;
  TYPEOF(h.cont_phone_number_type_cd) left_cont_phone_number_type_cd;
  INTEGER1 cont_phone_number_type_cd_match_code;
  INTEGER2 cont_phone_number_type_cd_score;
  TYPEOF(h.cont_phone_number_type_cd) right_cont_phone_number_type_cd;
  TYPEOF(h.cont_phone_number_type_desc) left_cont_phone_number_type_desc;
  INTEGER1 cont_phone_number_type_desc_match_code;
  INTEGER2 cont_phone_number_type_desc_score;
  TYPEOF(h.cont_phone_number_type_desc) right_cont_phone_number_type_desc;
  TYPEOF(h.cont_fax_nbr) left_cont_fax_nbr;
  INTEGER1 cont_fax_nbr_match_code;
  INTEGER2 cont_fax_nbr_score;
  TYPEOF(h.cont_fax_nbr) right_cont_fax_nbr;
  TYPEOF(h.cont_email_address) left_cont_email_address;
  INTEGER1 cont_email_address_match_code;
  INTEGER2 cont_email_address_score;
  TYPEOF(h.cont_email_address) right_cont_email_address;
  TYPEOF(h.cont_web_address) left_cont_web_address;
  INTEGER1 cont_web_address_match_code;
  INTEGER2 cont_web_address_score;
  TYPEOF(h.cont_web_address) right_cont_web_address;
  TYPEOF(h.corp_acres) left_corp_acres;
  INTEGER1 corp_acres_match_code;
  INTEGER2 corp_acres_score;
  TYPEOF(h.corp_acres) right_corp_acres;
  TYPEOF(h.corp_action) left_corp_action;
  INTEGER1 corp_action_match_code;
  INTEGER2 corp_action_score;
  TYPEOF(h.corp_action) right_corp_action;
  TYPEOF(h.corp_action_date) left_corp_action_date;
  INTEGER1 corp_action_date_match_code;
  INTEGER2 corp_action_date_score;
  TYPEOF(h.corp_action_date) right_corp_action_date;
  TYPEOF(h.corp_action_employment_security_approval_date) left_corp_action_employment_security_approval_date;
  INTEGER1 corp_action_employment_security_approval_date_match_code;
  INTEGER2 corp_action_employment_security_approval_date_score;
  TYPEOF(h.corp_action_employment_security_approval_date) right_corp_action_employment_security_approval_date;
  TYPEOF(h.corp_action_pending_cd) left_corp_action_pending_cd;
  INTEGER1 corp_action_pending_cd_match_code;
  INTEGER2 corp_action_pending_cd_score;
  TYPEOF(h.corp_action_pending_cd) right_corp_action_pending_cd;
  TYPEOF(h.corp_action_pending_desc) left_corp_action_pending_desc;
  INTEGER1 corp_action_pending_desc_match_code;
  INTEGER2 corp_action_pending_desc_score;
  TYPEOF(h.corp_action_pending_desc) right_corp_action_pending_desc;
  TYPEOF(h.corp_action_statement_of_intent_date) left_corp_action_statement_of_intent_date;
  INTEGER1 corp_action_statement_of_intent_date_match_code;
  INTEGER2 corp_action_statement_of_intent_date_score;
  TYPEOF(h.corp_action_statement_of_intent_date) right_corp_action_statement_of_intent_date;
  TYPEOF(h.corp_action_tax_dept_approval_date) left_corp_action_tax_dept_approval_date;
  INTEGER1 corp_action_tax_dept_approval_date_match_code;
  INTEGER2 corp_action_tax_dept_approval_date_score;
  TYPEOF(h.corp_action_tax_dept_approval_date) right_corp_action_tax_dept_approval_date;
  TYPEOF(h.corp_acts2) left_corp_acts2;
  INTEGER1 corp_acts2_match_code;
  INTEGER2 corp_acts2_score;
  TYPEOF(h.corp_acts2) right_corp_acts2;
  TYPEOF(h.corp_acts3) left_corp_acts3;
  INTEGER1 corp_acts3_match_code;
  INTEGER2 corp_acts3_score;
  TYPEOF(h.corp_acts3) right_corp_acts3;
  TYPEOF(h.corp_additional_principals) left_corp_additional_principals;
  INTEGER1 corp_additional_principals_match_code;
  INTEGER2 corp_additional_principals_score;
  TYPEOF(h.corp_additional_principals) right_corp_additional_principals;
  TYPEOF(h.corp_address_office_type) left_corp_address_office_type;
  INTEGER1 corp_address_office_type_match_code;
  INTEGER2 corp_address_office_type_score;
  TYPEOF(h.corp_address_office_type) right_corp_address_office_type;
  TYPEOF(h.corp_agent_assign_date) left_corp_agent_assign_date;
  INTEGER1 corp_agent_assign_date_match_code;
  INTEGER2 corp_agent_assign_date_score;
  TYPEOF(h.corp_agent_assign_date) right_corp_agent_assign_date;
  TYPEOF(h.corp_agent_commercial) left_corp_agent_commercial;
  INTEGER1 corp_agent_commercial_match_code;
  INTEGER2 corp_agent_commercial_score;
  TYPEOF(h.corp_agent_commercial) right_corp_agent_commercial;
  TYPEOF(h.corp_agent_country) left_corp_agent_country;
  INTEGER1 corp_agent_country_match_code;
  INTEGER2 corp_agent_country_score;
  TYPEOF(h.corp_agent_country) right_corp_agent_country;
  TYPEOF(h.corp_agent_county) left_corp_agent_county;
  INTEGER1 corp_agent_county_match_code;
  INTEGER2 corp_agent_county_score;
  TYPEOF(h.corp_agent_county) right_corp_agent_county;
  TYPEOF(h.corp_agent_status_cd) left_corp_agent_status_cd;
  INTEGER1 corp_agent_status_cd_match_code;
  INTEGER2 corp_agent_status_cd_score;
  TYPEOF(h.corp_agent_status_cd) right_corp_agent_status_cd;
  TYPEOF(h.corp_agent_status_desc) left_corp_agent_status_desc;
  INTEGER1 corp_agent_status_desc_match_code;
  INTEGER2 corp_agent_status_desc_score;
  TYPEOF(h.corp_agent_status_desc) right_corp_agent_status_desc;
  TYPEOF(h.corp_agent_id) left_corp_agent_id;
  INTEGER1 corp_agent_id_match_code;
  INTEGER2 corp_agent_id_score;
  TYPEOF(h.corp_agent_id) right_corp_agent_id;
  TYPEOF(h.corp_agriculture_flag) left_corp_agriculture_flag;
  INTEGER1 corp_agriculture_flag_match_code;
  INTEGER2 corp_agriculture_flag_score;
  TYPEOF(h.corp_agriculture_flag) right_corp_agriculture_flag;
  TYPEOF(h.corp_authorized_partners) left_corp_authorized_partners;
  INTEGER1 corp_authorized_partners_match_code;
  INTEGER2 corp_authorized_partners_score;
  TYPEOF(h.corp_authorized_partners) right_corp_authorized_partners;
  TYPEOF(h.corp_comment) left_corp_comment;
  INTEGER1 corp_comment_match_code;
  INTEGER2 corp_comment_score;
  TYPEOF(h.corp_comment) right_corp_comment;
  TYPEOF(h.corp_consent_flag_for_protected_name) left_corp_consent_flag_for_protected_name;
  INTEGER1 corp_consent_flag_for_protected_name_match_code;
  INTEGER2 corp_consent_flag_for_protected_name_score;
  TYPEOF(h.corp_consent_flag_for_protected_name) right_corp_consent_flag_for_protected_name;
  TYPEOF(h.corp_converted) left_corp_converted;
  INTEGER1 corp_converted_match_code;
  INTEGER2 corp_converted_score;
  TYPEOF(h.corp_converted) right_corp_converted;
  TYPEOF(h.corp_converted_from) left_corp_converted_from;
  INTEGER1 corp_converted_from_match_code;
  INTEGER2 corp_converted_from_score;
  TYPEOF(h.corp_converted_from) right_corp_converted_from;
  TYPEOF(h.corp_country_of_formation) left_corp_country_of_formation;
  INTEGER1 corp_country_of_formation_match_code;
  INTEGER2 corp_country_of_formation_score;
  TYPEOF(h.corp_country_of_formation) right_corp_country_of_formation;
  TYPEOF(h.corp_date_of_organization_meeting) left_corp_date_of_organization_meeting;
  INTEGER1 corp_date_of_organization_meeting_match_code;
  INTEGER2 corp_date_of_organization_meeting_score;
  TYPEOF(h.corp_date_of_organization_meeting) right_corp_date_of_organization_meeting;
  TYPEOF(h.corp_delayed_effective_date) left_corp_delayed_effective_date;
  INTEGER1 corp_delayed_effective_date_match_code;
  INTEGER2 corp_delayed_effective_date_score;
  TYPEOF(h.corp_delayed_effective_date) right_corp_delayed_effective_date;
  TYPEOF(h.corp_directors_from_to) left_corp_directors_from_to;
  INTEGER1 corp_directors_from_to_match_code;
  INTEGER2 corp_directors_from_to_score;
  TYPEOF(h.corp_directors_from_to) right_corp_directors_from_to;
  TYPEOF(h.corp_dissolved_date) left_corp_dissolved_date;
  INTEGER1 corp_dissolved_date_match_code;
  INTEGER2 corp_dissolved_date_score;
  TYPEOF(h.corp_dissolved_date) right_corp_dissolved_date;
  TYPEOF(h.corp_farm_exemptions) left_corp_farm_exemptions;
  INTEGER1 corp_farm_exemptions_match_code;
  INTEGER2 corp_farm_exemptions_score;
  TYPEOF(h.corp_farm_exemptions) right_corp_farm_exemptions;
  TYPEOF(h.corp_farm_qual_date) left_corp_farm_qual_date;
  INTEGER1 corp_farm_qual_date_match_code;
  INTEGER2 corp_farm_qual_date_score;
  TYPEOF(h.corp_farm_qual_date) right_corp_farm_qual_date;
  TYPEOF(h.corp_farm_status_cd) left_corp_farm_status_cd;
  INTEGER1 corp_farm_status_cd_match_code;
  INTEGER2 corp_farm_status_cd_score;
  TYPEOF(h.corp_farm_status_cd) right_corp_farm_status_cd;
  TYPEOF(h.corp_farm_status_desc) left_corp_farm_status_desc;
  INTEGER1 corp_farm_status_desc_match_code;
  INTEGER2 corp_farm_status_desc_score;
  TYPEOF(h.corp_farm_status_desc) right_corp_farm_status_desc;
  TYPEOF(h.corp_fiscal_year_month) left_corp_fiscal_year_month;
  INTEGER1 corp_fiscal_year_month_match_code;
  INTEGER2 corp_fiscal_year_month_score;
  TYPEOF(h.corp_fiscal_year_month) right_corp_fiscal_year_month;
  TYPEOF(h.corp_foreign_fiduciary_capacity_in_state) left_corp_foreign_fiduciary_capacity_in_state;
  INTEGER1 corp_foreign_fiduciary_capacity_in_state_match_code;
  INTEGER2 corp_foreign_fiduciary_capacity_in_state_score;
  TYPEOF(h.corp_foreign_fiduciary_capacity_in_state) right_corp_foreign_fiduciary_capacity_in_state;
  TYPEOF(h.corp_governing_statute) left_corp_governing_statute;
  INTEGER1 corp_governing_statute_match_code;
  INTEGER2 corp_governing_statute_score;
  TYPEOF(h.corp_governing_statute) right_corp_governing_statute;
  TYPEOF(h.corp_has_members) left_corp_has_members;
  INTEGER1 corp_has_members_match_code;
  INTEGER2 corp_has_members_score;
  TYPEOF(h.corp_has_members) right_corp_has_members;
  TYPEOF(h.corp_has_vested_managers) left_corp_has_vested_managers;
  INTEGER1 corp_has_vested_managers_match_code;
  INTEGER2 corp_has_vested_managers_score;
  TYPEOF(h.corp_has_vested_managers) right_corp_has_vested_managers;
  TYPEOF(h.corp_home_incorporated_county) left_corp_home_incorporated_county;
  INTEGER1 corp_home_incorporated_county_match_code;
  INTEGER2 corp_home_incorporated_county_score;
  TYPEOF(h.corp_home_incorporated_county) right_corp_home_incorporated_county;
  TYPEOF(h.corp_home_state_name) left_corp_home_state_name;
  INTEGER1 corp_home_state_name_match_code;
  INTEGER2 corp_home_state_name_score;
  TYPEOF(h.corp_home_state_name) right_corp_home_state_name;
  TYPEOF(h.corp_is_professional) left_corp_is_professional;
  INTEGER1 corp_is_professional_match_code;
  INTEGER2 corp_is_professional_score;
  TYPEOF(h.corp_is_professional) right_corp_is_professional;
  TYPEOF(h.corp_is_non_profit_irs_approved) left_corp_is_non_profit_irs_approved;
  INTEGER1 corp_is_non_profit_irs_approved_match_code;
  INTEGER2 corp_is_non_profit_irs_approved_score;
  TYPEOF(h.corp_is_non_profit_irs_approved) right_corp_is_non_profit_irs_approved;
  TYPEOF(h.corp_last_renewal_date) left_corp_last_renewal_date;
  INTEGER1 corp_last_renewal_date_match_code;
  INTEGER2 corp_last_renewal_date_score;
  TYPEOF(h.corp_last_renewal_date) right_corp_last_renewal_date;
  TYPEOF(h.corp_last_renewal_year) left_corp_last_renewal_year;
  INTEGER1 corp_last_renewal_year_match_code;
  INTEGER2 corp_last_renewal_year_score;
  TYPEOF(h.corp_last_renewal_year) right_corp_last_renewal_year;
  TYPEOF(h.corp_license_type) left_corp_license_type;
  INTEGER1 corp_license_type_match_code;
  INTEGER2 corp_license_type_score;
  TYPEOF(h.corp_license_type) right_corp_license_type;
  TYPEOF(h.corp_llc_managed_desc) left_corp_llc_managed_desc;
  INTEGER1 corp_llc_managed_desc_match_code;
  INTEGER2 corp_llc_managed_desc_score;
  TYPEOF(h.corp_llc_managed_desc) right_corp_llc_managed_desc;
  TYPEOF(h.corp_llc_managed_ind) left_corp_llc_managed_ind;
  INTEGER1 corp_llc_managed_ind_match_code;
  INTEGER2 corp_llc_managed_ind_score;
  TYPEOF(h.corp_llc_managed_ind) right_corp_llc_managed_ind;
  TYPEOF(h.corp_management_desc) left_corp_management_desc;
  INTEGER1 corp_management_desc_match_code;
  INTEGER2 corp_management_desc_score;
  TYPEOF(h.corp_management_desc) right_corp_management_desc;
  TYPEOF(h.corp_management_type) left_corp_management_type;
  INTEGER1 corp_management_type_match_code;
  INTEGER2 corp_management_type_score;
  TYPEOF(h.corp_management_type) right_corp_management_type;
  TYPEOF(h.corp_manager_managed) left_corp_manager_managed;
  INTEGER1 corp_manager_managed_match_code;
  INTEGER2 corp_manager_managed_score;
  TYPEOF(h.corp_manager_managed) right_corp_manager_managed;
  TYPEOF(h.corp_merged_corporation_id) left_corp_merged_corporation_id;
  INTEGER1 corp_merged_corporation_id_match_code;
  INTEGER2 corp_merged_corporation_id_score;
  TYPEOF(h.corp_merged_corporation_id) right_corp_merged_corporation_id;
  TYPEOF(h.corp_merged_fein) left_corp_merged_fein;
  INTEGER1 corp_merged_fein_match_code;
  INTEGER2 corp_merged_fein_score;
  TYPEOF(h.corp_merged_fein) right_corp_merged_fein;
  TYPEOF(h.corp_merger_allowed_flag) left_corp_merger_allowed_flag;
  INTEGER1 corp_merger_allowed_flag_match_code;
  INTEGER2 corp_merger_allowed_flag_score;
  TYPEOF(h.corp_merger_allowed_flag) right_corp_merger_allowed_flag;
  TYPEOF(h.corp_merger_date) left_corp_merger_date;
  INTEGER1 corp_merger_date_match_code;
  INTEGER2 corp_merger_date_score;
  TYPEOF(h.corp_merger_date) right_corp_merger_date;
  TYPEOF(h.corp_merger_desc) left_corp_merger_desc;
  INTEGER1 corp_merger_desc_match_code;
  INTEGER2 corp_merger_desc_score;
  TYPEOF(h.corp_merger_desc) right_corp_merger_desc;
  TYPEOF(h.corp_merger_effective_date) left_corp_merger_effective_date;
  INTEGER1 corp_merger_effective_date_match_code;
  INTEGER2 corp_merger_effective_date_score;
  TYPEOF(h.corp_merger_effective_date) right_corp_merger_effective_date;
  TYPEOF(h.corp_merger_id) left_corp_merger_id;
  INTEGER1 corp_merger_id_match_code;
  INTEGER2 corp_merger_id_score;
  TYPEOF(h.corp_merger_id) right_corp_merger_id;
  TYPEOF(h.corp_merger_indicator) left_corp_merger_indicator;
  INTEGER1 corp_merger_indicator_match_code;
  INTEGER2 corp_merger_indicator_score;
  TYPEOF(h.corp_merger_indicator) right_corp_merger_indicator;
  TYPEOF(h.corp_merger_name) left_corp_merger_name;
  INTEGER1 corp_merger_name_match_code;
  INTEGER2 corp_merger_name_score;
  TYPEOF(h.corp_merger_name) right_corp_merger_name;
  TYPEOF(h.corp_merger_type_converted_to_cd) left_corp_merger_type_converted_to_cd;
  INTEGER1 corp_merger_type_converted_to_cd_match_code;
  INTEGER2 corp_merger_type_converted_to_cd_score;
  TYPEOF(h.corp_merger_type_converted_to_cd) right_corp_merger_type_converted_to_cd;
  TYPEOF(h.corp_merger_type_converted_to_desc) left_corp_merger_type_converted_to_desc;
  INTEGER1 corp_merger_type_converted_to_desc_match_code;
  INTEGER2 corp_merger_type_converted_to_desc_score;
  TYPEOF(h.corp_merger_type_converted_to_desc) right_corp_merger_type_converted_to_desc;
  TYPEOF(h.corp_naics_desc) left_corp_naics_desc;
  INTEGER1 corp_naics_desc_match_code;
  INTEGER2 corp_naics_desc_score;
  TYPEOF(h.corp_naics_desc) right_corp_naics_desc;
  TYPEOF(h.corp_name_effective_date) left_corp_name_effective_date;
  INTEGER1 corp_name_effective_date_match_code;
  INTEGER2 corp_name_effective_date_score;
  TYPEOF(h.corp_name_effective_date) right_corp_name_effective_date;
  TYPEOF(h.corp_name_reservation_date) left_corp_name_reservation_date;
  INTEGER1 corp_name_reservation_date_match_code;
  INTEGER2 corp_name_reservation_date_score;
  TYPEOF(h.corp_name_reservation_date) right_corp_name_reservation_date;
  TYPEOF(h.corp_name_reservation_desc) left_corp_name_reservation_desc;
  INTEGER1 corp_name_reservation_desc_match_code;
  INTEGER2 corp_name_reservation_desc_score;
  TYPEOF(h.corp_name_reservation_desc) right_corp_name_reservation_desc;
  TYPEOF(h.corp_name_reservation_expiration_date) left_corp_name_reservation_expiration_date;
  INTEGER1 corp_name_reservation_expiration_date_match_code;
  INTEGER2 corp_name_reservation_expiration_date_score;
  TYPEOF(h.corp_name_reservation_expiration_date) right_corp_name_reservation_expiration_date;
  TYPEOF(h.corp_name_reservation_nbr) left_corp_name_reservation_nbr;
  INTEGER1 corp_name_reservation_nbr_match_code;
  INTEGER2 corp_name_reservation_nbr_score;
  TYPEOF(h.corp_name_reservation_nbr) right_corp_name_reservation_nbr;
  TYPEOF(h.corp_name_reservation_type) left_corp_name_reservation_type;
  INTEGER1 corp_name_reservation_type_match_code;
  INTEGER2 corp_name_reservation_type_score;
  TYPEOF(h.corp_name_reservation_type) right_corp_name_reservation_type;
  TYPEOF(h.corp_name_status_cd) left_corp_name_status_cd;
  INTEGER1 corp_name_status_cd_match_code;
  INTEGER2 corp_name_status_cd_score;
  TYPEOF(h.corp_name_status_cd) right_corp_name_status_cd;
  TYPEOF(h.corp_name_status_date) left_corp_name_status_date;
  INTEGER1 corp_name_status_date_match_code;
  INTEGER2 corp_name_status_date_score;
  TYPEOF(h.corp_name_status_date) right_corp_name_status_date;
  TYPEOF(h.corp_name_status_desc) left_corp_name_status_desc;
  INTEGER1 corp_name_status_desc_match_code;
  INTEGER2 corp_name_status_desc_score;
  TYPEOF(h.corp_name_status_desc) right_corp_name_status_desc;
  TYPEOF(h.corp_non_profit_irs_approved_purpose) left_corp_non_profit_irs_approved_purpose;
  INTEGER1 corp_non_profit_irs_approved_purpose_match_code;
  INTEGER2 corp_non_profit_irs_approved_purpose_score;
  TYPEOF(h.corp_non_profit_irs_approved_purpose) right_corp_non_profit_irs_approved_purpose;
  TYPEOF(h.corp_non_profit_solicit_donations) left_corp_non_profit_solicit_donations;
  INTEGER1 corp_non_profit_solicit_donations_match_code;
  INTEGER2 corp_non_profit_solicit_donations_score;
  TYPEOF(h.corp_non_profit_solicit_donations) right_corp_non_profit_solicit_donations;
  TYPEOF(h.corp_nbr_of_amendments) left_corp_nbr_of_amendments;
  INTEGER1 corp_nbr_of_amendments_match_code;
  INTEGER2 corp_nbr_of_amendments_score;
  TYPEOF(h.corp_nbr_of_amendments) right_corp_nbr_of_amendments;
  TYPEOF(h.corp_nbr_of_initial_llc_members) left_corp_nbr_of_initial_llc_members;
  INTEGER1 corp_nbr_of_initial_llc_members_match_code;
  INTEGER2 corp_nbr_of_initial_llc_members_score;
  TYPEOF(h.corp_nbr_of_initial_llc_members) right_corp_nbr_of_initial_llc_members;
  TYPEOF(h.corp_nbr_of_partners) left_corp_nbr_of_partners;
  INTEGER1 corp_nbr_of_partners_match_code;
  INTEGER2 corp_nbr_of_partners_score;
  TYPEOF(h.corp_nbr_of_partners) right_corp_nbr_of_partners;
  TYPEOF(h.corp_operating_agreement) left_corp_operating_agreement;
  INTEGER1 corp_operating_agreement_match_code;
  INTEGER2 corp_operating_agreement_score;
  TYPEOF(h.corp_operating_agreement) right_corp_operating_agreement;
  TYPEOF(h.corp_opt_in_llc_act_desc) left_corp_opt_in_llc_act_desc;
  INTEGER1 corp_opt_in_llc_act_desc_match_code;
  INTEGER2 corp_opt_in_llc_act_desc_score;
  TYPEOF(h.corp_opt_in_llc_act_desc) right_corp_opt_in_llc_act_desc;
  TYPEOF(h.corp_opt_in_llc_act_ind) left_corp_opt_in_llc_act_ind;
  INTEGER1 corp_opt_in_llc_act_ind_match_code;
  INTEGER2 corp_opt_in_llc_act_ind_score;
  TYPEOF(h.corp_opt_in_llc_act_ind) right_corp_opt_in_llc_act_ind;
  TYPEOF(h.corp_organizational_comments) left_corp_organizational_comments;
  INTEGER1 corp_organizational_comments_match_code;
  INTEGER2 corp_organizational_comments_score;
  TYPEOF(h.corp_organizational_comments) right_corp_organizational_comments;
  TYPEOF(h.corp_partner_contributions_total) left_corp_partner_contributions_total;
  INTEGER1 corp_partner_contributions_total_match_code;
  INTEGER2 corp_partner_contributions_total_score;
  TYPEOF(h.corp_partner_contributions_total) right_corp_partner_contributions_total;
  TYPEOF(h.corp_partner_terms) left_corp_partner_terms;
  INTEGER1 corp_partner_terms_match_code;
  INTEGER2 corp_partner_terms_score;
  TYPEOF(h.corp_partner_terms) right_corp_partner_terms;
  TYPEOF(h.corp_percentage_voters_required_to_approve_amendments) left_corp_percentage_voters_required_to_approve_amendments;
  INTEGER1 corp_percentage_voters_required_to_approve_amendments_match_code;
  INTEGER2 corp_percentage_voters_required_to_approve_amendments_score;
  TYPEOF(h.corp_percentage_voters_required_to_approve_amendments) right_corp_percentage_voters_required_to_approve_amendments;
  TYPEOF(h.corp_profession) left_corp_profession;
  INTEGER1 corp_profession_match_code;
  INTEGER2 corp_profession_score;
  TYPEOF(h.corp_profession) right_corp_profession;
  TYPEOF(h.corp_province) left_corp_province;
  INTEGER1 corp_province_match_code;
  INTEGER2 corp_province_score;
  TYPEOF(h.corp_province) right_corp_province;
  TYPEOF(h.corp_public_mutual_corporation) left_corp_public_mutual_corporation;
  INTEGER1 corp_public_mutual_corporation_match_code;
  INTEGER2 corp_public_mutual_corporation_score;
  TYPEOF(h.corp_public_mutual_corporation) right_corp_public_mutual_corporation;
  TYPEOF(h.corp_purpose) left_corp_purpose;
  INTEGER1 corp_purpose_match_code;
  INTEGER2 corp_purpose_score;
  TYPEOF(h.corp_purpose) right_corp_purpose;
  TYPEOF(h.corp_ra_required_flag) left_corp_ra_required_flag;
  INTEGER1 corp_ra_required_flag_match_code;
  INTEGER2 corp_ra_required_flag_score;
  TYPEOF(h.corp_ra_required_flag) right_corp_ra_required_flag;
  TYPEOF(h.corp_registered_counties) left_corp_registered_counties;
  INTEGER1 corp_registered_counties_match_code;
  INTEGER2 corp_registered_counties_score;
  TYPEOF(h.corp_registered_counties) right_corp_registered_counties;
  TYPEOF(h.corp_regulated_ind) left_corp_regulated_ind;
  INTEGER1 corp_regulated_ind_match_code;
  INTEGER2 corp_regulated_ind_score;
  TYPEOF(h.corp_regulated_ind) right_corp_regulated_ind;
  TYPEOF(h.corp_renewal_date) left_corp_renewal_date;
  INTEGER1 corp_renewal_date_match_code;
  INTEGER2 corp_renewal_date_score;
  TYPEOF(h.corp_renewal_date) right_corp_renewal_date;
  TYPEOF(h.corp_standing_other) left_corp_standing_other;
  INTEGER1 corp_standing_other_match_code;
  INTEGER2 corp_standing_other_score;
  TYPEOF(h.corp_standing_other) right_corp_standing_other;
  TYPEOF(h.corp_survivor_corporation_id) left_corp_survivor_corporation_id;
  INTEGER1 corp_survivor_corporation_id_match_code;
  INTEGER2 corp_survivor_corporation_id_score;
  TYPEOF(h.corp_survivor_corporation_id) right_corp_survivor_corporation_id;
  TYPEOF(h.corp_tax_base) left_corp_tax_base;
  INTEGER1 corp_tax_base_match_code;
  INTEGER2 corp_tax_base_score;
  TYPEOF(h.corp_tax_base) right_corp_tax_base;
  TYPEOF(h.corp_tax_standing) left_corp_tax_standing;
  INTEGER1 corp_tax_standing_match_code;
  INTEGER2 corp_tax_standing_score;
  TYPEOF(h.corp_tax_standing) right_corp_tax_standing;
  TYPEOF(h.corp_termination_cd) left_corp_termination_cd;
  INTEGER1 corp_termination_cd_match_code;
  INTEGER2 corp_termination_cd_score;
  TYPEOF(h.corp_termination_cd) right_corp_termination_cd;
  TYPEOF(h.corp_termination_desc) left_corp_termination_desc;
  INTEGER1 corp_termination_desc_match_code;
  INTEGER2 corp_termination_desc_score;
  TYPEOF(h.corp_termination_desc) right_corp_termination_desc;
  TYPEOF(h.corp_termination_date) left_corp_termination_date;
  INTEGER1 corp_termination_date_match_code;
  INTEGER2 corp_termination_date_score;
  TYPEOF(h.corp_termination_date) right_corp_termination_date;
  TYPEOF(h.corp_trademark_business_mark_type) left_corp_trademark_business_mark_type;
  INTEGER1 corp_trademark_business_mark_type_match_code;
  INTEGER2 corp_trademark_business_mark_type_score;
  TYPEOF(h.corp_trademark_business_mark_type) right_corp_trademark_business_mark_type;
  TYPEOF(h.corp_trademark_cancelled_date) left_corp_trademark_cancelled_date;
  INTEGER1 corp_trademark_cancelled_date_match_code;
  INTEGER2 corp_trademark_cancelled_date_score;
  TYPEOF(h.corp_trademark_cancelled_date) right_corp_trademark_cancelled_date;
  TYPEOF(h.corp_trademark_class_desc1) left_corp_trademark_class_desc1;
  INTEGER1 corp_trademark_class_desc1_match_code;
  INTEGER2 corp_trademark_class_desc1_score;
  TYPEOF(h.corp_trademark_class_desc1) right_corp_trademark_class_desc1;
  TYPEOF(h.corp_trademark_class_desc2) left_corp_trademark_class_desc2;
  INTEGER1 corp_trademark_class_desc2_match_code;
  INTEGER2 corp_trademark_class_desc2_score;
  TYPEOF(h.corp_trademark_class_desc2) right_corp_trademark_class_desc2;
  TYPEOF(h.corp_trademark_class_desc3) left_corp_trademark_class_desc3;
  INTEGER1 corp_trademark_class_desc3_match_code;
  INTEGER2 corp_trademark_class_desc3_score;
  TYPEOF(h.corp_trademark_class_desc3) right_corp_trademark_class_desc3;
  TYPEOF(h.corp_trademark_class_desc4) left_corp_trademark_class_desc4;
  INTEGER1 corp_trademark_class_desc4_match_code;
  INTEGER2 corp_trademark_class_desc4_score;
  TYPEOF(h.corp_trademark_class_desc4) right_corp_trademark_class_desc4;
  TYPEOF(h.corp_trademark_class_desc5) left_corp_trademark_class_desc5;
  INTEGER1 corp_trademark_class_desc5_match_code;
  INTEGER2 corp_trademark_class_desc5_score;
  TYPEOF(h.corp_trademark_class_desc5) right_corp_trademark_class_desc5;
  TYPEOF(h.corp_trademark_class_desc6) left_corp_trademark_class_desc6;
  INTEGER1 corp_trademark_class_desc6_match_code;
  INTEGER2 corp_trademark_class_desc6_score;
  TYPEOF(h.corp_trademark_class_desc6) right_corp_trademark_class_desc6;
  TYPEOF(h.corp_trademark_classification_nbr) left_corp_trademark_classification_nbr;
  INTEGER1 corp_trademark_classification_nbr_match_code;
  INTEGER2 corp_trademark_classification_nbr_score;
  TYPEOF(h.corp_trademark_classification_nbr) right_corp_trademark_classification_nbr;
  TYPEOF(h.corp_trademark_disclaimer1) left_corp_trademark_disclaimer1;
  INTEGER1 corp_trademark_disclaimer1_match_code;
  INTEGER2 corp_trademark_disclaimer1_score;
  TYPEOF(h.corp_trademark_disclaimer1) right_corp_trademark_disclaimer1;
  TYPEOF(h.corp_trademark_disclaimer2) left_corp_trademark_disclaimer2;
  INTEGER1 corp_trademark_disclaimer2_match_code;
  INTEGER2 corp_trademark_disclaimer2_score;
  TYPEOF(h.corp_trademark_disclaimer2) right_corp_trademark_disclaimer2;
  TYPEOF(h.corp_trademark_expiration_date) left_corp_trademark_expiration_date;
  INTEGER1 corp_trademark_expiration_date_match_code;
  INTEGER2 corp_trademark_expiration_date_score;
  TYPEOF(h.corp_trademark_expiration_date) right_corp_trademark_expiration_date;
  TYPEOF(h.corp_trademark_filing_date) left_corp_trademark_filing_date;
  INTEGER1 corp_trademark_filing_date_match_code;
  INTEGER2 corp_trademark_filing_date_score;
  TYPEOF(h.corp_trademark_filing_date) right_corp_trademark_filing_date;
  TYPEOF(h.corp_trademark_first_use_date) left_corp_trademark_first_use_date;
  INTEGER1 corp_trademark_first_use_date_match_code;
  INTEGER2 corp_trademark_first_use_date_score;
  TYPEOF(h.corp_trademark_first_use_date) right_corp_trademark_first_use_date;
  TYPEOF(h.corp_trademark_first_use_date_in_state) left_corp_trademark_first_use_date_in_state;
  INTEGER1 corp_trademark_first_use_date_in_state_match_code;
  INTEGER2 corp_trademark_first_use_date_in_state_score;
  TYPEOF(h.corp_trademark_first_use_date_in_state) right_corp_trademark_first_use_date_in_state;
  TYPEOF(h.corp_trademark_keywords) left_corp_trademark_keywords;
  INTEGER1 corp_trademark_keywords_match_code;
  INTEGER2 corp_trademark_keywords_score;
  TYPEOF(h.corp_trademark_keywords) right_corp_trademark_keywords;
  TYPEOF(h.corp_trademark_logo) left_corp_trademark_logo;
  INTEGER1 corp_trademark_logo_match_code;
  INTEGER2 corp_trademark_logo_score;
  TYPEOF(h.corp_trademark_logo) right_corp_trademark_logo;
  TYPEOF(h.corp_trademark_name_expiration_date) left_corp_trademark_name_expiration_date;
  INTEGER1 corp_trademark_name_expiration_date_match_code;
  INTEGER2 corp_trademark_name_expiration_date_score;
  TYPEOF(h.corp_trademark_name_expiration_date) right_corp_trademark_name_expiration_date;
  TYPEOF(h.corp_trademark_nbr) left_corp_trademark_nbr;
  INTEGER1 corp_trademark_nbr_match_code;
  INTEGER2 corp_trademark_nbr_score;
  TYPEOF(h.corp_trademark_nbr) right_corp_trademark_nbr;
  TYPEOF(h.corp_trademark_renewal_date) left_corp_trademark_renewal_date;
  INTEGER1 corp_trademark_renewal_date_match_code;
  INTEGER2 corp_trademark_renewal_date_score;
  TYPEOF(h.corp_trademark_renewal_date) right_corp_trademark_renewal_date;
  TYPEOF(h.corp_trademark_status) left_corp_trademark_status;
  INTEGER1 corp_trademark_status_match_code;
  INTEGER2 corp_trademark_status_score;
  TYPEOF(h.corp_trademark_status) right_corp_trademark_status;
  TYPEOF(h.corp_trademark_used_1) left_corp_trademark_used_1;
  INTEGER1 corp_trademark_used_1_match_code;
  INTEGER2 corp_trademark_used_1_score;
  TYPEOF(h.corp_trademark_used_1) right_corp_trademark_used_1;
  TYPEOF(h.corp_trademark_used_2) left_corp_trademark_used_2;
  INTEGER1 corp_trademark_used_2_match_code;
  INTEGER2 corp_trademark_used_2_score;
  TYPEOF(h.corp_trademark_used_2) right_corp_trademark_used_2;
  TYPEOF(h.corp_trademark_used_3) left_corp_trademark_used_3;
  INTEGER1 corp_trademark_used_3_match_code;
  INTEGER2 corp_trademark_used_3_score;
  TYPEOF(h.corp_trademark_used_3) right_corp_trademark_used_3;
  TYPEOF(h.cont_owner_percentage) left_cont_owner_percentage;
  INTEGER1 cont_owner_percentage_match_code;
  INTEGER2 cont_owner_percentage_score;
  TYPEOF(h.cont_owner_percentage) right_cont_owner_percentage;
  TYPEOF(h.cont_country) left_cont_country;
  INTEGER1 cont_country_match_code;
  INTEGER2 cont_country_score;
  TYPEOF(h.cont_country) right_cont_country;
  TYPEOF(h.cont_country_mailing) left_cont_country_mailing;
  INTEGER1 cont_country_mailing_match_code;
  INTEGER2 cont_country_mailing_score;
  TYPEOF(h.cont_country_mailing) right_cont_country_mailing;
  TYPEOF(h.cont_nondislosure) left_cont_nondislosure;
  INTEGER1 cont_nondislosure_match_code;
  INTEGER2 cont_nondislosure_score;
  TYPEOF(h.cont_nondislosure) right_cont_nondislosure;
  TYPEOF(h.cont_prep_addr_line1) left_cont_prep_addr_line1;
  INTEGER1 cont_prep_addr_line1_match_code;
  INTEGER2 cont_prep_addr_line1_score;
  TYPEOF(h.cont_prep_addr_line1) right_cont_prep_addr_line1;
  TYPEOF(h.cont_prep_addr_last_line) left_cont_prep_addr_last_line;
  INTEGER1 cont_prep_addr_last_line_match_code;
  INTEGER2 cont_prep_addr_last_line_score;
  TYPEOF(h.cont_prep_addr_last_line) right_cont_prep_addr_last_line;
  TYPEOF(h.recordorigin) left_recordorigin;
  INTEGER1 recordorigin_match_code;
  INTEGER2 recordorigin_score;
  TYPEOF(h.recordorigin) right_recordorigin;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.1 := le.;
  SELF.2 := ri.;
  SELF.1 := le.;
  SELF.2 := ri.;
  INTEGER2 dt_vendor_first_reported_year_score := MAP ( le.dt_vendor_first_reported_year_isnull or ri.dt_vendor_first_reported_year_isnull => 0,
                                  le.dt_vendor_first_reported_year = ri.dt_vendor_first_reported_year => le.dt_vendor_first_reported_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_year_weight100,s.dt_vendor_first_reported_year_switch) );
  INTEGER2 dt_vendor_first_reported_month_score := MAP ( le.dt_vendor_first_reported_month_isnull or ri.dt_vendor_first_reported_month_isnull => 0,
                                  le.dt_vendor_first_reported_month = ri.dt_vendor_first_reported_month => le.dt_vendor_first_reported_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_month_weight100,s.dt_vendor_first_reported_month_switch) );
  INTEGER2 dt_vendor_first_reported_day_score := MAP ( le.dt_vendor_first_reported_day_isnull or ri.dt_vendor_first_reported_day_isnull => 0,
                                  le.dt_vendor_first_reported_day = ri.dt_vendor_first_reported_day => le.dt_vendor_first_reported_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_first_reported_day_weight100,s.dt_vendor_first_reported_day_switch) );
  INTEGER2 dt_vendor_first_reported_score_temp := (dt_vendor_first_reported_year_score+dt_vendor_first_reported_month_score+dt_vendor_first_reported_day_score);
  SELF.dt_vendor_first_reported_year_match_code := MAP(
                        le.dt_vendor_first_reported_year_isnull OR ri.dt_vendor_first_reported_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_first_reported_year(le.dt_vendor_first_reported_year,ri.dt_vendor_first_reported_year));
  SELF.dt_vendor_first_reported_month_match_code := MAP(
                        le.dt_vendor_first_reported_month_isnull OR ri.dt_vendor_first_reported_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_first_reported_month(le.dt_vendor_first_reported_month,ri.dt_vendor_first_reported_month,le.dt_vendor_first_reported_day,ri.dt_vendor_first_reported_day));
  SELF.dt_vendor_first_reported_day_match_code := MAP(
                        le.dt_vendor_first_reported_day_isnull or ri.dt_vendor_first_reported_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_first_reported_day(le.dt_vendor_first_reported_month,ri.dt_vendor_first_reported_month,le.dt_vendor_first_reported_day,ri.dt_vendor_first_reported_day));
  SELF.dt_vendor_first_reported_match_code := MAP(
                        le.dt_vendor_first_reported_day_isnull AND le.dt_vendor_first_reported_month_isnull AND le.dt_vendor_first_reported_year_isnull OR ri.dt_vendor_first_reported_day_isnull AND ri.dt_vendor_first_reported_month_isnull AND ri.dt_vendor_first_reported_year_isnull => SALT34.MatchCode.OneSideNull,
                        dt_vendor_first_reported_score_temp = dt_vendor_first_reported_year_score+dt_vendor_first_reported_month_score+dt_vendor_first_reported_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_year  IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year) AND le.dt_vendor_first_reported_month  IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month) AND le.dt_vendor_first_reported_day  IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day) or ri.dt_vendor_first_reported_year  IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year) AND ri.dt_vendor_first_reported_month  IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month) AND ri.dt_vendor_first_reported_day  IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day) => 0,
                        dt_vendor_first_reported_score_temp);
 
  SELF.left_dt_vendor_first_reported := (( le.dt_vendor_first_reported_year * 100 ) + le.dt_vendor_first_reported_month ) * 100 + le.dt_vendor_first_reported_day;
  SELF.right_dt_vendor_first_reported := (( ri.dt_vendor_first_reported_year * 100 ) + ri.dt_vendor_first_reported_month ) * 100 + ri.dt_vendor_first_reported_day;
  INTEGER2 dt_vendor_last_reported_year_score := MAP ( le.dt_vendor_last_reported_year_isnull or ri.dt_vendor_last_reported_year_isnull => 0,
                                  le.dt_vendor_last_reported_year = ri.dt_vendor_last_reported_year => le.dt_vendor_last_reported_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_year_weight100,s.dt_vendor_last_reported_year_switch) );
  INTEGER2 dt_vendor_last_reported_month_score := MAP ( le.dt_vendor_last_reported_month_isnull or ri.dt_vendor_last_reported_month_isnull => 0,
                                  le.dt_vendor_last_reported_month = ri.dt_vendor_last_reported_month => le.dt_vendor_last_reported_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_month_weight100,s.dt_vendor_last_reported_month_switch) );
  INTEGER2 dt_vendor_last_reported_day_score := MAP ( le.dt_vendor_last_reported_day_isnull or ri.dt_vendor_last_reported_day_isnull => 0,
                                  le.dt_vendor_last_reported_day = ri.dt_vendor_last_reported_day => le.dt_vendor_last_reported_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_vendor_last_reported_day_weight100,s.dt_vendor_last_reported_day_switch) );
  INTEGER2 dt_vendor_last_reported_score_temp := (dt_vendor_last_reported_year_score+dt_vendor_last_reported_month_score+dt_vendor_last_reported_day_score);
  SELF.dt_vendor_last_reported_year_match_code := MAP(
                        le.dt_vendor_last_reported_year_isnull OR ri.dt_vendor_last_reported_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_last_reported_year(le.dt_vendor_last_reported_year,ri.dt_vendor_last_reported_year));
  SELF.dt_vendor_last_reported_month_match_code := MAP(
                        le.dt_vendor_last_reported_month_isnull OR ri.dt_vendor_last_reported_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_last_reported_month(le.dt_vendor_last_reported_month,ri.dt_vendor_last_reported_month,le.dt_vendor_last_reported_day,ri.dt_vendor_last_reported_day));
  SELF.dt_vendor_last_reported_day_match_code := MAP(
                        le.dt_vendor_last_reported_day_isnull or ri.dt_vendor_last_reported_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_vendor_last_reported_day(le.dt_vendor_last_reported_month,ri.dt_vendor_last_reported_month,le.dt_vendor_last_reported_day,ri.dt_vendor_last_reported_day));
  SELF.dt_vendor_last_reported_match_code := MAP(
                        le.dt_vendor_last_reported_day_isnull AND le.dt_vendor_last_reported_month_isnull AND le.dt_vendor_last_reported_year_isnull OR ri.dt_vendor_last_reported_day_isnull AND ri.dt_vendor_last_reported_month_isnull AND ri.dt_vendor_last_reported_year_isnull => SALT34.MatchCode.OneSideNull,
                        dt_vendor_last_reported_score_temp = dt_vendor_last_reported_year_score+dt_vendor_last_reported_month_score+dt_vendor_last_reported_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_year  IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year) AND le.dt_vendor_last_reported_month  IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month) AND le.dt_vendor_last_reported_day  IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day) or ri.dt_vendor_last_reported_year  IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year) AND ri.dt_vendor_last_reported_month  IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month) AND ri.dt_vendor_last_reported_day  IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day) => 0,
                        dt_vendor_last_reported_score_temp);
 
  SELF.left_dt_vendor_last_reported := (( le.dt_vendor_last_reported_year * 100 ) + le.dt_vendor_last_reported_month ) * 100 + le.dt_vendor_last_reported_day;
  SELF.right_dt_vendor_last_reported := (( ri.dt_vendor_last_reported_year * 100 ) + ri.dt_vendor_last_reported_month ) * 100 + ri.dt_vendor_last_reported_day;
  INTEGER2 dt_first_seen_year_score := MAP ( le.dt_first_seen_year_isnull or ri.dt_first_seen_year_isnull => 0,
                                  le.dt_first_seen_year = ri.dt_first_seen_year => le.dt_first_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_year_weight100,s.dt_first_seen_year_switch) );
  INTEGER2 dt_first_seen_month_score := MAP ( le.dt_first_seen_month_isnull or ri.dt_first_seen_month_isnull => 0,
                                  le.dt_first_seen_month = ri.dt_first_seen_month => le.dt_first_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_month_weight100,s.dt_first_seen_month_switch) );
  INTEGER2 dt_first_seen_day_score := MAP ( le.dt_first_seen_day_isnull or ri.dt_first_seen_day_isnull => 0,
                                  le.dt_first_seen_day = ri.dt_first_seen_day => le.dt_first_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_first_seen_day_weight100,s.dt_first_seen_day_switch) );
  INTEGER2 dt_first_seen_score_temp := (dt_first_seen_year_score+dt_first_seen_month_score+dt_first_seen_day_score);
  SELF.dt_first_seen_year_match_code := MAP(
                        le.dt_first_seen_year_isnull OR ri.dt_first_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_first_seen_year(le.dt_first_seen_year,ri.dt_first_seen_year));
  SELF.dt_first_seen_month_match_code := MAP(
                        le.dt_first_seen_month_isnull OR ri.dt_first_seen_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_first_seen_month(le.dt_first_seen_month,ri.dt_first_seen_month,le.dt_first_seen_day,ri.dt_first_seen_day));
  SELF.dt_first_seen_day_match_code := MAP(
                        le.dt_first_seen_day_isnull or ri.dt_first_seen_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_first_seen_day(le.dt_first_seen_month,ri.dt_first_seen_month,le.dt_first_seen_day,ri.dt_first_seen_day));
  SELF.dt_first_seen_match_code := MAP(
                        le.dt_first_seen_day_isnull AND le.dt_first_seen_month_isnull AND le.dt_first_seen_year_isnull OR ri.dt_first_seen_day_isnull AND ri.dt_first_seen_month_isnull AND ri.dt_first_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        dt_first_seen_score_temp = dt_first_seen_year_score+dt_first_seen_month_score+dt_first_seen_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.dt_first_seen_score := MAP( le.dt_first_seen_year  IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year) AND le.dt_first_seen_month  IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month) AND le.dt_first_seen_day  IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day) or ri.dt_first_seen_year  IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year) AND ri.dt_first_seen_month  IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month) AND ri.dt_first_seen_day  IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day) => 0,
                        dt_first_seen_score_temp);
 
  SELF.left_dt_first_seen := (( le.dt_first_seen_year * 100 ) + le.dt_first_seen_month ) * 100 + le.dt_first_seen_day;
  SELF.right_dt_first_seen := (( ri.dt_first_seen_year * 100 ) + ri.dt_first_seen_month ) * 100 + ri.dt_first_seen_day;
  INTEGER2 dt_last_seen_year_score := MAP ( le.dt_last_seen_year_isnull or ri.dt_last_seen_year_isnull => 0,
                                  le.dt_last_seen_year = ri.dt_last_seen_year => le.dt_last_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_year_weight100,s.dt_last_seen_year_switch) );
  INTEGER2 dt_last_seen_month_score := MAP ( le.dt_last_seen_month_isnull or ri.dt_last_seen_month_isnull => 0,
                                  le.dt_last_seen_month = ri.dt_last_seen_month => le.dt_last_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_month_weight100,s.dt_last_seen_month_switch) );
  INTEGER2 dt_last_seen_day_score := MAP ( le.dt_last_seen_day_isnull or ri.dt_last_seen_day_isnull => 0,
                                  le.dt_last_seen_day = ri.dt_last_seen_day => le.dt_last_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.dt_last_seen_day_weight100,s.dt_last_seen_day_switch) );
  INTEGER2 dt_last_seen_score_temp := (dt_last_seen_year_score+dt_last_seen_month_score+dt_last_seen_day_score);
  SELF.dt_last_seen_year_match_code := MAP(
                        le.dt_last_seen_year_isnull OR ri.dt_last_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_last_seen_year(le.dt_last_seen_year,ri.dt_last_seen_year));
  SELF.dt_last_seen_month_match_code := MAP(
                        le.dt_last_seen_month_isnull OR ri.dt_last_seen_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_last_seen_month(le.dt_last_seen_month,ri.dt_last_seen_month,le.dt_last_seen_day,ri.dt_last_seen_day));
  SELF.dt_last_seen_day_match_code := MAP(
                        le.dt_last_seen_day_isnull or ri.dt_last_seen_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_dt_last_seen_day(le.dt_last_seen_month,ri.dt_last_seen_month,le.dt_last_seen_day,ri.dt_last_seen_day));
  SELF.dt_last_seen_match_code := MAP(
                        le.dt_last_seen_day_isnull AND le.dt_last_seen_month_isnull AND le.dt_last_seen_year_isnull OR ri.dt_last_seen_day_isnull AND ri.dt_last_seen_month_isnull AND ri.dt_last_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        dt_last_seen_score_temp = dt_last_seen_year_score+dt_last_seen_month_score+dt_last_seen_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.dt_last_seen_score := MAP( le.dt_last_seen_year  IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year) AND le.dt_last_seen_month  IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month) AND le.dt_last_seen_day  IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day) or ri.dt_last_seen_year  IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year) AND ri.dt_last_seen_month  IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month) AND ri.dt_last_seen_day  IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day) => 0,
                        dt_last_seen_score_temp);
 
  SELF.left_dt_last_seen := (( le.dt_last_seen_year * 100 ) + le.dt_last_seen_month ) * 100 + le.dt_last_seen_day;
  SELF.right_dt_last_seen := (( ri.dt_last_seen_year * 100 ) + ri.dt_last_seen_month ) * 100 + ri.dt_last_seen_day;
  INTEGER2 corp_ra_dt_first_seen_year_score := MAP ( le.corp_ra_dt_first_seen_year_isnull or ri.corp_ra_dt_first_seen_year_isnull => 0,
                                  le.corp_ra_dt_first_seen_year = ri.corp_ra_dt_first_seen_year => le.corp_ra_dt_first_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_year_weight100,s.corp_ra_dt_first_seen_year_switch) );
  INTEGER2 corp_ra_dt_first_seen_month_score := MAP ( le.corp_ra_dt_first_seen_month_isnull or ri.corp_ra_dt_first_seen_month_isnull => 0,
                                  le.corp_ra_dt_first_seen_month = ri.corp_ra_dt_first_seen_month => le.corp_ra_dt_first_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_month_weight100,s.corp_ra_dt_first_seen_month_switch) );
  INTEGER2 corp_ra_dt_first_seen_day_score := MAP ( le.corp_ra_dt_first_seen_day_isnull or ri.corp_ra_dt_first_seen_day_isnull => 0,
                                  le.corp_ra_dt_first_seen_day = ri.corp_ra_dt_first_seen_day => le.corp_ra_dt_first_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_first_seen_day_weight100,s.corp_ra_dt_first_seen_day_switch) );
  INTEGER2 corp_ra_dt_first_seen_score_temp := (corp_ra_dt_first_seen_year_score+corp_ra_dt_first_seen_month_score+corp_ra_dt_first_seen_day_score);
  SELF.corp_ra_dt_first_seen_year_match_code := MAP(
                        le.corp_ra_dt_first_seen_year_isnull OR ri.corp_ra_dt_first_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_first_seen_year(le.corp_ra_dt_first_seen_year,ri.corp_ra_dt_first_seen_year));
  SELF.corp_ra_dt_first_seen_month_match_code := MAP(
                        le.corp_ra_dt_first_seen_month_isnull OR ri.corp_ra_dt_first_seen_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_first_seen_month(le.corp_ra_dt_first_seen_month,ri.corp_ra_dt_first_seen_month,le.corp_ra_dt_first_seen_day,ri.corp_ra_dt_first_seen_day));
  SELF.corp_ra_dt_first_seen_day_match_code := MAP(
                        le.corp_ra_dt_first_seen_day_isnull or ri.corp_ra_dt_first_seen_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_first_seen_day(le.corp_ra_dt_first_seen_month,ri.corp_ra_dt_first_seen_month,le.corp_ra_dt_first_seen_day,ri.corp_ra_dt_first_seen_day));
  SELF.corp_ra_dt_first_seen_match_code := MAP(
                        le.corp_ra_dt_first_seen_day_isnull AND le.corp_ra_dt_first_seen_month_isnull AND le.corp_ra_dt_first_seen_year_isnull OR ri.corp_ra_dt_first_seen_day_isnull AND ri.corp_ra_dt_first_seen_month_isnull AND ri.corp_ra_dt_first_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        corp_ra_dt_first_seen_score_temp = corp_ra_dt_first_seen_year_score+corp_ra_dt_first_seen_month_score+corp_ra_dt_first_seen_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.corp_ra_dt_first_seen_score := MAP( le.corp_ra_dt_first_seen_year  IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year) AND le.corp_ra_dt_first_seen_month  IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month) AND le.corp_ra_dt_first_seen_day  IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day) or ri.corp_ra_dt_first_seen_year  IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year) AND ri.corp_ra_dt_first_seen_month  IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month) AND ri.corp_ra_dt_first_seen_day  IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day) => 0,
                        corp_ra_dt_first_seen_score_temp);
 
  SELF.left_corp_ra_dt_first_seen := (( le.corp_ra_dt_first_seen_year * 100 ) + le.corp_ra_dt_first_seen_month ) * 100 + le.corp_ra_dt_first_seen_day;
  SELF.right_corp_ra_dt_first_seen := (( ri.corp_ra_dt_first_seen_year * 100 ) + ri.corp_ra_dt_first_seen_month ) * 100 + ri.corp_ra_dt_first_seen_day;
  INTEGER2 corp_ra_dt_last_seen_year_score := MAP ( le.corp_ra_dt_last_seen_year_isnull or ri.corp_ra_dt_last_seen_year_isnull => 0,
                                  le.corp_ra_dt_last_seen_year = ri.corp_ra_dt_last_seen_year => le.corp_ra_dt_last_seen_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_year_weight100,s.corp_ra_dt_last_seen_year_switch) );
  INTEGER2 corp_ra_dt_last_seen_month_score := MAP ( le.corp_ra_dt_last_seen_month_isnull or ri.corp_ra_dt_last_seen_month_isnull => 0,
                                  le.corp_ra_dt_last_seen_month = ri.corp_ra_dt_last_seen_month => le.corp_ra_dt_last_seen_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_month_weight100,s.corp_ra_dt_last_seen_month_switch) );
  INTEGER2 corp_ra_dt_last_seen_day_score := MAP ( le.corp_ra_dt_last_seen_day_isnull or ri.corp_ra_dt_last_seen_day_isnull => 0,
                                  le.corp_ra_dt_last_seen_day = ri.corp_ra_dt_last_seen_day => le.corp_ra_dt_last_seen_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_ra_dt_last_seen_day_weight100,s.corp_ra_dt_last_seen_day_switch) );
  INTEGER2 corp_ra_dt_last_seen_score_temp := (corp_ra_dt_last_seen_year_score+corp_ra_dt_last_seen_month_score+corp_ra_dt_last_seen_day_score);
  SELF.corp_ra_dt_last_seen_year_match_code := MAP(
                        le.corp_ra_dt_last_seen_year_isnull OR ri.corp_ra_dt_last_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_last_seen_year(le.corp_ra_dt_last_seen_year,ri.corp_ra_dt_last_seen_year));
  SELF.corp_ra_dt_last_seen_month_match_code := MAP(
                        le.corp_ra_dt_last_seen_month_isnull OR ri.corp_ra_dt_last_seen_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_last_seen_month(le.corp_ra_dt_last_seen_month,ri.corp_ra_dt_last_seen_month,le.corp_ra_dt_last_seen_day,ri.corp_ra_dt_last_seen_day));
  SELF.corp_ra_dt_last_seen_day_match_code := MAP(
                        le.corp_ra_dt_last_seen_day_isnull or ri.corp_ra_dt_last_seen_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_ra_dt_last_seen_day(le.corp_ra_dt_last_seen_month,ri.corp_ra_dt_last_seen_month,le.corp_ra_dt_last_seen_day,ri.corp_ra_dt_last_seen_day));
  SELF.corp_ra_dt_last_seen_match_code := MAP(
                        le.corp_ra_dt_last_seen_day_isnull AND le.corp_ra_dt_last_seen_month_isnull AND le.corp_ra_dt_last_seen_year_isnull OR ri.corp_ra_dt_last_seen_day_isnull AND ri.corp_ra_dt_last_seen_month_isnull AND ri.corp_ra_dt_last_seen_year_isnull => SALT34.MatchCode.OneSideNull,
                        corp_ra_dt_last_seen_score_temp = corp_ra_dt_last_seen_year_score+corp_ra_dt_last_seen_month_score+corp_ra_dt_last_seen_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.corp_ra_dt_last_seen_score := MAP( le.corp_ra_dt_last_seen_year  IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year) AND le.corp_ra_dt_last_seen_month  IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month) AND le.corp_ra_dt_last_seen_day  IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day) or ri.corp_ra_dt_last_seen_year  IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year) AND ri.corp_ra_dt_last_seen_month  IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month) AND ri.corp_ra_dt_last_seen_day  IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day) => 0,
                        corp_ra_dt_last_seen_score_temp);
 
  SELF.left_corp_ra_dt_last_seen := (( le.corp_ra_dt_last_seen_year * 100 ) + le.corp_ra_dt_last_seen_month ) * 100 + le.corp_ra_dt_last_seen_day;
  SELF.right_corp_ra_dt_last_seen := (( ri.corp_ra_dt_last_seen_year * 100 ) + ri.corp_ra_dt_last_seen_month ) * 100 + ri.corp_ra_dt_last_seen_day;
  SELF.left_corp_key := le.corp_key;
  SELF.right_corp_key := ri.corp_key;
  SELF.corp_key_match_code := MAP(
		le.corp_key_isnull OR ri.corp_key_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_key(le.corp_key,ri.corp_key));
  SELF.corp_key_score := MAP(
                        le.corp_key_isnull OR ri.corp_key_isnull => 0,
                        le.corp_key = ri.corp_key  => le.corp_key_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_key_weight100,s.corp_key_switch));
  SELF.left_corp_supp_key := le.corp_supp_key;
  SELF.right_corp_supp_key := ri.corp_supp_key;
  SELF.corp_supp_key_match_code := MAP(
		le.corp_supp_key_isnull OR ri.corp_supp_key_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_supp_key(le.corp_supp_key,ri.corp_supp_key));
  SELF.corp_supp_key_score := MAP(
                        le.corp_supp_key_isnull OR ri.corp_supp_key_isnull => 0,
                        le.corp_supp_key = ri.corp_supp_key  => le.corp_supp_key_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_supp_key_weight100,s.corp_supp_key_switch));
  SELF.left_corp_vendor := le.corp_vendor;
  SELF.right_corp_vendor := ri.corp_vendor;
  SELF.corp_vendor_match_code := MAP(
		le.corp_vendor_isnull OR ri.corp_vendor_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_vendor(le.corp_vendor,ri.corp_vendor));
  SELF.corp_vendor_score := MAP(
                        le.corp_vendor_isnull OR ri.corp_vendor_isnull => 0,
                        le.corp_vendor = ri.corp_vendor  => le.corp_vendor_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_weight100,s.corp_vendor_switch));
  SELF.left_corp_vendor_county := le.corp_vendor_county;
  SELF.right_corp_vendor_county := ri.corp_vendor_county;
  SELF.corp_vendor_county_match_code := MAP(
		le.corp_vendor_county_isnull OR ri.corp_vendor_county_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_vendor_county(le.corp_vendor_county,ri.corp_vendor_county));
  SELF.corp_vendor_county_score := MAP(
                        le.corp_vendor_county_isnull OR ri.corp_vendor_county_isnull => 0,
                        le.corp_vendor_county = ri.corp_vendor_county  => le.corp_vendor_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_county_weight100,s.corp_vendor_county_switch));
  SELF.left_corp_vendor_subcode := le.corp_vendor_subcode;
  SELF.right_corp_vendor_subcode := ri.corp_vendor_subcode;
  SELF.corp_vendor_subcode_match_code := MAP(
		le.corp_vendor_subcode_isnull OR ri.corp_vendor_subcode_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_vendor_subcode(le.corp_vendor_subcode,ri.corp_vendor_subcode));
  SELF.corp_vendor_subcode_score := MAP(
                        le.corp_vendor_subcode_isnull OR ri.corp_vendor_subcode_isnull => 0,
                        le.corp_vendor_subcode = ri.corp_vendor_subcode  => le.corp_vendor_subcode_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_vendor_subcode_weight100,s.corp_vendor_subcode_switch));
  SELF.left_corp_state_origin := le.corp_state_origin;
  SELF.right_corp_state_origin := ri.corp_state_origin;
  SELF.corp_state_origin_match_code := MAP(
		le.corp_state_origin_isnull OR ri.corp_state_origin_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_state_origin(le.corp_state_origin,ri.corp_state_origin));
  SELF.corp_state_origin_score := MAP(
                        le.corp_state_origin_isnull OR ri.corp_state_origin_isnull => 0,
                        le.corp_state_origin = ri.corp_state_origin  => le.corp_state_origin_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_state_origin_weight100,s.corp_state_origin_switch));
  INTEGER2 corp_process_date_year_score := MAP ( le.corp_process_date_year_isnull or ri.corp_process_date_year_isnull => 0,
                                  le.corp_process_date_year = ri.corp_process_date_year => le.corp_process_date_year_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_year_weight100,s.corp_process_date_year_switch) );
  INTEGER2 corp_process_date_month_score := MAP ( le.corp_process_date_month_isnull or ri.corp_process_date_month_isnull => 0,
                                  le.corp_process_date_month = ri.corp_process_date_month => le.corp_process_date_month_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_month_weight100,s.corp_process_date_month_switch) );
  INTEGER2 corp_process_date_day_score := MAP ( le.corp_process_date_day_isnull or ri.corp_process_date_day_isnull => 0,
                                  le.corp_process_date_day = ri.corp_process_date_day => le.corp_process_date_day_weight100,
                                  SALT34.fn_fail_scale(le.corp_process_date_day_weight100,s.corp_process_date_day_switch) );
  INTEGER2 corp_process_date_score_temp := (corp_process_date_year_score+corp_process_date_month_score+corp_process_date_day_score);
  SELF.corp_process_date_year_match_code := MAP(
                        le.corp_process_date_year_isnull OR ri.corp_process_date_year_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_process_date_year(le.corp_process_date_year,ri.corp_process_date_year));
  SELF.corp_process_date_month_match_code := MAP(
                        le.corp_process_date_month_isnull OR ri.corp_process_date_month_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_process_date_month(le.corp_process_date_month,ri.corp_process_date_month,le.corp_process_date_day,ri.corp_process_date_day));
  SELF.corp_process_date_day_match_code := MAP(
                        le.corp_process_date_day_isnull or ri.corp_process_date_day_isnull => SALT34.MatchCode.OneSideNull,
                        match_methods(ih).match_corp_process_date_day(le.corp_process_date_month,ri.corp_process_date_month,le.corp_process_date_day,ri.corp_process_date_day));
  SELF.corp_process_date_match_code := MAP(
                        le.corp_process_date_day_isnull AND le.corp_process_date_month_isnull AND le.corp_process_date_year_isnull OR ri.corp_process_date_day_isnull AND ri.corp_process_date_month_isnull AND ri.corp_process_date_year_isnull => SALT34.MatchCode.OneSideNull,
                        corp_process_date_score_temp = corp_process_date_year_score+corp_process_date_month_score+corp_process_date_day_score => SALT34.MatchCode.DateAggregate,
                        SALT34.MatchCode.NoMatch);
  SELF.corp_process_date_score := MAP( le.corp_process_date_year  IN SET(s.nulls_corp_process_date_year,corp_process_date_year) AND le.corp_process_date_month  IN SET(s.nulls_corp_process_date_month,corp_process_date_month) AND le.corp_process_date_day  IN SET(s.nulls_corp_process_date_day,corp_process_date_day) or ri.corp_process_date_year  IN SET(s.nulls_corp_process_date_year,corp_process_date_year) AND ri.corp_process_date_month  IN SET(s.nulls_corp_process_date_month,corp_process_date_month) AND ri.corp_process_date_day  IN SET(s.nulls_corp_process_date_day,corp_process_date_day) => 0,
                        corp_process_date_score_temp);
 
  SELF.left_corp_process_date := (( le.corp_process_date_year * 100 ) + le.corp_process_date_month ) * 100 + le.corp_process_date_day;
  SELF.right_corp_process_date := (( ri.corp_process_date_year * 100 ) + ri.corp_process_date_month ) * 100 + ri.corp_process_date_day;
  SELF.left_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr;
  SELF.right_corp_orig_sos_charter_nbr := ri.corp_orig_sos_charter_nbr;
  SELF.corp_orig_sos_charter_nbr_match_code := MAP(
		le.corp_orig_sos_charter_nbr_isnull OR ri.corp_orig_sos_charter_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_orig_sos_charter_nbr(le.corp_orig_sos_charter_nbr,ri.corp_orig_sos_charter_nbr));
  SELF.corp_orig_sos_charter_nbr_score := MAP(
                        le.corp_orig_sos_charter_nbr_isnull OR ri.corp_orig_sos_charter_nbr_isnull => 0,
                        le.corp_orig_sos_charter_nbr = ri.corp_orig_sos_charter_nbr  => le.corp_orig_sos_charter_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_sos_charter_nbr_weight100,s.corp_orig_sos_charter_nbr_switch));
  SELF.left_corp_legal_name := le.corp_legal_name;
  SELF.right_corp_legal_name := ri.corp_legal_name;
  SELF.corp_legal_name_match_code := MAP(
		le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_legal_name(le.corp_legal_name,ri.corp_legal_name));
  SELF.corp_legal_name_score := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_legal_name_weight100,s.corp_legal_name_switch));
  SELF.left_corp_ln_name_type_cd := le.corp_ln_name_type_cd;
  SELF.right_corp_ln_name_type_cd := ri.corp_ln_name_type_cd;
  SELF.corp_ln_name_type_cd_match_code := MAP(
		le.corp_ln_name_type_cd_isnull OR ri.corp_ln_name_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ln_name_type_cd(le.corp_ln_name_type_cd,ri.corp_ln_name_type_cd));
  SELF.corp_ln_name_type_cd_score := MAP(
                        le.corp_ln_name_type_cd_isnull OR ri.corp_ln_name_type_cd_isnull => 0,
                        le.corp_ln_name_type_cd = ri.corp_ln_name_type_cd  => le.corp_ln_name_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ln_name_type_cd_weight100,s.corp_ln_name_type_cd_switch));
  SELF.left_corp_ln_name_type_desc := le.corp_ln_name_type_desc;
  SELF.right_corp_ln_name_type_desc := ri.corp_ln_name_type_desc;
  SELF.corp_ln_name_type_desc_match_code := MAP(
		le.corp_ln_name_type_desc_isnull OR ri.corp_ln_name_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ln_name_type_desc(le.corp_ln_name_type_desc,ri.corp_ln_name_type_desc));
  SELF.corp_ln_name_type_desc_score := MAP(
                        le.corp_ln_name_type_desc_isnull OR ri.corp_ln_name_type_desc_isnull => 0,
                        le.corp_ln_name_type_desc = ri.corp_ln_name_type_desc  => le.corp_ln_name_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ln_name_type_desc_weight100,s.corp_ln_name_type_desc_switch));
  SELF.left_corp_supp_nbr := le.corp_supp_nbr;
  SELF.right_corp_supp_nbr := ri.corp_supp_nbr;
  SELF.corp_supp_nbr_match_code := MAP(
		le.corp_supp_nbr_isnull OR ri.corp_supp_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_supp_nbr(le.corp_supp_nbr,ri.corp_supp_nbr));
  SELF.corp_supp_nbr_score := MAP(
                        le.corp_supp_nbr_isnull OR ri.corp_supp_nbr_isnull => 0,
                        le.corp_supp_nbr = ri.corp_supp_nbr  => le.corp_supp_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_supp_nbr_weight100,s.corp_supp_nbr_switch));
  SELF.left_corp_name_comment := le.corp_name_comment;
  SELF.right_corp_name_comment := ri.corp_name_comment;
  SELF.corp_name_comment_match_code := MAP(
		le.corp_name_comment_isnull OR ri.corp_name_comment_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_comment(le.corp_name_comment,ri.corp_name_comment));
  SELF.corp_name_comment_score := MAP(
                        le.corp_name_comment_isnull OR ri.corp_name_comment_isnull => 0,
                        le.corp_name_comment = ri.corp_name_comment  => le.corp_name_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_comment_weight100,s.corp_name_comment_switch));
  SELF.left_corp_address1_type_cd := le.corp_address1_type_cd;
  SELF.right_corp_address1_type_cd := ri.corp_address1_type_cd;
  SELF.corp_address1_type_cd_match_code := MAP(
		le.corp_address1_type_cd_isnull OR ri.corp_address1_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_type_cd(le.corp_address1_type_cd,ri.corp_address1_type_cd));
  SELF.corp_address1_type_cd_score := MAP(
                        le.corp_address1_type_cd_isnull OR ri.corp_address1_type_cd_isnull => 0,
                        le.corp_address1_type_cd = ri.corp_address1_type_cd  => le.corp_address1_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_type_cd_weight100,s.corp_address1_type_cd_switch));
  SELF.left_corp_address1_type_desc := le.corp_address1_type_desc;
  SELF.right_corp_address1_type_desc := ri.corp_address1_type_desc;
  SELF.corp_address1_type_desc_match_code := MAP(
		le.corp_address1_type_desc_isnull OR ri.corp_address1_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_type_desc(le.corp_address1_type_desc,ri.corp_address1_type_desc));
  SELF.corp_address1_type_desc_score := MAP(
                        le.corp_address1_type_desc_isnull OR ri.corp_address1_type_desc_isnull => 0,
                        le.corp_address1_type_desc = ri.corp_address1_type_desc  => le.corp_address1_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_type_desc_weight100,s.corp_address1_type_desc_switch));
  SELF.left_corp_address1_line1 := le.corp_address1_line1;
  SELF.right_corp_address1_line1 := ri.corp_address1_line1;
  SELF.corp_address1_line1_match_code := MAP(
		le.corp_address1_line1_isnull OR ri.corp_address1_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_line1(le.corp_address1_line1,ri.corp_address1_line1));
  SELF.corp_address1_line1_score := MAP(
                        le.corp_address1_line1_isnull OR ri.corp_address1_line1_isnull => 0,
                        le.corp_address1_line1 = ri.corp_address1_line1  => le.corp_address1_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line1_weight100,s.corp_address1_line1_switch));
  SELF.left_corp_address1_line2 := le.corp_address1_line2;
  SELF.right_corp_address1_line2 := ri.corp_address1_line2;
  SELF.corp_address1_line2_match_code := MAP(
		le.corp_address1_line2_isnull OR ri.corp_address1_line2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_line2(le.corp_address1_line2,ri.corp_address1_line2));
  SELF.corp_address1_line2_score := MAP(
                        le.corp_address1_line2_isnull OR ri.corp_address1_line2_isnull => 0,
                        le.corp_address1_line2 = ri.corp_address1_line2  => le.corp_address1_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line2_weight100,s.corp_address1_line2_switch));
  SELF.left_corp_address1_line3 := le.corp_address1_line3;
  SELF.right_corp_address1_line3 := ri.corp_address1_line3;
  SELF.corp_address1_line3_match_code := MAP(
		le.corp_address1_line3_isnull OR ri.corp_address1_line3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_line3(le.corp_address1_line3,ri.corp_address1_line3));
  SELF.corp_address1_line3_score := MAP(
                        le.corp_address1_line3_isnull OR ri.corp_address1_line3_isnull => 0,
                        le.corp_address1_line3 = ri.corp_address1_line3  => le.corp_address1_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_line3_weight100,s.corp_address1_line3_switch));
  SELF.left_corp_address1_effective_date := le.corp_address1_effective_date;
  SELF.right_corp_address1_effective_date := ri.corp_address1_effective_date;
  SELF.corp_address1_effective_date_match_code := MAP(
		le.corp_address1_effective_date_isnull OR ri.corp_address1_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address1_effective_date(le.corp_address1_effective_date,ri.corp_address1_effective_date));
  SELF.corp_address1_effective_date_score := MAP(
                        le.corp_address1_effective_date_isnull OR ri.corp_address1_effective_date_isnull => 0,
                        le.corp_address1_effective_date = ri.corp_address1_effective_date  => le.corp_address1_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address1_effective_date_weight100,s.corp_address1_effective_date_switch));
  SELF.left_corp_address2_type_cd := le.corp_address2_type_cd;
  SELF.right_corp_address2_type_cd := ri.corp_address2_type_cd;
  SELF.corp_address2_type_cd_match_code := MAP(
		le.corp_address2_type_cd_isnull OR ri.corp_address2_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_type_cd(le.corp_address2_type_cd,ri.corp_address2_type_cd));
  SELF.corp_address2_type_cd_score := MAP(
                        le.corp_address2_type_cd_isnull OR ri.corp_address2_type_cd_isnull => 0,
                        le.corp_address2_type_cd = ri.corp_address2_type_cd  => le.corp_address2_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_type_cd_weight100,s.corp_address2_type_cd_switch));
  SELF.left_corp_address2_type_desc := le.corp_address2_type_desc;
  SELF.right_corp_address2_type_desc := ri.corp_address2_type_desc;
  SELF.corp_address2_type_desc_match_code := MAP(
		le.corp_address2_type_desc_isnull OR ri.corp_address2_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_type_desc(le.corp_address2_type_desc,ri.corp_address2_type_desc));
  SELF.corp_address2_type_desc_score := MAP(
                        le.corp_address2_type_desc_isnull OR ri.corp_address2_type_desc_isnull => 0,
                        le.corp_address2_type_desc = ri.corp_address2_type_desc  => le.corp_address2_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_type_desc_weight100,s.corp_address2_type_desc_switch));
  SELF.left_corp_address2_line1 := le.corp_address2_line1;
  SELF.right_corp_address2_line1 := ri.corp_address2_line1;
  SELF.corp_address2_line1_match_code := MAP(
		le.corp_address2_line1_isnull OR ri.corp_address2_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_line1(le.corp_address2_line1,ri.corp_address2_line1));
  SELF.corp_address2_line1_score := MAP(
                        le.corp_address2_line1_isnull OR ri.corp_address2_line1_isnull => 0,
                        le.corp_address2_line1 = ri.corp_address2_line1  => le.corp_address2_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line1_weight100,s.corp_address2_line1_switch));
  SELF.left_corp_address2_line2 := le.corp_address2_line2;
  SELF.right_corp_address2_line2 := ri.corp_address2_line2;
  SELF.corp_address2_line2_match_code := MAP(
		le.corp_address2_line2_isnull OR ri.corp_address2_line2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_line2(le.corp_address2_line2,ri.corp_address2_line2));
  SELF.corp_address2_line2_score := MAP(
                        le.corp_address2_line2_isnull OR ri.corp_address2_line2_isnull => 0,
                        le.corp_address2_line2 = ri.corp_address2_line2  => le.corp_address2_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line2_weight100,s.corp_address2_line2_switch));
  SELF.left_corp_address2_line3 := le.corp_address2_line3;
  SELF.right_corp_address2_line3 := ri.corp_address2_line3;
  SELF.corp_address2_line3_match_code := MAP(
		le.corp_address2_line3_isnull OR ri.corp_address2_line3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_line3(le.corp_address2_line3,ri.corp_address2_line3));
  SELF.corp_address2_line3_score := MAP(
                        le.corp_address2_line3_isnull OR ri.corp_address2_line3_isnull => 0,
                        le.corp_address2_line3 = ri.corp_address2_line3  => le.corp_address2_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_line3_weight100,s.corp_address2_line3_switch));
  SELF.left_corp_address2_effective_date := le.corp_address2_effective_date;
  SELF.right_corp_address2_effective_date := ri.corp_address2_effective_date;
  SELF.corp_address2_effective_date_match_code := MAP(
		le.corp_address2_effective_date_isnull OR ri.corp_address2_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address2_effective_date(le.corp_address2_effective_date,ri.corp_address2_effective_date));
  SELF.corp_address2_effective_date_score := MAP(
                        le.corp_address2_effective_date_isnull OR ri.corp_address2_effective_date_isnull => 0,
                        le.corp_address2_effective_date = ri.corp_address2_effective_date  => le.corp_address2_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address2_effective_date_weight100,s.corp_address2_effective_date_switch));
  SELF.left_corp_phone_number := le.corp_phone_number;
  SELF.right_corp_phone_number := ri.corp_phone_number;
  SELF.corp_phone_number_match_code := MAP(
		le.corp_phone_number_isnull OR ri.corp_phone_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_phone_number(le.corp_phone_number,ri.corp_phone_number));
  SELF.corp_phone_number_score := MAP(
                        le.corp_phone_number_isnull OR ri.corp_phone_number_isnull => 0,
                        le.corp_phone_number = ri.corp_phone_number  => le.corp_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_weight100,s.corp_phone_number_switch));
  SELF.left_corp_phone_number_type_cd := le.corp_phone_number_type_cd;
  SELF.right_corp_phone_number_type_cd := ri.corp_phone_number_type_cd;
  SELF.corp_phone_number_type_cd_match_code := MAP(
		le.corp_phone_number_type_cd_isnull OR ri.corp_phone_number_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_phone_number_type_cd(le.corp_phone_number_type_cd,ri.corp_phone_number_type_cd));
  SELF.corp_phone_number_type_cd_score := MAP(
                        le.corp_phone_number_type_cd_isnull OR ri.corp_phone_number_type_cd_isnull => 0,
                        le.corp_phone_number_type_cd = ri.corp_phone_number_type_cd  => le.corp_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_type_cd_weight100,s.corp_phone_number_type_cd_switch));
  SELF.left_corp_phone_number_type_desc := le.corp_phone_number_type_desc;
  SELF.right_corp_phone_number_type_desc := ri.corp_phone_number_type_desc;
  SELF.corp_phone_number_type_desc_match_code := MAP(
		le.corp_phone_number_type_desc_isnull OR ri.corp_phone_number_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_phone_number_type_desc(le.corp_phone_number_type_desc,ri.corp_phone_number_type_desc));
  SELF.corp_phone_number_type_desc_score := MAP(
                        le.corp_phone_number_type_desc_isnull OR ri.corp_phone_number_type_desc_isnull => 0,
                        le.corp_phone_number_type_desc = ri.corp_phone_number_type_desc  => le.corp_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_phone_number_type_desc_weight100,s.corp_phone_number_type_desc_switch));
  SELF.left_corp_fax_nbr := le.corp_fax_nbr;
  SELF.right_corp_fax_nbr := ri.corp_fax_nbr;
  SELF.corp_fax_nbr_match_code := MAP(
		le.corp_fax_nbr_isnull OR ri.corp_fax_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_fax_nbr(le.corp_fax_nbr,ri.corp_fax_nbr));
  SELF.corp_fax_nbr_score := MAP(
                        le.corp_fax_nbr_isnull OR ri.corp_fax_nbr_isnull => 0,
                        le.corp_fax_nbr = ri.corp_fax_nbr  => le.corp_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fax_nbr_weight100,s.corp_fax_nbr_switch));
  SELF.left_corp_email_address := le.corp_email_address;
  SELF.right_corp_email_address := ri.corp_email_address;
  SELF.corp_email_address_match_code := MAP(
		le.corp_email_address_isnull OR ri.corp_email_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_email_address(le.corp_email_address,ri.corp_email_address));
  SELF.corp_email_address_score := MAP(
                        le.corp_email_address_isnull OR ri.corp_email_address_isnull => 0,
                        le.corp_email_address = ri.corp_email_address  => le.corp_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_email_address_weight100,s.corp_email_address_switch));
  SELF.left_corp_web_address := le.corp_web_address;
  SELF.right_corp_web_address := ri.corp_web_address;
  SELF.corp_web_address_match_code := MAP(
		le.corp_web_address_isnull OR ri.corp_web_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_web_address(le.corp_web_address,ri.corp_web_address));
  SELF.corp_web_address_score := MAP(
                        le.corp_web_address_isnull OR ri.corp_web_address_isnull => 0,
                        le.corp_web_address = ri.corp_web_address  => le.corp_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_web_address_weight100,s.corp_web_address_switch));
  SELF.left_corp_filing_reference_nbr := le.corp_filing_reference_nbr;
  SELF.right_corp_filing_reference_nbr := ri.corp_filing_reference_nbr;
  SELF.corp_filing_reference_nbr_match_code := MAP(
		le.corp_filing_reference_nbr_isnull OR ri.corp_filing_reference_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_filing_reference_nbr(le.corp_filing_reference_nbr,ri.corp_filing_reference_nbr));
  SELF.corp_filing_reference_nbr_score := MAP(
                        le.corp_filing_reference_nbr_isnull OR ri.corp_filing_reference_nbr_isnull => 0,
                        le.corp_filing_reference_nbr = ri.corp_filing_reference_nbr  => le.corp_filing_reference_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_reference_nbr_weight100,s.corp_filing_reference_nbr_switch));
  SELF.left_corp_filing_date := le.corp_filing_date;
  SELF.right_corp_filing_date := ri.corp_filing_date;
  SELF.corp_filing_date_match_code := MAP(
		le.corp_filing_date_isnull OR ri.corp_filing_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_filing_date(le.corp_filing_date,ri.corp_filing_date));
  SELF.corp_filing_date_score := MAP(
                        le.corp_filing_date_isnull OR ri.corp_filing_date_isnull => 0,
                        le.corp_filing_date = ri.corp_filing_date  => le.corp_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_date_weight100,s.corp_filing_date_switch));
  SELF.left_corp_filing_cd := le.corp_filing_cd;
  SELF.right_corp_filing_cd := ri.corp_filing_cd;
  SELF.corp_filing_cd_match_code := MAP(
		le.corp_filing_cd_isnull OR ri.corp_filing_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_filing_cd(le.corp_filing_cd,ri.corp_filing_cd));
  SELF.corp_filing_cd_score := MAP(
                        le.corp_filing_cd_isnull OR ri.corp_filing_cd_isnull => 0,
                        le.corp_filing_cd = ri.corp_filing_cd  => le.corp_filing_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_cd_weight100,s.corp_filing_cd_switch));
  SELF.left_corp_filing_desc := le.corp_filing_desc;
  SELF.right_corp_filing_desc := ri.corp_filing_desc;
  SELF.corp_filing_desc_match_code := MAP(
		le.corp_filing_desc_isnull OR ri.corp_filing_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_filing_desc(le.corp_filing_desc,ri.corp_filing_desc));
  SELF.corp_filing_desc_score := MAP(
                        le.corp_filing_desc_isnull OR ri.corp_filing_desc_isnull => 0,
                        le.corp_filing_desc = ri.corp_filing_desc  => le.corp_filing_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_filing_desc_weight100,s.corp_filing_desc_switch));
  SELF.left_corp_status_cd := le.corp_status_cd;
  SELF.right_corp_status_cd := ri.corp_status_cd;
  SELF.corp_status_cd_match_code := MAP(
		le.corp_status_cd_isnull OR ri.corp_status_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_status_cd(le.corp_status_cd,ri.corp_status_cd));
  SELF.corp_status_cd_score := MAP(
                        le.corp_status_cd_isnull OR ri.corp_status_cd_isnull => 0,
                        le.corp_status_cd = ri.corp_status_cd  => le.corp_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_cd_weight100,s.corp_status_cd_switch));
  SELF.left_corp_status_desc := le.corp_status_desc;
  SELF.right_corp_status_desc := ri.corp_status_desc;
  SELF.corp_status_desc_match_code := MAP(
		le.corp_status_desc_isnull OR ri.corp_status_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_status_desc(le.corp_status_desc,ri.corp_status_desc));
  SELF.corp_status_desc_score := MAP(
                        le.corp_status_desc_isnull OR ri.corp_status_desc_isnull => 0,
                        le.corp_status_desc = ri.corp_status_desc  => le.corp_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_desc_weight100,s.corp_status_desc_switch));
  SELF.left_corp_status_date := le.corp_status_date;
  SELF.right_corp_status_date := ri.corp_status_date;
  SELF.corp_status_date_match_code := MAP(
		le.corp_status_date_isnull OR ri.corp_status_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_status_date(le.corp_status_date,ri.corp_status_date));
  SELF.corp_status_date_score := MAP(
                        le.corp_status_date_isnull OR ri.corp_status_date_isnull => 0,
                        le.corp_status_date = ri.corp_status_date  => le.corp_status_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_date_weight100,s.corp_status_date_switch));
  SELF.left_corp_standing := le.corp_standing;
  SELF.right_corp_standing := ri.corp_standing;
  SELF.corp_standing_match_code := MAP(
		le.corp_standing_isnull OR ri.corp_standing_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_standing(le.corp_standing,ri.corp_standing));
  SELF.corp_standing_score := MAP(
                        le.corp_standing_isnull OR ri.corp_standing_isnull => 0,
                        le.corp_standing = ri.corp_standing  => le.corp_standing_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_standing_weight100,s.corp_standing_switch));
  SELF.left_corp_status_comment := le.corp_status_comment;
  SELF.right_corp_status_comment := ri.corp_status_comment;
  SELF.corp_status_comment_match_code := MAP(
		le.corp_status_comment_isnull OR ri.corp_status_comment_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_status_comment(le.corp_status_comment,ri.corp_status_comment));
  SELF.corp_status_comment_score := MAP(
                        le.corp_status_comment_isnull OR ri.corp_status_comment_isnull => 0,
                        le.corp_status_comment = ri.corp_status_comment  => le.corp_status_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_status_comment_weight100,s.corp_status_comment_switch));
  SELF.left_corp_ticker_symbol := le.corp_ticker_symbol;
  SELF.right_corp_ticker_symbol := ri.corp_ticker_symbol;
  SELF.corp_ticker_symbol_match_code := MAP(
		le.corp_ticker_symbol_isnull OR ri.corp_ticker_symbol_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ticker_symbol(le.corp_ticker_symbol,ri.corp_ticker_symbol));
  SELF.corp_ticker_symbol_score := MAP(
                        le.corp_ticker_symbol_isnull OR ri.corp_ticker_symbol_isnull => 0,
                        le.corp_ticker_symbol = ri.corp_ticker_symbol  => le.corp_ticker_symbol_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ticker_symbol_weight100,s.corp_ticker_symbol_switch));
  SELF.left_corp_stock_exchange := le.corp_stock_exchange;
  SELF.right_corp_stock_exchange := ri.corp_stock_exchange;
  SELF.corp_stock_exchange_match_code := MAP(
		le.corp_stock_exchange_isnull OR ri.corp_stock_exchange_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_stock_exchange(le.corp_stock_exchange,ri.corp_stock_exchange));
  SELF.corp_stock_exchange_score := MAP(
                        le.corp_stock_exchange_isnull OR ri.corp_stock_exchange_isnull => 0,
                        le.corp_stock_exchange = ri.corp_stock_exchange  => le.corp_stock_exchange_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_stock_exchange_weight100,s.corp_stock_exchange_switch));
  SELF.left_corp_inc_state := le.corp_inc_state;
  SELF.right_corp_inc_state := ri.corp_inc_state;
  SELF.corp_inc_state_match_code := MAP(
		le.corp_inc_state_isnull OR ri.corp_inc_state_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_inc_state(le.corp_inc_state,ri.corp_inc_state));
  SELF.corp_inc_state_score := MAP(
                        le.corp_inc_state_isnull OR ri.corp_inc_state_isnull => 0,
                        le.corp_inc_state = ri.corp_inc_state  => le.corp_inc_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_state_weight100,s.corp_inc_state_switch));
  SELF.left_corp_inc_county := le.corp_inc_county;
  SELF.right_corp_inc_county := ri.corp_inc_county;
  SELF.corp_inc_county_match_code := MAP(
		le.corp_inc_county_isnull OR ri.corp_inc_county_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_inc_county(le.corp_inc_county,ri.corp_inc_county));
  SELF.corp_inc_county_score := MAP(
                        le.corp_inc_county_isnull OR ri.corp_inc_county_isnull => 0,
                        le.corp_inc_county = ri.corp_inc_county  => le.corp_inc_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_county_weight100,s.corp_inc_county_switch));
  SELF.left_corp_inc_date := le.corp_inc_date;
  SELF.right_corp_inc_date := ri.corp_inc_date;
  SELF.corp_inc_date_match_code := MAP(
		le.corp_inc_date_isnull OR ri.corp_inc_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_inc_date(le.corp_inc_date,ri.corp_inc_date));
  SELF.corp_inc_date_score := MAP(
                        le.corp_inc_date_isnull OR ri.corp_inc_date_isnull => 0,
                        le.corp_inc_date = ri.corp_inc_date  => le.corp_inc_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_inc_date_weight100,s.corp_inc_date_switch));
  SELF.left_corp_anniversary_month := le.corp_anniversary_month;
  SELF.right_corp_anniversary_month := ri.corp_anniversary_month;
  SELF.corp_anniversary_month_match_code := MAP(
		le.corp_anniversary_month_isnull OR ri.corp_anniversary_month_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_anniversary_month(le.corp_anniversary_month,ri.corp_anniversary_month));
  SELF.corp_anniversary_month_score := MAP(
                        le.corp_anniversary_month_isnull OR ri.corp_anniversary_month_isnull => 0,
                        le.corp_anniversary_month = ri.corp_anniversary_month  => le.corp_anniversary_month_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_anniversary_month_weight100,s.corp_anniversary_month_switch));
  SELF.left_corp_fed_tax_id := le.corp_fed_tax_id;
  SELF.right_corp_fed_tax_id := ri.corp_fed_tax_id;
  SELF.corp_fed_tax_id_match_code := MAP(
		le.corp_fed_tax_id_isnull OR ri.corp_fed_tax_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_fed_tax_id(le.corp_fed_tax_id,ri.corp_fed_tax_id));
  SELF.corp_fed_tax_id_score := MAP(
                        le.corp_fed_tax_id_isnull OR ri.corp_fed_tax_id_isnull => 0,
                        le.corp_fed_tax_id = ri.corp_fed_tax_id  => le.corp_fed_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fed_tax_id_weight100,s.corp_fed_tax_id_switch));
  SELF.left_corp_state_tax_id := le.corp_state_tax_id;
  SELF.right_corp_state_tax_id := ri.corp_state_tax_id;
  SELF.corp_state_tax_id_match_code := MAP(
		le.corp_state_tax_id_isnull OR ri.corp_state_tax_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_state_tax_id(le.corp_state_tax_id,ri.corp_state_tax_id));
  SELF.corp_state_tax_id_score := MAP(
                        le.corp_state_tax_id_isnull OR ri.corp_state_tax_id_isnull => 0,
                        le.corp_state_tax_id = ri.corp_state_tax_id  => le.corp_state_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_state_tax_id_weight100,s.corp_state_tax_id_switch));
  SELF.left_corp_term_exist_cd := le.corp_term_exist_cd;
  SELF.right_corp_term_exist_cd := ri.corp_term_exist_cd;
  SELF.corp_term_exist_cd_match_code := MAP(
		le.corp_term_exist_cd_isnull OR ri.corp_term_exist_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_term_exist_cd(le.corp_term_exist_cd,ri.corp_term_exist_cd));
  SELF.corp_term_exist_cd_score := MAP(
                        le.corp_term_exist_cd_isnull OR ri.corp_term_exist_cd_isnull => 0,
                        le.corp_term_exist_cd = ri.corp_term_exist_cd  => le.corp_term_exist_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_cd_weight100,s.corp_term_exist_cd_switch));
  SELF.left_corp_term_exist_exp := le.corp_term_exist_exp;
  SELF.right_corp_term_exist_exp := ri.corp_term_exist_exp;
  SELF.corp_term_exist_exp_match_code := MAP(
		le.corp_term_exist_exp_isnull OR ri.corp_term_exist_exp_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_term_exist_exp(le.corp_term_exist_exp,ri.corp_term_exist_exp));
  SELF.corp_term_exist_exp_score := MAP(
                        le.corp_term_exist_exp_isnull OR ri.corp_term_exist_exp_isnull => 0,
                        le.corp_term_exist_exp = ri.corp_term_exist_exp  => le.corp_term_exist_exp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_exp_weight100,s.corp_term_exist_exp_switch));
  SELF.left_corp_term_exist_desc := le.corp_term_exist_desc;
  SELF.right_corp_term_exist_desc := ri.corp_term_exist_desc;
  SELF.corp_term_exist_desc_match_code := MAP(
		le.corp_term_exist_desc_isnull OR ri.corp_term_exist_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_term_exist_desc(le.corp_term_exist_desc,ri.corp_term_exist_desc));
  SELF.corp_term_exist_desc_score := MAP(
                        le.corp_term_exist_desc_isnull OR ri.corp_term_exist_desc_isnull => 0,
                        le.corp_term_exist_desc = ri.corp_term_exist_desc  => le.corp_term_exist_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_term_exist_desc_weight100,s.corp_term_exist_desc_switch));
  SELF.left_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind;
  SELF.right_corp_foreign_domestic_ind := ri.corp_foreign_domestic_ind;
  SELF.corp_foreign_domestic_ind_match_code := MAP(
		le.corp_foreign_domestic_ind_isnull OR ri.corp_foreign_domestic_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_foreign_domestic_ind(le.corp_foreign_domestic_ind,ri.corp_foreign_domestic_ind));
  SELF.corp_foreign_domestic_ind_score := MAP(
                        le.corp_foreign_domestic_ind_isnull OR ri.corp_foreign_domestic_ind_isnull => 0,
                        le.corp_foreign_domestic_ind = ri.corp_foreign_domestic_ind  => le.corp_foreign_domestic_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_foreign_domestic_ind_weight100,s.corp_foreign_domestic_ind_switch));
  SELF.left_corp_forgn_state_cd := le.corp_forgn_state_cd;
  SELF.right_corp_forgn_state_cd := ri.corp_forgn_state_cd;
  SELF.corp_forgn_state_cd_match_code := MAP(
		le.corp_forgn_state_cd_isnull OR ri.corp_forgn_state_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_state_cd(le.corp_forgn_state_cd,ri.corp_forgn_state_cd));
  SELF.corp_forgn_state_cd_score := MAP(
                        le.corp_forgn_state_cd_isnull OR ri.corp_forgn_state_cd_isnull => 0,
                        le.corp_forgn_state_cd = ri.corp_forgn_state_cd  => le.corp_forgn_state_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_cd_weight100,s.corp_forgn_state_cd_switch));
  SELF.left_corp_forgn_state_desc := le.corp_forgn_state_desc;
  SELF.right_corp_forgn_state_desc := ri.corp_forgn_state_desc;
  SELF.corp_forgn_state_desc_match_code := MAP(
		le.corp_forgn_state_desc_isnull OR ri.corp_forgn_state_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_state_desc(le.corp_forgn_state_desc,ri.corp_forgn_state_desc));
  SELF.corp_forgn_state_desc_score := MAP(
                        le.corp_forgn_state_desc_isnull OR ri.corp_forgn_state_desc_isnull => 0,
                        le.corp_forgn_state_desc = ri.corp_forgn_state_desc  => le.corp_forgn_state_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_desc_weight100,s.corp_forgn_state_desc_switch));
  SELF.left_corp_forgn_sos_charter_nbr := le.corp_forgn_sos_charter_nbr;
  SELF.right_corp_forgn_sos_charter_nbr := ri.corp_forgn_sos_charter_nbr;
  SELF.corp_forgn_sos_charter_nbr_match_code := MAP(
		le.corp_forgn_sos_charter_nbr_isnull OR ri.corp_forgn_sos_charter_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_sos_charter_nbr(le.corp_forgn_sos_charter_nbr,ri.corp_forgn_sos_charter_nbr));
  SELF.corp_forgn_sos_charter_nbr_score := MAP(
                        le.corp_forgn_sos_charter_nbr_isnull OR ri.corp_forgn_sos_charter_nbr_isnull => 0,
                        le.corp_forgn_sos_charter_nbr = ri.corp_forgn_sos_charter_nbr  => le.corp_forgn_sos_charter_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_sos_charter_nbr_weight100,s.corp_forgn_sos_charter_nbr_switch));
  SELF.left_corp_forgn_date := le.corp_forgn_date;
  SELF.right_corp_forgn_date := ri.corp_forgn_date;
  SELF.corp_forgn_date_match_code := MAP(
		le.corp_forgn_date_isnull OR ri.corp_forgn_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_date(le.corp_forgn_date,ri.corp_forgn_date));
  SELF.corp_forgn_date_score := MAP(
                        le.corp_forgn_date_isnull OR ri.corp_forgn_date_isnull => 0,
                        le.corp_forgn_date = ri.corp_forgn_date  => le.corp_forgn_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_date_weight100,s.corp_forgn_date_switch));
  SELF.left_corp_forgn_fed_tax_id := le.corp_forgn_fed_tax_id;
  SELF.right_corp_forgn_fed_tax_id := ri.corp_forgn_fed_tax_id;
  SELF.corp_forgn_fed_tax_id_match_code := MAP(
		le.corp_forgn_fed_tax_id_isnull OR ri.corp_forgn_fed_tax_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_fed_tax_id(le.corp_forgn_fed_tax_id,ri.corp_forgn_fed_tax_id));
  SELF.corp_forgn_fed_tax_id_score := MAP(
                        le.corp_forgn_fed_tax_id_isnull OR ri.corp_forgn_fed_tax_id_isnull => 0,
                        le.corp_forgn_fed_tax_id = ri.corp_forgn_fed_tax_id  => le.corp_forgn_fed_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_fed_tax_id_weight100,s.corp_forgn_fed_tax_id_switch));
  SELF.left_corp_forgn_state_tax_id := le.corp_forgn_state_tax_id;
  SELF.right_corp_forgn_state_tax_id := ri.corp_forgn_state_tax_id;
  SELF.corp_forgn_state_tax_id_match_code := MAP(
		le.corp_forgn_state_tax_id_isnull OR ri.corp_forgn_state_tax_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_state_tax_id(le.corp_forgn_state_tax_id,ri.corp_forgn_state_tax_id));
  SELF.corp_forgn_state_tax_id_score := MAP(
                        le.corp_forgn_state_tax_id_isnull OR ri.corp_forgn_state_tax_id_isnull => 0,
                        le.corp_forgn_state_tax_id = ri.corp_forgn_state_tax_id  => le.corp_forgn_state_tax_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_state_tax_id_weight100,s.corp_forgn_state_tax_id_switch));
  SELF.left_corp_forgn_term_exist_cd := le.corp_forgn_term_exist_cd;
  SELF.right_corp_forgn_term_exist_cd := ri.corp_forgn_term_exist_cd;
  SELF.corp_forgn_term_exist_cd_match_code := MAP(
		le.corp_forgn_term_exist_cd_isnull OR ri.corp_forgn_term_exist_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_term_exist_cd(le.corp_forgn_term_exist_cd,ri.corp_forgn_term_exist_cd));
  SELF.corp_forgn_term_exist_cd_score := MAP(
                        le.corp_forgn_term_exist_cd_isnull OR ri.corp_forgn_term_exist_cd_isnull => 0,
                        le.corp_forgn_term_exist_cd = ri.corp_forgn_term_exist_cd  => le.corp_forgn_term_exist_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_cd_weight100,s.corp_forgn_term_exist_cd_switch));
  SELF.left_corp_forgn_term_exist_exp := le.corp_forgn_term_exist_exp;
  SELF.right_corp_forgn_term_exist_exp := ri.corp_forgn_term_exist_exp;
  SELF.corp_forgn_term_exist_exp_match_code := MAP(
		le.corp_forgn_term_exist_exp_isnull OR ri.corp_forgn_term_exist_exp_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_term_exist_exp(le.corp_forgn_term_exist_exp,ri.corp_forgn_term_exist_exp));
  SELF.corp_forgn_term_exist_exp_score := MAP(
                        le.corp_forgn_term_exist_exp_isnull OR ri.corp_forgn_term_exist_exp_isnull => 0,
                        le.corp_forgn_term_exist_exp = ri.corp_forgn_term_exist_exp  => le.corp_forgn_term_exist_exp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_exp_weight100,s.corp_forgn_term_exist_exp_switch));
  SELF.left_corp_forgn_term_exist_desc := le.corp_forgn_term_exist_desc;
  SELF.right_corp_forgn_term_exist_desc := ri.corp_forgn_term_exist_desc;
  SELF.corp_forgn_term_exist_desc_match_code := MAP(
		le.corp_forgn_term_exist_desc_isnull OR ri.corp_forgn_term_exist_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_forgn_term_exist_desc(le.corp_forgn_term_exist_desc,ri.corp_forgn_term_exist_desc));
  SELF.corp_forgn_term_exist_desc_score := MAP(
                        le.corp_forgn_term_exist_desc_isnull OR ri.corp_forgn_term_exist_desc_isnull => 0,
                        le.corp_forgn_term_exist_desc = ri.corp_forgn_term_exist_desc  => le.corp_forgn_term_exist_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_forgn_term_exist_desc_weight100,s.corp_forgn_term_exist_desc_switch));
  SELF.left_corp_orig_org_structure_cd := le.corp_orig_org_structure_cd;
  SELF.right_corp_orig_org_structure_cd := ri.corp_orig_org_structure_cd;
  SELF.corp_orig_org_structure_cd_match_code := MAP(
		le.corp_orig_org_structure_cd_isnull OR ri.corp_orig_org_structure_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_orig_org_structure_cd(le.corp_orig_org_structure_cd,ri.corp_orig_org_structure_cd));
  SELF.corp_orig_org_structure_cd_score := MAP(
                        le.corp_orig_org_structure_cd_isnull OR ri.corp_orig_org_structure_cd_isnull => 0,
                        le.corp_orig_org_structure_cd = ri.corp_orig_org_structure_cd  => le.corp_orig_org_structure_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_org_structure_cd_weight100,s.corp_orig_org_structure_cd_switch));
  SELF.left_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc;
  SELF.right_corp_orig_org_structure_desc := ri.corp_orig_org_structure_desc;
  SELF.corp_orig_org_structure_desc_match_code := MAP(
		le.corp_orig_org_structure_desc_isnull OR ri.corp_orig_org_structure_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_orig_org_structure_desc(le.corp_orig_org_structure_desc,ri.corp_orig_org_structure_desc));
  SELF.corp_orig_org_structure_desc_score := MAP(
                        le.corp_orig_org_structure_desc_isnull OR ri.corp_orig_org_structure_desc_isnull => 0,
                        le.corp_orig_org_structure_desc = ri.corp_orig_org_structure_desc  => le.corp_orig_org_structure_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_org_structure_desc_weight100,s.corp_orig_org_structure_desc_switch));
  SELF.left_corp_for_profit_ind := le.corp_for_profit_ind;
  SELF.right_corp_for_profit_ind := ri.corp_for_profit_ind;
  SELF.corp_for_profit_ind_match_code := MAP(
		le.corp_for_profit_ind_isnull OR ri.corp_for_profit_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_for_profit_ind(le.corp_for_profit_ind,ri.corp_for_profit_ind));
  SELF.corp_for_profit_ind_score := MAP(
                        le.corp_for_profit_ind_isnull OR ri.corp_for_profit_ind_isnull => 0,
                        le.corp_for_profit_ind = ri.corp_for_profit_ind  => le.corp_for_profit_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_for_profit_ind_weight100,s.corp_for_profit_ind_switch));
  SELF.left_corp_public_or_private_ind := le.corp_public_or_private_ind;
  SELF.right_corp_public_or_private_ind := ri.corp_public_or_private_ind;
  SELF.corp_public_or_private_ind_match_code := MAP(
		le.corp_public_or_private_ind_isnull OR ri.corp_public_or_private_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_public_or_private_ind(le.corp_public_or_private_ind,ri.corp_public_or_private_ind));
  SELF.corp_public_or_private_ind_score := MAP(
                        le.corp_public_or_private_ind_isnull OR ri.corp_public_or_private_ind_isnull => 0,
                        le.corp_public_or_private_ind = ri.corp_public_or_private_ind  => le.corp_public_or_private_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_public_or_private_ind_weight100,s.corp_public_or_private_ind_switch));
  SELF.left_corp_sic_code := le.corp_sic_code;
  SELF.right_corp_sic_code := ri.corp_sic_code;
  SELF.corp_sic_code_match_code := MAP(
		le.corp_sic_code_isnull OR ri.corp_sic_code_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_sic_code(le.corp_sic_code,ri.corp_sic_code));
  SELF.corp_sic_code_score := MAP(
                        le.corp_sic_code_isnull OR ri.corp_sic_code_isnull => 0,
                        le.corp_sic_code = ri.corp_sic_code  => le.corp_sic_code_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_sic_code_weight100,s.corp_sic_code_switch));
  SELF.left_corp_naic_code := le.corp_naic_code;
  SELF.right_corp_naic_code := ri.corp_naic_code;
  SELF.corp_naic_code_match_code := MAP(
		le.corp_naic_code_isnull OR ri.corp_naic_code_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_naic_code(le.corp_naic_code,ri.corp_naic_code));
  SELF.corp_naic_code_score := MAP(
                        le.corp_naic_code_isnull OR ri.corp_naic_code_isnull => 0,
                        le.corp_naic_code = ri.corp_naic_code  => le.corp_naic_code_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_naic_code_weight100,s.corp_naic_code_switch));
  SELF.left_corp_orig_bus_type_cd := le.corp_orig_bus_type_cd;
  SELF.right_corp_orig_bus_type_cd := ri.corp_orig_bus_type_cd;
  SELF.corp_orig_bus_type_cd_match_code := MAP(
		le.corp_orig_bus_type_cd_isnull OR ri.corp_orig_bus_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_orig_bus_type_cd(le.corp_orig_bus_type_cd,ri.corp_orig_bus_type_cd));
  SELF.corp_orig_bus_type_cd_score := MAP(
                        le.corp_orig_bus_type_cd_isnull OR ri.corp_orig_bus_type_cd_isnull => 0,
                        le.corp_orig_bus_type_cd = ri.corp_orig_bus_type_cd  => le.corp_orig_bus_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_bus_type_cd_weight100,s.corp_orig_bus_type_cd_switch));
  SELF.left_corp_orig_bus_type_desc := le.corp_orig_bus_type_desc;
  SELF.right_corp_orig_bus_type_desc := ri.corp_orig_bus_type_desc;
  SELF.corp_orig_bus_type_desc_match_code := MAP(
		le.corp_orig_bus_type_desc_isnull OR ri.corp_orig_bus_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_orig_bus_type_desc(le.corp_orig_bus_type_desc,ri.corp_orig_bus_type_desc));
  SELF.corp_orig_bus_type_desc_score := MAP(
                        le.corp_orig_bus_type_desc_isnull OR ri.corp_orig_bus_type_desc_isnull => 0,
                        le.corp_orig_bus_type_desc = ri.corp_orig_bus_type_desc  => le.corp_orig_bus_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_orig_bus_type_desc_weight100,s.corp_orig_bus_type_desc_switch));
  SELF.left_corp_entity_desc := le.corp_entity_desc;
  SELF.right_corp_entity_desc := ri.corp_entity_desc;
  SELF.corp_entity_desc_match_code := MAP(
		le.corp_entity_desc_isnull OR ri.corp_entity_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_entity_desc(le.corp_entity_desc,ri.corp_entity_desc));
  SELF.corp_entity_desc_score := MAP(
                        le.corp_entity_desc_isnull OR ri.corp_entity_desc_isnull => 0,
                        le.corp_entity_desc = ri.corp_entity_desc  => le.corp_entity_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_entity_desc_weight100,s.corp_entity_desc_switch));
  SELF.left_corp_certificate_nbr := le.corp_certificate_nbr;
  SELF.right_corp_certificate_nbr := ri.corp_certificate_nbr;
  SELF.corp_certificate_nbr_match_code := MAP(
		le.corp_certificate_nbr_isnull OR ri.corp_certificate_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_certificate_nbr(le.corp_certificate_nbr,ri.corp_certificate_nbr));
  SELF.corp_certificate_nbr_score := MAP(
                        le.corp_certificate_nbr_isnull OR ri.corp_certificate_nbr_isnull => 0,
                        le.corp_certificate_nbr = ri.corp_certificate_nbr  => le.corp_certificate_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_certificate_nbr_weight100,s.corp_certificate_nbr_switch));
  SELF.left_corp_internal_nbr := le.corp_internal_nbr;
  SELF.right_corp_internal_nbr := ri.corp_internal_nbr;
  SELF.corp_internal_nbr_match_code := MAP(
		le.corp_internal_nbr_isnull OR ri.corp_internal_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_internal_nbr(le.corp_internal_nbr,ri.corp_internal_nbr));
  SELF.corp_internal_nbr_score := MAP(
                        le.corp_internal_nbr_isnull OR ri.corp_internal_nbr_isnull => 0,
                        le.corp_internal_nbr = ri.corp_internal_nbr  => le.corp_internal_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_internal_nbr_weight100,s.corp_internal_nbr_switch));
  SELF.left_corp_previous_nbr := le.corp_previous_nbr;
  SELF.right_corp_previous_nbr := ri.corp_previous_nbr;
  SELF.corp_previous_nbr_match_code := MAP(
		le.corp_previous_nbr_isnull OR ri.corp_previous_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_previous_nbr(le.corp_previous_nbr,ri.corp_previous_nbr));
  SELF.corp_previous_nbr_score := MAP(
                        le.corp_previous_nbr_isnull OR ri.corp_previous_nbr_isnull => 0,
                        le.corp_previous_nbr = ri.corp_previous_nbr  => le.corp_previous_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_previous_nbr_weight100,s.corp_previous_nbr_switch));
  SELF.left_corp_microfilm_nbr := le.corp_microfilm_nbr;
  SELF.right_corp_microfilm_nbr := ri.corp_microfilm_nbr;
  SELF.corp_microfilm_nbr_match_code := MAP(
		le.corp_microfilm_nbr_isnull OR ri.corp_microfilm_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_microfilm_nbr(le.corp_microfilm_nbr,ri.corp_microfilm_nbr));
  SELF.corp_microfilm_nbr_score := MAP(
                        le.corp_microfilm_nbr_isnull OR ri.corp_microfilm_nbr_isnull => 0,
                        le.corp_microfilm_nbr = ri.corp_microfilm_nbr  => le.corp_microfilm_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_microfilm_nbr_weight100,s.corp_microfilm_nbr_switch));
  SELF.left_corp_amendments_filed := le.corp_amendments_filed;
  SELF.right_corp_amendments_filed := ri.corp_amendments_filed;
  SELF.corp_amendments_filed_match_code := MAP(
		le.corp_amendments_filed_isnull OR ri.corp_amendments_filed_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_amendments_filed(le.corp_amendments_filed,ri.corp_amendments_filed));
  SELF.corp_amendments_filed_score := MAP(
                        le.corp_amendments_filed_isnull OR ri.corp_amendments_filed_isnull => 0,
                        le.corp_amendments_filed = ri.corp_amendments_filed  => le.corp_amendments_filed_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_amendments_filed_weight100,s.corp_amendments_filed_switch));
  SELF.left_corp_acts := le.corp_acts;
  SELF.right_corp_acts := ri.corp_acts;
  SELF.corp_acts_match_code := MAP(
		le.corp_acts_isnull OR ri.corp_acts_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_acts(le.corp_acts,ri.corp_acts));
  SELF.corp_acts_score := MAP(
                        le.corp_acts_isnull OR ri.corp_acts_isnull => 0,
                        le.corp_acts = ri.corp_acts  => le.corp_acts_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts_weight100,s.corp_acts_switch));
  SELF.left_corp_partnership_ind := le.corp_partnership_ind;
  SELF.right_corp_partnership_ind := ri.corp_partnership_ind;
  SELF.corp_partnership_ind_match_code := MAP(
		le.corp_partnership_ind_isnull OR ri.corp_partnership_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_partnership_ind(le.corp_partnership_ind,ri.corp_partnership_ind));
  SELF.corp_partnership_ind_score := MAP(
                        le.corp_partnership_ind_isnull OR ri.corp_partnership_ind_isnull => 0,
                        le.corp_partnership_ind = ri.corp_partnership_ind  => le.corp_partnership_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partnership_ind_weight100,s.corp_partnership_ind_switch));
  SELF.left_corp_mfg_ind := le.corp_mfg_ind;
  SELF.right_corp_mfg_ind := ri.corp_mfg_ind;
  SELF.corp_mfg_ind_match_code := MAP(
		le.corp_mfg_ind_isnull OR ri.corp_mfg_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_mfg_ind(le.corp_mfg_ind,ri.corp_mfg_ind));
  SELF.corp_mfg_ind_score := MAP(
                        le.corp_mfg_ind_isnull OR ri.corp_mfg_ind_isnull => 0,
                        le.corp_mfg_ind = ri.corp_mfg_ind  => le.corp_mfg_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_mfg_ind_weight100,s.corp_mfg_ind_switch));
  SELF.left_corp_addl_info := le.corp_addl_info;
  SELF.right_corp_addl_info := ri.corp_addl_info;
  SELF.corp_addl_info_match_code := MAP(
		le.corp_addl_info_isnull OR ri.corp_addl_info_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_addl_info(le.corp_addl_info,ri.corp_addl_info));
  SELF.corp_addl_info_score := MAP(
                        le.corp_addl_info_isnull OR ri.corp_addl_info_isnull => 0,
                        le.corp_addl_info = ri.corp_addl_info  => le.corp_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_addl_info_weight100,s.corp_addl_info_switch));
  SELF.left_corp_taxes := le.corp_taxes;
  SELF.right_corp_taxes := ri.corp_taxes;
  SELF.corp_taxes_match_code := MAP(
		le.corp_taxes_isnull OR ri.corp_taxes_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_taxes(le.corp_taxes,ri.corp_taxes));
  SELF.corp_taxes_score := MAP(
                        le.corp_taxes_isnull OR ri.corp_taxes_isnull => 0,
                        le.corp_taxes = ri.corp_taxes  => le.corp_taxes_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_taxes_weight100,s.corp_taxes_switch));
  SELF.left_corp_franchise_taxes := le.corp_franchise_taxes;
  SELF.right_corp_franchise_taxes := ri.corp_franchise_taxes;
  SELF.corp_franchise_taxes_match_code := MAP(
		le.corp_franchise_taxes_isnull OR ri.corp_franchise_taxes_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_franchise_taxes(le.corp_franchise_taxes,ri.corp_franchise_taxes));
  SELF.corp_franchise_taxes_score := MAP(
                        le.corp_franchise_taxes_isnull OR ri.corp_franchise_taxes_isnull => 0,
                        le.corp_franchise_taxes = ri.corp_franchise_taxes  => le.corp_franchise_taxes_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_franchise_taxes_weight100,s.corp_franchise_taxes_switch));
  SELF.left_corp_tax_program_cd := le.corp_tax_program_cd;
  SELF.right_corp_tax_program_cd := ri.corp_tax_program_cd;
  SELF.corp_tax_program_cd_match_code := MAP(
		le.corp_tax_program_cd_isnull OR ri.corp_tax_program_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_tax_program_cd(le.corp_tax_program_cd,ri.corp_tax_program_cd));
  SELF.corp_tax_program_cd_score := MAP(
                        le.corp_tax_program_cd_isnull OR ri.corp_tax_program_cd_isnull => 0,
                        le.corp_tax_program_cd = ri.corp_tax_program_cd  => le.corp_tax_program_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_program_cd_weight100,s.corp_tax_program_cd_switch));
  SELF.left_corp_tax_program_desc := le.corp_tax_program_desc;
  SELF.right_corp_tax_program_desc := ri.corp_tax_program_desc;
  SELF.corp_tax_program_desc_match_code := MAP(
		le.corp_tax_program_desc_isnull OR ri.corp_tax_program_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_tax_program_desc(le.corp_tax_program_desc,ri.corp_tax_program_desc));
  SELF.corp_tax_program_desc_score := MAP(
                        le.corp_tax_program_desc_isnull OR ri.corp_tax_program_desc_isnull => 0,
                        le.corp_tax_program_desc = ri.corp_tax_program_desc  => le.corp_tax_program_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_program_desc_weight100,s.corp_tax_program_desc_switch));
  SELF.left_corp_ra_full_name := le.corp_ra_full_name;
  SELF.right_corp_ra_full_name := ri.corp_ra_full_name;
  SELF.corp_ra_full_name_match_code := MAP(
		le.corp_ra_full_name_isnull OR ri.corp_ra_full_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_full_name(le.corp_ra_full_name,ri.corp_ra_full_name));
  SELF.corp_ra_full_name_score := MAP(
                        le.corp_ra_full_name_isnull OR ri.corp_ra_full_name_isnull => 0,
                        le.corp_ra_full_name = ri.corp_ra_full_name  => le.corp_ra_full_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_full_name_weight100,s.corp_ra_full_name_switch));
  SELF.left_corp_ra_fname := le.corp_ra_fname;
  SELF.right_corp_ra_fname := ri.corp_ra_fname;
  SELF.corp_ra_fname_match_code := MAP(
		le.corp_ra_fname_isnull OR ri.corp_ra_fname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_fname(le.corp_ra_fname,ri.corp_ra_fname));
  SELF.corp_ra_fname_score := MAP(
                        le.corp_ra_fname_isnull OR ri.corp_ra_fname_isnull => 0,
                        le.corp_ra_fname = ri.corp_ra_fname  => le.corp_ra_fname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fname_weight100,s.corp_ra_fname_switch));
  SELF.left_corp_ra_mname := le.corp_ra_mname;
  SELF.right_corp_ra_mname := ri.corp_ra_mname;
  SELF.corp_ra_mname_match_code := MAP(
		le.corp_ra_mname_isnull OR ri.corp_ra_mname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_mname(le.corp_ra_mname,ri.corp_ra_mname));
  SELF.corp_ra_mname_score := MAP(
                        le.corp_ra_mname_isnull OR ri.corp_ra_mname_isnull => 0,
                        le.corp_ra_mname = ri.corp_ra_mname  => le.corp_ra_mname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_mname_weight100,s.corp_ra_mname_switch));
  SELF.left_corp_ra_lname := le.corp_ra_lname;
  SELF.right_corp_ra_lname := ri.corp_ra_lname;
  SELF.corp_ra_lname_match_code := MAP(
		le.corp_ra_lname_isnull OR ri.corp_ra_lname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_lname(le.corp_ra_lname,ri.corp_ra_lname));
  SELF.corp_ra_lname_score := MAP(
                        le.corp_ra_lname_isnull OR ri.corp_ra_lname_isnull => 0,
                        le.corp_ra_lname = ri.corp_ra_lname  => le.corp_ra_lname_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_lname_weight100,s.corp_ra_lname_switch));
  SELF.left_corp_ra_suffix := le.corp_ra_suffix;
  SELF.right_corp_ra_suffix := ri.corp_ra_suffix;
  SELF.corp_ra_suffix_match_code := MAP(
		le.corp_ra_suffix_isnull OR ri.corp_ra_suffix_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_suffix(le.corp_ra_suffix,ri.corp_ra_suffix));
  SELF.corp_ra_suffix_score := MAP(
                        le.corp_ra_suffix_isnull OR ri.corp_ra_suffix_isnull => 0,
                        le.corp_ra_suffix = ri.corp_ra_suffix  => le.corp_ra_suffix_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_suffix_weight100,s.corp_ra_suffix_switch));
  SELF.left_corp_ra_title_cd := le.corp_ra_title_cd;
  SELF.right_corp_ra_title_cd := ri.corp_ra_title_cd;
  SELF.corp_ra_title_cd_match_code := MAP(
		le.corp_ra_title_cd_isnull OR ri.corp_ra_title_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_title_cd(le.corp_ra_title_cd,ri.corp_ra_title_cd));
  SELF.corp_ra_title_cd_score := MAP(
                        le.corp_ra_title_cd_isnull OR ri.corp_ra_title_cd_isnull => 0,
                        le.corp_ra_title_cd = ri.corp_ra_title_cd  => le.corp_ra_title_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_title_cd_weight100,s.corp_ra_title_cd_switch));
  SELF.left_corp_ra_title_desc := le.corp_ra_title_desc;
  SELF.right_corp_ra_title_desc := ri.corp_ra_title_desc;
  SELF.corp_ra_title_desc_match_code := MAP(
		le.corp_ra_title_desc_isnull OR ri.corp_ra_title_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_title_desc(le.corp_ra_title_desc,ri.corp_ra_title_desc));
  SELF.corp_ra_title_desc_score := MAP(
                        le.corp_ra_title_desc_isnull OR ri.corp_ra_title_desc_isnull => 0,
                        le.corp_ra_title_desc = ri.corp_ra_title_desc  => le.corp_ra_title_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_title_desc_weight100,s.corp_ra_title_desc_switch));
  SELF.left_corp_ra_fein := le.corp_ra_fein;
  SELF.right_corp_ra_fein := ri.corp_ra_fein;
  SELF.corp_ra_fein_match_code := MAP(
		le.corp_ra_fein_isnull OR ri.corp_ra_fein_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_fein(le.corp_ra_fein,ri.corp_ra_fein));
  SELF.corp_ra_fein_score := MAP(
                        le.corp_ra_fein_isnull OR ri.corp_ra_fein_isnull => 0,
                        le.corp_ra_fein = ri.corp_ra_fein  => le.corp_ra_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fein_weight100,s.corp_ra_fein_switch));
  SELF.left_corp_ra_ssn := le.corp_ra_ssn;
  SELF.right_corp_ra_ssn := ri.corp_ra_ssn;
  SELF.corp_ra_ssn_match_code := MAP(
		le.corp_ra_ssn_isnull OR ri.corp_ra_ssn_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_ssn(le.corp_ra_ssn,ri.corp_ra_ssn));
  SELF.corp_ra_ssn_score := MAP(
                        le.corp_ra_ssn_isnull OR ri.corp_ra_ssn_isnull => 0,
                        le.corp_ra_ssn = ri.corp_ra_ssn  => le.corp_ra_ssn_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_ssn_weight100,s.corp_ra_ssn_switch));
  SELF.left_corp_ra_dob := le.corp_ra_dob;
  SELF.right_corp_ra_dob := ri.corp_ra_dob;
  SELF.corp_ra_dob_match_code := MAP(
		le.corp_ra_dob_isnull OR ri.corp_ra_dob_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_dob(le.corp_ra_dob,ri.corp_ra_dob));
  SELF.corp_ra_dob_score := MAP(
                        le.corp_ra_dob_isnull OR ri.corp_ra_dob_isnull => 0,
                        le.corp_ra_dob = ri.corp_ra_dob  => le.corp_ra_dob_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_dob_weight100,s.corp_ra_dob_switch));
  SELF.left_corp_ra_effective_date := le.corp_ra_effective_date;
  SELF.right_corp_ra_effective_date := ri.corp_ra_effective_date;
  SELF.corp_ra_effective_date_match_code := MAP(
		le.corp_ra_effective_date_isnull OR ri.corp_ra_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_effective_date(le.corp_ra_effective_date,ri.corp_ra_effective_date));
  SELF.corp_ra_effective_date_score := MAP(
                        le.corp_ra_effective_date_isnull OR ri.corp_ra_effective_date_isnull => 0,
                        le.corp_ra_effective_date = ri.corp_ra_effective_date  => le.corp_ra_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_effective_date_weight100,s.corp_ra_effective_date_switch));
  SELF.left_corp_ra_resign_date := le.corp_ra_resign_date;
  SELF.right_corp_ra_resign_date := ri.corp_ra_resign_date;
  SELF.corp_ra_resign_date_match_code := MAP(
		le.corp_ra_resign_date_isnull OR ri.corp_ra_resign_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_resign_date(le.corp_ra_resign_date,ri.corp_ra_resign_date));
  SELF.corp_ra_resign_date_score := MAP(
                        le.corp_ra_resign_date_isnull OR ri.corp_ra_resign_date_isnull => 0,
                        le.corp_ra_resign_date = ri.corp_ra_resign_date  => le.corp_ra_resign_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_resign_date_weight100,s.corp_ra_resign_date_switch));
  SELF.left_corp_ra_no_comp := le.corp_ra_no_comp;
  SELF.right_corp_ra_no_comp := ri.corp_ra_no_comp;
  SELF.corp_ra_no_comp_match_code := MAP(
		le.corp_ra_no_comp_isnull OR ri.corp_ra_no_comp_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_no_comp(le.corp_ra_no_comp,ri.corp_ra_no_comp));
  SELF.corp_ra_no_comp_score := MAP(
                        le.corp_ra_no_comp_isnull OR ri.corp_ra_no_comp_isnull => 0,
                        le.corp_ra_no_comp = ri.corp_ra_no_comp  => le.corp_ra_no_comp_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_no_comp_weight100,s.corp_ra_no_comp_switch));
  SELF.left_corp_ra_no_comp_igs := le.corp_ra_no_comp_igs;
  SELF.right_corp_ra_no_comp_igs := ri.corp_ra_no_comp_igs;
  SELF.corp_ra_no_comp_igs_match_code := MAP(
		le.corp_ra_no_comp_igs_isnull OR ri.corp_ra_no_comp_igs_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_no_comp_igs(le.corp_ra_no_comp_igs,ri.corp_ra_no_comp_igs));
  SELF.corp_ra_no_comp_igs_score := MAP(
                        le.corp_ra_no_comp_igs_isnull OR ri.corp_ra_no_comp_igs_isnull => 0,
                        le.corp_ra_no_comp_igs = ri.corp_ra_no_comp_igs  => le.corp_ra_no_comp_igs_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_no_comp_igs_weight100,s.corp_ra_no_comp_igs_switch));
  SELF.left_corp_ra_addl_info := le.corp_ra_addl_info;
  SELF.right_corp_ra_addl_info := ri.corp_ra_addl_info;
  SELF.corp_ra_addl_info_match_code := MAP(
		le.corp_ra_addl_info_isnull OR ri.corp_ra_addl_info_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_addl_info(le.corp_ra_addl_info,ri.corp_ra_addl_info));
  SELF.corp_ra_addl_info_score := MAP(
                        le.corp_ra_addl_info_isnull OR ri.corp_ra_addl_info_isnull => 0,
                        le.corp_ra_addl_info = ri.corp_ra_addl_info  => le.corp_ra_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_addl_info_weight100,s.corp_ra_addl_info_switch));
  SELF.left_corp_ra_address_type_cd := le.corp_ra_address_type_cd;
  SELF.right_corp_ra_address_type_cd := ri.corp_ra_address_type_cd;
  SELF.corp_ra_address_type_cd_match_code := MAP(
		le.corp_ra_address_type_cd_isnull OR ri.corp_ra_address_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_address_type_cd(le.corp_ra_address_type_cd,ri.corp_ra_address_type_cd));
  SELF.corp_ra_address_type_cd_score := MAP(
                        le.corp_ra_address_type_cd_isnull OR ri.corp_ra_address_type_cd_isnull => 0,
                        le.corp_ra_address_type_cd = ri.corp_ra_address_type_cd  => le.corp_ra_address_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_type_cd_weight100,s.corp_ra_address_type_cd_switch));
  SELF.left_corp_ra_address_type_desc := le.corp_ra_address_type_desc;
  SELF.right_corp_ra_address_type_desc := ri.corp_ra_address_type_desc;
  SELF.corp_ra_address_type_desc_match_code := MAP(
		le.corp_ra_address_type_desc_isnull OR ri.corp_ra_address_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_address_type_desc(le.corp_ra_address_type_desc,ri.corp_ra_address_type_desc));
  SELF.corp_ra_address_type_desc_score := MAP(
                        le.corp_ra_address_type_desc_isnull OR ri.corp_ra_address_type_desc_isnull => 0,
                        le.corp_ra_address_type_desc = ri.corp_ra_address_type_desc  => le.corp_ra_address_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_type_desc_weight100,s.corp_ra_address_type_desc_switch));
  SELF.left_corp_ra_address_line1 := le.corp_ra_address_line1;
  SELF.right_corp_ra_address_line1 := ri.corp_ra_address_line1;
  SELF.corp_ra_address_line1_match_code := MAP(
		le.corp_ra_address_line1_isnull OR ri.corp_ra_address_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_address_line1(le.corp_ra_address_line1,ri.corp_ra_address_line1));
  SELF.corp_ra_address_line1_score := MAP(
                        le.corp_ra_address_line1_isnull OR ri.corp_ra_address_line1_isnull => 0,
                        le.corp_ra_address_line1 = ri.corp_ra_address_line1  => le.corp_ra_address_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line1_weight100,s.corp_ra_address_line1_switch));
  SELF.left_corp_ra_address_line2 := le.corp_ra_address_line2;
  SELF.right_corp_ra_address_line2 := ri.corp_ra_address_line2;
  SELF.corp_ra_address_line2_match_code := MAP(
		le.corp_ra_address_line2_isnull OR ri.corp_ra_address_line2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_address_line2(le.corp_ra_address_line2,ri.corp_ra_address_line2));
  SELF.corp_ra_address_line2_score := MAP(
                        le.corp_ra_address_line2_isnull OR ri.corp_ra_address_line2_isnull => 0,
                        le.corp_ra_address_line2 = ri.corp_ra_address_line2  => le.corp_ra_address_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line2_weight100,s.corp_ra_address_line2_switch));
  SELF.left_corp_ra_address_line3 := le.corp_ra_address_line3;
  SELF.right_corp_ra_address_line3 := ri.corp_ra_address_line3;
  SELF.corp_ra_address_line3_match_code := MAP(
		le.corp_ra_address_line3_isnull OR ri.corp_ra_address_line3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_address_line3(le.corp_ra_address_line3,ri.corp_ra_address_line3));
  SELF.corp_ra_address_line3_score := MAP(
                        le.corp_ra_address_line3_isnull OR ri.corp_ra_address_line3_isnull => 0,
                        le.corp_ra_address_line3 = ri.corp_ra_address_line3  => le.corp_ra_address_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_address_line3_weight100,s.corp_ra_address_line3_switch));
  SELF.left_corp_ra_phone_number := le.corp_ra_phone_number;
  SELF.right_corp_ra_phone_number := ri.corp_ra_phone_number;
  SELF.corp_ra_phone_number_match_code := MAP(
		le.corp_ra_phone_number_isnull OR ri.corp_ra_phone_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_phone_number(le.corp_ra_phone_number,ri.corp_ra_phone_number));
  SELF.corp_ra_phone_number_score := MAP(
                        le.corp_ra_phone_number_isnull OR ri.corp_ra_phone_number_isnull => 0,
                        le.corp_ra_phone_number = ri.corp_ra_phone_number  => le.corp_ra_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_weight100,s.corp_ra_phone_number_switch));
  SELF.left_corp_ra_phone_number_type_cd := le.corp_ra_phone_number_type_cd;
  SELF.right_corp_ra_phone_number_type_cd := ri.corp_ra_phone_number_type_cd;
  SELF.corp_ra_phone_number_type_cd_match_code := MAP(
		le.corp_ra_phone_number_type_cd_isnull OR ri.corp_ra_phone_number_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_phone_number_type_cd(le.corp_ra_phone_number_type_cd,ri.corp_ra_phone_number_type_cd));
  SELF.corp_ra_phone_number_type_cd_score := MAP(
                        le.corp_ra_phone_number_type_cd_isnull OR ri.corp_ra_phone_number_type_cd_isnull => 0,
                        le.corp_ra_phone_number_type_cd = ri.corp_ra_phone_number_type_cd  => le.corp_ra_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_type_cd_weight100,s.corp_ra_phone_number_type_cd_switch));
  SELF.left_corp_ra_phone_number_type_desc := le.corp_ra_phone_number_type_desc;
  SELF.right_corp_ra_phone_number_type_desc := ri.corp_ra_phone_number_type_desc;
  SELF.corp_ra_phone_number_type_desc_match_code := MAP(
		le.corp_ra_phone_number_type_desc_isnull OR ri.corp_ra_phone_number_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_phone_number_type_desc(le.corp_ra_phone_number_type_desc,ri.corp_ra_phone_number_type_desc));
  SELF.corp_ra_phone_number_type_desc_score := MAP(
                        le.corp_ra_phone_number_type_desc_isnull OR ri.corp_ra_phone_number_type_desc_isnull => 0,
                        le.corp_ra_phone_number_type_desc = ri.corp_ra_phone_number_type_desc  => le.corp_ra_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_phone_number_type_desc_weight100,s.corp_ra_phone_number_type_desc_switch));
  SELF.left_corp_ra_fax_nbr := le.corp_ra_fax_nbr;
  SELF.right_corp_ra_fax_nbr := ri.corp_ra_fax_nbr;
  SELF.corp_ra_fax_nbr_match_code := MAP(
		le.corp_ra_fax_nbr_isnull OR ri.corp_ra_fax_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_fax_nbr(le.corp_ra_fax_nbr,ri.corp_ra_fax_nbr));
  SELF.corp_ra_fax_nbr_score := MAP(
                        le.corp_ra_fax_nbr_isnull OR ri.corp_ra_fax_nbr_isnull => 0,
                        le.corp_ra_fax_nbr = ri.corp_ra_fax_nbr  => le.corp_ra_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_fax_nbr_weight100,s.corp_ra_fax_nbr_switch));
  SELF.left_corp_ra_email_address := le.corp_ra_email_address;
  SELF.right_corp_ra_email_address := ri.corp_ra_email_address;
  SELF.corp_ra_email_address_match_code := MAP(
		le.corp_ra_email_address_isnull OR ri.corp_ra_email_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_email_address(le.corp_ra_email_address,ri.corp_ra_email_address));
  SELF.corp_ra_email_address_score := MAP(
                        le.corp_ra_email_address_isnull OR ri.corp_ra_email_address_isnull => 0,
                        le.corp_ra_email_address = ri.corp_ra_email_address  => le.corp_ra_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_email_address_weight100,s.corp_ra_email_address_switch));
  SELF.left_corp_ra_web_address := le.corp_ra_web_address;
  SELF.right_corp_ra_web_address := ri.corp_ra_web_address;
  SELF.corp_ra_web_address_match_code := MAP(
		le.corp_ra_web_address_isnull OR ri.corp_ra_web_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_web_address(le.corp_ra_web_address,ri.corp_ra_web_address));
  SELF.corp_ra_web_address_score := MAP(
                        le.corp_ra_web_address_isnull OR ri.corp_ra_web_address_isnull => 0,
                        le.corp_ra_web_address = ri.corp_ra_web_address  => le.corp_ra_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_web_address_weight100,s.corp_ra_web_address_switch));
  SELF.left_corp_prep_addr1_line1 := le.corp_prep_addr1_line1;
  SELF.right_corp_prep_addr1_line1 := ri.corp_prep_addr1_line1;
  SELF.corp_prep_addr1_line1_match_code := MAP(
		le.corp_prep_addr1_line1_isnull OR ri.corp_prep_addr1_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_prep_addr1_line1(le.corp_prep_addr1_line1,ri.corp_prep_addr1_line1));
  SELF.corp_prep_addr1_line1_score := MAP(
                        le.corp_prep_addr1_line1_isnull OR ri.corp_prep_addr1_line1_isnull => 0,
                        le.corp_prep_addr1_line1 = ri.corp_prep_addr1_line1  => le.corp_prep_addr1_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr1_line1_weight100,s.corp_prep_addr1_line1_switch));
  SELF.left_corp_prep_addr1_last_line := le.corp_prep_addr1_last_line;
  SELF.right_corp_prep_addr1_last_line := ri.corp_prep_addr1_last_line;
  SELF.corp_prep_addr1_last_line_match_code := MAP(
		le.corp_prep_addr1_last_line_isnull OR ri.corp_prep_addr1_last_line_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_prep_addr1_last_line(le.corp_prep_addr1_last_line,ri.corp_prep_addr1_last_line));
  SELF.corp_prep_addr1_last_line_score := MAP(
                        le.corp_prep_addr1_last_line_isnull OR ri.corp_prep_addr1_last_line_isnull => 0,
                        le.corp_prep_addr1_last_line = ri.corp_prep_addr1_last_line  => le.corp_prep_addr1_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr1_last_line_weight100,s.corp_prep_addr1_last_line_switch));
  SELF.left_corp_prep_addr2_line1 := le.corp_prep_addr2_line1;
  SELF.right_corp_prep_addr2_line1 := ri.corp_prep_addr2_line1;
  SELF.corp_prep_addr2_line1_match_code := MAP(
		le.corp_prep_addr2_line1_isnull OR ri.corp_prep_addr2_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_prep_addr2_line1(le.corp_prep_addr2_line1,ri.corp_prep_addr2_line1));
  SELF.corp_prep_addr2_line1_score := MAP(
                        le.corp_prep_addr2_line1_isnull OR ri.corp_prep_addr2_line1_isnull => 0,
                        le.corp_prep_addr2_line1 = ri.corp_prep_addr2_line1  => le.corp_prep_addr2_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr2_line1_weight100,s.corp_prep_addr2_line1_switch));
  SELF.left_corp_prep_addr2_last_line := le.corp_prep_addr2_last_line;
  SELF.right_corp_prep_addr2_last_line := ri.corp_prep_addr2_last_line;
  SELF.corp_prep_addr2_last_line_match_code := MAP(
		le.corp_prep_addr2_last_line_isnull OR ri.corp_prep_addr2_last_line_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_prep_addr2_last_line(le.corp_prep_addr2_last_line,ri.corp_prep_addr2_last_line));
  SELF.corp_prep_addr2_last_line_score := MAP(
                        le.corp_prep_addr2_last_line_isnull OR ri.corp_prep_addr2_last_line_isnull => 0,
                        le.corp_prep_addr2_last_line = ri.corp_prep_addr2_last_line  => le.corp_prep_addr2_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_prep_addr2_last_line_weight100,s.corp_prep_addr2_last_line_switch));
  SELF.left_ra_prep_addr_line1 := le.ra_prep_addr_line1;
  SELF.right_ra_prep_addr_line1 := ri.ra_prep_addr_line1;
  SELF.ra_prep_addr_line1_match_code := MAP(
		le.ra_prep_addr_line1_isnull OR ri.ra_prep_addr_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_ra_prep_addr_line1(le.ra_prep_addr_line1,ri.ra_prep_addr_line1));
  SELF.ra_prep_addr_line1_score := MAP(
                        le.ra_prep_addr_line1_isnull OR ri.ra_prep_addr_line1_isnull => 0,
                        le.ra_prep_addr_line1 = ri.ra_prep_addr_line1  => le.ra_prep_addr_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.ra_prep_addr_line1_weight100,s.ra_prep_addr_line1_switch));
  SELF.left_ra_prep_addr_last_line := le.ra_prep_addr_last_line;
  SELF.right_ra_prep_addr_last_line := ri.ra_prep_addr_last_line;
  SELF.ra_prep_addr_last_line_match_code := MAP(
		le.ra_prep_addr_last_line_isnull OR ri.ra_prep_addr_last_line_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_ra_prep_addr_last_line(le.ra_prep_addr_last_line,ri.ra_prep_addr_last_line));
  SELF.ra_prep_addr_last_line_score := MAP(
                        le.ra_prep_addr_last_line_isnull OR ri.ra_prep_addr_last_line_isnull => 0,
                        le.ra_prep_addr_last_line = ri.ra_prep_addr_last_line  => le.ra_prep_addr_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.ra_prep_addr_last_line_weight100,s.ra_prep_addr_last_line_switch));
  SELF.left_cont_filing_reference_nbr := le.cont_filing_reference_nbr;
  SELF.right_cont_filing_reference_nbr := ri.cont_filing_reference_nbr;
  SELF.cont_filing_reference_nbr_match_code := MAP(
		le.cont_filing_reference_nbr_isnull OR ri.cont_filing_reference_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_filing_reference_nbr(le.cont_filing_reference_nbr,ri.cont_filing_reference_nbr));
  SELF.cont_filing_reference_nbr_score := MAP(
                        le.cont_filing_reference_nbr_isnull OR ri.cont_filing_reference_nbr_isnull => 0,
                        le.cont_filing_reference_nbr = ri.cont_filing_reference_nbr  => le.cont_filing_reference_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_reference_nbr_weight100,s.cont_filing_reference_nbr_switch));
  SELF.left_cont_filing_date := le.cont_filing_date;
  SELF.right_cont_filing_date := ri.cont_filing_date;
  SELF.cont_filing_date_match_code := MAP(
		le.cont_filing_date_isnull OR ri.cont_filing_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_filing_date(le.cont_filing_date,ri.cont_filing_date));
  SELF.cont_filing_date_score := MAP(
                        le.cont_filing_date_isnull OR ri.cont_filing_date_isnull => 0,
                        le.cont_filing_date = ri.cont_filing_date  => le.cont_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_date_weight100,s.cont_filing_date_switch));
  SELF.left_cont_filing_cd := le.cont_filing_cd;
  SELF.right_cont_filing_cd := ri.cont_filing_cd;
  SELF.cont_filing_cd_match_code := MAP(
		le.cont_filing_cd_isnull OR ri.cont_filing_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_filing_cd(le.cont_filing_cd,ri.cont_filing_cd));
  SELF.cont_filing_cd_score := MAP(
                        le.cont_filing_cd_isnull OR ri.cont_filing_cd_isnull => 0,
                        le.cont_filing_cd = ri.cont_filing_cd  => le.cont_filing_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_cd_weight100,s.cont_filing_cd_switch));
  SELF.left_cont_filing_desc := le.cont_filing_desc;
  SELF.right_cont_filing_desc := ri.cont_filing_desc;
  SELF.cont_filing_desc_match_code := MAP(
		le.cont_filing_desc_isnull OR ri.cont_filing_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_filing_desc(le.cont_filing_desc,ri.cont_filing_desc));
  SELF.cont_filing_desc_score := MAP(
                        le.cont_filing_desc_isnull OR ri.cont_filing_desc_isnull => 0,
                        le.cont_filing_desc = ri.cont_filing_desc  => le.cont_filing_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_filing_desc_weight100,s.cont_filing_desc_switch));
  SELF.left_cont_type_cd := le.cont_type_cd;
  SELF.right_cont_type_cd := ri.cont_type_cd;
  SELF.cont_type_cd_match_code := MAP(
		le.cont_type_cd_isnull OR ri.cont_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_type_cd(le.cont_type_cd,ri.cont_type_cd));
  SELF.cont_type_cd_score := MAP(
                        le.cont_type_cd_isnull OR ri.cont_type_cd_isnull => 0,
                        le.cont_type_cd = ri.cont_type_cd  => le.cont_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_type_cd_weight100,s.cont_type_cd_switch));
  SELF.left_cont_type_desc := le.cont_type_desc;
  SELF.right_cont_type_desc := ri.cont_type_desc;
  SELF.cont_type_desc_match_code := MAP(
		le.cont_type_desc_isnull OR ri.cont_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_type_desc(le.cont_type_desc,ri.cont_type_desc));
  SELF.cont_type_desc_score := MAP(
                        le.cont_type_desc_isnull OR ri.cont_type_desc_isnull => 0,
                        le.cont_type_desc = ri.cont_type_desc  => le.cont_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_type_desc_weight100,s.cont_type_desc_switch));
  SELF.left_cont_full_name := le.cont_full_name;
  SELF.right_cont_full_name := ri.cont_full_name;
  SELF.cont_full_name_match_code := MAP(
		le.cont_full_name_isnull OR ri.cont_full_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_full_name(le.cont_full_name,ri.cont_full_name));
  SELF.cont_full_name_score := MAP(
                        le.cont_full_name_isnull OR ri.cont_full_name_isnull => 0,
                        le.cont_full_name = ri.cont_full_name  => le.cont_full_name_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_full_name_weight100,s.cont_full_name_switch));
  SELF.left_cont_fname := le.cont_fname;
  SELF.right_cont_fname := ri.cont_fname;
  SELF.cont_fname_match_code := MAP(
		le.cont_fname_isnull OR ri.cont_fname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_fname(le.cont_fname,ri.cont_fname));
  SELF.cont_fname_score := MAP(
                        le.cont_fname_isnull OR ri.cont_fname_isnull => 0,
                        le.cont_fname = ri.cont_fname  => le.cont_fname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fname_weight100,s.cont_fname_switch));
  SELF.left_cont_mname := le.cont_mname;
  SELF.right_cont_mname := ri.cont_mname;
  SELF.cont_mname_match_code := MAP(
		le.cont_mname_isnull OR ri.cont_mname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_mname(le.cont_mname,ri.cont_mname));
  SELF.cont_mname_score := MAP(
                        le.cont_mname_isnull OR ri.cont_mname_isnull => 0,
                        le.cont_mname = ri.cont_mname  => le.cont_mname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_mname_weight100,s.cont_mname_switch));
  SELF.left_cont_lname := le.cont_lname;
  SELF.right_cont_lname := ri.cont_lname;
  SELF.cont_lname_match_code := MAP(
		le.cont_lname_isnull OR ri.cont_lname_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_lname(le.cont_lname,ri.cont_lname));
  SELF.cont_lname_score := MAP(
                        le.cont_lname_isnull OR ri.cont_lname_isnull => 0,
                        le.cont_lname = ri.cont_lname  => le.cont_lname_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_lname_weight100,s.cont_lname_switch));
  SELF.left_cont_suffix := le.cont_suffix;
  SELF.right_cont_suffix := ri.cont_suffix;
  SELF.cont_suffix_match_code := MAP(
		le.cont_suffix_isnull OR ri.cont_suffix_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_suffix(le.cont_suffix,ri.cont_suffix));
  SELF.cont_suffix_score := MAP(
                        le.cont_suffix_isnull OR ri.cont_suffix_isnull => 0,
                        le.cont_suffix = ri.cont_suffix  => le.cont_suffix_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_suffix_weight100,s.cont_suffix_switch));
  SELF.left_cont_title1_desc := le.cont_title1_desc;
  SELF.right_cont_title1_desc := ri.cont_title1_desc;
  SELF.cont_title1_desc_match_code := MAP(
		le.cont_title1_desc_isnull OR ri.cont_title1_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_title1_desc(le.cont_title1_desc,ri.cont_title1_desc));
  SELF.cont_title1_desc_score := MAP(
                        le.cont_title1_desc_isnull OR ri.cont_title1_desc_isnull => 0,
                        le.cont_title1_desc = ri.cont_title1_desc  => le.cont_title1_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title1_desc_weight100,s.cont_title1_desc_switch));
  SELF.left_cont_title2_desc := le.cont_title2_desc;
  SELF.right_cont_title2_desc := ri.cont_title2_desc;
  SELF.cont_title2_desc_match_code := MAP(
		le.cont_title2_desc_isnull OR ri.cont_title2_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_title2_desc(le.cont_title2_desc,ri.cont_title2_desc));
  SELF.cont_title2_desc_score := MAP(
                        le.cont_title2_desc_isnull OR ri.cont_title2_desc_isnull => 0,
                        le.cont_title2_desc = ri.cont_title2_desc  => le.cont_title2_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title2_desc_weight100,s.cont_title2_desc_switch));
  SELF.left_cont_title3_desc := le.cont_title3_desc;
  SELF.right_cont_title3_desc := ri.cont_title3_desc;
  SELF.cont_title3_desc_match_code := MAP(
		le.cont_title3_desc_isnull OR ri.cont_title3_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_title3_desc(le.cont_title3_desc,ri.cont_title3_desc));
  SELF.cont_title3_desc_score := MAP(
                        le.cont_title3_desc_isnull OR ri.cont_title3_desc_isnull => 0,
                        le.cont_title3_desc = ri.cont_title3_desc  => le.cont_title3_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title3_desc_weight100,s.cont_title3_desc_switch));
  SELF.left_cont_title4_desc := le.cont_title4_desc;
  SELF.right_cont_title4_desc := ri.cont_title4_desc;
  SELF.cont_title4_desc_match_code := MAP(
		le.cont_title4_desc_isnull OR ri.cont_title4_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_title4_desc(le.cont_title4_desc,ri.cont_title4_desc));
  SELF.cont_title4_desc_score := MAP(
                        le.cont_title4_desc_isnull OR ri.cont_title4_desc_isnull => 0,
                        le.cont_title4_desc = ri.cont_title4_desc  => le.cont_title4_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title4_desc_weight100,s.cont_title4_desc_switch));
  SELF.left_cont_title5_desc := le.cont_title5_desc;
  SELF.right_cont_title5_desc := ri.cont_title5_desc;
  SELF.cont_title5_desc_match_code := MAP(
		le.cont_title5_desc_isnull OR ri.cont_title5_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_title5_desc(le.cont_title5_desc,ri.cont_title5_desc));
  SELF.cont_title5_desc_score := MAP(
                        le.cont_title5_desc_isnull OR ri.cont_title5_desc_isnull => 0,
                        le.cont_title5_desc = ri.cont_title5_desc  => le.cont_title5_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_title5_desc_weight100,s.cont_title5_desc_switch));
  SELF.left_cont_fein := le.cont_fein;
  SELF.right_cont_fein := ri.cont_fein;
  SELF.cont_fein_match_code := MAP(
		le.cont_fein_isnull OR ri.cont_fein_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_fein(le.cont_fein,ri.cont_fein));
  SELF.cont_fein_score := MAP(
                        le.cont_fein_isnull OR ri.cont_fein_isnull => 0,
                        le.cont_fein = ri.cont_fein  => le.cont_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fein_weight100,s.cont_fein_switch));
  SELF.left_cont_ssn := le.cont_ssn;
  SELF.right_cont_ssn := ri.cont_ssn;
  SELF.cont_ssn_match_code := MAP(
		le.cont_ssn_isnull OR ri.cont_ssn_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_ssn(le.cont_ssn,ri.cont_ssn));
  SELF.cont_ssn_score := MAP(
                        le.cont_ssn_isnull OR ri.cont_ssn_isnull => 0,
                        le.cont_ssn = ri.cont_ssn  => le.cont_ssn_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_ssn_weight100,s.cont_ssn_switch));
  SELF.left_cont_dob := le.cont_dob;
  SELF.right_cont_dob := ri.cont_dob;
  SELF.cont_dob_match_code := MAP(
		le.cont_dob_isnull OR ri.cont_dob_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_dob(le.cont_dob,ri.cont_dob));
  SELF.cont_dob_score := MAP(
                        le.cont_dob_isnull OR ri.cont_dob_isnull => 0,
                        le.cont_dob = ri.cont_dob  => le.cont_dob_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_dob_weight100,s.cont_dob_switch));
  SELF.left_cont_status_cd := le.cont_status_cd;
  SELF.right_cont_status_cd := ri.cont_status_cd;
  SELF.cont_status_cd_match_code := MAP(
		le.cont_status_cd_isnull OR ri.cont_status_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_status_cd(le.cont_status_cd,ri.cont_status_cd));
  SELF.cont_status_cd_score := MAP(
                        le.cont_status_cd_isnull OR ri.cont_status_cd_isnull => 0,
                        le.cont_status_cd = ri.cont_status_cd  => le.cont_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_status_cd_weight100,s.cont_status_cd_switch));
  SELF.left_cont_status_desc := le.cont_status_desc;
  SELF.right_cont_status_desc := ri.cont_status_desc;
  SELF.cont_status_desc_match_code := MAP(
		le.cont_status_desc_isnull OR ri.cont_status_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_status_desc(le.cont_status_desc,ri.cont_status_desc));
  SELF.cont_status_desc_score := MAP(
                        le.cont_status_desc_isnull OR ri.cont_status_desc_isnull => 0,
                        le.cont_status_desc = ri.cont_status_desc  => le.cont_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_status_desc_weight100,s.cont_status_desc_switch));
  SELF.left_cont_effective_date := le.cont_effective_date;
  SELF.right_cont_effective_date := ri.cont_effective_date;
  SELF.cont_effective_date_match_code := MAP(
		le.cont_effective_date_isnull OR ri.cont_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_effective_date(le.cont_effective_date,ri.cont_effective_date));
  SELF.cont_effective_date_score := MAP(
                        le.cont_effective_date_isnull OR ri.cont_effective_date_isnull => 0,
                        le.cont_effective_date = ri.cont_effective_date  => le.cont_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_date_weight100,s.cont_effective_date_switch));
  SELF.left_cont_effective_cd := le.cont_effective_cd;
  SELF.right_cont_effective_cd := ri.cont_effective_cd;
  SELF.cont_effective_cd_match_code := MAP(
		le.cont_effective_cd_isnull OR ri.cont_effective_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_effective_cd(le.cont_effective_cd,ri.cont_effective_cd));
  SELF.cont_effective_cd_score := MAP(
                        le.cont_effective_cd_isnull OR ri.cont_effective_cd_isnull => 0,
                        le.cont_effective_cd = ri.cont_effective_cd  => le.cont_effective_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_cd_weight100,s.cont_effective_cd_switch));
  SELF.left_cont_effective_desc := le.cont_effective_desc;
  SELF.right_cont_effective_desc := ri.cont_effective_desc;
  SELF.cont_effective_desc_match_code := MAP(
		le.cont_effective_desc_isnull OR ri.cont_effective_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_effective_desc(le.cont_effective_desc,ri.cont_effective_desc));
  SELF.cont_effective_desc_score := MAP(
                        le.cont_effective_desc_isnull OR ri.cont_effective_desc_isnull => 0,
                        le.cont_effective_desc = ri.cont_effective_desc  => le.cont_effective_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_effective_desc_weight100,s.cont_effective_desc_switch));
  SELF.left_cont_addl_info := le.cont_addl_info;
  SELF.right_cont_addl_info := ri.cont_addl_info;
  SELF.cont_addl_info_match_code := MAP(
		le.cont_addl_info_isnull OR ri.cont_addl_info_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_addl_info(le.cont_addl_info,ri.cont_addl_info));
  SELF.cont_addl_info_score := MAP(
                        le.cont_addl_info_isnull OR ri.cont_addl_info_isnull => 0,
                        le.cont_addl_info = ri.cont_addl_info  => le.cont_addl_info_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_addl_info_weight100,s.cont_addl_info_switch));
  SELF.left_cont_address_type_cd := le.cont_address_type_cd;
  SELF.right_cont_address_type_cd := ri.cont_address_type_cd;
  SELF.cont_address_type_cd_match_code := MAP(
		le.cont_address_type_cd_isnull OR ri.cont_address_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_type_cd(le.cont_address_type_cd,ri.cont_address_type_cd));
  SELF.cont_address_type_cd_score := MAP(
                        le.cont_address_type_cd_isnull OR ri.cont_address_type_cd_isnull => 0,
                        le.cont_address_type_cd = ri.cont_address_type_cd  => le.cont_address_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_type_cd_weight100,s.cont_address_type_cd_switch));
  SELF.left_cont_address_type_desc := le.cont_address_type_desc;
  SELF.right_cont_address_type_desc := ri.cont_address_type_desc;
  SELF.cont_address_type_desc_match_code := MAP(
		le.cont_address_type_desc_isnull OR ri.cont_address_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_type_desc(le.cont_address_type_desc,ri.cont_address_type_desc));
  SELF.cont_address_type_desc_score := MAP(
                        le.cont_address_type_desc_isnull OR ri.cont_address_type_desc_isnull => 0,
                        le.cont_address_type_desc = ri.cont_address_type_desc  => le.cont_address_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_type_desc_weight100,s.cont_address_type_desc_switch));
  SELF.left_cont_address_line1 := le.cont_address_line1;
  SELF.right_cont_address_line1 := ri.cont_address_line1;
  SELF.cont_address_line1_match_code := MAP(
		le.cont_address_line1_isnull OR ri.cont_address_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_line1(le.cont_address_line1,ri.cont_address_line1));
  SELF.cont_address_line1_score := MAP(
                        le.cont_address_line1_isnull OR ri.cont_address_line1_isnull => 0,
                        le.cont_address_line1 = ri.cont_address_line1  => le.cont_address_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line1_weight100,s.cont_address_line1_switch));
  SELF.left_cont_address_line2 := le.cont_address_line2;
  SELF.right_cont_address_line2 := ri.cont_address_line2;
  SELF.cont_address_line2_match_code := MAP(
		le.cont_address_line2_isnull OR ri.cont_address_line2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_line2(le.cont_address_line2,ri.cont_address_line2));
  SELF.cont_address_line2_score := MAP(
                        le.cont_address_line2_isnull OR ri.cont_address_line2_isnull => 0,
                        le.cont_address_line2 = ri.cont_address_line2  => le.cont_address_line2_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line2_weight100,s.cont_address_line2_switch));
  SELF.left_cont_address_line3 := le.cont_address_line3;
  SELF.right_cont_address_line3 := ri.cont_address_line3;
  SELF.cont_address_line3_match_code := MAP(
		le.cont_address_line3_isnull OR ri.cont_address_line3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_line3(le.cont_address_line3,ri.cont_address_line3));
  SELF.cont_address_line3_score := MAP(
                        le.cont_address_line3_isnull OR ri.cont_address_line3_isnull => 0,
                        le.cont_address_line3 = ri.cont_address_line3  => le.cont_address_line3_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_line3_weight100,s.cont_address_line3_switch));
  SELF.left_cont_address_effective_date := le.cont_address_effective_date;
  SELF.right_cont_address_effective_date := ri.cont_address_effective_date;
  SELF.cont_address_effective_date_match_code := MAP(
		le.cont_address_effective_date_isnull OR ri.cont_address_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_effective_date(le.cont_address_effective_date,ri.cont_address_effective_date));
  SELF.cont_address_effective_date_score := MAP(
                        le.cont_address_effective_date_isnull OR ri.cont_address_effective_date_isnull => 0,
                        le.cont_address_effective_date = ri.cont_address_effective_date  => le.cont_address_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_effective_date_weight100,s.cont_address_effective_date_switch));
  SELF.left_cont_address_county := le.cont_address_county;
  SELF.right_cont_address_county := ri.cont_address_county;
  SELF.cont_address_county_match_code := MAP(
		le.cont_address_county_isnull OR ri.cont_address_county_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_address_county(le.cont_address_county,ri.cont_address_county));
  SELF.cont_address_county_score := MAP(
                        le.cont_address_county_isnull OR ri.cont_address_county_isnull => 0,
                        le.cont_address_county = ri.cont_address_county  => le.cont_address_county_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_address_county_weight100,s.cont_address_county_switch));
  SELF.left_cont_phone_number := le.cont_phone_number;
  SELF.right_cont_phone_number := ri.cont_phone_number;
  SELF.cont_phone_number_match_code := MAP(
		le.cont_phone_number_isnull OR ri.cont_phone_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_phone_number(le.cont_phone_number,ri.cont_phone_number));
  SELF.cont_phone_number_score := MAP(
                        le.cont_phone_number_isnull OR ri.cont_phone_number_isnull => 0,
                        le.cont_phone_number = ri.cont_phone_number  => le.cont_phone_number_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_weight100,s.cont_phone_number_switch));
  SELF.left_cont_phone_number_type_cd := le.cont_phone_number_type_cd;
  SELF.right_cont_phone_number_type_cd := ri.cont_phone_number_type_cd;
  SELF.cont_phone_number_type_cd_match_code := MAP(
		le.cont_phone_number_type_cd_isnull OR ri.cont_phone_number_type_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_phone_number_type_cd(le.cont_phone_number_type_cd,ri.cont_phone_number_type_cd));
  SELF.cont_phone_number_type_cd_score := MAP(
                        le.cont_phone_number_type_cd_isnull OR ri.cont_phone_number_type_cd_isnull => 0,
                        le.cont_phone_number_type_cd = ri.cont_phone_number_type_cd  => le.cont_phone_number_type_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_type_cd_weight100,s.cont_phone_number_type_cd_switch));
  SELF.left_cont_phone_number_type_desc := le.cont_phone_number_type_desc;
  SELF.right_cont_phone_number_type_desc := ri.cont_phone_number_type_desc;
  SELF.cont_phone_number_type_desc_match_code := MAP(
		le.cont_phone_number_type_desc_isnull OR ri.cont_phone_number_type_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_phone_number_type_desc(le.cont_phone_number_type_desc,ri.cont_phone_number_type_desc));
  SELF.cont_phone_number_type_desc_score := MAP(
                        le.cont_phone_number_type_desc_isnull OR ri.cont_phone_number_type_desc_isnull => 0,
                        le.cont_phone_number_type_desc = ri.cont_phone_number_type_desc  => le.cont_phone_number_type_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_phone_number_type_desc_weight100,s.cont_phone_number_type_desc_switch));
  SELF.left_cont_fax_nbr := le.cont_fax_nbr;
  SELF.right_cont_fax_nbr := ri.cont_fax_nbr;
  SELF.cont_fax_nbr_match_code := MAP(
		le.cont_fax_nbr_isnull OR ri.cont_fax_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_fax_nbr(le.cont_fax_nbr,ri.cont_fax_nbr));
  SELF.cont_fax_nbr_score := MAP(
                        le.cont_fax_nbr_isnull OR ri.cont_fax_nbr_isnull => 0,
                        le.cont_fax_nbr = ri.cont_fax_nbr  => le.cont_fax_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_fax_nbr_weight100,s.cont_fax_nbr_switch));
  SELF.left_cont_email_address := le.cont_email_address;
  SELF.right_cont_email_address := ri.cont_email_address;
  SELF.cont_email_address_match_code := MAP(
		le.cont_email_address_isnull OR ri.cont_email_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_email_address(le.cont_email_address,ri.cont_email_address));
  SELF.cont_email_address_score := MAP(
                        le.cont_email_address_isnull OR ri.cont_email_address_isnull => 0,
                        le.cont_email_address = ri.cont_email_address  => le.cont_email_address_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_email_address_weight100,s.cont_email_address_switch));
  SELF.left_cont_web_address := le.cont_web_address;
  SELF.right_cont_web_address := ri.cont_web_address;
  SELF.cont_web_address_match_code := MAP(
		le.cont_web_address_isnull OR ri.cont_web_address_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_web_address(le.cont_web_address,ri.cont_web_address));
  SELF.cont_web_address_score := MAP(
                        le.cont_web_address_isnull OR ri.cont_web_address_isnull => 0,
                        le.cont_web_address = ri.cont_web_address  => le.cont_web_address_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_web_address_weight100,s.cont_web_address_switch));
  SELF.left_corp_acres := le.corp_acres;
  SELF.right_corp_acres := ri.corp_acres;
  SELF.corp_acres_match_code := MAP(
		le.corp_acres_isnull OR ri.corp_acres_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_acres(le.corp_acres,ri.corp_acres));
  SELF.corp_acres_score := MAP(
                        le.corp_acres_isnull OR ri.corp_acres_isnull => 0,
                        le.corp_acres = ri.corp_acres  => le.corp_acres_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acres_weight100,s.corp_acres_switch));
  SELF.left_corp_action := le.corp_action;
  SELF.right_corp_action := ri.corp_action;
  SELF.corp_action_match_code := MAP(
		le.corp_action_isnull OR ri.corp_action_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action(le.corp_action,ri.corp_action));
  SELF.corp_action_score := MAP(
                        le.corp_action_isnull OR ri.corp_action_isnull => 0,
                        le.corp_action = ri.corp_action  => le.corp_action_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_weight100,s.corp_action_switch));
  SELF.left_corp_action_date := le.corp_action_date;
  SELF.right_corp_action_date := ri.corp_action_date;
  SELF.corp_action_date_match_code := MAP(
		le.corp_action_date_isnull OR ri.corp_action_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_date(le.corp_action_date,ri.corp_action_date));
  SELF.corp_action_date_score := MAP(
                        le.corp_action_date_isnull OR ri.corp_action_date_isnull => 0,
                        le.corp_action_date = ri.corp_action_date  => le.corp_action_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_date_weight100,s.corp_action_date_switch));
  SELF.left_corp_action_employment_security_approval_date := le.corp_action_employment_security_approval_date;
  SELF.right_corp_action_employment_security_approval_date := ri.corp_action_employment_security_approval_date;
  SELF.corp_action_employment_security_approval_date_match_code := MAP(
		le.corp_action_employment_security_approval_date_isnull OR ri.corp_action_employment_security_approval_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_employment_security_approval_date(le.corp_action_employment_security_approval_date,ri.corp_action_employment_security_approval_date));
  SELF.corp_action_employment_security_approval_date_score := MAP(
                        le.corp_action_employment_security_approval_date_isnull OR ri.corp_action_employment_security_approval_date_isnull => 0,
                        le.corp_action_employment_security_approval_date = ri.corp_action_employment_security_approval_date  => le.corp_action_employment_security_approval_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_employment_security_approval_date_weight100,s.corp_action_employment_security_approval_date_switch));
  SELF.left_corp_action_pending_cd := le.corp_action_pending_cd;
  SELF.right_corp_action_pending_cd := ri.corp_action_pending_cd;
  SELF.corp_action_pending_cd_match_code := MAP(
		le.corp_action_pending_cd_isnull OR ri.corp_action_pending_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_pending_cd(le.corp_action_pending_cd,ri.corp_action_pending_cd));
  SELF.corp_action_pending_cd_score := MAP(
                        le.corp_action_pending_cd_isnull OR ri.corp_action_pending_cd_isnull => 0,
                        le.corp_action_pending_cd = ri.corp_action_pending_cd  => le.corp_action_pending_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_pending_cd_weight100,s.corp_action_pending_cd_switch));
  SELF.left_corp_action_pending_desc := le.corp_action_pending_desc;
  SELF.right_corp_action_pending_desc := ri.corp_action_pending_desc;
  SELF.corp_action_pending_desc_match_code := MAP(
		le.corp_action_pending_desc_isnull OR ri.corp_action_pending_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_pending_desc(le.corp_action_pending_desc,ri.corp_action_pending_desc));
  SELF.corp_action_pending_desc_score := MAP(
                        le.corp_action_pending_desc_isnull OR ri.corp_action_pending_desc_isnull => 0,
                        le.corp_action_pending_desc = ri.corp_action_pending_desc  => le.corp_action_pending_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_pending_desc_weight100,s.corp_action_pending_desc_switch));
  SELF.left_corp_action_statement_of_intent_date := le.corp_action_statement_of_intent_date;
  SELF.right_corp_action_statement_of_intent_date := ri.corp_action_statement_of_intent_date;
  SELF.corp_action_statement_of_intent_date_match_code := MAP(
		le.corp_action_statement_of_intent_date_isnull OR ri.corp_action_statement_of_intent_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_statement_of_intent_date(le.corp_action_statement_of_intent_date,ri.corp_action_statement_of_intent_date));
  SELF.corp_action_statement_of_intent_date_score := MAP(
                        le.corp_action_statement_of_intent_date_isnull OR ri.corp_action_statement_of_intent_date_isnull => 0,
                        le.corp_action_statement_of_intent_date = ri.corp_action_statement_of_intent_date  => le.corp_action_statement_of_intent_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_statement_of_intent_date_weight100,s.corp_action_statement_of_intent_date_switch));
  SELF.left_corp_action_tax_dept_approval_date := le.corp_action_tax_dept_approval_date;
  SELF.right_corp_action_tax_dept_approval_date := ri.corp_action_tax_dept_approval_date;
  SELF.corp_action_tax_dept_approval_date_match_code := MAP(
		le.corp_action_tax_dept_approval_date_isnull OR ri.corp_action_tax_dept_approval_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_action_tax_dept_approval_date(le.corp_action_tax_dept_approval_date,ri.corp_action_tax_dept_approval_date));
  SELF.corp_action_tax_dept_approval_date_score := MAP(
                        le.corp_action_tax_dept_approval_date_isnull OR ri.corp_action_tax_dept_approval_date_isnull => 0,
                        le.corp_action_tax_dept_approval_date = ri.corp_action_tax_dept_approval_date  => le.corp_action_tax_dept_approval_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_action_tax_dept_approval_date_weight100,s.corp_action_tax_dept_approval_date_switch));
  SELF.left_corp_acts2 := le.corp_acts2;
  SELF.right_corp_acts2 := ri.corp_acts2;
  SELF.corp_acts2_match_code := MAP(
		le.corp_acts2_isnull OR ri.corp_acts2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_acts2(le.corp_acts2,ri.corp_acts2));
  SELF.corp_acts2_score := MAP(
                        le.corp_acts2_isnull OR ri.corp_acts2_isnull => 0,
                        le.corp_acts2 = ri.corp_acts2  => le.corp_acts2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts2_weight100,s.corp_acts2_switch));
  SELF.left_corp_acts3 := le.corp_acts3;
  SELF.right_corp_acts3 := ri.corp_acts3;
  SELF.corp_acts3_match_code := MAP(
		le.corp_acts3_isnull OR ri.corp_acts3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_acts3(le.corp_acts3,ri.corp_acts3));
  SELF.corp_acts3_score := MAP(
                        le.corp_acts3_isnull OR ri.corp_acts3_isnull => 0,
                        le.corp_acts3 = ri.corp_acts3  => le.corp_acts3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_acts3_weight100,s.corp_acts3_switch));
  SELF.left_corp_additional_principals := le.corp_additional_principals;
  SELF.right_corp_additional_principals := ri.corp_additional_principals;
  SELF.corp_additional_principals_match_code := MAP(
		le.corp_additional_principals_isnull OR ri.corp_additional_principals_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_additional_principals(le.corp_additional_principals,ri.corp_additional_principals));
  SELF.corp_additional_principals_score := MAP(
                        le.corp_additional_principals_isnull OR ri.corp_additional_principals_isnull => 0,
                        le.corp_additional_principals = ri.corp_additional_principals  => le.corp_additional_principals_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_additional_principals_weight100,s.corp_additional_principals_switch));
  SELF.left_corp_address_office_type := le.corp_address_office_type;
  SELF.right_corp_address_office_type := ri.corp_address_office_type;
  SELF.corp_address_office_type_match_code := MAP(
		le.corp_address_office_type_isnull OR ri.corp_address_office_type_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_address_office_type(le.corp_address_office_type,ri.corp_address_office_type));
  SELF.corp_address_office_type_score := MAP(
                        le.corp_address_office_type_isnull OR ri.corp_address_office_type_isnull => 0,
                        le.corp_address_office_type = ri.corp_address_office_type  => le.corp_address_office_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_address_office_type_weight100,s.corp_address_office_type_switch));
  SELF.left_corp_agent_assign_date := le.corp_agent_assign_date;
  SELF.right_corp_agent_assign_date := ri.corp_agent_assign_date;
  SELF.corp_agent_assign_date_match_code := MAP(
		le.corp_agent_assign_date_isnull OR ri.corp_agent_assign_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_assign_date(le.corp_agent_assign_date,ri.corp_agent_assign_date));
  SELF.corp_agent_assign_date_score := MAP(
                        le.corp_agent_assign_date_isnull OR ri.corp_agent_assign_date_isnull => 0,
                        le.corp_agent_assign_date = ri.corp_agent_assign_date  => le.corp_agent_assign_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_assign_date_weight100,s.corp_agent_assign_date_switch));
  SELF.left_corp_agent_commercial := le.corp_agent_commercial;
  SELF.right_corp_agent_commercial := ri.corp_agent_commercial;
  SELF.corp_agent_commercial_match_code := MAP(
		le.corp_agent_commercial_isnull OR ri.corp_agent_commercial_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_commercial(le.corp_agent_commercial,ri.corp_agent_commercial));
  SELF.corp_agent_commercial_score := MAP(
                        le.corp_agent_commercial_isnull OR ri.corp_agent_commercial_isnull => 0,
                        le.corp_agent_commercial = ri.corp_agent_commercial  => le.corp_agent_commercial_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_commercial_weight100,s.corp_agent_commercial_switch));
  SELF.left_corp_agent_country := le.corp_agent_country;
  SELF.right_corp_agent_country := ri.corp_agent_country;
  SELF.corp_agent_country_match_code := MAP(
		le.corp_agent_country_isnull OR ri.corp_agent_country_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_country(le.corp_agent_country,ri.corp_agent_country));
  SELF.corp_agent_country_score := MAP(
                        le.corp_agent_country_isnull OR ri.corp_agent_country_isnull => 0,
                        le.corp_agent_country = ri.corp_agent_country  => le.corp_agent_country_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_country_weight100,s.corp_agent_country_switch));
  SELF.left_corp_agent_county := le.corp_agent_county;
  SELF.right_corp_agent_county := ri.corp_agent_county;
  SELF.corp_agent_county_match_code := MAP(
		le.corp_agent_county_isnull OR ri.corp_agent_county_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_county(le.corp_agent_county,ri.corp_agent_county));
  SELF.corp_agent_county_score := MAP(
                        le.corp_agent_county_isnull OR ri.corp_agent_county_isnull => 0,
                        le.corp_agent_county = ri.corp_agent_county  => le.corp_agent_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_county_weight100,s.corp_agent_county_switch));
  SELF.left_corp_agent_status_cd := le.corp_agent_status_cd;
  SELF.right_corp_agent_status_cd := ri.corp_agent_status_cd;
  SELF.corp_agent_status_cd_match_code := MAP(
		le.corp_agent_status_cd_isnull OR ri.corp_agent_status_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_status_cd(le.corp_agent_status_cd,ri.corp_agent_status_cd));
  SELF.corp_agent_status_cd_score := MAP(
                        le.corp_agent_status_cd_isnull OR ri.corp_agent_status_cd_isnull => 0,
                        le.corp_agent_status_cd = ri.corp_agent_status_cd  => le.corp_agent_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_status_cd_weight100,s.corp_agent_status_cd_switch));
  SELF.left_corp_agent_status_desc := le.corp_agent_status_desc;
  SELF.right_corp_agent_status_desc := ri.corp_agent_status_desc;
  SELF.corp_agent_status_desc_match_code := MAP(
		le.corp_agent_status_desc_isnull OR ri.corp_agent_status_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_status_desc(le.corp_agent_status_desc,ri.corp_agent_status_desc));
  SELF.corp_agent_status_desc_score := MAP(
                        le.corp_agent_status_desc_isnull OR ri.corp_agent_status_desc_isnull => 0,
                        le.corp_agent_status_desc = ri.corp_agent_status_desc  => le.corp_agent_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_status_desc_weight100,s.corp_agent_status_desc_switch));
  SELF.left_corp_agent_id := le.corp_agent_id;
  SELF.right_corp_agent_id := ri.corp_agent_id;
  SELF.corp_agent_id_match_code := MAP(
		le.corp_agent_id_isnull OR ri.corp_agent_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agent_id(le.corp_agent_id,ri.corp_agent_id));
  SELF.corp_agent_id_score := MAP(
                        le.corp_agent_id_isnull OR ri.corp_agent_id_isnull => 0,
                        le.corp_agent_id = ri.corp_agent_id  => le.corp_agent_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agent_id_weight100,s.corp_agent_id_switch));
  SELF.left_corp_agriculture_flag := le.corp_agriculture_flag;
  SELF.right_corp_agriculture_flag := ri.corp_agriculture_flag;
  SELF.corp_agriculture_flag_match_code := MAP(
		le.corp_agriculture_flag_isnull OR ri.corp_agriculture_flag_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_agriculture_flag(le.corp_agriculture_flag,ri.corp_agriculture_flag));
  SELF.corp_agriculture_flag_score := MAP(
                        le.corp_agriculture_flag_isnull OR ri.corp_agriculture_flag_isnull => 0,
                        le.corp_agriculture_flag = ri.corp_agriculture_flag  => le.corp_agriculture_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_agriculture_flag_weight100,s.corp_agriculture_flag_switch));
  SELF.left_corp_authorized_partners := le.corp_authorized_partners;
  SELF.right_corp_authorized_partners := ri.corp_authorized_partners;
  SELF.corp_authorized_partners_match_code := MAP(
		le.corp_authorized_partners_isnull OR ri.corp_authorized_partners_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_authorized_partners(le.corp_authorized_partners,ri.corp_authorized_partners));
  SELF.corp_authorized_partners_score := MAP(
                        le.corp_authorized_partners_isnull OR ri.corp_authorized_partners_isnull => 0,
                        le.corp_authorized_partners = ri.corp_authorized_partners  => le.corp_authorized_partners_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_authorized_partners_weight100,s.corp_authorized_partners_switch));
  SELF.left_corp_comment := le.corp_comment;
  SELF.right_corp_comment := ri.corp_comment;
  SELF.corp_comment_match_code := MAP(
		le.corp_comment_isnull OR ri.corp_comment_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_comment(le.corp_comment,ri.corp_comment));
  SELF.corp_comment_score := MAP(
                        le.corp_comment_isnull OR ri.corp_comment_isnull => 0,
                        le.corp_comment = ri.corp_comment  => le.corp_comment_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_comment_weight100,s.corp_comment_switch));
  SELF.left_corp_consent_flag_for_protected_name := le.corp_consent_flag_for_protected_name;
  SELF.right_corp_consent_flag_for_protected_name := ri.corp_consent_flag_for_protected_name;
  SELF.corp_consent_flag_for_protected_name_match_code := MAP(
		le.corp_consent_flag_for_protected_name_isnull OR ri.corp_consent_flag_for_protected_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_consent_flag_for_protected_name(le.corp_consent_flag_for_protected_name,ri.corp_consent_flag_for_protected_name));
  SELF.corp_consent_flag_for_protected_name_score := MAP(
                        le.corp_consent_flag_for_protected_name_isnull OR ri.corp_consent_flag_for_protected_name_isnull => 0,
                        le.corp_consent_flag_for_protected_name = ri.corp_consent_flag_for_protected_name  => le.corp_consent_flag_for_protected_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_consent_flag_for_protected_name_weight100,s.corp_consent_flag_for_protected_name_switch));
  SELF.left_corp_converted := le.corp_converted;
  SELF.right_corp_converted := ri.corp_converted;
  SELF.corp_converted_match_code := MAP(
		le.corp_converted_isnull OR ri.corp_converted_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_converted(le.corp_converted,ri.corp_converted));
  SELF.corp_converted_score := MAP(
                        le.corp_converted_isnull OR ri.corp_converted_isnull => 0,
                        le.corp_converted = ri.corp_converted  => le.corp_converted_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_converted_weight100,s.corp_converted_switch));
  SELF.left_corp_converted_from := le.corp_converted_from;
  SELF.right_corp_converted_from := ri.corp_converted_from;
  SELF.corp_converted_from_match_code := MAP(
		le.corp_converted_from_isnull OR ri.corp_converted_from_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_converted_from(le.corp_converted_from,ri.corp_converted_from));
  SELF.corp_converted_from_score := MAP(
                        le.corp_converted_from_isnull OR ri.corp_converted_from_isnull => 0,
                        le.corp_converted_from = ri.corp_converted_from  => le.corp_converted_from_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_converted_from_weight100,s.corp_converted_from_switch));
  SELF.left_corp_country_of_formation := le.corp_country_of_formation;
  SELF.right_corp_country_of_formation := ri.corp_country_of_formation;
  SELF.corp_country_of_formation_match_code := MAP(
		le.corp_country_of_formation_isnull OR ri.corp_country_of_formation_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_country_of_formation(le.corp_country_of_formation,ri.corp_country_of_formation));
  SELF.corp_country_of_formation_score := MAP(
                        le.corp_country_of_formation_isnull OR ri.corp_country_of_formation_isnull => 0,
                        le.corp_country_of_formation = ri.corp_country_of_formation  => le.corp_country_of_formation_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_country_of_formation_weight100,s.corp_country_of_formation_switch));
  SELF.left_corp_date_of_organization_meeting := le.corp_date_of_organization_meeting;
  SELF.right_corp_date_of_organization_meeting := ri.corp_date_of_organization_meeting;
  SELF.corp_date_of_organization_meeting_match_code := MAP(
		le.corp_date_of_organization_meeting_isnull OR ri.corp_date_of_organization_meeting_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_date_of_organization_meeting(le.corp_date_of_organization_meeting,ri.corp_date_of_organization_meeting));
  SELF.corp_date_of_organization_meeting_score := MAP(
                        le.corp_date_of_organization_meeting_isnull OR ri.corp_date_of_organization_meeting_isnull => 0,
                        le.corp_date_of_organization_meeting = ri.corp_date_of_organization_meeting  => le.corp_date_of_organization_meeting_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_date_of_organization_meeting_weight100,s.corp_date_of_organization_meeting_switch));
  SELF.left_corp_delayed_effective_date := le.corp_delayed_effective_date;
  SELF.right_corp_delayed_effective_date := ri.corp_delayed_effective_date;
  SELF.corp_delayed_effective_date_match_code := MAP(
		le.corp_delayed_effective_date_isnull OR ri.corp_delayed_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_delayed_effective_date(le.corp_delayed_effective_date,ri.corp_delayed_effective_date));
  SELF.corp_delayed_effective_date_score := MAP(
                        le.corp_delayed_effective_date_isnull OR ri.corp_delayed_effective_date_isnull => 0,
                        le.corp_delayed_effective_date = ri.corp_delayed_effective_date  => le.corp_delayed_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_delayed_effective_date_weight100,s.corp_delayed_effective_date_switch));
  SELF.left_corp_directors_from_to := le.corp_directors_from_to;
  SELF.right_corp_directors_from_to := ri.corp_directors_from_to;
  SELF.corp_directors_from_to_match_code := MAP(
		le.corp_directors_from_to_isnull OR ri.corp_directors_from_to_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_directors_from_to(le.corp_directors_from_to,ri.corp_directors_from_to));
  SELF.corp_directors_from_to_score := MAP(
                        le.corp_directors_from_to_isnull OR ri.corp_directors_from_to_isnull => 0,
                        le.corp_directors_from_to = ri.corp_directors_from_to  => le.corp_directors_from_to_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_directors_from_to_weight100,s.corp_directors_from_to_switch));
  SELF.left_corp_dissolved_date := le.corp_dissolved_date;
  SELF.right_corp_dissolved_date := ri.corp_dissolved_date;
  SELF.corp_dissolved_date_match_code := MAP(
		le.corp_dissolved_date_isnull OR ri.corp_dissolved_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_dissolved_date(le.corp_dissolved_date,ri.corp_dissolved_date));
  SELF.corp_dissolved_date_score := MAP(
                        le.corp_dissolved_date_isnull OR ri.corp_dissolved_date_isnull => 0,
                        le.corp_dissolved_date = ri.corp_dissolved_date  => le.corp_dissolved_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_dissolved_date_weight100,s.corp_dissolved_date_switch));
  SELF.left_corp_farm_exemptions := le.corp_farm_exemptions;
  SELF.right_corp_farm_exemptions := ri.corp_farm_exemptions;
  SELF.corp_farm_exemptions_match_code := MAP(
		le.corp_farm_exemptions_isnull OR ri.corp_farm_exemptions_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_farm_exemptions(le.corp_farm_exemptions,ri.corp_farm_exemptions));
  SELF.corp_farm_exemptions_score := MAP(
                        le.corp_farm_exemptions_isnull OR ri.corp_farm_exemptions_isnull => 0,
                        le.corp_farm_exemptions = ri.corp_farm_exemptions  => le.corp_farm_exemptions_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_exemptions_weight100,s.corp_farm_exemptions_switch));
  SELF.left_corp_farm_qual_date := le.corp_farm_qual_date;
  SELF.right_corp_farm_qual_date := ri.corp_farm_qual_date;
  SELF.corp_farm_qual_date_match_code := MAP(
		le.corp_farm_qual_date_isnull OR ri.corp_farm_qual_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_farm_qual_date(le.corp_farm_qual_date,ri.corp_farm_qual_date));
  SELF.corp_farm_qual_date_score := MAP(
                        le.corp_farm_qual_date_isnull OR ri.corp_farm_qual_date_isnull => 0,
                        le.corp_farm_qual_date = ri.corp_farm_qual_date  => le.corp_farm_qual_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_qual_date_weight100,s.corp_farm_qual_date_switch));
  SELF.left_corp_farm_status_cd := le.corp_farm_status_cd;
  SELF.right_corp_farm_status_cd := ri.corp_farm_status_cd;
  SELF.corp_farm_status_cd_match_code := MAP(
		le.corp_farm_status_cd_isnull OR ri.corp_farm_status_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_farm_status_cd(le.corp_farm_status_cd,ri.corp_farm_status_cd));
  SELF.corp_farm_status_cd_score := MAP(
                        le.corp_farm_status_cd_isnull OR ri.corp_farm_status_cd_isnull => 0,
                        le.corp_farm_status_cd = ri.corp_farm_status_cd  => le.corp_farm_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_status_cd_weight100,s.corp_farm_status_cd_switch));
  SELF.left_corp_farm_status_desc := le.corp_farm_status_desc;
  SELF.right_corp_farm_status_desc := ri.corp_farm_status_desc;
  SELF.corp_farm_status_desc_match_code := MAP(
		le.corp_farm_status_desc_isnull OR ri.corp_farm_status_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_farm_status_desc(le.corp_farm_status_desc,ri.corp_farm_status_desc));
  SELF.corp_farm_status_desc_score := MAP(
                        le.corp_farm_status_desc_isnull OR ri.corp_farm_status_desc_isnull => 0,
                        le.corp_farm_status_desc = ri.corp_farm_status_desc  => le.corp_farm_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_farm_status_desc_weight100,s.corp_farm_status_desc_switch));
  SELF.left_corp_fiscal_year_month := le.corp_fiscal_year_month;
  SELF.right_corp_fiscal_year_month := ri.corp_fiscal_year_month;
  SELF.corp_fiscal_year_month_match_code := MAP(
		le.corp_fiscal_year_month_isnull OR ri.corp_fiscal_year_month_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_fiscal_year_month(le.corp_fiscal_year_month,ri.corp_fiscal_year_month));
  SELF.corp_fiscal_year_month_score := MAP(
                        le.corp_fiscal_year_month_isnull OR ri.corp_fiscal_year_month_isnull => 0,
                        le.corp_fiscal_year_month = ri.corp_fiscal_year_month  => le.corp_fiscal_year_month_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_fiscal_year_month_weight100,s.corp_fiscal_year_month_switch));
  SELF.left_corp_foreign_fiduciary_capacity_in_state := le.corp_foreign_fiduciary_capacity_in_state;
  SELF.right_corp_foreign_fiduciary_capacity_in_state := ri.corp_foreign_fiduciary_capacity_in_state;
  SELF.corp_foreign_fiduciary_capacity_in_state_match_code := MAP(
		le.corp_foreign_fiduciary_capacity_in_state_isnull OR ri.corp_foreign_fiduciary_capacity_in_state_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_foreign_fiduciary_capacity_in_state(le.corp_foreign_fiduciary_capacity_in_state,ri.corp_foreign_fiduciary_capacity_in_state));
  SELF.corp_foreign_fiduciary_capacity_in_state_score := MAP(
                        le.corp_foreign_fiduciary_capacity_in_state_isnull OR ri.corp_foreign_fiduciary_capacity_in_state_isnull => 0,
                        le.corp_foreign_fiduciary_capacity_in_state = ri.corp_foreign_fiduciary_capacity_in_state  => le.corp_foreign_fiduciary_capacity_in_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_foreign_fiduciary_capacity_in_state_weight100,s.corp_foreign_fiduciary_capacity_in_state_switch));
  SELF.left_corp_governing_statute := le.corp_governing_statute;
  SELF.right_corp_governing_statute := ri.corp_governing_statute;
  SELF.corp_governing_statute_match_code := MAP(
		le.corp_governing_statute_isnull OR ri.corp_governing_statute_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_governing_statute(le.corp_governing_statute,ri.corp_governing_statute));
  SELF.corp_governing_statute_score := MAP(
                        le.corp_governing_statute_isnull OR ri.corp_governing_statute_isnull => 0,
                        le.corp_governing_statute = ri.corp_governing_statute  => le.corp_governing_statute_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_governing_statute_weight100,s.corp_governing_statute_switch));
  SELF.left_corp_has_members := le.corp_has_members;
  SELF.right_corp_has_members := ri.corp_has_members;
  SELF.corp_has_members_match_code := MAP(
		le.corp_has_members_isnull OR ri.corp_has_members_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_has_members(le.corp_has_members,ri.corp_has_members));
  SELF.corp_has_members_score := MAP(
                        le.corp_has_members_isnull OR ri.corp_has_members_isnull => 0,
                        le.corp_has_members = ri.corp_has_members  => le.corp_has_members_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_has_members_weight100,s.corp_has_members_switch));
  SELF.left_corp_has_vested_managers := le.corp_has_vested_managers;
  SELF.right_corp_has_vested_managers := ri.corp_has_vested_managers;
  SELF.corp_has_vested_managers_match_code := MAP(
		le.corp_has_vested_managers_isnull OR ri.corp_has_vested_managers_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_has_vested_managers(le.corp_has_vested_managers,ri.corp_has_vested_managers));
  SELF.corp_has_vested_managers_score := MAP(
                        le.corp_has_vested_managers_isnull OR ri.corp_has_vested_managers_isnull => 0,
                        le.corp_has_vested_managers = ri.corp_has_vested_managers  => le.corp_has_vested_managers_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_has_vested_managers_weight100,s.corp_has_vested_managers_switch));
  SELF.left_corp_home_incorporated_county := le.corp_home_incorporated_county;
  SELF.right_corp_home_incorporated_county := ri.corp_home_incorporated_county;
  SELF.corp_home_incorporated_county_match_code := MAP(
		le.corp_home_incorporated_county_isnull OR ri.corp_home_incorporated_county_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_home_incorporated_county(le.corp_home_incorporated_county,ri.corp_home_incorporated_county));
  SELF.corp_home_incorporated_county_score := MAP(
                        le.corp_home_incorporated_county_isnull OR ri.corp_home_incorporated_county_isnull => 0,
                        le.corp_home_incorporated_county = ri.corp_home_incorporated_county  => le.corp_home_incorporated_county_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_home_incorporated_county_weight100,s.corp_home_incorporated_county_switch));
  SELF.left_corp_home_state_name := le.corp_home_state_name;
  SELF.right_corp_home_state_name := ri.corp_home_state_name;
  SELF.corp_home_state_name_match_code := MAP(
		le.corp_home_state_name_isnull OR ri.corp_home_state_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_home_state_name(le.corp_home_state_name,ri.corp_home_state_name));
  SELF.corp_home_state_name_score := MAP(
                        le.corp_home_state_name_isnull OR ri.corp_home_state_name_isnull => 0,
                        le.corp_home_state_name = ri.corp_home_state_name  => le.corp_home_state_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_home_state_name_weight100,s.corp_home_state_name_switch));
  SELF.left_corp_is_professional := le.corp_is_professional;
  SELF.right_corp_is_professional := ri.corp_is_professional;
  SELF.corp_is_professional_match_code := MAP(
		le.corp_is_professional_isnull OR ri.corp_is_professional_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_is_professional(le.corp_is_professional,ri.corp_is_professional));
  SELF.corp_is_professional_score := MAP(
                        le.corp_is_professional_isnull OR ri.corp_is_professional_isnull => 0,
                        le.corp_is_professional = ri.corp_is_professional  => le.corp_is_professional_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_is_professional_weight100,s.corp_is_professional_switch));
  SELF.left_corp_is_non_profit_irs_approved := le.corp_is_non_profit_irs_approved;
  SELF.right_corp_is_non_profit_irs_approved := ri.corp_is_non_profit_irs_approved;
  SELF.corp_is_non_profit_irs_approved_match_code := MAP(
		le.corp_is_non_profit_irs_approved_isnull OR ri.corp_is_non_profit_irs_approved_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_is_non_profit_irs_approved(le.corp_is_non_profit_irs_approved,ri.corp_is_non_profit_irs_approved));
  SELF.corp_is_non_profit_irs_approved_score := MAP(
                        le.corp_is_non_profit_irs_approved_isnull OR ri.corp_is_non_profit_irs_approved_isnull => 0,
                        le.corp_is_non_profit_irs_approved = ri.corp_is_non_profit_irs_approved  => le.corp_is_non_profit_irs_approved_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_is_non_profit_irs_approved_weight100,s.corp_is_non_profit_irs_approved_switch));
  SELF.left_corp_last_renewal_date := le.corp_last_renewal_date;
  SELF.right_corp_last_renewal_date := ri.corp_last_renewal_date;
  SELF.corp_last_renewal_date_match_code := MAP(
		le.corp_last_renewal_date_isnull OR ri.corp_last_renewal_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_last_renewal_date(le.corp_last_renewal_date,ri.corp_last_renewal_date));
  SELF.corp_last_renewal_date_score := MAP(
                        le.corp_last_renewal_date_isnull OR ri.corp_last_renewal_date_isnull => 0,
                        le.corp_last_renewal_date = ri.corp_last_renewal_date  => le.corp_last_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_last_renewal_date_weight100,s.corp_last_renewal_date_switch));
  SELF.left_corp_last_renewal_year := le.corp_last_renewal_year;
  SELF.right_corp_last_renewal_year := ri.corp_last_renewal_year;
  SELF.corp_last_renewal_year_match_code := MAP(
		le.corp_last_renewal_year_isnull OR ri.corp_last_renewal_year_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_last_renewal_year(le.corp_last_renewal_year,ri.corp_last_renewal_year));
  SELF.corp_last_renewal_year_score := MAP(
                        le.corp_last_renewal_year_isnull OR ri.corp_last_renewal_year_isnull => 0,
                        le.corp_last_renewal_year = ri.corp_last_renewal_year  => le.corp_last_renewal_year_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_last_renewal_year_weight100,s.corp_last_renewal_year_switch));
  SELF.left_corp_license_type := le.corp_license_type;
  SELF.right_corp_license_type := ri.corp_license_type;
  SELF.corp_license_type_match_code := MAP(
		le.corp_license_type_isnull OR ri.corp_license_type_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_license_type(le.corp_license_type,ri.corp_license_type));
  SELF.corp_license_type_score := MAP(
                        le.corp_license_type_isnull OR ri.corp_license_type_isnull => 0,
                        le.corp_license_type = ri.corp_license_type  => le.corp_license_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_license_type_weight100,s.corp_license_type_switch));
  SELF.left_corp_llc_managed_desc := le.corp_llc_managed_desc;
  SELF.right_corp_llc_managed_desc := ri.corp_llc_managed_desc;
  SELF.corp_llc_managed_desc_match_code := MAP(
		le.corp_llc_managed_desc_isnull OR ri.corp_llc_managed_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_llc_managed_desc(le.corp_llc_managed_desc,ri.corp_llc_managed_desc));
  SELF.corp_llc_managed_desc_score := MAP(
                        le.corp_llc_managed_desc_isnull OR ri.corp_llc_managed_desc_isnull => 0,
                        le.corp_llc_managed_desc = ri.corp_llc_managed_desc  => le.corp_llc_managed_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_llc_managed_desc_weight100,s.corp_llc_managed_desc_switch));
  SELF.left_corp_llc_managed_ind := le.corp_llc_managed_ind;
  SELF.right_corp_llc_managed_ind := ri.corp_llc_managed_ind;
  SELF.corp_llc_managed_ind_match_code := MAP(
		le.corp_llc_managed_ind_isnull OR ri.corp_llc_managed_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_llc_managed_ind(le.corp_llc_managed_ind,ri.corp_llc_managed_ind));
  SELF.corp_llc_managed_ind_score := MAP(
                        le.corp_llc_managed_ind_isnull OR ri.corp_llc_managed_ind_isnull => 0,
                        le.corp_llc_managed_ind = ri.corp_llc_managed_ind  => le.corp_llc_managed_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_llc_managed_ind_weight100,s.corp_llc_managed_ind_switch));
  SELF.left_corp_management_desc := le.corp_management_desc;
  SELF.right_corp_management_desc := ri.corp_management_desc;
  SELF.corp_management_desc_match_code := MAP(
		le.corp_management_desc_isnull OR ri.corp_management_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_management_desc(le.corp_management_desc,ri.corp_management_desc));
  SELF.corp_management_desc_score := MAP(
                        le.corp_management_desc_isnull OR ri.corp_management_desc_isnull => 0,
                        le.corp_management_desc = ri.corp_management_desc  => le.corp_management_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_management_desc_weight100,s.corp_management_desc_switch));
  SELF.left_corp_management_type := le.corp_management_type;
  SELF.right_corp_management_type := ri.corp_management_type;
  SELF.corp_management_type_match_code := MAP(
		le.corp_management_type_isnull OR ri.corp_management_type_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_management_type(le.corp_management_type,ri.corp_management_type));
  SELF.corp_management_type_score := MAP(
                        le.corp_management_type_isnull OR ri.corp_management_type_isnull => 0,
                        le.corp_management_type = ri.corp_management_type  => le.corp_management_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_management_type_weight100,s.corp_management_type_switch));
  SELF.left_corp_manager_managed := le.corp_manager_managed;
  SELF.right_corp_manager_managed := ri.corp_manager_managed;
  SELF.corp_manager_managed_match_code := MAP(
		le.corp_manager_managed_isnull OR ri.corp_manager_managed_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_manager_managed(le.corp_manager_managed,ri.corp_manager_managed));
  SELF.corp_manager_managed_score := MAP(
                        le.corp_manager_managed_isnull OR ri.corp_manager_managed_isnull => 0,
                        le.corp_manager_managed = ri.corp_manager_managed  => le.corp_manager_managed_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_manager_managed_weight100,s.corp_manager_managed_switch));
  SELF.left_corp_merged_corporation_id := le.corp_merged_corporation_id;
  SELF.right_corp_merged_corporation_id := ri.corp_merged_corporation_id;
  SELF.corp_merged_corporation_id_match_code := MAP(
		le.corp_merged_corporation_id_isnull OR ri.corp_merged_corporation_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merged_corporation_id(le.corp_merged_corporation_id,ri.corp_merged_corporation_id));
  SELF.corp_merged_corporation_id_score := MAP(
                        le.corp_merged_corporation_id_isnull OR ri.corp_merged_corporation_id_isnull => 0,
                        le.corp_merged_corporation_id = ri.corp_merged_corporation_id  => le.corp_merged_corporation_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merged_corporation_id_weight100,s.corp_merged_corporation_id_switch));
  SELF.left_corp_merged_fein := le.corp_merged_fein;
  SELF.right_corp_merged_fein := ri.corp_merged_fein;
  SELF.corp_merged_fein_match_code := MAP(
		le.corp_merged_fein_isnull OR ri.corp_merged_fein_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merged_fein(le.corp_merged_fein,ri.corp_merged_fein));
  SELF.corp_merged_fein_score := MAP(
                        le.corp_merged_fein_isnull OR ri.corp_merged_fein_isnull => 0,
                        le.corp_merged_fein = ri.corp_merged_fein  => le.corp_merged_fein_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merged_fein_weight100,s.corp_merged_fein_switch));
  SELF.left_corp_merger_allowed_flag := le.corp_merger_allowed_flag;
  SELF.right_corp_merger_allowed_flag := ri.corp_merger_allowed_flag;
  SELF.corp_merger_allowed_flag_match_code := MAP(
		le.corp_merger_allowed_flag_isnull OR ri.corp_merger_allowed_flag_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_allowed_flag(le.corp_merger_allowed_flag,ri.corp_merger_allowed_flag));
  SELF.corp_merger_allowed_flag_score := MAP(
                        le.corp_merger_allowed_flag_isnull OR ri.corp_merger_allowed_flag_isnull => 0,
                        le.corp_merger_allowed_flag = ri.corp_merger_allowed_flag  => le.corp_merger_allowed_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_allowed_flag_weight100,s.corp_merger_allowed_flag_switch));
  SELF.left_corp_merger_date := le.corp_merger_date;
  SELF.right_corp_merger_date := ri.corp_merger_date;
  SELF.corp_merger_date_match_code := MAP(
		le.corp_merger_date_isnull OR ri.corp_merger_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_date(le.corp_merger_date,ri.corp_merger_date));
  SELF.corp_merger_date_score := MAP(
                        le.corp_merger_date_isnull OR ri.corp_merger_date_isnull => 0,
                        le.corp_merger_date = ri.corp_merger_date  => le.corp_merger_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_date_weight100,s.corp_merger_date_switch));
  SELF.left_corp_merger_desc := le.corp_merger_desc;
  SELF.right_corp_merger_desc := ri.corp_merger_desc;
  SELF.corp_merger_desc_match_code := MAP(
		le.corp_merger_desc_isnull OR ri.corp_merger_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_desc(le.corp_merger_desc,ri.corp_merger_desc));
  SELF.corp_merger_desc_score := MAP(
                        le.corp_merger_desc_isnull OR ri.corp_merger_desc_isnull => 0,
                        le.corp_merger_desc = ri.corp_merger_desc  => le.corp_merger_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_desc_weight100,s.corp_merger_desc_switch));
  SELF.left_corp_merger_effective_date := le.corp_merger_effective_date;
  SELF.right_corp_merger_effective_date := ri.corp_merger_effective_date;
  SELF.corp_merger_effective_date_match_code := MAP(
		le.corp_merger_effective_date_isnull OR ri.corp_merger_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_effective_date(le.corp_merger_effective_date,ri.corp_merger_effective_date));
  SELF.corp_merger_effective_date_score := MAP(
                        le.corp_merger_effective_date_isnull OR ri.corp_merger_effective_date_isnull => 0,
                        le.corp_merger_effective_date = ri.corp_merger_effective_date  => le.corp_merger_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_effective_date_weight100,s.corp_merger_effective_date_switch));
  SELF.left_corp_merger_id := le.corp_merger_id;
  SELF.right_corp_merger_id := ri.corp_merger_id;
  SELF.corp_merger_id_match_code := MAP(
		le.corp_merger_id_isnull OR ri.corp_merger_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_id(le.corp_merger_id,ri.corp_merger_id));
  SELF.corp_merger_id_score := MAP(
                        le.corp_merger_id_isnull OR ri.corp_merger_id_isnull => 0,
                        le.corp_merger_id = ri.corp_merger_id  => le.corp_merger_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_id_weight100,s.corp_merger_id_switch));
  SELF.left_corp_merger_indicator := le.corp_merger_indicator;
  SELF.right_corp_merger_indicator := ri.corp_merger_indicator;
  SELF.corp_merger_indicator_match_code := MAP(
		le.corp_merger_indicator_isnull OR ri.corp_merger_indicator_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_indicator(le.corp_merger_indicator,ri.corp_merger_indicator));
  SELF.corp_merger_indicator_score := MAP(
                        le.corp_merger_indicator_isnull OR ri.corp_merger_indicator_isnull => 0,
                        le.corp_merger_indicator = ri.corp_merger_indicator  => le.corp_merger_indicator_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_indicator_weight100,s.corp_merger_indicator_switch));
  SELF.left_corp_merger_name := le.corp_merger_name;
  SELF.right_corp_merger_name := ri.corp_merger_name;
  SELF.corp_merger_name_match_code := MAP(
		le.corp_merger_name_isnull OR ri.corp_merger_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_name(le.corp_merger_name,ri.corp_merger_name));
  SELF.corp_merger_name_score := MAP(
                        le.corp_merger_name_isnull OR ri.corp_merger_name_isnull => 0,
                        le.corp_merger_name = ri.corp_merger_name  => le.corp_merger_name_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_name_weight100,s.corp_merger_name_switch));
  SELF.left_corp_merger_type_converted_to_cd := le.corp_merger_type_converted_to_cd;
  SELF.right_corp_merger_type_converted_to_cd := ri.corp_merger_type_converted_to_cd;
  SELF.corp_merger_type_converted_to_cd_match_code := MAP(
		le.corp_merger_type_converted_to_cd_isnull OR ri.corp_merger_type_converted_to_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_type_converted_to_cd(le.corp_merger_type_converted_to_cd,ri.corp_merger_type_converted_to_cd));
  SELF.corp_merger_type_converted_to_cd_score := MAP(
                        le.corp_merger_type_converted_to_cd_isnull OR ri.corp_merger_type_converted_to_cd_isnull => 0,
                        le.corp_merger_type_converted_to_cd = ri.corp_merger_type_converted_to_cd  => le.corp_merger_type_converted_to_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_type_converted_to_cd_weight100,s.corp_merger_type_converted_to_cd_switch));
  SELF.left_corp_merger_type_converted_to_desc := le.corp_merger_type_converted_to_desc;
  SELF.right_corp_merger_type_converted_to_desc := ri.corp_merger_type_converted_to_desc;
  SELF.corp_merger_type_converted_to_desc_match_code := MAP(
		le.corp_merger_type_converted_to_desc_isnull OR ri.corp_merger_type_converted_to_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_merger_type_converted_to_desc(le.corp_merger_type_converted_to_desc,ri.corp_merger_type_converted_to_desc));
  SELF.corp_merger_type_converted_to_desc_score := MAP(
                        le.corp_merger_type_converted_to_desc_isnull OR ri.corp_merger_type_converted_to_desc_isnull => 0,
                        le.corp_merger_type_converted_to_desc = ri.corp_merger_type_converted_to_desc  => le.corp_merger_type_converted_to_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_merger_type_converted_to_desc_weight100,s.corp_merger_type_converted_to_desc_switch));
  SELF.left_corp_naics_desc := le.corp_naics_desc;
  SELF.right_corp_naics_desc := ri.corp_naics_desc;
  SELF.corp_naics_desc_match_code := MAP(
		le.corp_naics_desc_isnull OR ri.corp_naics_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_naics_desc(le.corp_naics_desc,ri.corp_naics_desc));
  SELF.corp_naics_desc_score := MAP(
                        le.corp_naics_desc_isnull OR ri.corp_naics_desc_isnull => 0,
                        le.corp_naics_desc = ri.corp_naics_desc  => le.corp_naics_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_naics_desc_weight100,s.corp_naics_desc_switch));
  SELF.left_corp_name_effective_date := le.corp_name_effective_date;
  SELF.right_corp_name_effective_date := ri.corp_name_effective_date;
  SELF.corp_name_effective_date_match_code := MAP(
		le.corp_name_effective_date_isnull OR ri.corp_name_effective_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_effective_date(le.corp_name_effective_date,ri.corp_name_effective_date));
  SELF.corp_name_effective_date_score := MAP(
                        le.corp_name_effective_date_isnull OR ri.corp_name_effective_date_isnull => 0,
                        le.corp_name_effective_date = ri.corp_name_effective_date  => le.corp_name_effective_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_effective_date_weight100,s.corp_name_effective_date_switch));
  SELF.left_corp_name_reservation_date := le.corp_name_reservation_date;
  SELF.right_corp_name_reservation_date := ri.corp_name_reservation_date;
  SELF.corp_name_reservation_date_match_code := MAP(
		le.corp_name_reservation_date_isnull OR ri.corp_name_reservation_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_reservation_date(le.corp_name_reservation_date,ri.corp_name_reservation_date));
  SELF.corp_name_reservation_date_score := MAP(
                        le.corp_name_reservation_date_isnull OR ri.corp_name_reservation_date_isnull => 0,
                        le.corp_name_reservation_date = ri.corp_name_reservation_date  => le.corp_name_reservation_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_date_weight100,s.corp_name_reservation_date_switch));
  SELF.left_corp_name_reservation_desc := le.corp_name_reservation_desc;
  SELF.right_corp_name_reservation_desc := ri.corp_name_reservation_desc;
  SELF.corp_name_reservation_desc_match_code := MAP(
		le.corp_name_reservation_desc_isnull OR ri.corp_name_reservation_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_reservation_desc(le.corp_name_reservation_desc,ri.corp_name_reservation_desc));
  SELF.corp_name_reservation_desc_score := MAP(
                        le.corp_name_reservation_desc_isnull OR ri.corp_name_reservation_desc_isnull => 0,
                        le.corp_name_reservation_desc = ri.corp_name_reservation_desc  => le.corp_name_reservation_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_desc_weight100,s.corp_name_reservation_desc_switch));
  SELF.left_corp_name_reservation_expiration_date := le.corp_name_reservation_expiration_date;
  SELF.right_corp_name_reservation_expiration_date := ri.corp_name_reservation_expiration_date;
  SELF.corp_name_reservation_expiration_date_match_code := MAP(
		le.corp_name_reservation_expiration_date_isnull OR ri.corp_name_reservation_expiration_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_reservation_expiration_date(le.corp_name_reservation_expiration_date,ri.corp_name_reservation_expiration_date));
  SELF.corp_name_reservation_expiration_date_score := MAP(
                        le.corp_name_reservation_expiration_date_isnull OR ri.corp_name_reservation_expiration_date_isnull => 0,
                        le.corp_name_reservation_expiration_date = ri.corp_name_reservation_expiration_date  => le.corp_name_reservation_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_expiration_date_weight100,s.corp_name_reservation_expiration_date_switch));
  SELF.left_corp_name_reservation_nbr := le.corp_name_reservation_nbr;
  SELF.right_corp_name_reservation_nbr := ri.corp_name_reservation_nbr;
  SELF.corp_name_reservation_nbr_match_code := MAP(
		le.corp_name_reservation_nbr_isnull OR ri.corp_name_reservation_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_reservation_nbr(le.corp_name_reservation_nbr,ri.corp_name_reservation_nbr));
  SELF.corp_name_reservation_nbr_score := MAP(
                        le.corp_name_reservation_nbr_isnull OR ri.corp_name_reservation_nbr_isnull => 0,
                        le.corp_name_reservation_nbr = ri.corp_name_reservation_nbr  => le.corp_name_reservation_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_nbr_weight100,s.corp_name_reservation_nbr_switch));
  SELF.left_corp_name_reservation_type := le.corp_name_reservation_type;
  SELF.right_corp_name_reservation_type := ri.corp_name_reservation_type;
  SELF.corp_name_reservation_type_match_code := MAP(
		le.corp_name_reservation_type_isnull OR ri.corp_name_reservation_type_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_reservation_type(le.corp_name_reservation_type,ri.corp_name_reservation_type));
  SELF.corp_name_reservation_type_score := MAP(
                        le.corp_name_reservation_type_isnull OR ri.corp_name_reservation_type_isnull => 0,
                        le.corp_name_reservation_type = ri.corp_name_reservation_type  => le.corp_name_reservation_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_reservation_type_weight100,s.corp_name_reservation_type_switch));
  SELF.left_corp_name_status_cd := le.corp_name_status_cd;
  SELF.right_corp_name_status_cd := ri.corp_name_status_cd;
  SELF.corp_name_status_cd_match_code := MAP(
		le.corp_name_status_cd_isnull OR ri.corp_name_status_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_status_cd(le.corp_name_status_cd,ri.corp_name_status_cd));
  SELF.corp_name_status_cd_score := MAP(
                        le.corp_name_status_cd_isnull OR ri.corp_name_status_cd_isnull => 0,
                        le.corp_name_status_cd = ri.corp_name_status_cd  => le.corp_name_status_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_cd_weight100,s.corp_name_status_cd_switch));
  SELF.left_corp_name_status_date := le.corp_name_status_date;
  SELF.right_corp_name_status_date := ri.corp_name_status_date;
  SELF.corp_name_status_date_match_code := MAP(
		le.corp_name_status_date_isnull OR ri.corp_name_status_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_status_date(le.corp_name_status_date,ri.corp_name_status_date));
  SELF.corp_name_status_date_score := MAP(
                        le.corp_name_status_date_isnull OR ri.corp_name_status_date_isnull => 0,
                        le.corp_name_status_date = ri.corp_name_status_date  => le.corp_name_status_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_date_weight100,s.corp_name_status_date_switch));
  SELF.left_corp_name_status_desc := le.corp_name_status_desc;
  SELF.right_corp_name_status_desc := ri.corp_name_status_desc;
  SELF.corp_name_status_desc_match_code := MAP(
		le.corp_name_status_desc_isnull OR ri.corp_name_status_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_name_status_desc(le.corp_name_status_desc,ri.corp_name_status_desc));
  SELF.corp_name_status_desc_score := MAP(
                        le.corp_name_status_desc_isnull OR ri.corp_name_status_desc_isnull => 0,
                        le.corp_name_status_desc = ri.corp_name_status_desc  => le.corp_name_status_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_name_status_desc_weight100,s.corp_name_status_desc_switch));
  SELF.left_corp_non_profit_irs_approved_purpose := le.corp_non_profit_irs_approved_purpose;
  SELF.right_corp_non_profit_irs_approved_purpose := ri.corp_non_profit_irs_approved_purpose;
  SELF.corp_non_profit_irs_approved_purpose_match_code := MAP(
		le.corp_non_profit_irs_approved_purpose_isnull OR ri.corp_non_profit_irs_approved_purpose_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_non_profit_irs_approved_purpose(le.corp_non_profit_irs_approved_purpose,ri.corp_non_profit_irs_approved_purpose));
  SELF.corp_non_profit_irs_approved_purpose_score := MAP(
                        le.corp_non_profit_irs_approved_purpose_isnull OR ri.corp_non_profit_irs_approved_purpose_isnull => 0,
                        le.corp_non_profit_irs_approved_purpose = ri.corp_non_profit_irs_approved_purpose  => le.corp_non_profit_irs_approved_purpose_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_non_profit_irs_approved_purpose_weight100,s.corp_non_profit_irs_approved_purpose_switch));
  SELF.left_corp_non_profit_solicit_donations := le.corp_non_profit_solicit_donations;
  SELF.right_corp_non_profit_solicit_donations := ri.corp_non_profit_solicit_donations;
  SELF.corp_non_profit_solicit_donations_match_code := MAP(
		le.corp_non_profit_solicit_donations_isnull OR ri.corp_non_profit_solicit_donations_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_non_profit_solicit_donations(le.corp_non_profit_solicit_donations,ri.corp_non_profit_solicit_donations));
  SELF.corp_non_profit_solicit_donations_score := MAP(
                        le.corp_non_profit_solicit_donations_isnull OR ri.corp_non_profit_solicit_donations_isnull => 0,
                        le.corp_non_profit_solicit_donations = ri.corp_non_profit_solicit_donations  => le.corp_non_profit_solicit_donations_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_non_profit_solicit_donations_weight100,s.corp_non_profit_solicit_donations_switch));
  SELF.left_corp_nbr_of_amendments := le.corp_nbr_of_amendments;
  SELF.right_corp_nbr_of_amendments := ri.corp_nbr_of_amendments;
  SELF.corp_nbr_of_amendments_match_code := MAP(
		le.corp_nbr_of_amendments_isnull OR ri.corp_nbr_of_amendments_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_nbr_of_amendments(le.corp_nbr_of_amendments,ri.corp_nbr_of_amendments));
  SELF.corp_nbr_of_amendments_score := MAP(
                        le.corp_nbr_of_amendments_isnull OR ri.corp_nbr_of_amendments_isnull => 0,
                        le.corp_nbr_of_amendments = ri.corp_nbr_of_amendments  => le.corp_nbr_of_amendments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_amendments_weight100,s.corp_nbr_of_amendments_switch));
  SELF.left_corp_nbr_of_initial_llc_members := le.corp_nbr_of_initial_llc_members;
  SELF.right_corp_nbr_of_initial_llc_members := ri.corp_nbr_of_initial_llc_members;
  SELF.corp_nbr_of_initial_llc_members_match_code := MAP(
		le.corp_nbr_of_initial_llc_members_isnull OR ri.corp_nbr_of_initial_llc_members_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_nbr_of_initial_llc_members(le.corp_nbr_of_initial_llc_members,ri.corp_nbr_of_initial_llc_members));
  SELF.corp_nbr_of_initial_llc_members_score := MAP(
                        le.corp_nbr_of_initial_llc_members_isnull OR ri.corp_nbr_of_initial_llc_members_isnull => 0,
                        le.corp_nbr_of_initial_llc_members = ri.corp_nbr_of_initial_llc_members  => le.corp_nbr_of_initial_llc_members_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_initial_llc_members_weight100,s.corp_nbr_of_initial_llc_members_switch));
  SELF.left_corp_nbr_of_partners := le.corp_nbr_of_partners;
  SELF.right_corp_nbr_of_partners := ri.corp_nbr_of_partners;
  SELF.corp_nbr_of_partners_match_code := MAP(
		le.corp_nbr_of_partners_isnull OR ri.corp_nbr_of_partners_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_nbr_of_partners(le.corp_nbr_of_partners,ri.corp_nbr_of_partners));
  SELF.corp_nbr_of_partners_score := MAP(
                        le.corp_nbr_of_partners_isnull OR ri.corp_nbr_of_partners_isnull => 0,
                        le.corp_nbr_of_partners = ri.corp_nbr_of_partners  => le.corp_nbr_of_partners_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_nbr_of_partners_weight100,s.corp_nbr_of_partners_switch));
  SELF.left_corp_operating_agreement := le.corp_operating_agreement;
  SELF.right_corp_operating_agreement := ri.corp_operating_agreement;
  SELF.corp_operating_agreement_match_code := MAP(
		le.corp_operating_agreement_isnull OR ri.corp_operating_agreement_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_operating_agreement(le.corp_operating_agreement,ri.corp_operating_agreement));
  SELF.corp_operating_agreement_score := MAP(
                        le.corp_operating_agreement_isnull OR ri.corp_operating_agreement_isnull => 0,
                        le.corp_operating_agreement = ri.corp_operating_agreement  => le.corp_operating_agreement_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_operating_agreement_weight100,s.corp_operating_agreement_switch));
  SELF.left_corp_opt_in_llc_act_desc := le.corp_opt_in_llc_act_desc;
  SELF.right_corp_opt_in_llc_act_desc := ri.corp_opt_in_llc_act_desc;
  SELF.corp_opt_in_llc_act_desc_match_code := MAP(
		le.corp_opt_in_llc_act_desc_isnull OR ri.corp_opt_in_llc_act_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_opt_in_llc_act_desc(le.corp_opt_in_llc_act_desc,ri.corp_opt_in_llc_act_desc));
  SELF.corp_opt_in_llc_act_desc_score := MAP(
                        le.corp_opt_in_llc_act_desc_isnull OR ri.corp_opt_in_llc_act_desc_isnull => 0,
                        le.corp_opt_in_llc_act_desc = ri.corp_opt_in_llc_act_desc  => le.corp_opt_in_llc_act_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_opt_in_llc_act_desc_weight100,s.corp_opt_in_llc_act_desc_switch));
  SELF.left_corp_opt_in_llc_act_ind := le.corp_opt_in_llc_act_ind;
  SELF.right_corp_opt_in_llc_act_ind := ri.corp_opt_in_llc_act_ind;
  SELF.corp_opt_in_llc_act_ind_match_code := MAP(
		le.corp_opt_in_llc_act_ind_isnull OR ri.corp_opt_in_llc_act_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_opt_in_llc_act_ind(le.corp_opt_in_llc_act_ind,ri.corp_opt_in_llc_act_ind));
  SELF.corp_opt_in_llc_act_ind_score := MAP(
                        le.corp_opt_in_llc_act_ind_isnull OR ri.corp_opt_in_llc_act_ind_isnull => 0,
                        le.corp_opt_in_llc_act_ind = ri.corp_opt_in_llc_act_ind  => le.corp_opt_in_llc_act_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_opt_in_llc_act_ind_weight100,s.corp_opt_in_llc_act_ind_switch));
  SELF.left_corp_organizational_comments := le.corp_organizational_comments;
  SELF.right_corp_organizational_comments := ri.corp_organizational_comments;
  SELF.corp_organizational_comments_match_code := MAP(
		le.corp_organizational_comments_isnull OR ri.corp_organizational_comments_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_organizational_comments(le.corp_organizational_comments,ri.corp_organizational_comments));
  SELF.corp_organizational_comments_score := MAP(
                        le.corp_organizational_comments_isnull OR ri.corp_organizational_comments_isnull => 0,
                        le.corp_organizational_comments = ri.corp_organizational_comments  => le.corp_organizational_comments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_organizational_comments_weight100,s.corp_organizational_comments_switch));
  SELF.left_corp_partner_contributions_total := le.corp_partner_contributions_total;
  SELF.right_corp_partner_contributions_total := ri.corp_partner_contributions_total;
  SELF.corp_partner_contributions_total_match_code := MAP(
		le.corp_partner_contributions_total_isnull OR ri.corp_partner_contributions_total_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_partner_contributions_total(le.corp_partner_contributions_total,ri.corp_partner_contributions_total));
  SELF.corp_partner_contributions_total_score := MAP(
                        le.corp_partner_contributions_total_isnull OR ri.corp_partner_contributions_total_isnull => 0,
                        le.corp_partner_contributions_total = ri.corp_partner_contributions_total  => le.corp_partner_contributions_total_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partner_contributions_total_weight100,s.corp_partner_contributions_total_switch));
  SELF.left_corp_partner_terms := le.corp_partner_terms;
  SELF.right_corp_partner_terms := ri.corp_partner_terms;
  SELF.corp_partner_terms_match_code := MAP(
		le.corp_partner_terms_isnull OR ri.corp_partner_terms_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_partner_terms(le.corp_partner_terms,ri.corp_partner_terms));
  SELF.corp_partner_terms_score := MAP(
                        le.corp_partner_terms_isnull OR ri.corp_partner_terms_isnull => 0,
                        le.corp_partner_terms = ri.corp_partner_terms  => le.corp_partner_terms_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_partner_terms_weight100,s.corp_partner_terms_switch));
  SELF.left_corp_percentage_voters_required_to_approve_amendments := le.corp_percentage_voters_required_to_approve_amendments;
  SELF.right_corp_percentage_voters_required_to_approve_amendments := ri.corp_percentage_voters_required_to_approve_amendments;
  SELF.corp_percentage_voters_required_to_approve_amendments_match_code := MAP(
		le.corp_percentage_voters_required_to_approve_amendments_isnull OR ri.corp_percentage_voters_required_to_approve_amendments_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_percentage_voters_required_to_approve_amendments(le.corp_percentage_voters_required_to_approve_amendments,ri.corp_percentage_voters_required_to_approve_amendments));
  SELF.corp_percentage_voters_required_to_approve_amendments_score := MAP(
                        le.corp_percentage_voters_required_to_approve_amendments_isnull OR ri.corp_percentage_voters_required_to_approve_amendments_isnull => 0,
                        le.corp_percentage_voters_required_to_approve_amendments = ri.corp_percentage_voters_required_to_approve_amendments  => le.corp_percentage_voters_required_to_approve_amendments_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_percentage_voters_required_to_approve_amendments_weight100,s.corp_percentage_voters_required_to_approve_amendments_switch));
  SELF.left_corp_profession := le.corp_profession;
  SELF.right_corp_profession := ri.corp_profession;
  SELF.corp_profession_match_code := MAP(
		le.corp_profession_isnull OR ri.corp_profession_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_profession(le.corp_profession,ri.corp_profession));
  SELF.corp_profession_score := MAP(
                        le.corp_profession_isnull OR ri.corp_profession_isnull => 0,
                        le.corp_profession = ri.corp_profession  => le.corp_profession_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_profession_weight100,s.corp_profession_switch));
  SELF.left_corp_province := le.corp_province;
  SELF.right_corp_province := ri.corp_province;
  SELF.corp_province_match_code := MAP(
		le.corp_province_isnull OR ri.corp_province_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_province(le.corp_province,ri.corp_province));
  SELF.corp_province_score := MAP(
                        le.corp_province_isnull OR ri.corp_province_isnull => 0,
                        le.corp_province = ri.corp_province  => le.corp_province_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_province_weight100,s.corp_province_switch));
  SELF.left_corp_public_mutual_corporation := le.corp_public_mutual_corporation;
  SELF.right_corp_public_mutual_corporation := ri.corp_public_mutual_corporation;
  SELF.corp_public_mutual_corporation_match_code := MAP(
		le.corp_public_mutual_corporation_isnull OR ri.corp_public_mutual_corporation_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_public_mutual_corporation(le.corp_public_mutual_corporation,ri.corp_public_mutual_corporation));
  SELF.corp_public_mutual_corporation_score := MAP(
                        le.corp_public_mutual_corporation_isnull OR ri.corp_public_mutual_corporation_isnull => 0,
                        le.corp_public_mutual_corporation = ri.corp_public_mutual_corporation  => le.corp_public_mutual_corporation_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_public_mutual_corporation_weight100,s.corp_public_mutual_corporation_switch));
  SELF.left_corp_purpose := le.corp_purpose;
  SELF.right_corp_purpose := ri.corp_purpose;
  SELF.corp_purpose_match_code := MAP(
		le.corp_purpose_isnull OR ri.corp_purpose_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_purpose(le.corp_purpose,ri.corp_purpose));
  SELF.corp_purpose_score := MAP(
                        le.corp_purpose_isnull OR ri.corp_purpose_isnull => 0,
                        le.corp_purpose = ri.corp_purpose  => le.corp_purpose_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_purpose_weight100,s.corp_purpose_switch));
  SELF.left_corp_ra_required_flag := le.corp_ra_required_flag;
  SELF.right_corp_ra_required_flag := ri.corp_ra_required_flag;
  SELF.corp_ra_required_flag_match_code := MAP(
		le.corp_ra_required_flag_isnull OR ri.corp_ra_required_flag_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_ra_required_flag(le.corp_ra_required_flag,ri.corp_ra_required_flag));
  SELF.corp_ra_required_flag_score := MAP(
                        le.corp_ra_required_flag_isnull OR ri.corp_ra_required_flag_isnull => 0,
                        le.corp_ra_required_flag = ri.corp_ra_required_flag  => le.corp_ra_required_flag_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_ra_required_flag_weight100,s.corp_ra_required_flag_switch));
  SELF.left_corp_registered_counties := le.corp_registered_counties;
  SELF.right_corp_registered_counties := ri.corp_registered_counties;
  SELF.corp_registered_counties_match_code := MAP(
		le.corp_registered_counties_isnull OR ri.corp_registered_counties_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_registered_counties(le.corp_registered_counties,ri.corp_registered_counties));
  SELF.corp_registered_counties_score := MAP(
                        le.corp_registered_counties_isnull OR ri.corp_registered_counties_isnull => 0,
                        le.corp_registered_counties = ri.corp_registered_counties  => le.corp_registered_counties_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_registered_counties_weight100,s.corp_registered_counties_switch));
  SELF.left_corp_regulated_ind := le.corp_regulated_ind;
  SELF.right_corp_regulated_ind := ri.corp_regulated_ind;
  SELF.corp_regulated_ind_match_code := MAP(
		le.corp_regulated_ind_isnull OR ri.corp_regulated_ind_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_regulated_ind(le.corp_regulated_ind,ri.corp_regulated_ind));
  SELF.corp_regulated_ind_score := MAP(
                        le.corp_regulated_ind_isnull OR ri.corp_regulated_ind_isnull => 0,
                        le.corp_regulated_ind = ri.corp_regulated_ind  => le.corp_regulated_ind_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_regulated_ind_weight100,s.corp_regulated_ind_switch));
  SELF.left_corp_renewal_date := le.corp_renewal_date;
  SELF.right_corp_renewal_date := ri.corp_renewal_date;
  SELF.corp_renewal_date_match_code := MAP(
		le.corp_renewal_date_isnull OR ri.corp_renewal_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_renewal_date(le.corp_renewal_date,ri.corp_renewal_date));
  SELF.corp_renewal_date_score := MAP(
                        le.corp_renewal_date_isnull OR ri.corp_renewal_date_isnull => 0,
                        le.corp_renewal_date = ri.corp_renewal_date  => le.corp_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_renewal_date_weight100,s.corp_renewal_date_switch));
  SELF.left_corp_standing_other := le.corp_standing_other;
  SELF.right_corp_standing_other := ri.corp_standing_other;
  SELF.corp_standing_other_match_code := MAP(
		le.corp_standing_other_isnull OR ri.corp_standing_other_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_standing_other(le.corp_standing_other,ri.corp_standing_other));
  SELF.corp_standing_other_score := MAP(
                        le.corp_standing_other_isnull OR ri.corp_standing_other_isnull => 0,
                        le.corp_standing_other = ri.corp_standing_other  => le.corp_standing_other_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_standing_other_weight100,s.corp_standing_other_switch));
  SELF.left_corp_survivor_corporation_id := le.corp_survivor_corporation_id;
  SELF.right_corp_survivor_corporation_id := ri.corp_survivor_corporation_id;
  SELF.corp_survivor_corporation_id_match_code := MAP(
		le.corp_survivor_corporation_id_isnull OR ri.corp_survivor_corporation_id_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_survivor_corporation_id(le.corp_survivor_corporation_id,ri.corp_survivor_corporation_id));
  SELF.corp_survivor_corporation_id_score := MAP(
                        le.corp_survivor_corporation_id_isnull OR ri.corp_survivor_corporation_id_isnull => 0,
                        le.corp_survivor_corporation_id = ri.corp_survivor_corporation_id  => le.corp_survivor_corporation_id_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_survivor_corporation_id_weight100,s.corp_survivor_corporation_id_switch));
  SELF.left_corp_tax_base := le.corp_tax_base;
  SELF.right_corp_tax_base := ri.corp_tax_base;
  SELF.corp_tax_base_match_code := MAP(
		le.corp_tax_base_isnull OR ri.corp_tax_base_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_tax_base(le.corp_tax_base,ri.corp_tax_base));
  SELF.corp_tax_base_score := MAP(
                        le.corp_tax_base_isnull OR ri.corp_tax_base_isnull => 0,
                        le.corp_tax_base = ri.corp_tax_base  => le.corp_tax_base_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_base_weight100,s.corp_tax_base_switch));
  SELF.left_corp_tax_standing := le.corp_tax_standing;
  SELF.right_corp_tax_standing := ri.corp_tax_standing;
  SELF.corp_tax_standing_match_code := MAP(
		le.corp_tax_standing_isnull OR ri.corp_tax_standing_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_tax_standing(le.corp_tax_standing,ri.corp_tax_standing));
  SELF.corp_tax_standing_score := MAP(
                        le.corp_tax_standing_isnull OR ri.corp_tax_standing_isnull => 0,
                        le.corp_tax_standing = ri.corp_tax_standing  => le.corp_tax_standing_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_tax_standing_weight100,s.corp_tax_standing_switch));
  SELF.left_corp_termination_cd := le.corp_termination_cd;
  SELF.right_corp_termination_cd := ri.corp_termination_cd;
  SELF.corp_termination_cd_match_code := MAP(
		le.corp_termination_cd_isnull OR ri.corp_termination_cd_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_termination_cd(le.corp_termination_cd,ri.corp_termination_cd));
  SELF.corp_termination_cd_score := MAP(
                        le.corp_termination_cd_isnull OR ri.corp_termination_cd_isnull => 0,
                        le.corp_termination_cd = ri.corp_termination_cd  => le.corp_termination_cd_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_cd_weight100,s.corp_termination_cd_switch));
  SELF.left_corp_termination_desc := le.corp_termination_desc;
  SELF.right_corp_termination_desc := ri.corp_termination_desc;
  SELF.corp_termination_desc_match_code := MAP(
		le.corp_termination_desc_isnull OR ri.corp_termination_desc_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_termination_desc(le.corp_termination_desc,ri.corp_termination_desc));
  SELF.corp_termination_desc_score := MAP(
                        le.corp_termination_desc_isnull OR ri.corp_termination_desc_isnull => 0,
                        le.corp_termination_desc = ri.corp_termination_desc  => le.corp_termination_desc_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_desc_weight100,s.corp_termination_desc_switch));
  SELF.left_corp_termination_date := le.corp_termination_date;
  SELF.right_corp_termination_date := ri.corp_termination_date;
  SELF.corp_termination_date_match_code := MAP(
		le.corp_termination_date_isnull OR ri.corp_termination_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_termination_date(le.corp_termination_date,ri.corp_termination_date));
  SELF.corp_termination_date_score := MAP(
                        le.corp_termination_date_isnull OR ri.corp_termination_date_isnull => 0,
                        le.corp_termination_date = ri.corp_termination_date  => le.corp_termination_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_termination_date_weight100,s.corp_termination_date_switch));
  SELF.left_corp_trademark_business_mark_type := le.corp_trademark_business_mark_type;
  SELF.right_corp_trademark_business_mark_type := ri.corp_trademark_business_mark_type;
  SELF.corp_trademark_business_mark_type_match_code := MAP(
		le.corp_trademark_business_mark_type_isnull OR ri.corp_trademark_business_mark_type_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_business_mark_type(le.corp_trademark_business_mark_type,ri.corp_trademark_business_mark_type));
  SELF.corp_trademark_business_mark_type_score := MAP(
                        le.corp_trademark_business_mark_type_isnull OR ri.corp_trademark_business_mark_type_isnull => 0,
                        le.corp_trademark_business_mark_type = ri.corp_trademark_business_mark_type  => le.corp_trademark_business_mark_type_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_business_mark_type_weight100,s.corp_trademark_business_mark_type_switch));
  SELF.left_corp_trademark_cancelled_date := le.corp_trademark_cancelled_date;
  SELF.right_corp_trademark_cancelled_date := ri.corp_trademark_cancelled_date;
  SELF.corp_trademark_cancelled_date_match_code := MAP(
		le.corp_trademark_cancelled_date_isnull OR ri.corp_trademark_cancelled_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_cancelled_date(le.corp_trademark_cancelled_date,ri.corp_trademark_cancelled_date));
  SELF.corp_trademark_cancelled_date_score := MAP(
                        le.corp_trademark_cancelled_date_isnull OR ri.corp_trademark_cancelled_date_isnull => 0,
                        le.corp_trademark_cancelled_date = ri.corp_trademark_cancelled_date  => le.corp_trademark_cancelled_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_cancelled_date_weight100,s.corp_trademark_cancelled_date_switch));
  SELF.left_corp_trademark_class_desc1 := le.corp_trademark_class_desc1;
  SELF.right_corp_trademark_class_desc1 := ri.corp_trademark_class_desc1;
  SELF.corp_trademark_class_desc1_match_code := MAP(
		le.corp_trademark_class_desc1_isnull OR ri.corp_trademark_class_desc1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc1(le.corp_trademark_class_desc1,ri.corp_trademark_class_desc1));
  SELF.corp_trademark_class_desc1_score := MAP(
                        le.corp_trademark_class_desc1_isnull OR ri.corp_trademark_class_desc1_isnull => 0,
                        le.corp_trademark_class_desc1 = ri.corp_trademark_class_desc1  => le.corp_trademark_class_desc1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc1_weight100,s.corp_trademark_class_desc1_switch));
  SELF.left_corp_trademark_class_desc2 := le.corp_trademark_class_desc2;
  SELF.right_corp_trademark_class_desc2 := ri.corp_trademark_class_desc2;
  SELF.corp_trademark_class_desc2_match_code := MAP(
		le.corp_trademark_class_desc2_isnull OR ri.corp_trademark_class_desc2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc2(le.corp_trademark_class_desc2,ri.corp_trademark_class_desc2));
  SELF.corp_trademark_class_desc2_score := MAP(
                        le.corp_trademark_class_desc2_isnull OR ri.corp_trademark_class_desc2_isnull => 0,
                        le.corp_trademark_class_desc2 = ri.corp_trademark_class_desc2  => le.corp_trademark_class_desc2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc2_weight100,s.corp_trademark_class_desc2_switch));
  SELF.left_corp_trademark_class_desc3 := le.corp_trademark_class_desc3;
  SELF.right_corp_trademark_class_desc3 := ri.corp_trademark_class_desc3;
  SELF.corp_trademark_class_desc3_match_code := MAP(
		le.corp_trademark_class_desc3_isnull OR ri.corp_trademark_class_desc3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc3(le.corp_trademark_class_desc3,ri.corp_trademark_class_desc3));
  SELF.corp_trademark_class_desc3_score := MAP(
                        le.corp_trademark_class_desc3_isnull OR ri.corp_trademark_class_desc3_isnull => 0,
                        le.corp_trademark_class_desc3 = ri.corp_trademark_class_desc3  => le.corp_trademark_class_desc3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc3_weight100,s.corp_trademark_class_desc3_switch));
  SELF.left_corp_trademark_class_desc4 := le.corp_trademark_class_desc4;
  SELF.right_corp_trademark_class_desc4 := ri.corp_trademark_class_desc4;
  SELF.corp_trademark_class_desc4_match_code := MAP(
		le.corp_trademark_class_desc4_isnull OR ri.corp_trademark_class_desc4_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc4(le.corp_trademark_class_desc4,ri.corp_trademark_class_desc4));
  SELF.corp_trademark_class_desc4_score := MAP(
                        le.corp_trademark_class_desc4_isnull OR ri.corp_trademark_class_desc4_isnull => 0,
                        le.corp_trademark_class_desc4 = ri.corp_trademark_class_desc4  => le.corp_trademark_class_desc4_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc4_weight100,s.corp_trademark_class_desc4_switch));
  SELF.left_corp_trademark_class_desc5 := le.corp_trademark_class_desc5;
  SELF.right_corp_trademark_class_desc5 := ri.corp_trademark_class_desc5;
  SELF.corp_trademark_class_desc5_match_code := MAP(
		le.corp_trademark_class_desc5_isnull OR ri.corp_trademark_class_desc5_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc5(le.corp_trademark_class_desc5,ri.corp_trademark_class_desc5));
  SELF.corp_trademark_class_desc5_score := MAP(
                        le.corp_trademark_class_desc5_isnull OR ri.corp_trademark_class_desc5_isnull => 0,
                        le.corp_trademark_class_desc5 = ri.corp_trademark_class_desc5  => le.corp_trademark_class_desc5_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc5_weight100,s.corp_trademark_class_desc5_switch));
  SELF.left_corp_trademark_class_desc6 := le.corp_trademark_class_desc6;
  SELF.right_corp_trademark_class_desc6 := ri.corp_trademark_class_desc6;
  SELF.corp_trademark_class_desc6_match_code := MAP(
		le.corp_trademark_class_desc6_isnull OR ri.corp_trademark_class_desc6_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_class_desc6(le.corp_trademark_class_desc6,ri.corp_trademark_class_desc6));
  SELF.corp_trademark_class_desc6_score := MAP(
                        le.corp_trademark_class_desc6_isnull OR ri.corp_trademark_class_desc6_isnull => 0,
                        le.corp_trademark_class_desc6 = ri.corp_trademark_class_desc6  => le.corp_trademark_class_desc6_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_class_desc6_weight100,s.corp_trademark_class_desc6_switch));
  SELF.left_corp_trademark_classification_nbr := le.corp_trademark_classification_nbr;
  SELF.right_corp_trademark_classification_nbr := ri.corp_trademark_classification_nbr;
  SELF.corp_trademark_classification_nbr_match_code := MAP(
		le.corp_trademark_classification_nbr_isnull OR ri.corp_trademark_classification_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_classification_nbr(le.corp_trademark_classification_nbr,ri.corp_trademark_classification_nbr));
  SELF.corp_trademark_classification_nbr_score := MAP(
                        le.corp_trademark_classification_nbr_isnull OR ri.corp_trademark_classification_nbr_isnull => 0,
                        le.corp_trademark_classification_nbr = ri.corp_trademark_classification_nbr  => le.corp_trademark_classification_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_classification_nbr_weight100,s.corp_trademark_classification_nbr_switch));
  SELF.left_corp_trademark_disclaimer1 := le.corp_trademark_disclaimer1;
  SELF.right_corp_trademark_disclaimer1 := ri.corp_trademark_disclaimer1;
  SELF.corp_trademark_disclaimer1_match_code := MAP(
		le.corp_trademark_disclaimer1_isnull OR ri.corp_trademark_disclaimer1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_disclaimer1(le.corp_trademark_disclaimer1,ri.corp_trademark_disclaimer1));
  SELF.corp_trademark_disclaimer1_score := MAP(
                        le.corp_trademark_disclaimer1_isnull OR ri.corp_trademark_disclaimer1_isnull => 0,
                        le.corp_trademark_disclaimer1 = ri.corp_trademark_disclaimer1  => le.corp_trademark_disclaimer1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_disclaimer1_weight100,s.corp_trademark_disclaimer1_switch));
  SELF.left_corp_trademark_disclaimer2 := le.corp_trademark_disclaimer2;
  SELF.right_corp_trademark_disclaimer2 := ri.corp_trademark_disclaimer2;
  SELF.corp_trademark_disclaimer2_match_code := MAP(
		le.corp_trademark_disclaimer2_isnull OR ri.corp_trademark_disclaimer2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_disclaimer2(le.corp_trademark_disclaimer2,ri.corp_trademark_disclaimer2));
  SELF.corp_trademark_disclaimer2_score := MAP(
                        le.corp_trademark_disclaimer2_isnull OR ri.corp_trademark_disclaimer2_isnull => 0,
                        le.corp_trademark_disclaimer2 = ri.corp_trademark_disclaimer2  => le.corp_trademark_disclaimer2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_disclaimer2_weight100,s.corp_trademark_disclaimer2_switch));
  SELF.left_corp_trademark_expiration_date := le.corp_trademark_expiration_date;
  SELF.right_corp_trademark_expiration_date := ri.corp_trademark_expiration_date;
  SELF.corp_trademark_expiration_date_match_code := MAP(
		le.corp_trademark_expiration_date_isnull OR ri.corp_trademark_expiration_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_expiration_date(le.corp_trademark_expiration_date,ri.corp_trademark_expiration_date));
  SELF.corp_trademark_expiration_date_score := MAP(
                        le.corp_trademark_expiration_date_isnull OR ri.corp_trademark_expiration_date_isnull => 0,
                        le.corp_trademark_expiration_date = ri.corp_trademark_expiration_date  => le.corp_trademark_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_expiration_date_weight100,s.corp_trademark_expiration_date_switch));
  SELF.left_corp_trademark_filing_date := le.corp_trademark_filing_date;
  SELF.right_corp_trademark_filing_date := ri.corp_trademark_filing_date;
  SELF.corp_trademark_filing_date_match_code := MAP(
		le.corp_trademark_filing_date_isnull OR ri.corp_trademark_filing_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_filing_date(le.corp_trademark_filing_date,ri.corp_trademark_filing_date));
  SELF.corp_trademark_filing_date_score := MAP(
                        le.corp_trademark_filing_date_isnull OR ri.corp_trademark_filing_date_isnull => 0,
                        le.corp_trademark_filing_date = ri.corp_trademark_filing_date  => le.corp_trademark_filing_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_filing_date_weight100,s.corp_trademark_filing_date_switch));
  SELF.left_corp_trademark_first_use_date := le.corp_trademark_first_use_date;
  SELF.right_corp_trademark_first_use_date := ri.corp_trademark_first_use_date;
  SELF.corp_trademark_first_use_date_match_code := MAP(
		le.corp_trademark_first_use_date_isnull OR ri.corp_trademark_first_use_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_first_use_date(le.corp_trademark_first_use_date,ri.corp_trademark_first_use_date));
  SELF.corp_trademark_first_use_date_score := MAP(
                        le.corp_trademark_first_use_date_isnull OR ri.corp_trademark_first_use_date_isnull => 0,
                        le.corp_trademark_first_use_date = ri.corp_trademark_first_use_date  => le.corp_trademark_first_use_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_first_use_date_weight100,s.corp_trademark_first_use_date_switch));
  SELF.left_corp_trademark_first_use_date_in_state := le.corp_trademark_first_use_date_in_state;
  SELF.right_corp_trademark_first_use_date_in_state := ri.corp_trademark_first_use_date_in_state;
  SELF.corp_trademark_first_use_date_in_state_match_code := MAP(
		le.corp_trademark_first_use_date_in_state_isnull OR ri.corp_trademark_first_use_date_in_state_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_first_use_date_in_state(le.corp_trademark_first_use_date_in_state,ri.corp_trademark_first_use_date_in_state));
  SELF.corp_trademark_first_use_date_in_state_score := MAP(
                        le.corp_trademark_first_use_date_in_state_isnull OR ri.corp_trademark_first_use_date_in_state_isnull => 0,
                        le.corp_trademark_first_use_date_in_state = ri.corp_trademark_first_use_date_in_state  => le.corp_trademark_first_use_date_in_state_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_first_use_date_in_state_weight100,s.corp_trademark_first_use_date_in_state_switch));
  SELF.left_corp_trademark_keywords := le.corp_trademark_keywords;
  SELF.right_corp_trademark_keywords := ri.corp_trademark_keywords;
  SELF.corp_trademark_keywords_match_code := MAP(
		le.corp_trademark_keywords_isnull OR ri.corp_trademark_keywords_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_keywords(le.corp_trademark_keywords,ri.corp_trademark_keywords));
  SELF.corp_trademark_keywords_score := MAP(
                        le.corp_trademark_keywords_isnull OR ri.corp_trademark_keywords_isnull => 0,
                        le.corp_trademark_keywords = ri.corp_trademark_keywords  => le.corp_trademark_keywords_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_keywords_weight100,s.corp_trademark_keywords_switch));
  SELF.left_corp_trademark_logo := le.corp_trademark_logo;
  SELF.right_corp_trademark_logo := ri.corp_trademark_logo;
  SELF.corp_trademark_logo_match_code := MAP(
		le.corp_trademark_logo_isnull OR ri.corp_trademark_logo_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_logo(le.corp_trademark_logo,ri.corp_trademark_logo));
  SELF.corp_trademark_logo_score := MAP(
                        le.corp_trademark_logo_isnull OR ri.corp_trademark_logo_isnull => 0,
                        le.corp_trademark_logo = ri.corp_trademark_logo  => le.corp_trademark_logo_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_logo_weight100,s.corp_trademark_logo_switch));
  SELF.left_corp_trademark_name_expiration_date := le.corp_trademark_name_expiration_date;
  SELF.right_corp_trademark_name_expiration_date := ri.corp_trademark_name_expiration_date;
  SELF.corp_trademark_name_expiration_date_match_code := MAP(
		le.corp_trademark_name_expiration_date_isnull OR ri.corp_trademark_name_expiration_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_name_expiration_date(le.corp_trademark_name_expiration_date,ri.corp_trademark_name_expiration_date));
  SELF.corp_trademark_name_expiration_date_score := MAP(
                        le.corp_trademark_name_expiration_date_isnull OR ri.corp_trademark_name_expiration_date_isnull => 0,
                        le.corp_trademark_name_expiration_date = ri.corp_trademark_name_expiration_date  => le.corp_trademark_name_expiration_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_name_expiration_date_weight100,s.corp_trademark_name_expiration_date_switch));
  SELF.left_corp_trademark_nbr := le.corp_trademark_nbr;
  SELF.right_corp_trademark_nbr := ri.corp_trademark_nbr;
  SELF.corp_trademark_nbr_match_code := MAP(
		le.corp_trademark_nbr_isnull OR ri.corp_trademark_nbr_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_nbr(le.corp_trademark_nbr,ri.corp_trademark_nbr));
  SELF.corp_trademark_nbr_score := MAP(
                        le.corp_trademark_nbr_isnull OR ri.corp_trademark_nbr_isnull => 0,
                        le.corp_trademark_nbr = ri.corp_trademark_nbr  => le.corp_trademark_nbr_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_nbr_weight100,s.corp_trademark_nbr_switch));
  SELF.left_corp_trademark_renewal_date := le.corp_trademark_renewal_date;
  SELF.right_corp_trademark_renewal_date := ri.corp_trademark_renewal_date;
  SELF.corp_trademark_renewal_date_match_code := MAP(
		le.corp_trademark_renewal_date_isnull OR ri.corp_trademark_renewal_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_renewal_date(le.corp_trademark_renewal_date,ri.corp_trademark_renewal_date));
  SELF.corp_trademark_renewal_date_score := MAP(
                        le.corp_trademark_renewal_date_isnull OR ri.corp_trademark_renewal_date_isnull => 0,
                        le.corp_trademark_renewal_date = ri.corp_trademark_renewal_date  => le.corp_trademark_renewal_date_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_renewal_date_weight100,s.corp_trademark_renewal_date_switch));
  SELF.left_corp_trademark_status := le.corp_trademark_status;
  SELF.right_corp_trademark_status := ri.corp_trademark_status;
  SELF.corp_trademark_status_match_code := MAP(
		le.corp_trademark_status_isnull OR ri.corp_trademark_status_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_status(le.corp_trademark_status,ri.corp_trademark_status));
  SELF.corp_trademark_status_score := MAP(
                        le.corp_trademark_status_isnull OR ri.corp_trademark_status_isnull => 0,
                        le.corp_trademark_status = ri.corp_trademark_status  => le.corp_trademark_status_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_status_weight100,s.corp_trademark_status_switch));
  SELF.left_corp_trademark_used_1 := le.corp_trademark_used_1;
  SELF.right_corp_trademark_used_1 := ri.corp_trademark_used_1;
  SELF.corp_trademark_used_1_match_code := MAP(
		le.corp_trademark_used_1_isnull OR ri.corp_trademark_used_1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_used_1(le.corp_trademark_used_1,ri.corp_trademark_used_1));
  SELF.corp_trademark_used_1_score := MAP(
                        le.corp_trademark_used_1_isnull OR ri.corp_trademark_used_1_isnull => 0,
                        le.corp_trademark_used_1 = ri.corp_trademark_used_1  => le.corp_trademark_used_1_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_1_weight100,s.corp_trademark_used_1_switch));
  SELF.left_corp_trademark_used_2 := le.corp_trademark_used_2;
  SELF.right_corp_trademark_used_2 := ri.corp_trademark_used_2;
  SELF.corp_trademark_used_2_match_code := MAP(
		le.corp_trademark_used_2_isnull OR ri.corp_trademark_used_2_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_used_2(le.corp_trademark_used_2,ri.corp_trademark_used_2));
  SELF.corp_trademark_used_2_score := MAP(
                        le.corp_trademark_used_2_isnull OR ri.corp_trademark_used_2_isnull => 0,
                        le.corp_trademark_used_2 = ri.corp_trademark_used_2  => le.corp_trademark_used_2_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_2_weight100,s.corp_trademark_used_2_switch));
  SELF.left_corp_trademark_used_3 := le.corp_trademark_used_3;
  SELF.right_corp_trademark_used_3 := ri.corp_trademark_used_3;
  SELF.corp_trademark_used_3_match_code := MAP(
		le.corp_trademark_used_3_isnull OR ri.corp_trademark_used_3_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_corp_trademark_used_3(le.corp_trademark_used_3,ri.corp_trademark_used_3));
  SELF.corp_trademark_used_3_score := MAP(
                        le.corp_trademark_used_3_isnull OR ri.corp_trademark_used_3_isnull => 0,
                        le.corp_trademark_used_3 = ri.corp_trademark_used_3  => le.corp_trademark_used_3_weight100,
                        SALT34.Fn_Fail_Scale(le.corp_trademark_used_3_weight100,s.corp_trademark_used_3_switch));
  SELF.left_cont_owner_percentage := le.cont_owner_percentage;
  SELF.right_cont_owner_percentage := ri.cont_owner_percentage;
  SELF.cont_owner_percentage_match_code := MAP(
		le.cont_owner_percentage_isnull OR ri.cont_owner_percentage_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_owner_percentage(le.cont_owner_percentage,ri.cont_owner_percentage));
  SELF.cont_owner_percentage_score := MAP(
                        le.cont_owner_percentage_isnull OR ri.cont_owner_percentage_isnull => 0,
                        le.cont_owner_percentage = ri.cont_owner_percentage  => le.cont_owner_percentage_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_owner_percentage_weight100,s.cont_owner_percentage_switch));
  SELF.left_cont_country := le.cont_country;
  SELF.right_cont_country := ri.cont_country;
  SELF.cont_country_match_code := MAP(
		le.cont_country_isnull OR ri.cont_country_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_country(le.cont_country,ri.cont_country));
  SELF.cont_country_score := MAP(
                        le.cont_country_isnull OR ri.cont_country_isnull => 0,
                        le.cont_country = ri.cont_country  => le.cont_country_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_country_weight100,s.cont_country_switch));
  SELF.left_cont_country_mailing := le.cont_country_mailing;
  SELF.right_cont_country_mailing := ri.cont_country_mailing;
  SELF.cont_country_mailing_match_code := MAP(
		le.cont_country_mailing_isnull OR ri.cont_country_mailing_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_country_mailing(le.cont_country_mailing,ri.cont_country_mailing));
  SELF.cont_country_mailing_score := MAP(
                        le.cont_country_mailing_isnull OR ri.cont_country_mailing_isnull => 0,
                        le.cont_country_mailing = ri.cont_country_mailing  => le.cont_country_mailing_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_country_mailing_weight100,s.cont_country_mailing_switch));
  SELF.left_cont_nondislosure := le.cont_nondislosure;
  SELF.right_cont_nondislosure := ri.cont_nondislosure;
  SELF.cont_nondislosure_match_code := MAP(
		le.cont_nondislosure_isnull OR ri.cont_nondislosure_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_nondislosure(le.cont_nondislosure,ri.cont_nondislosure));
  SELF.cont_nondislosure_score := MAP(
                        le.cont_nondislosure_isnull OR ri.cont_nondislosure_isnull => 0,
                        le.cont_nondislosure = ri.cont_nondislosure  => le.cont_nondislosure_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_nondislosure_weight100,s.cont_nondislosure_switch));
  SELF.left_cont_prep_addr_line1 := le.cont_prep_addr_line1;
  SELF.right_cont_prep_addr_line1 := ri.cont_prep_addr_line1;
  SELF.cont_prep_addr_line1_match_code := MAP(
		le.cont_prep_addr_line1_isnull OR ri.cont_prep_addr_line1_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_prep_addr_line1(le.cont_prep_addr_line1,ri.cont_prep_addr_line1));
  SELF.cont_prep_addr_line1_score := MAP(
                        le.cont_prep_addr_line1_isnull OR ri.cont_prep_addr_line1_isnull => 0,
                        le.cont_prep_addr_line1 = ri.cont_prep_addr_line1  => le.cont_prep_addr_line1_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_prep_addr_line1_weight100,s.cont_prep_addr_line1_switch));
  SELF.left_cont_prep_addr_last_line := le.cont_prep_addr_last_line;
  SELF.right_cont_prep_addr_last_line := ri.cont_prep_addr_last_line;
  SELF.cont_prep_addr_last_line_match_code := MAP(
		le.cont_prep_addr_last_line_isnull OR ri.cont_prep_addr_last_line_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_cont_prep_addr_last_line(le.cont_prep_addr_last_line,ri.cont_prep_addr_last_line));
  SELF.cont_prep_addr_last_line_score := MAP(
                        le.cont_prep_addr_last_line_isnull OR ri.cont_prep_addr_last_line_isnull => 0,
                        le.cont_prep_addr_last_line = ri.cont_prep_addr_last_line  => le.cont_prep_addr_last_line_weight100,
                        SALT34.Fn_Fail_Scale(le.cont_prep_addr_last_line_weight100,s.cont_prep_addr_last_line_switch));
  SELF.left_recordorigin := le.recordorigin;
  SELF.right_recordorigin := ri.recordorigin;
  SELF.recordorigin_match_code := MAP(
		le.recordorigin_isnull OR ri.recordorigin_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_recordorigin(le.recordorigin,ri.recordorigin));
  SELF.recordorigin_score := MAP(
                        le.recordorigin_isnull OR ri.recordorigin_isnull => 0,
                        le.recordorigin = ri.recordorigin  => le.recordorigin_weight100,
                        SALT34.Fn_Fail_Scale(le.recordorigin_weight100,s.recordorigin_switch));
  SELF.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.dt_vendor_first_reported_score + SELF.dt_vendor_last_reported_score + SELF.dt_first_seen_score + SELF.dt_last_seen_score + SELF.corp_ra_dt_first_seen_score + SELF.corp_ra_dt_last_seen_score + SELF.corp_key_score + SELF.corp_supp_key_score + SELF.corp_vendor_score + SELF.corp_vendor_county_score + SELF.corp_vendor_subcode_score + SELF.corp_state_origin_score + SELF.corp_process_date_score + SELF.corp_orig_sos_charter_nbr_score + SELF.corp_legal_name_score + SELF.corp_ln_name_type_cd_score + SELF.corp_ln_name_type_desc_score + SELF.corp_supp_nbr_score + SELF.corp_name_comment_score + SELF.corp_address1_type_cd_score + SELF.corp_address1_type_desc_score + SELF.corp_address1_line1_score + SELF.corp_address1_line2_score + SELF.corp_address1_line3_score + SELF.corp_address1_effective_date_score + SELF.corp_address2_type_cd_score + SELF.corp_address2_type_desc_score + SELF.corp_address2_line1_score + SELF.corp_address2_line2_score + SELF.corp_address2_line3_score + SELF.corp_address2_effective_date_score + SELF.corp_phone_number_score + SELF.corp_phone_number_type_cd_score + SELF.corp_phone_number_type_desc_score + SELF.corp_fax_nbr_score + SELF.corp_email_address_score + SELF.corp_web_address_score + SELF.corp_filing_reference_nbr_score + SELF.corp_filing_date_score + SELF.corp_filing_cd_score + SELF.corp_filing_desc_score + SELF.corp_status_cd_score + SELF.corp_status_desc_score + SELF.corp_status_date_score + SELF.corp_standing_score + SELF.corp_status_comment_score + SELF.corp_ticker_symbol_score + SELF.corp_stock_exchange_score + SELF.corp_inc_state_score + SELF.corp_inc_county_score + SELF.corp_inc_date_score + SELF.corp_anniversary_month_score + SELF.corp_fed_tax_id_score + SELF.corp_state_tax_id_score + SELF.corp_term_exist_cd_score + SELF.corp_term_exist_exp_score + SELF.corp_term_exist_desc_score + SELF.corp_foreign_domestic_ind_score + SELF.corp_forgn_state_cd_score + SELF.corp_forgn_state_desc_score + SELF.corp_forgn_sos_charter_nbr_score + SELF.corp_forgn_date_score + SELF.corp_forgn_fed_tax_id_score + SELF.corp_forgn_state_tax_id_score + SELF.corp_forgn_term_exist_cd_score + SELF.corp_forgn_term_exist_exp_score + SELF.corp_forgn_term_exist_desc_score + SELF.corp_orig_org_structure_cd_score + SELF.corp_orig_org_structure_desc_score + SELF.corp_for_profit_ind_score + SELF.corp_public_or_private_ind_score + SELF.corp_sic_code_score + SELF.corp_naic_code_score + SELF.corp_orig_bus_type_cd_score + SELF.corp_orig_bus_type_desc_score + SELF.corp_entity_desc_score + SELF.corp_certificate_nbr_score + SELF.corp_internal_nbr_score + SELF.corp_previous_nbr_score + SELF.corp_microfilm_nbr_score + SELF.corp_amendments_filed_score + SELF.corp_acts_score + SELF.corp_partnership_ind_score + SELF.corp_mfg_ind_score + SELF.corp_addl_info_score + SELF.corp_taxes_score + SELF.corp_franchise_taxes_score + SELF.corp_tax_program_cd_score + SELF.corp_tax_program_desc_score + SELF.corp_ra_full_name_score + SELF.corp_ra_fname_score + SELF.corp_ra_mname_score + SELF.corp_ra_lname_score + SELF.corp_ra_suffix_score + SELF.corp_ra_title_cd_score + SELF.corp_ra_title_desc_score + SELF.corp_ra_fein_score + SELF.corp_ra_ssn_score + SELF.corp_ra_dob_score + SELF.corp_ra_effective_date_score + SELF.corp_ra_resign_date_score + SELF.corp_ra_no_comp_score + SELF.corp_ra_no_comp_igs_score + SELF.corp_ra_addl_info_score + SELF.corp_ra_address_type_cd_score + SELF.corp_ra_address_type_desc_score + SELF.corp_ra_address_line1_score + SELF.corp_ra_address_line2_score + SELF.corp_ra_address_line3_score + SELF.corp_ra_phone_number_score + SELF.corp_ra_phone_number_type_cd_score + SELF.corp_ra_phone_number_type_desc_score + SELF.corp_ra_fax_nbr_score + SELF.corp_ra_email_address_score + SELF.corp_ra_web_address_score + SELF.corp_prep_addr1_line1_score + SELF.corp_prep_addr1_last_line_score + SELF.corp_prep_addr2_line1_score + SELF.corp_prep_addr2_last_line_score + SELF.ra_prep_addr_line1_score + SELF.ra_prep_addr_last_line_score + SELF.cont_filing_reference_nbr_score + SELF.cont_filing_date_score + SELF.cont_filing_cd_score + SELF.cont_filing_desc_score + SELF.cont_type_cd_score + SELF.cont_type_desc_score + SELF.cont_full_name_score + SELF.cont_fname_score + SELF.cont_mname_score + SELF.cont_lname_score + SELF.cont_suffix_score + SELF.cont_title1_desc_score + SELF.cont_title2_desc_score + SELF.cont_title3_desc_score + SELF.cont_title4_desc_score + SELF.cont_title5_desc_score + SELF.cont_fein_score + SELF.cont_ssn_score + SELF.cont_dob_score + SELF.cont_status_cd_score + SELF.cont_status_desc_score + SELF.cont_effective_date_score + SELF.cont_effective_cd_score + SELF.cont_effective_desc_score + SELF.cont_addl_info_score + SELF.cont_address_type_cd_score + SELF.cont_address_type_desc_score + SELF.cont_address_line1_score + SELF.cont_address_line2_score + SELF.cont_address_line3_score + SELF.cont_address_effective_date_score + SELF.cont_address_county_score + SELF.cont_phone_number_score + SELF.cont_phone_number_type_cd_score + SELF.cont_phone_number_type_desc_score + SELF.cont_fax_nbr_score + SELF.cont_email_address_score + SELF.cont_web_address_score + SELF.corp_acres_score + SELF.corp_action_score + SELF.corp_action_date_score + SELF.corp_action_employment_security_approval_date_score + SELF.corp_action_pending_cd_score + SELF.corp_action_pending_desc_score + SELF.corp_action_statement_of_intent_date_score + SELF.corp_action_tax_dept_approval_date_score + SELF.corp_acts2_score + SELF.corp_acts3_score + SELF.corp_additional_principals_score + SELF.corp_address_office_type_score + SELF.corp_agent_assign_date_score + SELF.corp_agent_commercial_score + SELF.corp_agent_country_score + SELF.corp_agent_county_score + SELF.corp_agent_status_cd_score + SELF.corp_agent_status_desc_score + SELF.corp_agent_id_score + SELF.corp_agriculture_flag_score + SELF.corp_authorized_partners_score + SELF.corp_comment_score + SELF.corp_consent_flag_for_protected_name_score + SELF.corp_converted_score + SELF.corp_converted_from_score + SELF.corp_country_of_formation_score + SELF.corp_date_of_organization_meeting_score + SELF.corp_delayed_effective_date_score + SELF.corp_directors_from_to_score + SELF.corp_dissolved_date_score + SELF.corp_farm_exemptions_score + SELF.corp_farm_qual_date_score + SELF.corp_farm_status_cd_score + SELF.corp_farm_status_desc_score + SELF.corp_fiscal_year_month_score + SELF.corp_foreign_fiduciary_capacity_in_state_score + SELF.corp_governing_statute_score + SELF.corp_has_members_score + SELF.corp_has_vested_managers_score + SELF.corp_home_incorporated_county_score + SELF.corp_home_state_name_score + SELF.corp_is_professional_score + SELF.corp_is_non_profit_irs_approved_score + SELF.corp_last_renewal_date_score + SELF.corp_last_renewal_year_score + SELF.corp_license_type_score + SELF.corp_llc_managed_desc_score + SELF.corp_llc_managed_ind_score + SELF.corp_management_desc_score + SELF.corp_management_type_score + SELF.corp_manager_managed_score + SELF.corp_merged_corporation_id_score + SELF.corp_merged_fein_score + SELF.corp_merger_allowed_flag_score + SELF.corp_merger_date_score + SELF.corp_merger_desc_score + SELF.corp_merger_effective_date_score + SELF.corp_merger_id_score + SELF.corp_merger_indicator_score + SELF.corp_merger_name_score + SELF.corp_merger_type_converted_to_cd_score + SELF.corp_merger_type_converted_to_desc_score + SELF.corp_naics_desc_score + SELF.corp_name_effective_date_score + SELF.corp_name_reservation_date_score + SELF.corp_name_reservation_desc_score + SELF.corp_name_reservation_expiration_date_score + SELF.corp_name_reservation_nbr_score + SELF.corp_name_reservation_type_score + SELF.corp_name_status_cd_score + SELF.corp_name_status_date_score + SELF.corp_name_status_desc_score + SELF.corp_non_profit_irs_approved_purpose_score + SELF.corp_non_profit_solicit_donations_score + SELF.corp_nbr_of_amendments_score + SELF.corp_nbr_of_initial_llc_members_score + SELF.corp_nbr_of_partners_score + SELF.corp_operating_agreement_score + SELF.corp_opt_in_llc_act_desc_score + SELF.corp_opt_in_llc_act_ind_score + SELF.corp_organizational_comments_score + SELF.corp_partner_contributions_total_score + SELF.corp_partner_terms_score + SELF.corp_percentage_voters_required_to_approve_amendments_score + SELF.corp_profession_score + SELF.corp_province_score + SELF.corp_public_mutual_corporation_score + SELF.corp_purpose_score + SELF.corp_ra_required_flag_score + SELF.corp_registered_counties_score + SELF.corp_regulated_ind_score + SELF.corp_renewal_date_score + SELF.corp_standing_other_score + SELF.corp_survivor_corporation_id_score + SELF.corp_tax_base_score + SELF.corp_tax_standing_score + SELF.corp_termination_cd_score + SELF.corp_termination_desc_score + SELF.corp_termination_date_score + SELF.corp_trademark_business_mark_type_score + SELF.corp_trademark_cancelled_date_score + SELF.corp_trademark_class_desc1_score + SELF.corp_trademark_class_desc2_score + SELF.corp_trademark_class_desc3_score + SELF.corp_trademark_class_desc4_score + SELF.corp_trademark_class_desc5_score + SELF.corp_trademark_class_desc6_score + SELF.corp_trademark_classification_nbr_score + SELF.corp_trademark_disclaimer1_score + SELF.corp_trademark_disclaimer2_score + SELF.corp_trademark_expiration_date_score + SELF.corp_trademark_filing_date_score + SELF.corp_trademark_first_use_date_score + SELF.corp_trademark_first_use_date_in_state_score + SELF.corp_trademark_keywords_score + SELF.corp_trademark_logo_score + SELF.corp_trademark_name_expiration_date_score + SELF.corp_trademark_nbr_score + SELF.corp_trademark_renewal_date_score + SELF.corp_trademark_status_score + SELF.corp_trademark_used_1_score + SELF.corp_trademark_used_2_score + SELF.corp_trademark_used_3_score + SELF.cont_owner_percentage_score + SELF.cont_country_score + SELF.cont_country_mailing_score + SELF.cont_nondislosure_score + SELF.cont_prep_addr_line1_score + SELF.cont_prep_addr_last_line_score + SELF.recordorigin_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT. = RIGHT.1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.2 = RIGHT.,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, 1, 2, -Conf, LOCAL ), 1, 2, LOCAL ); // 2 distributed by join
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when  known
  j1 := JOIN(in_data,im,LEFT. = RIGHT.1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.2 = RIGHT.,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT34.UIDType BaseRecord) := FUNCTION//Faster form when  known
  j1 := in_data( = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.1=RIGHT.1 AND LEFT.2=RIGHT.2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT34.UIDType ;
  DATASET(SALT34.Layout_FieldValueList) dt_vendor_first_reported_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) dt_vendor_last_reported_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_dt_first_seen_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_dt_last_seen_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_key_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_supp_key_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_vendor_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_vendor_county_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_vendor_subcode_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_state_origin_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_process_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_orig_sos_charter_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_legal_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ln_name_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ln_name_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_supp_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_comment_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_line2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_line3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address1_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_line2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_line3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address2_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_phone_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_phone_number_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_phone_number_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_fax_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_email_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_web_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_filing_reference_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_filing_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_filing_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_filing_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_status_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_status_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_status_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_standing_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_status_comment_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ticker_symbol_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_stock_exchange_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_inc_state_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_inc_county_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_inc_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_anniversary_month_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_fed_tax_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_state_tax_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_term_exist_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_term_exist_exp_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_term_exist_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_foreign_domestic_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_state_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_state_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_sos_charter_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_fed_tax_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_state_tax_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_term_exist_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_term_exist_exp_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_forgn_term_exist_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_orig_org_structure_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_orig_org_structure_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_for_profit_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_public_or_private_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_sic_code_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_naic_code_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_orig_bus_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_orig_bus_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_entity_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_certificate_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_internal_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_previous_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_microfilm_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_amendments_filed_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_acts_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_partnership_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_mfg_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_addl_info_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_taxes_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_franchise_taxes_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_tax_program_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_tax_program_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_full_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_fname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_mname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_lname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_suffix_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_title_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_title_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_fein_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_ssn_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_dob_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_resign_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_no_comp_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_no_comp_igs_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_addl_info_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_address_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_address_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_address_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_address_line2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_address_line3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_phone_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_phone_number_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_phone_number_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_fax_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_email_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_web_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_prep_addr1_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_prep_addr1_last_line_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_prep_addr2_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_prep_addr2_last_line_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) ra_prep_addr_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) ra_prep_addr_last_line_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_filing_reference_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_filing_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_filing_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_filing_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_full_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_fname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_mname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_lname_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_suffix_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_title1_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_title2_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_title3_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_title4_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_title5_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_fein_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_ssn_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_dob_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_status_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_status_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_effective_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_effective_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_addl_info_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_line2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_line3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_address_county_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_phone_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_phone_number_type_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_phone_number_type_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_fax_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_email_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_web_address_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_acres_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_employment_security_approval_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_pending_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_pending_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_statement_of_intent_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_action_tax_dept_approval_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_acts2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_acts3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_additional_principals_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_address_office_type_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_assign_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_commercial_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_country_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_county_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_status_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_status_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agent_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_agriculture_flag_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_authorized_partners_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_comment_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_consent_flag_for_protected_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_converted_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_converted_from_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_country_of_formation_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_date_of_organization_meeting_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_delayed_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_directors_from_to_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_dissolved_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_farm_exemptions_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_farm_qual_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_farm_status_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_farm_status_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_fiscal_year_month_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_foreign_fiduciary_capacity_in_state_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_governing_statute_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_has_members_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_has_vested_managers_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_home_incorporated_county_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_home_state_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_is_professional_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_is_non_profit_irs_approved_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_last_renewal_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_last_renewal_year_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_license_type_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_llc_managed_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_llc_managed_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_management_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_management_type_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_manager_managed_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merged_corporation_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merged_fein_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_allowed_flag_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_indicator_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_type_converted_to_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_merger_type_converted_to_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_naics_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_effective_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_reservation_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_reservation_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_reservation_expiration_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_reservation_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_reservation_type_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_status_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_status_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_name_status_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_non_profit_irs_approved_purpose_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_non_profit_solicit_donations_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_nbr_of_amendments_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_nbr_of_initial_llc_members_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_nbr_of_partners_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_operating_agreement_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_opt_in_llc_act_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_opt_in_llc_act_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_organizational_comments_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_partner_contributions_total_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_partner_terms_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_percentage_voters_required_to_approve_amendments_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_profession_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_province_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_public_mutual_corporation_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_purpose_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_ra_required_flag_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_registered_counties_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_regulated_ind_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_renewal_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_standing_other_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_survivor_corporation_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_tax_base_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_tax_standing_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_termination_cd_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_termination_desc_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_termination_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_business_mark_type_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_cancelled_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc4_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc5_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_class_desc6_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_classification_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_disclaimer1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_disclaimer2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_expiration_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_filing_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_first_use_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_first_use_date_in_state_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_keywords_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_logo_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_name_expiration_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_nbr_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_renewal_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_status_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_used_1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_used_2_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) corp_trademark_used_3_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_owner_percentage_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_country_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_country_mailing_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_nondislosure_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_prep_addr_line1_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) cont_prep_addr_last_line_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) recordorigin_Values := DATASET([],SALT34.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF. := le.;
    SELF.dt_vendor_first_reported_values := SALT34.fn_combine_fieldvaluelist(le.dt_vendor_first_reported_values,ri.dt_vendor_first_reported_values);
    SELF.dt_vendor_last_reported_values := SALT34.fn_combine_fieldvaluelist(le.dt_vendor_last_reported_values,ri.dt_vendor_last_reported_values);
    SELF.dt_first_seen_values := SALT34.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT34.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
    SELF.corp_ra_dt_first_seen_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_dt_first_seen_values,ri.corp_ra_dt_first_seen_values);
    SELF.corp_ra_dt_last_seen_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_dt_last_seen_values,ri.corp_ra_dt_last_seen_values);
    SELF.corp_key_values := SALT34.fn_combine_fieldvaluelist(le.corp_key_values,ri.corp_key_values);
    SELF.corp_supp_key_values := SALT34.fn_combine_fieldvaluelist(le.corp_supp_key_values,ri.corp_supp_key_values);
    SELF.corp_vendor_values := SALT34.fn_combine_fieldvaluelist(le.corp_vendor_values,ri.corp_vendor_values);
    SELF.corp_vendor_county_values := SALT34.fn_combine_fieldvaluelist(le.corp_vendor_county_values,ri.corp_vendor_county_values);
    SELF.corp_vendor_subcode_values := SALT34.fn_combine_fieldvaluelist(le.corp_vendor_subcode_values,ri.corp_vendor_subcode_values);
    SELF.corp_state_origin_values := SALT34.fn_combine_fieldvaluelist(le.corp_state_origin_values,ri.corp_state_origin_values);
    SELF.corp_process_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_process_date_values,ri.corp_process_date_values);
    SELF.corp_orig_sos_charter_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_orig_sos_charter_nbr_values,ri.corp_orig_sos_charter_nbr_values);
    SELF.corp_legal_name_values := SALT34.fn_combine_fieldvaluelist(le.corp_legal_name_values,ri.corp_legal_name_values);
    SELF.corp_ln_name_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_ln_name_type_cd_values,ri.corp_ln_name_type_cd_values);
    SELF.corp_ln_name_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_ln_name_type_desc_values,ri.corp_ln_name_type_desc_values);
    SELF.corp_supp_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_supp_nbr_values,ri.corp_supp_nbr_values);
    SELF.corp_name_comment_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_comment_values,ri.corp_name_comment_values);
    SELF.corp_address1_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_type_cd_values,ri.corp_address1_type_cd_values);
    SELF.corp_address1_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_type_desc_values,ri.corp_address1_type_desc_values);
    SELF.corp_address1_line1_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_line1_values,ri.corp_address1_line1_values);
    SELF.corp_address1_line2_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_line2_values,ri.corp_address1_line2_values);
    SELF.corp_address1_line3_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_line3_values,ri.corp_address1_line3_values);
    SELF.corp_address1_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_address1_effective_date_values,ri.corp_address1_effective_date_values);
    SELF.corp_address2_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_type_cd_values,ri.corp_address2_type_cd_values);
    SELF.corp_address2_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_type_desc_values,ri.corp_address2_type_desc_values);
    SELF.corp_address2_line1_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_line1_values,ri.corp_address2_line1_values);
    SELF.corp_address2_line2_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_line2_values,ri.corp_address2_line2_values);
    SELF.corp_address2_line3_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_line3_values,ri.corp_address2_line3_values);
    SELF.corp_address2_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_address2_effective_date_values,ri.corp_address2_effective_date_values);
    SELF.corp_phone_number_values := SALT34.fn_combine_fieldvaluelist(le.corp_phone_number_values,ri.corp_phone_number_values);
    SELF.corp_phone_number_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_phone_number_type_cd_values,ri.corp_phone_number_type_cd_values);
    SELF.corp_phone_number_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_phone_number_type_desc_values,ri.corp_phone_number_type_desc_values);
    SELF.corp_fax_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_fax_nbr_values,ri.corp_fax_nbr_values);
    SELF.corp_email_address_values := SALT34.fn_combine_fieldvaluelist(le.corp_email_address_values,ri.corp_email_address_values);
    SELF.corp_web_address_values := SALT34.fn_combine_fieldvaluelist(le.corp_web_address_values,ri.corp_web_address_values);
    SELF.corp_filing_reference_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_filing_reference_nbr_values,ri.corp_filing_reference_nbr_values);
    SELF.corp_filing_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_filing_date_values,ri.corp_filing_date_values);
    SELF.corp_filing_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_filing_cd_values,ri.corp_filing_cd_values);
    SELF.corp_filing_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_filing_desc_values,ri.corp_filing_desc_values);
    SELF.corp_status_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_status_cd_values,ri.corp_status_cd_values);
    SELF.corp_status_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_status_desc_values,ri.corp_status_desc_values);
    SELF.corp_status_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_status_date_values,ri.corp_status_date_values);
    SELF.corp_standing_values := SALT34.fn_combine_fieldvaluelist(le.corp_standing_values,ri.corp_standing_values);
    SELF.corp_status_comment_values := SALT34.fn_combine_fieldvaluelist(le.corp_status_comment_values,ri.corp_status_comment_values);
    SELF.corp_ticker_symbol_values := SALT34.fn_combine_fieldvaluelist(le.corp_ticker_symbol_values,ri.corp_ticker_symbol_values);
    SELF.corp_stock_exchange_values := SALT34.fn_combine_fieldvaluelist(le.corp_stock_exchange_values,ri.corp_stock_exchange_values);
    SELF.corp_inc_state_values := SALT34.fn_combine_fieldvaluelist(le.corp_inc_state_values,ri.corp_inc_state_values);
    SELF.corp_inc_county_values := SALT34.fn_combine_fieldvaluelist(le.corp_inc_county_values,ri.corp_inc_county_values);
    SELF.corp_inc_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_inc_date_values,ri.corp_inc_date_values);
    SELF.corp_anniversary_month_values := SALT34.fn_combine_fieldvaluelist(le.corp_anniversary_month_values,ri.corp_anniversary_month_values);
    SELF.corp_fed_tax_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_fed_tax_id_values,ri.corp_fed_tax_id_values);
    SELF.corp_state_tax_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_state_tax_id_values,ri.corp_state_tax_id_values);
    SELF.corp_term_exist_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_term_exist_cd_values,ri.corp_term_exist_cd_values);
    SELF.corp_term_exist_exp_values := SALT34.fn_combine_fieldvaluelist(le.corp_term_exist_exp_values,ri.corp_term_exist_exp_values);
    SELF.corp_term_exist_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_term_exist_desc_values,ri.corp_term_exist_desc_values);
    SELF.corp_foreign_domestic_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_foreign_domestic_ind_values,ri.corp_foreign_domestic_ind_values);
    SELF.corp_forgn_state_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_state_cd_values,ri.corp_forgn_state_cd_values);
    SELF.corp_forgn_state_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_state_desc_values,ri.corp_forgn_state_desc_values);
    SELF.corp_forgn_sos_charter_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_sos_charter_nbr_values,ri.corp_forgn_sos_charter_nbr_values);
    SELF.corp_forgn_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_date_values,ri.corp_forgn_date_values);
    SELF.corp_forgn_fed_tax_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_fed_tax_id_values,ri.corp_forgn_fed_tax_id_values);
    SELF.corp_forgn_state_tax_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_state_tax_id_values,ri.corp_forgn_state_tax_id_values);
    SELF.corp_forgn_term_exist_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_term_exist_cd_values,ri.corp_forgn_term_exist_cd_values);
    SELF.corp_forgn_term_exist_exp_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_term_exist_exp_values,ri.corp_forgn_term_exist_exp_values);
    SELF.corp_forgn_term_exist_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_forgn_term_exist_desc_values,ri.corp_forgn_term_exist_desc_values);
    SELF.corp_orig_org_structure_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_orig_org_structure_cd_values,ri.corp_orig_org_structure_cd_values);
    SELF.corp_orig_org_structure_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_orig_org_structure_desc_values,ri.corp_orig_org_structure_desc_values);
    SELF.corp_for_profit_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_for_profit_ind_values,ri.corp_for_profit_ind_values);
    SELF.corp_public_or_private_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_public_or_private_ind_values,ri.corp_public_or_private_ind_values);
    SELF.corp_sic_code_values := SALT34.fn_combine_fieldvaluelist(le.corp_sic_code_values,ri.corp_sic_code_values);
    SELF.corp_naic_code_values := SALT34.fn_combine_fieldvaluelist(le.corp_naic_code_values,ri.corp_naic_code_values);
    SELF.corp_orig_bus_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_orig_bus_type_cd_values,ri.corp_orig_bus_type_cd_values);
    SELF.corp_orig_bus_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_orig_bus_type_desc_values,ri.corp_orig_bus_type_desc_values);
    SELF.corp_entity_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_entity_desc_values,ri.corp_entity_desc_values);
    SELF.corp_certificate_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_certificate_nbr_values,ri.corp_certificate_nbr_values);
    SELF.corp_internal_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_internal_nbr_values,ri.corp_internal_nbr_values);
    SELF.corp_previous_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_previous_nbr_values,ri.corp_previous_nbr_values);
    SELF.corp_microfilm_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_microfilm_nbr_values,ri.corp_microfilm_nbr_values);
    SELF.corp_amendments_filed_values := SALT34.fn_combine_fieldvaluelist(le.corp_amendments_filed_values,ri.corp_amendments_filed_values);
    SELF.corp_acts_values := SALT34.fn_combine_fieldvaluelist(le.corp_acts_values,ri.corp_acts_values);
    SELF.corp_partnership_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_partnership_ind_values,ri.corp_partnership_ind_values);
    SELF.corp_mfg_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_mfg_ind_values,ri.corp_mfg_ind_values);
    SELF.corp_addl_info_values := SALT34.fn_combine_fieldvaluelist(le.corp_addl_info_values,ri.corp_addl_info_values);
    SELF.corp_taxes_values := SALT34.fn_combine_fieldvaluelist(le.corp_taxes_values,ri.corp_taxes_values);
    SELF.corp_franchise_taxes_values := SALT34.fn_combine_fieldvaluelist(le.corp_franchise_taxes_values,ri.corp_franchise_taxes_values);
    SELF.corp_tax_program_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_tax_program_cd_values,ri.corp_tax_program_cd_values);
    SELF.corp_tax_program_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_tax_program_desc_values,ri.corp_tax_program_desc_values);
    SELF.corp_ra_full_name_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_full_name_values,ri.corp_ra_full_name_values);
    SELF.corp_ra_fname_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_fname_values,ri.corp_ra_fname_values);
    SELF.corp_ra_mname_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_mname_values,ri.corp_ra_mname_values);
    SELF.corp_ra_lname_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_lname_values,ri.corp_ra_lname_values);
    SELF.corp_ra_suffix_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_suffix_values,ri.corp_ra_suffix_values);
    SELF.corp_ra_title_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_title_cd_values,ri.corp_ra_title_cd_values);
    SELF.corp_ra_title_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_title_desc_values,ri.corp_ra_title_desc_values);
    SELF.corp_ra_fein_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_fein_values,ri.corp_ra_fein_values);
    SELF.corp_ra_ssn_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_ssn_values,ri.corp_ra_ssn_values);
    SELF.corp_ra_dob_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_dob_values,ri.corp_ra_dob_values);
    SELF.corp_ra_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_effective_date_values,ri.corp_ra_effective_date_values);
    SELF.corp_ra_resign_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_resign_date_values,ri.corp_ra_resign_date_values);
    SELF.corp_ra_no_comp_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_no_comp_values,ri.corp_ra_no_comp_values);
    SELF.corp_ra_no_comp_igs_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_no_comp_igs_values,ri.corp_ra_no_comp_igs_values);
    SELF.corp_ra_addl_info_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_addl_info_values,ri.corp_ra_addl_info_values);
    SELF.corp_ra_address_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_address_type_cd_values,ri.corp_ra_address_type_cd_values);
    SELF.corp_ra_address_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_address_type_desc_values,ri.corp_ra_address_type_desc_values);
    SELF.corp_ra_address_line1_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_address_line1_values,ri.corp_ra_address_line1_values);
    SELF.corp_ra_address_line2_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_address_line2_values,ri.corp_ra_address_line2_values);
    SELF.corp_ra_address_line3_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_address_line3_values,ri.corp_ra_address_line3_values);
    SELF.corp_ra_phone_number_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_phone_number_values,ri.corp_ra_phone_number_values);
    SELF.corp_ra_phone_number_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_phone_number_type_cd_values,ri.corp_ra_phone_number_type_cd_values);
    SELF.corp_ra_phone_number_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_phone_number_type_desc_values,ri.corp_ra_phone_number_type_desc_values);
    SELF.corp_ra_fax_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_fax_nbr_values,ri.corp_ra_fax_nbr_values);
    SELF.corp_ra_email_address_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_email_address_values,ri.corp_ra_email_address_values);
    SELF.corp_ra_web_address_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_web_address_values,ri.corp_ra_web_address_values);
    SELF.corp_prep_addr1_line1_values := SALT34.fn_combine_fieldvaluelist(le.corp_prep_addr1_line1_values,ri.corp_prep_addr1_line1_values);
    SELF.corp_prep_addr1_last_line_values := SALT34.fn_combine_fieldvaluelist(le.corp_prep_addr1_last_line_values,ri.corp_prep_addr1_last_line_values);
    SELF.corp_prep_addr2_line1_values := SALT34.fn_combine_fieldvaluelist(le.corp_prep_addr2_line1_values,ri.corp_prep_addr2_line1_values);
    SELF.corp_prep_addr2_last_line_values := SALT34.fn_combine_fieldvaluelist(le.corp_prep_addr2_last_line_values,ri.corp_prep_addr2_last_line_values);
    SELF.ra_prep_addr_line1_values := SALT34.fn_combine_fieldvaluelist(le.ra_prep_addr_line1_values,ri.ra_prep_addr_line1_values);
    SELF.ra_prep_addr_last_line_values := SALT34.fn_combine_fieldvaluelist(le.ra_prep_addr_last_line_values,ri.ra_prep_addr_last_line_values);
    SELF.cont_filing_reference_nbr_values := SALT34.fn_combine_fieldvaluelist(le.cont_filing_reference_nbr_values,ri.cont_filing_reference_nbr_values);
    SELF.cont_filing_date_values := SALT34.fn_combine_fieldvaluelist(le.cont_filing_date_values,ri.cont_filing_date_values);
    SELF.cont_filing_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_filing_cd_values,ri.cont_filing_cd_values);
    SELF.cont_filing_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_filing_desc_values,ri.cont_filing_desc_values);
    SELF.cont_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_type_cd_values,ri.cont_type_cd_values);
    SELF.cont_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_type_desc_values,ri.cont_type_desc_values);
    SELF.cont_full_name_values := SALT34.fn_combine_fieldvaluelist(le.cont_full_name_values,ri.cont_full_name_values);
    SELF.cont_fname_values := SALT34.fn_combine_fieldvaluelist(le.cont_fname_values,ri.cont_fname_values);
    SELF.cont_mname_values := SALT34.fn_combine_fieldvaluelist(le.cont_mname_values,ri.cont_mname_values);
    SELF.cont_lname_values := SALT34.fn_combine_fieldvaluelist(le.cont_lname_values,ri.cont_lname_values);
    SELF.cont_suffix_values := SALT34.fn_combine_fieldvaluelist(le.cont_suffix_values,ri.cont_suffix_values);
    SELF.cont_title1_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_title1_desc_values,ri.cont_title1_desc_values);
    SELF.cont_title2_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_title2_desc_values,ri.cont_title2_desc_values);
    SELF.cont_title3_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_title3_desc_values,ri.cont_title3_desc_values);
    SELF.cont_title4_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_title4_desc_values,ri.cont_title4_desc_values);
    SELF.cont_title5_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_title5_desc_values,ri.cont_title5_desc_values);
    SELF.cont_fein_values := SALT34.fn_combine_fieldvaluelist(le.cont_fein_values,ri.cont_fein_values);
    SELF.cont_ssn_values := SALT34.fn_combine_fieldvaluelist(le.cont_ssn_values,ri.cont_ssn_values);
    SELF.cont_dob_values := SALT34.fn_combine_fieldvaluelist(le.cont_dob_values,ri.cont_dob_values);
    SELF.cont_status_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_status_cd_values,ri.cont_status_cd_values);
    SELF.cont_status_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_status_desc_values,ri.cont_status_desc_values);
    SELF.cont_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.cont_effective_date_values,ri.cont_effective_date_values);
    SELF.cont_effective_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_effective_cd_values,ri.cont_effective_cd_values);
    SELF.cont_effective_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_effective_desc_values,ri.cont_effective_desc_values);
    SELF.cont_addl_info_values := SALT34.fn_combine_fieldvaluelist(le.cont_addl_info_values,ri.cont_addl_info_values);
    SELF.cont_address_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_type_cd_values,ri.cont_address_type_cd_values);
    SELF.cont_address_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_type_desc_values,ri.cont_address_type_desc_values);
    SELF.cont_address_line1_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_line1_values,ri.cont_address_line1_values);
    SELF.cont_address_line2_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_line2_values,ri.cont_address_line2_values);
    SELF.cont_address_line3_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_line3_values,ri.cont_address_line3_values);
    SELF.cont_address_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_effective_date_values,ri.cont_address_effective_date_values);
    SELF.cont_address_county_values := SALT34.fn_combine_fieldvaluelist(le.cont_address_county_values,ri.cont_address_county_values);
    SELF.cont_phone_number_values := SALT34.fn_combine_fieldvaluelist(le.cont_phone_number_values,ri.cont_phone_number_values);
    SELF.cont_phone_number_type_cd_values := SALT34.fn_combine_fieldvaluelist(le.cont_phone_number_type_cd_values,ri.cont_phone_number_type_cd_values);
    SELF.cont_phone_number_type_desc_values := SALT34.fn_combine_fieldvaluelist(le.cont_phone_number_type_desc_values,ri.cont_phone_number_type_desc_values);
    SELF.cont_fax_nbr_values := SALT34.fn_combine_fieldvaluelist(le.cont_fax_nbr_values,ri.cont_fax_nbr_values);
    SELF.cont_email_address_values := SALT34.fn_combine_fieldvaluelist(le.cont_email_address_values,ri.cont_email_address_values);
    SELF.cont_web_address_values := SALT34.fn_combine_fieldvaluelist(le.cont_web_address_values,ri.cont_web_address_values);
    SELF.corp_acres_values := SALT34.fn_combine_fieldvaluelist(le.corp_acres_values,ri.corp_acres_values);
    SELF.corp_action_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_values,ri.corp_action_values);
    SELF.corp_action_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_date_values,ri.corp_action_date_values);
    SELF.corp_action_employment_security_approval_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_employment_security_approval_date_values,ri.corp_action_employment_security_approval_date_values);
    SELF.corp_action_pending_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_pending_cd_values,ri.corp_action_pending_cd_values);
    SELF.corp_action_pending_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_pending_desc_values,ri.corp_action_pending_desc_values);
    SELF.corp_action_statement_of_intent_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_statement_of_intent_date_values,ri.corp_action_statement_of_intent_date_values);
    SELF.corp_action_tax_dept_approval_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_action_tax_dept_approval_date_values,ri.corp_action_tax_dept_approval_date_values);
    SELF.corp_acts2_values := SALT34.fn_combine_fieldvaluelist(le.corp_acts2_values,ri.corp_acts2_values);
    SELF.corp_acts3_values := SALT34.fn_combine_fieldvaluelist(le.corp_acts3_values,ri.corp_acts3_values);
    SELF.corp_additional_principals_values := SALT34.fn_combine_fieldvaluelist(le.corp_additional_principals_values,ri.corp_additional_principals_values);
    SELF.corp_address_office_type_values := SALT34.fn_combine_fieldvaluelist(le.corp_address_office_type_values,ri.corp_address_office_type_values);
    SELF.corp_agent_assign_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_assign_date_values,ri.corp_agent_assign_date_values);
    SELF.corp_agent_commercial_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_commercial_values,ri.corp_agent_commercial_values);
    SELF.corp_agent_country_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_country_values,ri.corp_agent_country_values);
    SELF.corp_agent_county_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_county_values,ri.corp_agent_county_values);
    SELF.corp_agent_status_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_status_cd_values,ri.corp_agent_status_cd_values);
    SELF.corp_agent_status_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_status_desc_values,ri.corp_agent_status_desc_values);
    SELF.corp_agent_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_agent_id_values,ri.corp_agent_id_values);
    SELF.corp_agriculture_flag_values := SALT34.fn_combine_fieldvaluelist(le.corp_agriculture_flag_values,ri.corp_agriculture_flag_values);
    SELF.corp_authorized_partners_values := SALT34.fn_combine_fieldvaluelist(le.corp_authorized_partners_values,ri.corp_authorized_partners_values);
    SELF.corp_comment_values := SALT34.fn_combine_fieldvaluelist(le.corp_comment_values,ri.corp_comment_values);
    SELF.corp_consent_flag_for_protected_name_values := SALT34.fn_combine_fieldvaluelist(le.corp_consent_flag_for_protected_name_values,ri.corp_consent_flag_for_protected_name_values);
    SELF.corp_converted_values := SALT34.fn_combine_fieldvaluelist(le.corp_converted_values,ri.corp_converted_values);
    SELF.corp_converted_from_values := SALT34.fn_combine_fieldvaluelist(le.corp_converted_from_values,ri.corp_converted_from_values);
    SELF.corp_country_of_formation_values := SALT34.fn_combine_fieldvaluelist(le.corp_country_of_formation_values,ri.corp_country_of_formation_values);
    SELF.corp_date_of_organization_meeting_values := SALT34.fn_combine_fieldvaluelist(le.corp_date_of_organization_meeting_values,ri.corp_date_of_organization_meeting_values);
    SELF.corp_delayed_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_delayed_effective_date_values,ri.corp_delayed_effective_date_values);
    SELF.corp_directors_from_to_values := SALT34.fn_combine_fieldvaluelist(le.corp_directors_from_to_values,ri.corp_directors_from_to_values);
    SELF.corp_dissolved_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_dissolved_date_values,ri.corp_dissolved_date_values);
    SELF.corp_farm_exemptions_values := SALT34.fn_combine_fieldvaluelist(le.corp_farm_exemptions_values,ri.corp_farm_exemptions_values);
    SELF.corp_farm_qual_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_farm_qual_date_values,ri.corp_farm_qual_date_values);
    SELF.corp_farm_status_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_farm_status_cd_values,ri.corp_farm_status_cd_values);
    SELF.corp_farm_status_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_farm_status_desc_values,ri.corp_farm_status_desc_values);
    SELF.corp_fiscal_year_month_values := SALT34.fn_combine_fieldvaluelist(le.corp_fiscal_year_month_values,ri.corp_fiscal_year_month_values);
    SELF.corp_foreign_fiduciary_capacity_in_state_values := SALT34.fn_combine_fieldvaluelist(le.corp_foreign_fiduciary_capacity_in_state_values,ri.corp_foreign_fiduciary_capacity_in_state_values);
    SELF.corp_governing_statute_values := SALT34.fn_combine_fieldvaluelist(le.corp_governing_statute_values,ri.corp_governing_statute_values);
    SELF.corp_has_members_values := SALT34.fn_combine_fieldvaluelist(le.corp_has_members_values,ri.corp_has_members_values);
    SELF.corp_has_vested_managers_values := SALT34.fn_combine_fieldvaluelist(le.corp_has_vested_managers_values,ri.corp_has_vested_managers_values);
    SELF.corp_home_incorporated_county_values := SALT34.fn_combine_fieldvaluelist(le.corp_home_incorporated_county_values,ri.corp_home_incorporated_county_values);
    SELF.corp_home_state_name_values := SALT34.fn_combine_fieldvaluelist(le.corp_home_state_name_values,ri.corp_home_state_name_values);
    SELF.corp_is_professional_values := SALT34.fn_combine_fieldvaluelist(le.corp_is_professional_values,ri.corp_is_professional_values);
    SELF.corp_is_non_profit_irs_approved_values := SALT34.fn_combine_fieldvaluelist(le.corp_is_non_profit_irs_approved_values,ri.corp_is_non_profit_irs_approved_values);
    SELF.corp_last_renewal_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_last_renewal_date_values,ri.corp_last_renewal_date_values);
    SELF.corp_last_renewal_year_values := SALT34.fn_combine_fieldvaluelist(le.corp_last_renewal_year_values,ri.corp_last_renewal_year_values);
    SELF.corp_license_type_values := SALT34.fn_combine_fieldvaluelist(le.corp_license_type_values,ri.corp_license_type_values);
    SELF.corp_llc_managed_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_llc_managed_desc_values,ri.corp_llc_managed_desc_values);
    SELF.corp_llc_managed_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_llc_managed_ind_values,ri.corp_llc_managed_ind_values);
    SELF.corp_management_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_management_desc_values,ri.corp_management_desc_values);
    SELF.corp_management_type_values := SALT34.fn_combine_fieldvaluelist(le.corp_management_type_values,ri.corp_management_type_values);
    SELF.corp_manager_managed_values := SALT34.fn_combine_fieldvaluelist(le.corp_manager_managed_values,ri.corp_manager_managed_values);
    SELF.corp_merged_corporation_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_merged_corporation_id_values,ri.corp_merged_corporation_id_values);
    SELF.corp_merged_fein_values := SALT34.fn_combine_fieldvaluelist(le.corp_merged_fein_values,ri.corp_merged_fein_values);
    SELF.corp_merger_allowed_flag_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_allowed_flag_values,ri.corp_merger_allowed_flag_values);
    SELF.corp_merger_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_date_values,ri.corp_merger_date_values);
    SELF.corp_merger_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_desc_values,ri.corp_merger_desc_values);
    SELF.corp_merger_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_effective_date_values,ri.corp_merger_effective_date_values);
    SELF.corp_merger_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_id_values,ri.corp_merger_id_values);
    SELF.corp_merger_indicator_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_indicator_values,ri.corp_merger_indicator_values);
    SELF.corp_merger_name_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_name_values,ri.corp_merger_name_values);
    SELF.corp_merger_type_converted_to_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_type_converted_to_cd_values,ri.corp_merger_type_converted_to_cd_values);
    SELF.corp_merger_type_converted_to_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_merger_type_converted_to_desc_values,ri.corp_merger_type_converted_to_desc_values);
    SELF.corp_naics_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_naics_desc_values,ri.corp_naics_desc_values);
    SELF.corp_name_effective_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_effective_date_values,ri.corp_name_effective_date_values);
    SELF.corp_name_reservation_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_reservation_date_values,ri.corp_name_reservation_date_values);
    SELF.corp_name_reservation_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_reservation_desc_values,ri.corp_name_reservation_desc_values);
    SELF.corp_name_reservation_expiration_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_reservation_expiration_date_values,ri.corp_name_reservation_expiration_date_values);
    SELF.corp_name_reservation_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_reservation_nbr_values,ri.corp_name_reservation_nbr_values);
    SELF.corp_name_reservation_type_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_reservation_type_values,ri.corp_name_reservation_type_values);
    SELF.corp_name_status_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_status_cd_values,ri.corp_name_status_cd_values);
    SELF.corp_name_status_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_status_date_values,ri.corp_name_status_date_values);
    SELF.corp_name_status_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_name_status_desc_values,ri.corp_name_status_desc_values);
    SELF.corp_non_profit_irs_approved_purpose_values := SALT34.fn_combine_fieldvaluelist(le.corp_non_profit_irs_approved_purpose_values,ri.corp_non_profit_irs_approved_purpose_values);
    SELF.corp_non_profit_solicit_donations_values := SALT34.fn_combine_fieldvaluelist(le.corp_non_profit_solicit_donations_values,ri.corp_non_profit_solicit_donations_values);
    SELF.corp_nbr_of_amendments_values := SALT34.fn_combine_fieldvaluelist(le.corp_nbr_of_amendments_values,ri.corp_nbr_of_amendments_values);
    SELF.corp_nbr_of_initial_llc_members_values := SALT34.fn_combine_fieldvaluelist(le.corp_nbr_of_initial_llc_members_values,ri.corp_nbr_of_initial_llc_members_values);
    SELF.corp_nbr_of_partners_values := SALT34.fn_combine_fieldvaluelist(le.corp_nbr_of_partners_values,ri.corp_nbr_of_partners_values);
    SELF.corp_operating_agreement_values := SALT34.fn_combine_fieldvaluelist(le.corp_operating_agreement_values,ri.corp_operating_agreement_values);
    SELF.corp_opt_in_llc_act_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_opt_in_llc_act_desc_values,ri.corp_opt_in_llc_act_desc_values);
    SELF.corp_opt_in_llc_act_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_opt_in_llc_act_ind_values,ri.corp_opt_in_llc_act_ind_values);
    SELF.corp_organizational_comments_values := SALT34.fn_combine_fieldvaluelist(le.corp_organizational_comments_values,ri.corp_organizational_comments_values);
    SELF.corp_partner_contributions_total_values := SALT34.fn_combine_fieldvaluelist(le.corp_partner_contributions_total_values,ri.corp_partner_contributions_total_values);
    SELF.corp_partner_terms_values := SALT34.fn_combine_fieldvaluelist(le.corp_partner_terms_values,ri.corp_partner_terms_values);
    SELF.corp_percentage_voters_required_to_approve_amendments_values := SALT34.fn_combine_fieldvaluelist(le.corp_percentage_voters_required_to_approve_amendments_values,ri.corp_percentage_voters_required_to_approve_amendments_values);
    SELF.corp_profession_values := SALT34.fn_combine_fieldvaluelist(le.corp_profession_values,ri.corp_profession_values);
    SELF.corp_province_values := SALT34.fn_combine_fieldvaluelist(le.corp_province_values,ri.corp_province_values);
    SELF.corp_public_mutual_corporation_values := SALT34.fn_combine_fieldvaluelist(le.corp_public_mutual_corporation_values,ri.corp_public_mutual_corporation_values);
    SELF.corp_purpose_values := SALT34.fn_combine_fieldvaluelist(le.corp_purpose_values,ri.corp_purpose_values);
    SELF.corp_ra_required_flag_values := SALT34.fn_combine_fieldvaluelist(le.corp_ra_required_flag_values,ri.corp_ra_required_flag_values);
    SELF.corp_registered_counties_values := SALT34.fn_combine_fieldvaluelist(le.corp_registered_counties_values,ri.corp_registered_counties_values);
    SELF.corp_regulated_ind_values := SALT34.fn_combine_fieldvaluelist(le.corp_regulated_ind_values,ri.corp_regulated_ind_values);
    SELF.corp_renewal_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_renewal_date_values,ri.corp_renewal_date_values);
    SELF.corp_standing_other_values := SALT34.fn_combine_fieldvaluelist(le.corp_standing_other_values,ri.corp_standing_other_values);
    SELF.corp_survivor_corporation_id_values := SALT34.fn_combine_fieldvaluelist(le.corp_survivor_corporation_id_values,ri.corp_survivor_corporation_id_values);
    SELF.corp_tax_base_values := SALT34.fn_combine_fieldvaluelist(le.corp_tax_base_values,ri.corp_tax_base_values);
    SELF.corp_tax_standing_values := SALT34.fn_combine_fieldvaluelist(le.corp_tax_standing_values,ri.corp_tax_standing_values);
    SELF.corp_termination_cd_values := SALT34.fn_combine_fieldvaluelist(le.corp_termination_cd_values,ri.corp_termination_cd_values);
    SELF.corp_termination_desc_values := SALT34.fn_combine_fieldvaluelist(le.corp_termination_desc_values,ri.corp_termination_desc_values);
    SELF.corp_termination_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_termination_date_values,ri.corp_termination_date_values);
    SELF.corp_trademark_business_mark_type_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_business_mark_type_values,ri.corp_trademark_business_mark_type_values);
    SELF.corp_trademark_cancelled_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_cancelled_date_values,ri.corp_trademark_cancelled_date_values);
    SELF.corp_trademark_class_desc1_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc1_values,ri.corp_trademark_class_desc1_values);
    SELF.corp_trademark_class_desc2_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc2_values,ri.corp_trademark_class_desc2_values);
    SELF.corp_trademark_class_desc3_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc3_values,ri.corp_trademark_class_desc3_values);
    SELF.corp_trademark_class_desc4_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc4_values,ri.corp_trademark_class_desc4_values);
    SELF.corp_trademark_class_desc5_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc5_values,ri.corp_trademark_class_desc5_values);
    SELF.corp_trademark_class_desc6_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_class_desc6_values,ri.corp_trademark_class_desc6_values);
    SELF.corp_trademark_classification_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_classification_nbr_values,ri.corp_trademark_classification_nbr_values);
    SELF.corp_trademark_disclaimer1_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_disclaimer1_values,ri.corp_trademark_disclaimer1_values);
    SELF.corp_trademark_disclaimer2_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_disclaimer2_values,ri.corp_trademark_disclaimer2_values);
    SELF.corp_trademark_expiration_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_expiration_date_values,ri.corp_trademark_expiration_date_values);
    SELF.corp_trademark_filing_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_filing_date_values,ri.corp_trademark_filing_date_values);
    SELF.corp_trademark_first_use_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_first_use_date_values,ri.corp_trademark_first_use_date_values);
    SELF.corp_trademark_first_use_date_in_state_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_first_use_date_in_state_values,ri.corp_trademark_first_use_date_in_state_values);
    SELF.corp_trademark_keywords_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_keywords_values,ri.corp_trademark_keywords_values);
    SELF.corp_trademark_logo_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_logo_values,ri.corp_trademark_logo_values);
    SELF.corp_trademark_name_expiration_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_name_expiration_date_values,ri.corp_trademark_name_expiration_date_values);
    SELF.corp_trademark_nbr_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_nbr_values,ri.corp_trademark_nbr_values);
    SELF.corp_trademark_renewal_date_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_renewal_date_values,ri.corp_trademark_renewal_date_values);
    SELF.corp_trademark_status_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_status_values,ri.corp_trademark_status_values);
    SELF.corp_trademark_used_1_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_used_1_values,ri.corp_trademark_used_1_values);
    SELF.corp_trademark_used_2_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_used_2_values,ri.corp_trademark_used_2_values);
    SELF.corp_trademark_used_3_values := SALT34.fn_combine_fieldvaluelist(le.corp_trademark_used_3_values,ri.corp_trademark_used_3_values);
    SELF.cont_owner_percentage_values := SALT34.fn_combine_fieldvaluelist(le.cont_owner_percentage_values,ri.cont_owner_percentage_values);
    SELF.cont_country_values := SALT34.fn_combine_fieldvaluelist(le.cont_country_values,ri.cont_country_values);
    SELF.cont_country_mailing_values := SALT34.fn_combine_fieldvaluelist(le.cont_country_mailing_values,ri.cont_country_mailing_values);
    SELF.cont_nondislosure_values := SALT34.fn_combine_fieldvaluelist(le.cont_nondislosure_values,ri.cont_nondislosure_values);
    SELF.cont_prep_addr_line1_values := SALT34.fn_combine_fieldvaluelist(le.cont_prep_addr_line1_values,ri.cont_prep_addr_line1_values);
    SELF.cont_prep_addr_last_line_values := SALT34.fn_combine_fieldvaluelist(le.cont_prep_addr_last_line_values,ri.cont_prep_addr_last_line_values);
    SELF.recordorigin_values := SALT34.fn_combine_fieldvaluelist(le.recordorigin_values,ri.recordorigin_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH() ), , LOCAL ), LEFT. = RIGHT., RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF. := le.;
    SELF.dt_vendor_first_reported_values := SORT(le.dt_vendor_first_reported_values, -cnt, val, LOCAL);
    SELF.dt_vendor_last_reported_values := SORT(le.dt_vendor_last_reported_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
    SELF.corp_ra_dt_first_seen_values := SORT(le.corp_ra_dt_first_seen_values, -cnt, val, LOCAL);
    SELF.corp_ra_dt_last_seen_values := SORT(le.corp_ra_dt_last_seen_values, -cnt, val, LOCAL);
    SELF.corp_key_values := SORT(le.corp_key_values, -cnt, val, LOCAL);
    SELF.corp_supp_key_values := SORT(le.corp_supp_key_values, -cnt, val, LOCAL);
    SELF.corp_vendor_values := SORT(le.corp_vendor_values, -cnt, val, LOCAL);
    SELF.corp_vendor_county_values := SORT(le.corp_vendor_county_values, -cnt, val, LOCAL);
    SELF.corp_vendor_subcode_values := SORT(le.corp_vendor_subcode_values, -cnt, val, LOCAL);
    SELF.corp_state_origin_values := SORT(le.corp_state_origin_values, -cnt, val, LOCAL);
    SELF.corp_process_date_values := SORT(le.corp_process_date_values, -cnt, val, LOCAL);
    SELF.corp_orig_sos_charter_nbr_values := SORT(le.corp_orig_sos_charter_nbr_values, -cnt, val, LOCAL);
    SELF.corp_legal_name_values := SORT(le.corp_legal_name_values, -cnt, val, LOCAL);
    SELF.corp_ln_name_type_cd_values := SORT(le.corp_ln_name_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_ln_name_type_desc_values := SORT(le.corp_ln_name_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_supp_nbr_values := SORT(le.corp_supp_nbr_values, -cnt, val, LOCAL);
    SELF.corp_name_comment_values := SORT(le.corp_name_comment_values, -cnt, val, LOCAL);
    SELF.corp_address1_type_cd_values := SORT(le.corp_address1_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_address1_type_desc_values := SORT(le.corp_address1_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_address1_line1_values := SORT(le.corp_address1_line1_values, -cnt, val, LOCAL);
    SELF.corp_address1_line2_values := SORT(le.corp_address1_line2_values, -cnt, val, LOCAL);
    SELF.corp_address1_line3_values := SORT(le.corp_address1_line3_values, -cnt, val, LOCAL);
    SELF.corp_address1_effective_date_values := SORT(le.corp_address1_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_address2_type_cd_values := SORT(le.corp_address2_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_address2_type_desc_values := SORT(le.corp_address2_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_address2_line1_values := SORT(le.corp_address2_line1_values, -cnt, val, LOCAL);
    SELF.corp_address2_line2_values := SORT(le.corp_address2_line2_values, -cnt, val, LOCAL);
    SELF.corp_address2_line3_values := SORT(le.corp_address2_line3_values, -cnt, val, LOCAL);
    SELF.corp_address2_effective_date_values := SORT(le.corp_address2_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_phone_number_values := SORT(le.corp_phone_number_values, -cnt, val, LOCAL);
    SELF.corp_phone_number_type_cd_values := SORT(le.corp_phone_number_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_phone_number_type_desc_values := SORT(le.corp_phone_number_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_fax_nbr_values := SORT(le.corp_fax_nbr_values, -cnt, val, LOCAL);
    SELF.corp_email_address_values := SORT(le.corp_email_address_values, -cnt, val, LOCAL);
    SELF.corp_web_address_values := SORT(le.corp_web_address_values, -cnt, val, LOCAL);
    SELF.corp_filing_reference_nbr_values := SORT(le.corp_filing_reference_nbr_values, -cnt, val, LOCAL);
    SELF.corp_filing_date_values := SORT(le.corp_filing_date_values, -cnt, val, LOCAL);
    SELF.corp_filing_cd_values := SORT(le.corp_filing_cd_values, -cnt, val, LOCAL);
    SELF.corp_filing_desc_values := SORT(le.corp_filing_desc_values, -cnt, val, LOCAL);
    SELF.corp_status_cd_values := SORT(le.corp_status_cd_values, -cnt, val, LOCAL);
    SELF.corp_status_desc_values := SORT(le.corp_status_desc_values, -cnt, val, LOCAL);
    SELF.corp_status_date_values := SORT(le.corp_status_date_values, -cnt, val, LOCAL);
    SELF.corp_standing_values := SORT(le.corp_standing_values, -cnt, val, LOCAL);
    SELF.corp_status_comment_values := SORT(le.corp_status_comment_values, -cnt, val, LOCAL);
    SELF.corp_ticker_symbol_values := SORT(le.corp_ticker_symbol_values, -cnt, val, LOCAL);
    SELF.corp_stock_exchange_values := SORT(le.corp_stock_exchange_values, -cnt, val, LOCAL);
    SELF.corp_inc_state_values := SORT(le.corp_inc_state_values, -cnt, val, LOCAL);
    SELF.corp_inc_county_values := SORT(le.corp_inc_county_values, -cnt, val, LOCAL);
    SELF.corp_inc_date_values := SORT(le.corp_inc_date_values, -cnt, val, LOCAL);
    SELF.corp_anniversary_month_values := SORT(le.corp_anniversary_month_values, -cnt, val, LOCAL);
    SELF.corp_fed_tax_id_values := SORT(le.corp_fed_tax_id_values, -cnt, val, LOCAL);
    SELF.corp_state_tax_id_values := SORT(le.corp_state_tax_id_values, -cnt, val, LOCAL);
    SELF.corp_term_exist_cd_values := SORT(le.corp_term_exist_cd_values, -cnt, val, LOCAL);
    SELF.corp_term_exist_exp_values := SORT(le.corp_term_exist_exp_values, -cnt, val, LOCAL);
    SELF.corp_term_exist_desc_values := SORT(le.corp_term_exist_desc_values, -cnt, val, LOCAL);
    SELF.corp_foreign_domestic_ind_values := SORT(le.corp_foreign_domestic_ind_values, -cnt, val, LOCAL);
    SELF.corp_forgn_state_cd_values := SORT(le.corp_forgn_state_cd_values, -cnt, val, LOCAL);
    SELF.corp_forgn_state_desc_values := SORT(le.corp_forgn_state_desc_values, -cnt, val, LOCAL);
    SELF.corp_forgn_sos_charter_nbr_values := SORT(le.corp_forgn_sos_charter_nbr_values, -cnt, val, LOCAL);
    SELF.corp_forgn_date_values := SORT(le.corp_forgn_date_values, -cnt, val, LOCAL);
    SELF.corp_forgn_fed_tax_id_values := SORT(le.corp_forgn_fed_tax_id_values, -cnt, val, LOCAL);
    SELF.corp_forgn_state_tax_id_values := SORT(le.corp_forgn_state_tax_id_values, -cnt, val, LOCAL);
    SELF.corp_forgn_term_exist_cd_values := SORT(le.corp_forgn_term_exist_cd_values, -cnt, val, LOCAL);
    SELF.corp_forgn_term_exist_exp_values := SORT(le.corp_forgn_term_exist_exp_values, -cnt, val, LOCAL);
    SELF.corp_forgn_term_exist_desc_values := SORT(le.corp_forgn_term_exist_desc_values, -cnt, val, LOCAL);
    SELF.corp_orig_org_structure_cd_values := SORT(le.corp_orig_org_structure_cd_values, -cnt, val, LOCAL);
    SELF.corp_orig_org_structure_desc_values := SORT(le.corp_orig_org_structure_desc_values, -cnt, val, LOCAL);
    SELF.corp_for_profit_ind_values := SORT(le.corp_for_profit_ind_values, -cnt, val, LOCAL);
    SELF.corp_public_or_private_ind_values := SORT(le.corp_public_or_private_ind_values, -cnt, val, LOCAL);
    SELF.corp_sic_code_values := SORT(le.corp_sic_code_values, -cnt, val, LOCAL);
    SELF.corp_naic_code_values := SORT(le.corp_naic_code_values, -cnt, val, LOCAL);
    SELF.corp_orig_bus_type_cd_values := SORT(le.corp_orig_bus_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_orig_bus_type_desc_values := SORT(le.corp_orig_bus_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_entity_desc_values := SORT(le.corp_entity_desc_values, -cnt, val, LOCAL);
    SELF.corp_certificate_nbr_values := SORT(le.corp_certificate_nbr_values, -cnt, val, LOCAL);
    SELF.corp_internal_nbr_values := SORT(le.corp_internal_nbr_values, -cnt, val, LOCAL);
    SELF.corp_previous_nbr_values := SORT(le.corp_previous_nbr_values, -cnt, val, LOCAL);
    SELF.corp_microfilm_nbr_values := SORT(le.corp_microfilm_nbr_values, -cnt, val, LOCAL);
    SELF.corp_amendments_filed_values := SORT(le.corp_amendments_filed_values, -cnt, val, LOCAL);
    SELF.corp_acts_values := SORT(le.corp_acts_values, -cnt, val, LOCAL);
    SELF.corp_partnership_ind_values := SORT(le.corp_partnership_ind_values, -cnt, val, LOCAL);
    SELF.corp_mfg_ind_values := SORT(le.corp_mfg_ind_values, -cnt, val, LOCAL);
    SELF.corp_addl_info_values := SORT(le.corp_addl_info_values, -cnt, val, LOCAL);
    SELF.corp_taxes_values := SORT(le.corp_taxes_values, -cnt, val, LOCAL);
    SELF.corp_franchise_taxes_values := SORT(le.corp_franchise_taxes_values, -cnt, val, LOCAL);
    SELF.corp_tax_program_cd_values := SORT(le.corp_tax_program_cd_values, -cnt, val, LOCAL);
    SELF.corp_tax_program_desc_values := SORT(le.corp_tax_program_desc_values, -cnt, val, LOCAL);
    SELF.corp_ra_full_name_values := SORT(le.corp_ra_full_name_values, -cnt, val, LOCAL);
    SELF.corp_ra_fname_values := SORT(le.corp_ra_fname_values, -cnt, val, LOCAL);
    SELF.corp_ra_mname_values := SORT(le.corp_ra_mname_values, -cnt, val, LOCAL);
    SELF.corp_ra_lname_values := SORT(le.corp_ra_lname_values, -cnt, val, LOCAL);
    SELF.corp_ra_suffix_values := SORT(le.corp_ra_suffix_values, -cnt, val, LOCAL);
    SELF.corp_ra_title_cd_values := SORT(le.corp_ra_title_cd_values, -cnt, val, LOCAL);
    SELF.corp_ra_title_desc_values := SORT(le.corp_ra_title_desc_values, -cnt, val, LOCAL);
    SELF.corp_ra_fein_values := SORT(le.corp_ra_fein_values, -cnt, val, LOCAL);
    SELF.corp_ra_ssn_values := SORT(le.corp_ra_ssn_values, -cnt, val, LOCAL);
    SELF.corp_ra_dob_values := SORT(le.corp_ra_dob_values, -cnt, val, LOCAL);
    SELF.corp_ra_effective_date_values := SORT(le.corp_ra_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_ra_resign_date_values := SORT(le.corp_ra_resign_date_values, -cnt, val, LOCAL);
    SELF.corp_ra_no_comp_values := SORT(le.corp_ra_no_comp_values, -cnt, val, LOCAL);
    SELF.corp_ra_no_comp_igs_values := SORT(le.corp_ra_no_comp_igs_values, -cnt, val, LOCAL);
    SELF.corp_ra_addl_info_values := SORT(le.corp_ra_addl_info_values, -cnt, val, LOCAL);
    SELF.corp_ra_address_type_cd_values := SORT(le.corp_ra_address_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_ra_address_type_desc_values := SORT(le.corp_ra_address_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_ra_address_line1_values := SORT(le.corp_ra_address_line1_values, -cnt, val, LOCAL);
    SELF.corp_ra_address_line2_values := SORT(le.corp_ra_address_line2_values, -cnt, val, LOCAL);
    SELF.corp_ra_address_line3_values := SORT(le.corp_ra_address_line3_values, -cnt, val, LOCAL);
    SELF.corp_ra_phone_number_values := SORT(le.corp_ra_phone_number_values, -cnt, val, LOCAL);
    SELF.corp_ra_phone_number_type_cd_values := SORT(le.corp_ra_phone_number_type_cd_values, -cnt, val, LOCAL);
    SELF.corp_ra_phone_number_type_desc_values := SORT(le.corp_ra_phone_number_type_desc_values, -cnt, val, LOCAL);
    SELF.corp_ra_fax_nbr_values := SORT(le.corp_ra_fax_nbr_values, -cnt, val, LOCAL);
    SELF.corp_ra_email_address_values := SORT(le.corp_ra_email_address_values, -cnt, val, LOCAL);
    SELF.corp_ra_web_address_values := SORT(le.corp_ra_web_address_values, -cnt, val, LOCAL);
    SELF.corp_prep_addr1_line1_values := SORT(le.corp_prep_addr1_line1_values, -cnt, val, LOCAL);
    SELF.corp_prep_addr1_last_line_values := SORT(le.corp_prep_addr1_last_line_values, -cnt, val, LOCAL);
    SELF.corp_prep_addr2_line1_values := SORT(le.corp_prep_addr2_line1_values, -cnt, val, LOCAL);
    SELF.corp_prep_addr2_last_line_values := SORT(le.corp_prep_addr2_last_line_values, -cnt, val, LOCAL);
    SELF.ra_prep_addr_line1_values := SORT(le.ra_prep_addr_line1_values, -cnt, val, LOCAL);
    SELF.ra_prep_addr_last_line_values := SORT(le.ra_prep_addr_last_line_values, -cnt, val, LOCAL);
    SELF.cont_filing_reference_nbr_values := SORT(le.cont_filing_reference_nbr_values, -cnt, val, LOCAL);
    SELF.cont_filing_date_values := SORT(le.cont_filing_date_values, -cnt, val, LOCAL);
    SELF.cont_filing_cd_values := SORT(le.cont_filing_cd_values, -cnt, val, LOCAL);
    SELF.cont_filing_desc_values := SORT(le.cont_filing_desc_values, -cnt, val, LOCAL);
    SELF.cont_type_cd_values := SORT(le.cont_type_cd_values, -cnt, val, LOCAL);
    SELF.cont_type_desc_values := SORT(le.cont_type_desc_values, -cnt, val, LOCAL);
    SELF.cont_full_name_values := SORT(le.cont_full_name_values, -cnt, val, LOCAL);
    SELF.cont_fname_values := SORT(le.cont_fname_values, -cnt, val, LOCAL);
    SELF.cont_mname_values := SORT(le.cont_mname_values, -cnt, val, LOCAL);
    SELF.cont_lname_values := SORT(le.cont_lname_values, -cnt, val, LOCAL);
    SELF.cont_suffix_values := SORT(le.cont_suffix_values, -cnt, val, LOCAL);
    SELF.cont_title1_desc_values := SORT(le.cont_title1_desc_values, -cnt, val, LOCAL);
    SELF.cont_title2_desc_values := SORT(le.cont_title2_desc_values, -cnt, val, LOCAL);
    SELF.cont_title3_desc_values := SORT(le.cont_title3_desc_values, -cnt, val, LOCAL);
    SELF.cont_title4_desc_values := SORT(le.cont_title4_desc_values, -cnt, val, LOCAL);
    SELF.cont_title5_desc_values := SORT(le.cont_title5_desc_values, -cnt, val, LOCAL);
    SELF.cont_fein_values := SORT(le.cont_fein_values, -cnt, val, LOCAL);
    SELF.cont_ssn_values := SORT(le.cont_ssn_values, -cnt, val, LOCAL);
    SELF.cont_dob_values := SORT(le.cont_dob_values, -cnt, val, LOCAL);
    SELF.cont_status_cd_values := SORT(le.cont_status_cd_values, -cnt, val, LOCAL);
    SELF.cont_status_desc_values := SORT(le.cont_status_desc_values, -cnt, val, LOCAL);
    SELF.cont_effective_date_values := SORT(le.cont_effective_date_values, -cnt, val, LOCAL);
    SELF.cont_effective_cd_values := SORT(le.cont_effective_cd_values, -cnt, val, LOCAL);
    SELF.cont_effective_desc_values := SORT(le.cont_effective_desc_values, -cnt, val, LOCAL);
    SELF.cont_addl_info_values := SORT(le.cont_addl_info_values, -cnt, val, LOCAL);
    SELF.cont_address_type_cd_values := SORT(le.cont_address_type_cd_values, -cnt, val, LOCAL);
    SELF.cont_address_type_desc_values := SORT(le.cont_address_type_desc_values, -cnt, val, LOCAL);
    SELF.cont_address_line1_values := SORT(le.cont_address_line1_values, -cnt, val, LOCAL);
    SELF.cont_address_line2_values := SORT(le.cont_address_line2_values, -cnt, val, LOCAL);
    SELF.cont_address_line3_values := SORT(le.cont_address_line3_values, -cnt, val, LOCAL);
    SELF.cont_address_effective_date_values := SORT(le.cont_address_effective_date_values, -cnt, val, LOCAL);
    SELF.cont_address_county_values := SORT(le.cont_address_county_values, -cnt, val, LOCAL);
    SELF.cont_phone_number_values := SORT(le.cont_phone_number_values, -cnt, val, LOCAL);
    SELF.cont_phone_number_type_cd_values := SORT(le.cont_phone_number_type_cd_values, -cnt, val, LOCAL);
    SELF.cont_phone_number_type_desc_values := SORT(le.cont_phone_number_type_desc_values, -cnt, val, LOCAL);
    SELF.cont_fax_nbr_values := SORT(le.cont_fax_nbr_values, -cnt, val, LOCAL);
    SELF.cont_email_address_values := SORT(le.cont_email_address_values, -cnt, val, LOCAL);
    SELF.cont_web_address_values := SORT(le.cont_web_address_values, -cnt, val, LOCAL);
    SELF.corp_acres_values := SORT(le.corp_acres_values, -cnt, val, LOCAL);
    SELF.corp_action_values := SORT(le.corp_action_values, -cnt, val, LOCAL);
    SELF.corp_action_date_values := SORT(le.corp_action_date_values, -cnt, val, LOCAL);
    SELF.corp_action_employment_security_approval_date_values := SORT(le.corp_action_employment_security_approval_date_values, -cnt, val, LOCAL);
    SELF.corp_action_pending_cd_values := SORT(le.corp_action_pending_cd_values, -cnt, val, LOCAL);
    SELF.corp_action_pending_desc_values := SORT(le.corp_action_pending_desc_values, -cnt, val, LOCAL);
    SELF.corp_action_statement_of_intent_date_values := SORT(le.corp_action_statement_of_intent_date_values, -cnt, val, LOCAL);
    SELF.corp_action_tax_dept_approval_date_values := SORT(le.corp_action_tax_dept_approval_date_values, -cnt, val, LOCAL);
    SELF.corp_acts2_values := SORT(le.corp_acts2_values, -cnt, val, LOCAL);
    SELF.corp_acts3_values := SORT(le.corp_acts3_values, -cnt, val, LOCAL);
    SELF.corp_additional_principals_values := SORT(le.corp_additional_principals_values, -cnt, val, LOCAL);
    SELF.corp_address_office_type_values := SORT(le.corp_address_office_type_values, -cnt, val, LOCAL);
    SELF.corp_agent_assign_date_values := SORT(le.corp_agent_assign_date_values, -cnt, val, LOCAL);
    SELF.corp_agent_commercial_values := SORT(le.corp_agent_commercial_values, -cnt, val, LOCAL);
    SELF.corp_agent_country_values := SORT(le.corp_agent_country_values, -cnt, val, LOCAL);
    SELF.corp_agent_county_values := SORT(le.corp_agent_county_values, -cnt, val, LOCAL);
    SELF.corp_agent_status_cd_values := SORT(le.corp_agent_status_cd_values, -cnt, val, LOCAL);
    SELF.corp_agent_status_desc_values := SORT(le.corp_agent_status_desc_values, -cnt, val, LOCAL);
    SELF.corp_agent_id_values := SORT(le.corp_agent_id_values, -cnt, val, LOCAL);
    SELF.corp_agriculture_flag_values := SORT(le.corp_agriculture_flag_values, -cnt, val, LOCAL);
    SELF.corp_authorized_partners_values := SORT(le.corp_authorized_partners_values, -cnt, val, LOCAL);
    SELF.corp_comment_values := SORT(le.corp_comment_values, -cnt, val, LOCAL);
    SELF.corp_consent_flag_for_protected_name_values := SORT(le.corp_consent_flag_for_protected_name_values, -cnt, val, LOCAL);
    SELF.corp_converted_values := SORT(le.corp_converted_values, -cnt, val, LOCAL);
    SELF.corp_converted_from_values := SORT(le.corp_converted_from_values, -cnt, val, LOCAL);
    SELF.corp_country_of_formation_values := SORT(le.corp_country_of_formation_values, -cnt, val, LOCAL);
    SELF.corp_date_of_organization_meeting_values := SORT(le.corp_date_of_organization_meeting_values, -cnt, val, LOCAL);
    SELF.corp_delayed_effective_date_values := SORT(le.corp_delayed_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_directors_from_to_values := SORT(le.corp_directors_from_to_values, -cnt, val, LOCAL);
    SELF.corp_dissolved_date_values := SORT(le.corp_dissolved_date_values, -cnt, val, LOCAL);
    SELF.corp_farm_exemptions_values := SORT(le.corp_farm_exemptions_values, -cnt, val, LOCAL);
    SELF.corp_farm_qual_date_values := SORT(le.corp_farm_qual_date_values, -cnt, val, LOCAL);
    SELF.corp_farm_status_cd_values := SORT(le.corp_farm_status_cd_values, -cnt, val, LOCAL);
    SELF.corp_farm_status_desc_values := SORT(le.corp_farm_status_desc_values, -cnt, val, LOCAL);
    SELF.corp_fiscal_year_month_values := SORT(le.corp_fiscal_year_month_values, -cnt, val, LOCAL);
    SELF.corp_foreign_fiduciary_capacity_in_state_values := SORT(le.corp_foreign_fiduciary_capacity_in_state_values, -cnt, val, LOCAL);
    SELF.corp_governing_statute_values := SORT(le.corp_governing_statute_values, -cnt, val, LOCAL);
    SELF.corp_has_members_values := SORT(le.corp_has_members_values, -cnt, val, LOCAL);
    SELF.corp_has_vested_managers_values := SORT(le.corp_has_vested_managers_values, -cnt, val, LOCAL);
    SELF.corp_home_incorporated_county_values := SORT(le.corp_home_incorporated_county_values, -cnt, val, LOCAL);
    SELF.corp_home_state_name_values := SORT(le.corp_home_state_name_values, -cnt, val, LOCAL);
    SELF.corp_is_professional_values := SORT(le.corp_is_professional_values, -cnt, val, LOCAL);
    SELF.corp_is_non_profit_irs_approved_values := SORT(le.corp_is_non_profit_irs_approved_values, -cnt, val, LOCAL);
    SELF.corp_last_renewal_date_values := SORT(le.corp_last_renewal_date_values, -cnt, val, LOCAL);
    SELF.corp_last_renewal_year_values := SORT(le.corp_last_renewal_year_values, -cnt, val, LOCAL);
    SELF.corp_license_type_values := SORT(le.corp_license_type_values, -cnt, val, LOCAL);
    SELF.corp_llc_managed_desc_values := SORT(le.corp_llc_managed_desc_values, -cnt, val, LOCAL);
    SELF.corp_llc_managed_ind_values := SORT(le.corp_llc_managed_ind_values, -cnt, val, LOCAL);
    SELF.corp_management_desc_values := SORT(le.corp_management_desc_values, -cnt, val, LOCAL);
    SELF.corp_management_type_values := SORT(le.corp_management_type_values, -cnt, val, LOCAL);
    SELF.corp_manager_managed_values := SORT(le.corp_manager_managed_values, -cnt, val, LOCAL);
    SELF.corp_merged_corporation_id_values := SORT(le.corp_merged_corporation_id_values, -cnt, val, LOCAL);
    SELF.corp_merged_fein_values := SORT(le.corp_merged_fein_values, -cnt, val, LOCAL);
    SELF.corp_merger_allowed_flag_values := SORT(le.corp_merger_allowed_flag_values, -cnt, val, LOCAL);
    SELF.corp_merger_date_values := SORT(le.corp_merger_date_values, -cnt, val, LOCAL);
    SELF.corp_merger_desc_values := SORT(le.corp_merger_desc_values, -cnt, val, LOCAL);
    SELF.corp_merger_effective_date_values := SORT(le.corp_merger_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_merger_id_values := SORT(le.corp_merger_id_values, -cnt, val, LOCAL);
    SELF.corp_merger_indicator_values := SORT(le.corp_merger_indicator_values, -cnt, val, LOCAL);
    SELF.corp_merger_name_values := SORT(le.corp_merger_name_values, -cnt, val, LOCAL);
    SELF.corp_merger_type_converted_to_cd_values := SORT(le.corp_merger_type_converted_to_cd_values, -cnt, val, LOCAL);
    SELF.corp_merger_type_converted_to_desc_values := SORT(le.corp_merger_type_converted_to_desc_values, -cnt, val, LOCAL);
    SELF.corp_naics_desc_values := SORT(le.corp_naics_desc_values, -cnt, val, LOCAL);
    SELF.corp_name_effective_date_values := SORT(le.corp_name_effective_date_values, -cnt, val, LOCAL);
    SELF.corp_name_reservation_date_values := SORT(le.corp_name_reservation_date_values, -cnt, val, LOCAL);
    SELF.corp_name_reservation_desc_values := SORT(le.corp_name_reservation_desc_values, -cnt, val, LOCAL);
    SELF.corp_name_reservation_expiration_date_values := SORT(le.corp_name_reservation_expiration_date_values, -cnt, val, LOCAL);
    SELF.corp_name_reservation_nbr_values := SORT(le.corp_name_reservation_nbr_values, -cnt, val, LOCAL);
    SELF.corp_name_reservation_type_values := SORT(le.corp_name_reservation_type_values, -cnt, val, LOCAL);
    SELF.corp_name_status_cd_values := SORT(le.corp_name_status_cd_values, -cnt, val, LOCAL);
    SELF.corp_name_status_date_values := SORT(le.corp_name_status_date_values, -cnt, val, LOCAL);
    SELF.corp_name_status_desc_values := SORT(le.corp_name_status_desc_values, -cnt, val, LOCAL);
    SELF.corp_non_profit_irs_approved_purpose_values := SORT(le.corp_non_profit_irs_approved_purpose_values, -cnt, val, LOCAL);
    SELF.corp_non_profit_solicit_donations_values := SORT(le.corp_non_profit_solicit_donations_values, -cnt, val, LOCAL);
    SELF.corp_nbr_of_amendments_values := SORT(le.corp_nbr_of_amendments_values, -cnt, val, LOCAL);
    SELF.corp_nbr_of_initial_llc_members_values := SORT(le.corp_nbr_of_initial_llc_members_values, -cnt, val, LOCAL);
    SELF.corp_nbr_of_partners_values := SORT(le.corp_nbr_of_partners_values, -cnt, val, LOCAL);
    SELF.corp_operating_agreement_values := SORT(le.corp_operating_agreement_values, -cnt, val, LOCAL);
    SELF.corp_opt_in_llc_act_desc_values := SORT(le.corp_opt_in_llc_act_desc_values, -cnt, val, LOCAL);
    SELF.corp_opt_in_llc_act_ind_values := SORT(le.corp_opt_in_llc_act_ind_values, -cnt, val, LOCAL);
    SELF.corp_organizational_comments_values := SORT(le.corp_organizational_comments_values, -cnt, val, LOCAL);
    SELF.corp_partner_contributions_total_values := SORT(le.corp_partner_contributions_total_values, -cnt, val, LOCAL);
    SELF.corp_partner_terms_values := SORT(le.corp_partner_terms_values, -cnt, val, LOCAL);
    SELF.corp_percentage_voters_required_to_approve_amendments_values := SORT(le.corp_percentage_voters_required_to_approve_amendments_values, -cnt, val, LOCAL);
    SELF.corp_profession_values := SORT(le.corp_profession_values, -cnt, val, LOCAL);
    SELF.corp_province_values := SORT(le.corp_province_values, -cnt, val, LOCAL);
    SELF.corp_public_mutual_corporation_values := SORT(le.corp_public_mutual_corporation_values, -cnt, val, LOCAL);
    SELF.corp_purpose_values := SORT(le.corp_purpose_values, -cnt, val, LOCAL);
    SELF.corp_ra_required_flag_values := SORT(le.corp_ra_required_flag_values, -cnt, val, LOCAL);
    SELF.corp_registered_counties_values := SORT(le.corp_registered_counties_values, -cnt, val, LOCAL);
    SELF.corp_regulated_ind_values := SORT(le.corp_regulated_ind_values, -cnt, val, LOCAL);
    SELF.corp_renewal_date_values := SORT(le.corp_renewal_date_values, -cnt, val, LOCAL);
    SELF.corp_standing_other_values := SORT(le.corp_standing_other_values, -cnt, val, LOCAL);
    SELF.corp_survivor_corporation_id_values := SORT(le.corp_survivor_corporation_id_values, -cnt, val, LOCAL);
    SELF.corp_tax_base_values := SORT(le.corp_tax_base_values, -cnt, val, LOCAL);
    SELF.corp_tax_standing_values := SORT(le.corp_tax_standing_values, -cnt, val, LOCAL);
    SELF.corp_termination_cd_values := SORT(le.corp_termination_cd_values, -cnt, val, LOCAL);
    SELF.corp_termination_desc_values := SORT(le.corp_termination_desc_values, -cnt, val, LOCAL);
    SELF.corp_termination_date_values := SORT(le.corp_termination_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_business_mark_type_values := SORT(le.corp_trademark_business_mark_type_values, -cnt, val, LOCAL);
    SELF.corp_trademark_cancelled_date_values := SORT(le.corp_trademark_cancelled_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc1_values := SORT(le.corp_trademark_class_desc1_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc2_values := SORT(le.corp_trademark_class_desc2_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc3_values := SORT(le.corp_trademark_class_desc3_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc4_values := SORT(le.corp_trademark_class_desc4_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc5_values := SORT(le.corp_trademark_class_desc5_values, -cnt, val, LOCAL);
    SELF.corp_trademark_class_desc6_values := SORT(le.corp_trademark_class_desc6_values, -cnt, val, LOCAL);
    SELF.corp_trademark_classification_nbr_values := SORT(le.corp_trademark_classification_nbr_values, -cnt, val, LOCAL);
    SELF.corp_trademark_disclaimer1_values := SORT(le.corp_trademark_disclaimer1_values, -cnt, val, LOCAL);
    SELF.corp_trademark_disclaimer2_values := SORT(le.corp_trademark_disclaimer2_values, -cnt, val, LOCAL);
    SELF.corp_trademark_expiration_date_values := SORT(le.corp_trademark_expiration_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_filing_date_values := SORT(le.corp_trademark_filing_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_first_use_date_values := SORT(le.corp_trademark_first_use_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_first_use_date_in_state_values := SORT(le.corp_trademark_first_use_date_in_state_values, -cnt, val, LOCAL);
    SELF.corp_trademark_keywords_values := SORT(le.corp_trademark_keywords_values, -cnt, val, LOCAL);
    SELF.corp_trademark_logo_values := SORT(le.corp_trademark_logo_values, -cnt, val, LOCAL);
    SELF.corp_trademark_name_expiration_date_values := SORT(le.corp_trademark_name_expiration_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_nbr_values := SORT(le.corp_trademark_nbr_values, -cnt, val, LOCAL);
    SELF.corp_trademark_renewal_date_values := SORT(le.corp_trademark_renewal_date_values, -cnt, val, LOCAL);
    SELF.corp_trademark_status_values := SORT(le.corp_trademark_status_values, -cnt, val, LOCAL);
    SELF.corp_trademark_used_1_values := SORT(le.corp_trademark_used_1_values, -cnt, val, LOCAL);
    SELF.corp_trademark_used_2_values := SORT(le.corp_trademark_used_2_values, -cnt, val, LOCAL);
    SELF.corp_trademark_used_3_values := SORT(le.corp_trademark_used_3_values, -cnt, val, LOCAL);
    SELF.cont_owner_percentage_values := SORT(le.cont_owner_percentage_values, -cnt, val, LOCAL);
    SELF.cont_country_values := SORT(le.cont_country_values, -cnt, val, LOCAL);
    SELF.cont_country_mailing_values := SORT(le.cont_country_mailing_values, -cnt, val, LOCAL);
    SELF.cont_nondislosure_values := SORT(le.cont_nondislosure_values, -cnt, val, LOCAL);
    SELF.cont_prep_addr_line1_values := SORT(le.cont_prep_addr_line1_values, -cnt, val, LOCAL);
    SELF.cont_prep_addr_last_line_values := SORT(le.cont_prep_addr_last_line_values, -cnt, val, LOCAL);
    SELF.recordorigin_values := SORT(le.recordorigin_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF. := le.;
  self.dt_vendor_first_reported_Values := IF ( le.dt_vendor_first_reported_year  IN SET(s.nulls_dt_vendor_first_reported_year,dt_vendor_first_reported_year) AND le.dt_vendor_first_reported_month  IN SET(s.nulls_dt_vendor_first_reported_month,dt_vendor_first_reported_month) AND le.dt_vendor_first_reported_day  IN SET(s.nulls_dt_vendor_first_reported_day,dt_vendor_first_reported_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.dt_vendor_first_reported_month)+'/'+TRIM((STRING)le.dt_vendor_first_reported_day)+'/'+TRIM((STRING)le.dt_vendor_first_reported_year)}],SALT34.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( le.dt_vendor_last_reported_year  IN SET(s.nulls_dt_vendor_last_reported_year,dt_vendor_last_reported_year) AND le.dt_vendor_last_reported_month  IN SET(s.nulls_dt_vendor_last_reported_month,dt_vendor_last_reported_month) AND le.dt_vendor_last_reported_day  IN SET(s.nulls_dt_vendor_last_reported_day,dt_vendor_last_reported_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.dt_vendor_last_reported_month)+'/'+TRIM((STRING)le.dt_vendor_last_reported_day)+'/'+TRIM((STRING)le.dt_vendor_last_reported_year)}],SALT34.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( le.dt_first_seen_year  IN SET(s.nulls_dt_first_seen_year,dt_first_seen_year) AND le.dt_first_seen_month  IN SET(s.nulls_dt_first_seen_month,dt_first_seen_month) AND le.dt_first_seen_day  IN SET(s.nulls_dt_first_seen_day,dt_first_seen_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.dt_first_seen_month)+'/'+TRIM((STRING)le.dt_first_seen_day)+'/'+TRIM((STRING)le.dt_first_seen_year)}],SALT34.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( le.dt_last_seen_year  IN SET(s.nulls_dt_last_seen_year,dt_last_seen_year) AND le.dt_last_seen_month  IN SET(s.nulls_dt_last_seen_month,dt_last_seen_month) AND le.dt_last_seen_day  IN SET(s.nulls_dt_last_seen_day,dt_last_seen_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.dt_last_seen_month)+'/'+TRIM((STRING)le.dt_last_seen_day)+'/'+TRIM((STRING)le.dt_last_seen_year)}],SALT34.Layout_FieldValueList));
  self.corp_ra_dt_first_seen_Values := IF ( le.corp_ra_dt_first_seen_year  IN SET(s.nulls_corp_ra_dt_first_seen_year,corp_ra_dt_first_seen_year) AND le.corp_ra_dt_first_seen_month  IN SET(s.nulls_corp_ra_dt_first_seen_month,corp_ra_dt_first_seen_month) AND le.corp_ra_dt_first_seen_day  IN SET(s.nulls_corp_ra_dt_first_seen_day,corp_ra_dt_first_seen_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.corp_ra_dt_first_seen_month)+'/'+TRIM((STRING)le.corp_ra_dt_first_seen_day)+'/'+TRIM((STRING)le.corp_ra_dt_first_seen_year)}],SALT34.Layout_FieldValueList));
  self.corp_ra_dt_last_seen_Values := IF ( le.corp_ra_dt_last_seen_year  IN SET(s.nulls_corp_ra_dt_last_seen_year,corp_ra_dt_last_seen_year) AND le.corp_ra_dt_last_seen_month  IN SET(s.nulls_corp_ra_dt_last_seen_month,corp_ra_dt_last_seen_month) AND le.corp_ra_dt_last_seen_day  IN SET(s.nulls_corp_ra_dt_last_seen_day,corp_ra_dt_last_seen_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.corp_ra_dt_last_seen_month)+'/'+TRIM((STRING)le.corp_ra_dt_last_seen_day)+'/'+TRIM((STRING)le.corp_ra_dt_last_seen_year)}],SALT34.Layout_FieldValueList));
  SELF.corp_key_Values := IF ( (le.corp_key  IN SET(s.nulls_corp_key,corp_key) OR le.corp_key = (TYPEOF(le.corp_key))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_key)}],SALT34.Layout_FieldValueList));
  SELF.corp_supp_key_Values := IF ( (le.corp_supp_key  IN SET(s.nulls_corp_supp_key,corp_supp_key) OR le.corp_supp_key = (TYPEOF(le.corp_supp_key))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_supp_key)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_Values := IF ( (le.corp_vendor  IN SET(s.nulls_corp_vendor,corp_vendor) OR le.corp_vendor = (TYPEOF(le.corp_vendor))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_county_Values := IF ( (le.corp_vendor_county  IN SET(s.nulls_corp_vendor_county,corp_vendor_county) OR le.corp_vendor_county = (TYPEOF(le.corp_vendor_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_subcode_Values := IF ( (le.corp_vendor_subcode  IN SET(s.nulls_corp_vendor_subcode,corp_vendor_subcode) OR le.corp_vendor_subcode = (TYPEOF(le.corp_vendor_subcode))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor_subcode)}],SALT34.Layout_FieldValueList));
  SELF.corp_state_origin_Values := IF ( (le.corp_state_origin  IN SET(s.nulls_corp_state_origin,corp_state_origin) OR le.corp_state_origin = (TYPEOF(le.corp_state_origin))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_state_origin)}],SALT34.Layout_FieldValueList));
  self.corp_process_date_Values := IF ( le.corp_process_date_year  IN SET(s.nulls_corp_process_date_year,corp_process_date_year) AND le.corp_process_date_month  IN SET(s.nulls_corp_process_date_month,corp_process_date_month) AND le.corp_process_date_day  IN SET(s.nulls_corp_process_date_day,corp_process_date_day),dataset([],SALT34.Layout_FieldValueList),dataset([{TRIM((STRING)le.corp_process_date_month)+'/'+TRIM((STRING)le.corp_process_date_day)+'/'+TRIM((STRING)le.corp_process_date_year)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_sos_charter_nbr_Values := IF ( (le.corp_orig_sos_charter_nbr  IN SET(s.nulls_corp_orig_sos_charter_nbr,corp_orig_sos_charter_nbr) OR le.corp_orig_sos_charter_nbr = (TYPEOF(le.corp_orig_sos_charter_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( (le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR le.corp_legal_name = (TYPEOF(le.corp_legal_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_legal_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_ln_name_type_cd_Values := IF ( (le.corp_ln_name_type_cd  IN SET(s.nulls_corp_ln_name_type_cd,corp_ln_name_type_cd) OR le.corp_ln_name_type_cd = (TYPEOF(le.corp_ln_name_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ln_name_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ln_name_type_desc_Values := IF ( (le.corp_ln_name_type_desc  IN SET(s.nulls_corp_ln_name_type_desc,corp_ln_name_type_desc) OR le.corp_ln_name_type_desc = (TYPEOF(le.corp_ln_name_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ln_name_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_supp_nbr_Values := IF ( (le.corp_supp_nbr  IN SET(s.nulls_corp_supp_nbr,corp_supp_nbr) OR le.corp_supp_nbr = (TYPEOF(le.corp_supp_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_supp_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_comment_Values := IF ( (le.corp_name_comment  IN SET(s.nulls_corp_name_comment,corp_name_comment) OR le.corp_name_comment = (TYPEOF(le.corp_name_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_type_cd_Values := IF ( (le.corp_address1_type_cd  IN SET(s.nulls_corp_address1_type_cd,corp_address1_type_cd) OR le.corp_address1_type_cd = (TYPEOF(le.corp_address1_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_type_desc_Values := IF ( (le.corp_address1_type_desc  IN SET(s.nulls_corp_address1_type_desc,corp_address1_type_desc) OR le.corp_address1_type_desc = (TYPEOF(le.corp_address1_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line1_Values := IF ( (le.corp_address1_line1  IN SET(s.nulls_corp_address1_line1,corp_address1_line1) OR le.corp_address1_line1 = (TYPEOF(le.corp_address1_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line2_Values := IF ( (le.corp_address1_line2  IN SET(s.nulls_corp_address1_line2,corp_address1_line2) OR le.corp_address1_line2 = (TYPEOF(le.corp_address1_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line3_Values := IF ( (le.corp_address1_line3  IN SET(s.nulls_corp_address1_line3,corp_address1_line3) OR le.corp_address1_line3 = (TYPEOF(le.corp_address1_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_effective_date_Values := IF ( (le.corp_address1_effective_date  IN SET(s.nulls_corp_address1_effective_date,corp_address1_effective_date) OR le.corp_address1_effective_date = (TYPEOF(le.corp_address1_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_type_cd_Values := IF ( (le.corp_address2_type_cd  IN SET(s.nulls_corp_address2_type_cd,corp_address2_type_cd) OR le.corp_address2_type_cd = (TYPEOF(le.corp_address2_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_type_desc_Values := IF ( (le.corp_address2_type_desc  IN SET(s.nulls_corp_address2_type_desc,corp_address2_type_desc) OR le.corp_address2_type_desc = (TYPEOF(le.corp_address2_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line1_Values := IF ( (le.corp_address2_line1  IN SET(s.nulls_corp_address2_line1,corp_address2_line1) OR le.corp_address2_line1 = (TYPEOF(le.corp_address2_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line2_Values := IF ( (le.corp_address2_line2  IN SET(s.nulls_corp_address2_line2,corp_address2_line2) OR le.corp_address2_line2 = (TYPEOF(le.corp_address2_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line3_Values := IF ( (le.corp_address2_line3  IN SET(s.nulls_corp_address2_line3,corp_address2_line3) OR le.corp_address2_line3 = (TYPEOF(le.corp_address2_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_effective_date_Values := IF ( (le.corp_address2_effective_date  IN SET(s.nulls_corp_address2_effective_date,corp_address2_effective_date) OR le.corp_address2_effective_date = (TYPEOF(le.corp_address2_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_Values := IF ( (le.corp_phone_number  IN SET(s.nulls_corp_phone_number,corp_phone_number) OR le.corp_phone_number = (TYPEOF(le.corp_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_type_cd_Values := IF ( (le.corp_phone_number_type_cd  IN SET(s.nulls_corp_phone_number_type_cd,corp_phone_number_type_cd) OR le.corp_phone_number_type_cd = (TYPEOF(le.corp_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_type_desc_Values := IF ( (le.corp_phone_number_type_desc  IN SET(s.nulls_corp_phone_number_type_desc,corp_phone_number_type_desc) OR le.corp_phone_number_type_desc = (TYPEOF(le.corp_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_fax_nbr_Values := IF ( (le.corp_fax_nbr  IN SET(s.nulls_corp_fax_nbr,corp_fax_nbr) OR le.corp_fax_nbr = (TYPEOF(le.corp_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_email_address_Values := IF ( (le.corp_email_address  IN SET(s.nulls_corp_email_address,corp_email_address) OR le.corp_email_address = (TYPEOF(le.corp_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_email_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_web_address_Values := IF ( (le.corp_web_address  IN SET(s.nulls_corp_web_address,corp_web_address) OR le.corp_web_address = (TYPEOF(le.corp_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_reference_nbr_Values := IF ( (le.corp_filing_reference_nbr  IN SET(s.nulls_corp_filing_reference_nbr,corp_filing_reference_nbr) OR le.corp_filing_reference_nbr = (TYPEOF(le.corp_filing_reference_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_reference_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_date_Values := IF ( (le.corp_filing_date  IN SET(s.nulls_corp_filing_date,corp_filing_date) OR le.corp_filing_date = (TYPEOF(le.corp_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_cd_Values := IF ( (le.corp_filing_cd  IN SET(s.nulls_corp_filing_cd,corp_filing_cd) OR le.corp_filing_cd = (TYPEOF(le.corp_filing_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_desc_Values := IF ( (le.corp_filing_desc  IN SET(s.nulls_corp_filing_desc,corp_filing_desc) OR le.corp_filing_desc = (TYPEOF(le.corp_filing_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_cd_Values := IF ( (le.corp_status_cd  IN SET(s.nulls_corp_status_cd,corp_status_cd) OR le.corp_status_cd = (TYPEOF(le.corp_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_desc_Values := IF ( (le.corp_status_desc  IN SET(s.nulls_corp_status_desc,corp_status_desc) OR le.corp_status_desc = (TYPEOF(le.corp_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_date_Values := IF ( (le.corp_status_date  IN SET(s.nulls_corp_status_date,corp_status_date) OR le.corp_status_date = (TYPEOF(le.corp_status_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_standing_Values := IF ( (le.corp_standing  IN SET(s.nulls_corp_standing,corp_standing) OR le.corp_standing = (TYPEOF(le.corp_standing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_standing)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_comment_Values := IF ( (le.corp_status_comment  IN SET(s.nulls_corp_status_comment,corp_status_comment) OR le.corp_status_comment = (TYPEOF(le.corp_status_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_ticker_symbol_Values := IF ( (le.corp_ticker_symbol  IN SET(s.nulls_corp_ticker_symbol,corp_ticker_symbol) OR le.corp_ticker_symbol = (TYPEOF(le.corp_ticker_symbol))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ticker_symbol)}],SALT34.Layout_FieldValueList));
  SELF.corp_stock_exchange_Values := IF ( (le.corp_stock_exchange  IN SET(s.nulls_corp_stock_exchange,corp_stock_exchange) OR le.corp_stock_exchange = (TYPEOF(le.corp_stock_exchange))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_stock_exchange)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_state_Values := IF ( (le.corp_inc_state  IN SET(s.nulls_corp_inc_state,corp_inc_state) OR le.corp_inc_state = (TYPEOF(le.corp_inc_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_county_Values := IF ( (le.corp_inc_county  IN SET(s.nulls_corp_inc_county,corp_inc_county) OR le.corp_inc_county = (TYPEOF(le.corp_inc_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_date_Values := IF ( (le.corp_inc_date  IN SET(s.nulls_corp_inc_date,corp_inc_date) OR le.corp_inc_date = (TYPEOF(le.corp_inc_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_anniversary_month_Values := IF ( (le.corp_anniversary_month  IN SET(s.nulls_corp_anniversary_month,corp_anniversary_month) OR le.corp_anniversary_month = (TYPEOF(le.corp_anniversary_month))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_anniversary_month)}],SALT34.Layout_FieldValueList));
  SELF.corp_fed_tax_id_Values := IF ( (le.corp_fed_tax_id  IN SET(s.nulls_corp_fed_tax_id,corp_fed_tax_id) OR le.corp_fed_tax_id = (TYPEOF(le.corp_fed_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fed_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_state_tax_id_Values := IF ( (le.corp_state_tax_id  IN SET(s.nulls_corp_state_tax_id,corp_state_tax_id) OR le.corp_state_tax_id = (TYPEOF(le.corp_state_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_state_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_cd_Values := IF ( (le.corp_term_exist_cd  IN SET(s.nulls_corp_term_exist_cd,corp_term_exist_cd) OR le.corp_term_exist_cd = (TYPEOF(le.corp_term_exist_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_exp_Values := IF ( (le.corp_term_exist_exp  IN SET(s.nulls_corp_term_exist_exp,corp_term_exist_exp) OR le.corp_term_exist_exp = (TYPEOF(le.corp_term_exist_exp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_exp)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_desc_Values := IF ( (le.corp_term_exist_desc  IN SET(s.nulls_corp_term_exist_desc,corp_term_exist_desc) OR le.corp_term_exist_desc = (TYPEOF(le.corp_term_exist_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_foreign_domestic_ind_Values := IF ( (le.corp_foreign_domestic_ind  IN SET(s.nulls_corp_foreign_domestic_ind,corp_foreign_domestic_ind) OR le.corp_foreign_domestic_ind = (TYPEOF(le.corp_foreign_domestic_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_foreign_domestic_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_cd_Values := IF ( (le.corp_forgn_state_cd  IN SET(s.nulls_corp_forgn_state_cd,corp_forgn_state_cd) OR le.corp_forgn_state_cd = (TYPEOF(le.corp_forgn_state_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_desc_Values := IF ( (le.corp_forgn_state_desc  IN SET(s.nulls_corp_forgn_state_desc,corp_forgn_state_desc) OR le.corp_forgn_state_desc = (TYPEOF(le.corp_forgn_state_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_sos_charter_nbr_Values := IF ( (le.corp_forgn_sos_charter_nbr  IN SET(s.nulls_corp_forgn_sos_charter_nbr,corp_forgn_sos_charter_nbr) OR le.corp_forgn_sos_charter_nbr = (TYPEOF(le.corp_forgn_sos_charter_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_sos_charter_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_date_Values := IF ( (le.corp_forgn_date  IN SET(s.nulls_corp_forgn_date,corp_forgn_date) OR le.corp_forgn_date = (TYPEOF(le.corp_forgn_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_fed_tax_id_Values := IF ( (le.corp_forgn_fed_tax_id  IN SET(s.nulls_corp_forgn_fed_tax_id,corp_forgn_fed_tax_id) OR le.corp_forgn_fed_tax_id = (TYPEOF(le.corp_forgn_fed_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_fed_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_tax_id_Values := IF ( (le.corp_forgn_state_tax_id  IN SET(s.nulls_corp_forgn_state_tax_id,corp_forgn_state_tax_id) OR le.corp_forgn_state_tax_id = (TYPEOF(le.corp_forgn_state_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_cd_Values := IF ( (le.corp_forgn_term_exist_cd  IN SET(s.nulls_corp_forgn_term_exist_cd,corp_forgn_term_exist_cd) OR le.corp_forgn_term_exist_cd = (TYPEOF(le.corp_forgn_term_exist_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_exp_Values := IF ( (le.corp_forgn_term_exist_exp  IN SET(s.nulls_corp_forgn_term_exist_exp,corp_forgn_term_exist_exp) OR le.corp_forgn_term_exist_exp = (TYPEOF(le.corp_forgn_term_exist_exp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_exp)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_desc_Values := IF ( (le.corp_forgn_term_exist_desc  IN SET(s.nulls_corp_forgn_term_exist_desc,corp_forgn_term_exist_desc) OR le.corp_forgn_term_exist_desc = (TYPEOF(le.corp_forgn_term_exist_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_org_structure_cd_Values := IF ( (le.corp_orig_org_structure_cd  IN SET(s.nulls_corp_orig_org_structure_cd,corp_orig_org_structure_cd) OR le.corp_orig_org_structure_cd = (TYPEOF(le.corp_orig_org_structure_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_org_structure_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_org_structure_desc_Values := IF ( (le.corp_orig_org_structure_desc  IN SET(s.nulls_corp_orig_org_structure_desc,corp_orig_org_structure_desc) OR le.corp_orig_org_structure_desc = (TYPEOF(le.corp_orig_org_structure_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_org_structure_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_for_profit_ind_Values := IF ( (le.corp_for_profit_ind  IN SET(s.nulls_corp_for_profit_ind,corp_for_profit_ind) OR le.corp_for_profit_ind = (TYPEOF(le.corp_for_profit_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_for_profit_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_public_or_private_ind_Values := IF ( (le.corp_public_or_private_ind  IN SET(s.nulls_corp_public_or_private_ind,corp_public_or_private_ind) OR le.corp_public_or_private_ind = (TYPEOF(le.corp_public_or_private_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_public_or_private_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_sic_code_Values := IF ( (le.corp_sic_code  IN SET(s.nulls_corp_sic_code,corp_sic_code) OR le.corp_sic_code = (TYPEOF(le.corp_sic_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_sic_code)}],SALT34.Layout_FieldValueList));
  SELF.corp_naic_code_Values := IF ( (le.corp_naic_code  IN SET(s.nulls_corp_naic_code,corp_naic_code) OR le.corp_naic_code = (TYPEOF(le.corp_naic_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_naic_code)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_bus_type_cd_Values := IF ( (le.corp_orig_bus_type_cd  IN SET(s.nulls_corp_orig_bus_type_cd,corp_orig_bus_type_cd) OR le.corp_orig_bus_type_cd = (TYPEOF(le.corp_orig_bus_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_bus_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_bus_type_desc_Values := IF ( (le.corp_orig_bus_type_desc  IN SET(s.nulls_corp_orig_bus_type_desc,corp_orig_bus_type_desc) OR le.corp_orig_bus_type_desc = (TYPEOF(le.corp_orig_bus_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_bus_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_entity_desc_Values := IF ( (le.corp_entity_desc  IN SET(s.nulls_corp_entity_desc,corp_entity_desc) OR le.corp_entity_desc = (TYPEOF(le.corp_entity_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_entity_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_certificate_nbr_Values := IF ( (le.corp_certificate_nbr  IN SET(s.nulls_corp_certificate_nbr,corp_certificate_nbr) OR le.corp_certificate_nbr = (TYPEOF(le.corp_certificate_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_certificate_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_internal_nbr_Values := IF ( (le.corp_internal_nbr  IN SET(s.nulls_corp_internal_nbr,corp_internal_nbr) OR le.corp_internal_nbr = (TYPEOF(le.corp_internal_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_internal_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_previous_nbr_Values := IF ( (le.corp_previous_nbr  IN SET(s.nulls_corp_previous_nbr,corp_previous_nbr) OR le.corp_previous_nbr = (TYPEOF(le.corp_previous_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_previous_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_microfilm_nbr_Values := IF ( (le.corp_microfilm_nbr  IN SET(s.nulls_corp_microfilm_nbr,corp_microfilm_nbr) OR le.corp_microfilm_nbr = (TYPEOF(le.corp_microfilm_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_microfilm_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_amendments_filed_Values := IF ( (le.corp_amendments_filed  IN SET(s.nulls_corp_amendments_filed,corp_amendments_filed) OR le.corp_amendments_filed = (TYPEOF(le.corp_amendments_filed))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_amendments_filed)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts_Values := IF ( (le.corp_acts  IN SET(s.nulls_corp_acts,corp_acts) OR le.corp_acts = (TYPEOF(le.corp_acts))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts)}],SALT34.Layout_FieldValueList));
  SELF.corp_partnership_ind_Values := IF ( (le.corp_partnership_ind  IN SET(s.nulls_corp_partnership_ind,corp_partnership_ind) OR le.corp_partnership_ind = (TYPEOF(le.corp_partnership_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partnership_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_mfg_ind_Values := IF ( (le.corp_mfg_ind  IN SET(s.nulls_corp_mfg_ind,corp_mfg_ind) OR le.corp_mfg_ind = (TYPEOF(le.corp_mfg_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_mfg_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_addl_info_Values := IF ( (le.corp_addl_info  IN SET(s.nulls_corp_addl_info,corp_addl_info) OR le.corp_addl_info = (TYPEOF(le.corp_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.corp_taxes_Values := IF ( (le.corp_taxes  IN SET(s.nulls_corp_taxes,corp_taxes) OR le.corp_taxes = (TYPEOF(le.corp_taxes))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_taxes)}],SALT34.Layout_FieldValueList));
  SELF.corp_franchise_taxes_Values := IF ( (le.corp_franchise_taxes  IN SET(s.nulls_corp_franchise_taxes,corp_franchise_taxes) OR le.corp_franchise_taxes = (TYPEOF(le.corp_franchise_taxes))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_franchise_taxes)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_program_cd_Values := IF ( (le.corp_tax_program_cd  IN SET(s.nulls_corp_tax_program_cd,corp_tax_program_cd) OR le.corp_tax_program_cd = (TYPEOF(le.corp_tax_program_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_program_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_program_desc_Values := IF ( (le.corp_tax_program_desc  IN SET(s.nulls_corp_tax_program_desc,corp_tax_program_desc) OR le.corp_tax_program_desc = (TYPEOF(le.corp_tax_program_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_program_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_full_name_Values := IF ( (le.corp_ra_full_name  IN SET(s.nulls_corp_ra_full_name,corp_ra_full_name) OR le.corp_ra_full_name = (TYPEOF(le.corp_ra_full_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_full_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fname_Values := IF ( (le.corp_ra_fname  IN SET(s.nulls_corp_ra_fname,corp_ra_fname) OR le.corp_ra_fname = (TYPEOF(le.corp_ra_fname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_mname_Values := IF ( (le.corp_ra_mname  IN SET(s.nulls_corp_ra_mname,corp_ra_mname) OR le.corp_ra_mname = (TYPEOF(le.corp_ra_mname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_mname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_lname_Values := IF ( (le.corp_ra_lname  IN SET(s.nulls_corp_ra_lname,corp_ra_lname) OR le.corp_ra_lname = (TYPEOF(le.corp_ra_lname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_lname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_suffix_Values := IF ( (le.corp_ra_suffix  IN SET(s.nulls_corp_ra_suffix,corp_ra_suffix) OR le.corp_ra_suffix = (TYPEOF(le.corp_ra_suffix))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_suffix)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_title_cd_Values := IF ( (le.corp_ra_title_cd  IN SET(s.nulls_corp_ra_title_cd,corp_ra_title_cd) OR le.corp_ra_title_cd = (TYPEOF(le.corp_ra_title_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_title_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_title_desc_Values := IF ( (le.corp_ra_title_desc  IN SET(s.nulls_corp_ra_title_desc,corp_ra_title_desc) OR le.corp_ra_title_desc = (TYPEOF(le.corp_ra_title_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_title_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fein_Values := IF ( (le.corp_ra_fein  IN SET(s.nulls_corp_ra_fein,corp_ra_fein) OR le.corp_ra_fein = (TYPEOF(le.corp_ra_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fein)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_ssn_Values := IF ( (le.corp_ra_ssn  IN SET(s.nulls_corp_ra_ssn,corp_ra_ssn) OR le.corp_ra_ssn = (TYPEOF(le.corp_ra_ssn))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_ssn)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_dob_Values := IF ( (le.corp_ra_dob  IN SET(s.nulls_corp_ra_dob,corp_ra_dob) OR le.corp_ra_dob = (TYPEOF(le.corp_ra_dob))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_dob)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_effective_date_Values := IF ( (le.corp_ra_effective_date  IN SET(s.nulls_corp_ra_effective_date,corp_ra_effective_date) OR le.corp_ra_effective_date = (TYPEOF(le.corp_ra_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_resign_date_Values := IF ( (le.corp_ra_resign_date  IN SET(s.nulls_corp_ra_resign_date,corp_ra_resign_date) OR le.corp_ra_resign_date = (TYPEOF(le.corp_ra_resign_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_resign_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_no_comp_Values := IF ( (le.corp_ra_no_comp  IN SET(s.nulls_corp_ra_no_comp,corp_ra_no_comp) OR le.corp_ra_no_comp = (TYPEOF(le.corp_ra_no_comp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_no_comp)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_no_comp_igs_Values := IF ( (le.corp_ra_no_comp_igs  IN SET(s.nulls_corp_ra_no_comp_igs,corp_ra_no_comp_igs) OR le.corp_ra_no_comp_igs = (TYPEOF(le.corp_ra_no_comp_igs))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_no_comp_igs)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_addl_info_Values := IF ( (le.corp_ra_addl_info  IN SET(s.nulls_corp_ra_addl_info,corp_ra_addl_info) OR le.corp_ra_addl_info = (TYPEOF(le.corp_ra_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_type_cd_Values := IF ( (le.corp_ra_address_type_cd  IN SET(s.nulls_corp_ra_address_type_cd,corp_ra_address_type_cd) OR le.corp_ra_address_type_cd = (TYPEOF(le.corp_ra_address_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_type_desc_Values := IF ( (le.corp_ra_address_type_desc  IN SET(s.nulls_corp_ra_address_type_desc,corp_ra_address_type_desc) OR le.corp_ra_address_type_desc = (TYPEOF(le.corp_ra_address_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line1_Values := IF ( (le.corp_ra_address_line1  IN SET(s.nulls_corp_ra_address_line1,corp_ra_address_line1) OR le.corp_ra_address_line1 = (TYPEOF(le.corp_ra_address_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line2_Values := IF ( (le.corp_ra_address_line2  IN SET(s.nulls_corp_ra_address_line2,corp_ra_address_line2) OR le.corp_ra_address_line2 = (TYPEOF(le.corp_ra_address_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line3_Values := IF ( (le.corp_ra_address_line3  IN SET(s.nulls_corp_ra_address_line3,corp_ra_address_line3) OR le.corp_ra_address_line3 = (TYPEOF(le.corp_ra_address_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_Values := IF ( (le.corp_ra_phone_number  IN SET(s.nulls_corp_ra_phone_number,corp_ra_phone_number) OR le.corp_ra_phone_number = (TYPEOF(le.corp_ra_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_type_cd_Values := IF ( (le.corp_ra_phone_number_type_cd  IN SET(s.nulls_corp_ra_phone_number_type_cd,corp_ra_phone_number_type_cd) OR le.corp_ra_phone_number_type_cd = (TYPEOF(le.corp_ra_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_type_desc_Values := IF ( (le.corp_ra_phone_number_type_desc  IN SET(s.nulls_corp_ra_phone_number_type_desc,corp_ra_phone_number_type_desc) OR le.corp_ra_phone_number_type_desc = (TYPEOF(le.corp_ra_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fax_nbr_Values := IF ( (le.corp_ra_fax_nbr  IN SET(s.nulls_corp_ra_fax_nbr,corp_ra_fax_nbr) OR le.corp_ra_fax_nbr = (TYPEOF(le.corp_ra_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_email_address_Values := IF ( (le.corp_ra_email_address  IN SET(s.nulls_corp_ra_email_address,corp_ra_email_address) OR le.corp_ra_email_address = (TYPEOF(le.corp_ra_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_email_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_web_address_Values := IF ( (le.corp_ra_web_address  IN SET(s.nulls_corp_ra_web_address,corp_ra_web_address) OR le.corp_ra_web_address = (TYPEOF(le.corp_ra_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr1_line1_Values := IF ( (le.corp_prep_addr1_line1  IN SET(s.nulls_corp_prep_addr1_line1,corp_prep_addr1_line1) OR le.corp_prep_addr1_line1 = (TYPEOF(le.corp_prep_addr1_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr1_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr1_last_line_Values := IF ( (le.corp_prep_addr1_last_line  IN SET(s.nulls_corp_prep_addr1_last_line,corp_prep_addr1_last_line) OR le.corp_prep_addr1_last_line = (TYPEOF(le.corp_prep_addr1_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr1_last_line)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr2_line1_Values := IF ( (le.corp_prep_addr2_line1  IN SET(s.nulls_corp_prep_addr2_line1,corp_prep_addr2_line1) OR le.corp_prep_addr2_line1 = (TYPEOF(le.corp_prep_addr2_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr2_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr2_last_line_Values := IF ( (le.corp_prep_addr2_last_line  IN SET(s.nulls_corp_prep_addr2_last_line,corp_prep_addr2_last_line) OR le.corp_prep_addr2_last_line = (TYPEOF(le.corp_prep_addr2_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr2_last_line)}],SALT34.Layout_FieldValueList));
  SELF.ra_prep_addr_line1_Values := IF ( (le.ra_prep_addr_line1  IN SET(s.nulls_ra_prep_addr_line1,ra_prep_addr_line1) OR le.ra_prep_addr_line1 = (TYPEOF(le.ra_prep_addr_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.ra_prep_addr_line1)}],SALT34.Layout_FieldValueList));
  SELF.ra_prep_addr_last_line_Values := IF ( (le.ra_prep_addr_last_line  IN SET(s.nulls_ra_prep_addr_last_line,ra_prep_addr_last_line) OR le.ra_prep_addr_last_line = (TYPEOF(le.ra_prep_addr_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.ra_prep_addr_last_line)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_reference_nbr_Values := IF ( (le.cont_filing_reference_nbr  IN SET(s.nulls_cont_filing_reference_nbr,cont_filing_reference_nbr) OR le.cont_filing_reference_nbr = (TYPEOF(le.cont_filing_reference_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_reference_nbr)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_date_Values := IF ( (le.cont_filing_date  IN SET(s.nulls_cont_filing_date,cont_filing_date) OR le.cont_filing_date = (TYPEOF(le.cont_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_cd_Values := IF ( (le.cont_filing_cd  IN SET(s.nulls_cont_filing_cd,cont_filing_cd) OR le.cont_filing_cd = (TYPEOF(le.cont_filing_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_desc_Values := IF ( (le.cont_filing_desc  IN SET(s.nulls_cont_filing_desc,cont_filing_desc) OR le.cont_filing_desc = (TYPEOF(le.cont_filing_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_type_cd_Values := IF ( (le.cont_type_cd  IN SET(s.nulls_cont_type_cd,cont_type_cd) OR le.cont_type_cd = (TYPEOF(le.cont_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_type_desc_Values := IF ( (le.cont_type_desc  IN SET(s.nulls_cont_type_desc,cont_type_desc) OR le.cont_type_desc = (TYPEOF(le.cont_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_full_name_Values := IF ( (le.cont_full_name  IN SET(s.nulls_cont_full_name,cont_full_name) OR le.cont_full_name = (TYPEOF(le.cont_full_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_full_name)}],SALT34.Layout_FieldValueList));
  SELF.cont_fname_Values := IF ( (le.cont_fname  IN SET(s.nulls_cont_fname,cont_fname) OR le.cont_fname = (TYPEOF(le.cont_fname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fname)}],SALT34.Layout_FieldValueList));
  SELF.cont_mname_Values := IF ( (le.cont_mname  IN SET(s.nulls_cont_mname,cont_mname) OR le.cont_mname = (TYPEOF(le.cont_mname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_mname)}],SALT34.Layout_FieldValueList));
  SELF.cont_lname_Values := IF ( (le.cont_lname  IN SET(s.nulls_cont_lname,cont_lname) OR le.cont_lname = (TYPEOF(le.cont_lname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_lname)}],SALT34.Layout_FieldValueList));
  SELF.cont_suffix_Values := IF ( (le.cont_suffix  IN SET(s.nulls_cont_suffix,cont_suffix) OR le.cont_suffix = (TYPEOF(le.cont_suffix))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_suffix)}],SALT34.Layout_FieldValueList));
  SELF.cont_title1_desc_Values := IF ( (le.cont_title1_desc  IN SET(s.nulls_cont_title1_desc,cont_title1_desc) OR le.cont_title1_desc = (TYPEOF(le.cont_title1_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title1_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title2_desc_Values := IF ( (le.cont_title2_desc  IN SET(s.nulls_cont_title2_desc,cont_title2_desc) OR le.cont_title2_desc = (TYPEOF(le.cont_title2_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title2_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title3_desc_Values := IF ( (le.cont_title3_desc  IN SET(s.nulls_cont_title3_desc,cont_title3_desc) OR le.cont_title3_desc = (TYPEOF(le.cont_title3_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title3_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title4_desc_Values := IF ( (le.cont_title4_desc  IN SET(s.nulls_cont_title4_desc,cont_title4_desc) OR le.cont_title4_desc = (TYPEOF(le.cont_title4_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title4_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title5_desc_Values := IF ( (le.cont_title5_desc  IN SET(s.nulls_cont_title5_desc,cont_title5_desc) OR le.cont_title5_desc = (TYPEOF(le.cont_title5_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title5_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_fein_Values := IF ( (le.cont_fein  IN SET(s.nulls_cont_fein,cont_fein) OR le.cont_fein = (TYPEOF(le.cont_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fein)}],SALT34.Layout_FieldValueList));
  SELF.cont_ssn_Values := IF ( (le.cont_ssn  IN SET(s.nulls_cont_ssn,cont_ssn) OR le.cont_ssn = (TYPEOF(le.cont_ssn))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_ssn)}],SALT34.Layout_FieldValueList));
  SELF.cont_dob_Values := IF ( (le.cont_dob  IN SET(s.nulls_cont_dob,cont_dob) OR le.cont_dob = (TYPEOF(le.cont_dob))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_dob)}],SALT34.Layout_FieldValueList));
  SELF.cont_status_cd_Values := IF ( (le.cont_status_cd  IN SET(s.nulls_cont_status_cd,cont_status_cd) OR le.cont_status_cd = (TYPEOF(le.cont_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_status_desc_Values := IF ( (le.cont_status_desc  IN SET(s.nulls_cont_status_desc,cont_status_desc) OR le.cont_status_desc = (TYPEOF(le.cont_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_date_Values := IF ( (le.cont_effective_date  IN SET(s.nulls_cont_effective_date,cont_effective_date) OR le.cont_effective_date = (TYPEOF(le.cont_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_cd_Values := IF ( (le.cont_effective_cd  IN SET(s.nulls_cont_effective_cd,cont_effective_cd) OR le.cont_effective_cd = (TYPEOF(le.cont_effective_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_desc_Values := IF ( (le.cont_effective_desc  IN SET(s.nulls_cont_effective_desc,cont_effective_desc) OR le.cont_effective_desc = (TYPEOF(le.cont_effective_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_addl_info_Values := IF ( (le.cont_addl_info  IN SET(s.nulls_cont_addl_info,cont_addl_info) OR le.cont_addl_info = (TYPEOF(le.cont_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_type_cd_Values := IF ( (le.cont_address_type_cd  IN SET(s.nulls_cont_address_type_cd,cont_address_type_cd) OR le.cont_address_type_cd = (TYPEOF(le.cont_address_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_type_desc_Values := IF ( (le.cont_address_type_desc  IN SET(s.nulls_cont_address_type_desc,cont_address_type_desc) OR le.cont_address_type_desc = (TYPEOF(le.cont_address_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line1_Values := IF ( (le.cont_address_line1  IN SET(s.nulls_cont_address_line1,cont_address_line1) OR le.cont_address_line1 = (TYPEOF(le.cont_address_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line1)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line2_Values := IF ( (le.cont_address_line2  IN SET(s.nulls_cont_address_line2,cont_address_line2) OR le.cont_address_line2 = (TYPEOF(le.cont_address_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line2)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line3_Values := IF ( (le.cont_address_line3  IN SET(s.nulls_cont_address_line3,cont_address_line3) OR le.cont_address_line3 = (TYPEOF(le.cont_address_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line3)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_effective_date_Values := IF ( (le.cont_address_effective_date  IN SET(s.nulls_cont_address_effective_date,cont_address_effective_date) OR le.cont_address_effective_date = (TYPEOF(le.cont_address_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_county_Values := IF ( (le.cont_address_county  IN SET(s.nulls_cont_address_county,cont_address_county) OR le.cont_address_county = (TYPEOF(le.cont_address_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_county)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_Values := IF ( (le.cont_phone_number  IN SET(s.nulls_cont_phone_number,cont_phone_number) OR le.cont_phone_number = (TYPEOF(le.cont_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_type_cd_Values := IF ( (le.cont_phone_number_type_cd  IN SET(s.nulls_cont_phone_number_type_cd,cont_phone_number_type_cd) OR le.cont_phone_number_type_cd = (TYPEOF(le.cont_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_type_desc_Values := IF ( (le.cont_phone_number_type_desc  IN SET(s.nulls_cont_phone_number_type_desc,cont_phone_number_type_desc) OR le.cont_phone_number_type_desc = (TYPEOF(le.cont_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_fax_nbr_Values := IF ( (le.cont_fax_nbr  IN SET(s.nulls_cont_fax_nbr,cont_fax_nbr) OR le.cont_fax_nbr = (TYPEOF(le.cont_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.cont_email_address_Values := IF ( (le.cont_email_address  IN SET(s.nulls_cont_email_address,cont_email_address) OR le.cont_email_address = (TYPEOF(le.cont_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_email_address)}],SALT34.Layout_FieldValueList));
  SELF.cont_web_address_Values := IF ( (le.cont_web_address  IN SET(s.nulls_cont_web_address,cont_web_address) OR le.cont_web_address = (TYPEOF(le.cont_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_acres_Values := IF ( (le.corp_acres  IN SET(s.nulls_corp_acres,corp_acres) OR le.corp_acres = (TYPEOF(le.corp_acres))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acres)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_Values := IF ( (le.corp_action  IN SET(s.nulls_corp_action,corp_action) OR le.corp_action = (TYPEOF(le.corp_action))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_date_Values := IF ( (le.corp_action_date  IN SET(s.nulls_corp_action_date,corp_action_date) OR le.corp_action_date = (TYPEOF(le.corp_action_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_employment_security_approval_date_Values := IF ( (le.corp_action_employment_security_approval_date  IN SET(s.nulls_corp_action_employment_security_approval_date,corp_action_employment_security_approval_date) OR le.corp_action_employment_security_approval_date = (TYPEOF(le.corp_action_employment_security_approval_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_employment_security_approval_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_pending_cd_Values := IF ( (le.corp_action_pending_cd  IN SET(s.nulls_corp_action_pending_cd,corp_action_pending_cd) OR le.corp_action_pending_cd = (TYPEOF(le.corp_action_pending_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_pending_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_pending_desc_Values := IF ( (le.corp_action_pending_desc  IN SET(s.nulls_corp_action_pending_desc,corp_action_pending_desc) OR le.corp_action_pending_desc = (TYPEOF(le.corp_action_pending_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_pending_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_statement_of_intent_date_Values := IF ( (le.corp_action_statement_of_intent_date  IN SET(s.nulls_corp_action_statement_of_intent_date,corp_action_statement_of_intent_date) OR le.corp_action_statement_of_intent_date = (TYPEOF(le.corp_action_statement_of_intent_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_statement_of_intent_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_tax_dept_approval_date_Values := IF ( (le.corp_action_tax_dept_approval_date  IN SET(s.nulls_corp_action_tax_dept_approval_date,corp_action_tax_dept_approval_date) OR le.corp_action_tax_dept_approval_date = (TYPEOF(le.corp_action_tax_dept_approval_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_tax_dept_approval_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts2_Values := IF ( (le.corp_acts2  IN SET(s.nulls_corp_acts2,corp_acts2) OR le.corp_acts2 = (TYPEOF(le.corp_acts2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts2)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts3_Values := IF ( (le.corp_acts3  IN SET(s.nulls_corp_acts3,corp_acts3) OR le.corp_acts3 = (TYPEOF(le.corp_acts3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts3)}],SALT34.Layout_FieldValueList));
  SELF.corp_additional_principals_Values := IF ( (le.corp_additional_principals  IN SET(s.nulls_corp_additional_principals,corp_additional_principals) OR le.corp_additional_principals = (TYPEOF(le.corp_additional_principals))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_additional_principals)}],SALT34.Layout_FieldValueList));
  SELF.corp_address_office_type_Values := IF ( (le.corp_address_office_type  IN SET(s.nulls_corp_address_office_type,corp_address_office_type) OR le.corp_address_office_type = (TYPEOF(le.corp_address_office_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address_office_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_assign_date_Values := IF ( (le.corp_agent_assign_date  IN SET(s.nulls_corp_agent_assign_date,corp_agent_assign_date) OR le.corp_agent_assign_date = (TYPEOF(le.corp_agent_assign_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_assign_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_commercial_Values := IF ( (le.corp_agent_commercial  IN SET(s.nulls_corp_agent_commercial,corp_agent_commercial) OR le.corp_agent_commercial = (TYPEOF(le.corp_agent_commercial))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_commercial)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_country_Values := IF ( (le.corp_agent_country  IN SET(s.nulls_corp_agent_country,corp_agent_country) OR le.corp_agent_country = (TYPEOF(le.corp_agent_country))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_country)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_county_Values := IF ( (le.corp_agent_county  IN SET(s.nulls_corp_agent_county,corp_agent_county) OR le.corp_agent_county = (TYPEOF(le.corp_agent_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_status_cd_Values := IF ( (le.corp_agent_status_cd  IN SET(s.nulls_corp_agent_status_cd,corp_agent_status_cd) OR le.corp_agent_status_cd = (TYPEOF(le.corp_agent_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_status_desc_Values := IF ( (le.corp_agent_status_desc  IN SET(s.nulls_corp_agent_status_desc,corp_agent_status_desc) OR le.corp_agent_status_desc = (TYPEOF(le.corp_agent_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_id_Values := IF ( (le.corp_agent_id  IN SET(s.nulls_corp_agent_id,corp_agent_id) OR le.corp_agent_id = (TYPEOF(le.corp_agent_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_agriculture_flag_Values := IF ( (le.corp_agriculture_flag  IN SET(s.nulls_corp_agriculture_flag,corp_agriculture_flag) OR le.corp_agriculture_flag = (TYPEOF(le.corp_agriculture_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agriculture_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_authorized_partners_Values := IF ( (le.corp_authorized_partners  IN SET(s.nulls_corp_authorized_partners,corp_authorized_partners) OR le.corp_authorized_partners = (TYPEOF(le.corp_authorized_partners))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_authorized_partners)}],SALT34.Layout_FieldValueList));
  SELF.corp_comment_Values := IF ( (le.corp_comment  IN SET(s.nulls_corp_comment,corp_comment) OR le.corp_comment = (TYPEOF(le.corp_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_consent_flag_for_protected_name_Values := IF ( (le.corp_consent_flag_for_protected_name  IN SET(s.nulls_corp_consent_flag_for_protected_name,corp_consent_flag_for_protected_name) OR le.corp_consent_flag_for_protected_name = (TYPEOF(le.corp_consent_flag_for_protected_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_consent_flag_for_protected_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_converted_Values := IF ( (le.corp_converted  IN SET(s.nulls_corp_converted,corp_converted) OR le.corp_converted = (TYPEOF(le.corp_converted))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_converted)}],SALT34.Layout_FieldValueList));
  SELF.corp_converted_from_Values := IF ( (le.corp_converted_from  IN SET(s.nulls_corp_converted_from,corp_converted_from) OR le.corp_converted_from = (TYPEOF(le.corp_converted_from))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_converted_from)}],SALT34.Layout_FieldValueList));
  SELF.corp_country_of_formation_Values := IF ( (le.corp_country_of_formation  IN SET(s.nulls_corp_country_of_formation,corp_country_of_formation) OR le.corp_country_of_formation = (TYPEOF(le.corp_country_of_formation))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_country_of_formation)}],SALT34.Layout_FieldValueList));
  SELF.corp_date_of_organization_meeting_Values := IF ( (le.corp_date_of_organization_meeting  IN SET(s.nulls_corp_date_of_organization_meeting,corp_date_of_organization_meeting) OR le.corp_date_of_organization_meeting = (TYPEOF(le.corp_date_of_organization_meeting))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_date_of_organization_meeting)}],SALT34.Layout_FieldValueList));
  SELF.corp_delayed_effective_date_Values := IF ( (le.corp_delayed_effective_date  IN SET(s.nulls_corp_delayed_effective_date,corp_delayed_effective_date) OR le.corp_delayed_effective_date = (TYPEOF(le.corp_delayed_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_delayed_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_directors_from_to_Values := IF ( (le.corp_directors_from_to  IN SET(s.nulls_corp_directors_from_to,corp_directors_from_to) OR le.corp_directors_from_to = (TYPEOF(le.corp_directors_from_to))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_directors_from_to)}],SALT34.Layout_FieldValueList));
  SELF.corp_dissolved_date_Values := IF ( (le.corp_dissolved_date  IN SET(s.nulls_corp_dissolved_date,corp_dissolved_date) OR le.corp_dissolved_date = (TYPEOF(le.corp_dissolved_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_dissolved_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_exemptions_Values := IF ( (le.corp_farm_exemptions  IN SET(s.nulls_corp_farm_exemptions,corp_farm_exemptions) OR le.corp_farm_exemptions = (TYPEOF(le.corp_farm_exemptions))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_exemptions)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_qual_date_Values := IF ( (le.corp_farm_qual_date  IN SET(s.nulls_corp_farm_qual_date,corp_farm_qual_date) OR le.corp_farm_qual_date = (TYPEOF(le.corp_farm_qual_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_qual_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_status_cd_Values := IF ( (le.corp_farm_status_cd  IN SET(s.nulls_corp_farm_status_cd,corp_farm_status_cd) OR le.corp_farm_status_cd = (TYPEOF(le.corp_farm_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_status_desc_Values := IF ( (le.corp_farm_status_desc  IN SET(s.nulls_corp_farm_status_desc,corp_farm_status_desc) OR le.corp_farm_status_desc = (TYPEOF(le.corp_farm_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_fiscal_year_month_Values := IF ( (le.corp_fiscal_year_month  IN SET(s.nulls_corp_fiscal_year_month,corp_fiscal_year_month) OR le.corp_fiscal_year_month = (TYPEOF(le.corp_fiscal_year_month))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fiscal_year_month)}],SALT34.Layout_FieldValueList));
  SELF.corp_foreign_fiduciary_capacity_in_state_Values := IF ( (le.corp_foreign_fiduciary_capacity_in_state  IN SET(s.nulls_corp_foreign_fiduciary_capacity_in_state,corp_foreign_fiduciary_capacity_in_state) OR le.corp_foreign_fiduciary_capacity_in_state = (TYPEOF(le.corp_foreign_fiduciary_capacity_in_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_foreign_fiduciary_capacity_in_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_governing_statute_Values := IF ( (le.corp_governing_statute  IN SET(s.nulls_corp_governing_statute,corp_governing_statute) OR le.corp_governing_statute = (TYPEOF(le.corp_governing_statute))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_governing_statute)}],SALT34.Layout_FieldValueList));
  SELF.corp_has_members_Values := IF ( (le.corp_has_members  IN SET(s.nulls_corp_has_members,corp_has_members) OR le.corp_has_members = (TYPEOF(le.corp_has_members))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_has_members)}],SALT34.Layout_FieldValueList));
  SELF.corp_has_vested_managers_Values := IF ( (le.corp_has_vested_managers  IN SET(s.nulls_corp_has_vested_managers,corp_has_vested_managers) OR le.corp_has_vested_managers = (TYPEOF(le.corp_has_vested_managers))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_has_vested_managers)}],SALT34.Layout_FieldValueList));
  SELF.corp_home_incorporated_county_Values := IF ( (le.corp_home_incorporated_county  IN SET(s.nulls_corp_home_incorporated_county,corp_home_incorporated_county) OR le.corp_home_incorporated_county = (TYPEOF(le.corp_home_incorporated_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_home_incorporated_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_home_state_name_Values := IF ( (le.corp_home_state_name  IN SET(s.nulls_corp_home_state_name,corp_home_state_name) OR le.corp_home_state_name = (TYPEOF(le.corp_home_state_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_home_state_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_is_professional_Values := IF ( (le.corp_is_professional  IN SET(s.nulls_corp_is_professional,corp_is_professional) OR le.corp_is_professional = (TYPEOF(le.corp_is_professional))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_is_professional)}],SALT34.Layout_FieldValueList));
  SELF.corp_is_non_profit_irs_approved_Values := IF ( (le.corp_is_non_profit_irs_approved  IN SET(s.nulls_corp_is_non_profit_irs_approved,corp_is_non_profit_irs_approved) OR le.corp_is_non_profit_irs_approved = (TYPEOF(le.corp_is_non_profit_irs_approved))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_is_non_profit_irs_approved)}],SALT34.Layout_FieldValueList));
  SELF.corp_last_renewal_date_Values := IF ( (le.corp_last_renewal_date  IN SET(s.nulls_corp_last_renewal_date,corp_last_renewal_date) OR le.corp_last_renewal_date = (TYPEOF(le.corp_last_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_last_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_last_renewal_year_Values := IF ( (le.corp_last_renewal_year  IN SET(s.nulls_corp_last_renewal_year,corp_last_renewal_year) OR le.corp_last_renewal_year = (TYPEOF(le.corp_last_renewal_year))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_last_renewal_year)}],SALT34.Layout_FieldValueList));
  SELF.corp_license_type_Values := IF ( (le.corp_license_type  IN SET(s.nulls_corp_license_type,corp_license_type) OR le.corp_license_type = (TYPEOF(le.corp_license_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_license_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_llc_managed_desc_Values := IF ( (le.corp_llc_managed_desc  IN SET(s.nulls_corp_llc_managed_desc,corp_llc_managed_desc) OR le.corp_llc_managed_desc = (TYPEOF(le.corp_llc_managed_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_llc_managed_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_llc_managed_ind_Values := IF ( (le.corp_llc_managed_ind  IN SET(s.nulls_corp_llc_managed_ind,corp_llc_managed_ind) OR le.corp_llc_managed_ind = (TYPEOF(le.corp_llc_managed_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_llc_managed_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_management_desc_Values := IF ( (le.corp_management_desc  IN SET(s.nulls_corp_management_desc,corp_management_desc) OR le.corp_management_desc = (TYPEOF(le.corp_management_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_management_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_management_type_Values := IF ( (le.corp_management_type  IN SET(s.nulls_corp_management_type,corp_management_type) OR le.corp_management_type = (TYPEOF(le.corp_management_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_management_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_manager_managed_Values := IF ( (le.corp_manager_managed  IN SET(s.nulls_corp_manager_managed,corp_manager_managed) OR le.corp_manager_managed = (TYPEOF(le.corp_manager_managed))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_manager_managed)}],SALT34.Layout_FieldValueList));
  SELF.corp_merged_corporation_id_Values := IF ( (le.corp_merged_corporation_id  IN SET(s.nulls_corp_merged_corporation_id,corp_merged_corporation_id) OR le.corp_merged_corporation_id = (TYPEOF(le.corp_merged_corporation_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merged_corporation_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_merged_fein_Values := IF ( (le.corp_merged_fein  IN SET(s.nulls_corp_merged_fein,corp_merged_fein) OR le.corp_merged_fein = (TYPEOF(le.corp_merged_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merged_fein)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_allowed_flag_Values := IF ( (le.corp_merger_allowed_flag  IN SET(s.nulls_corp_merger_allowed_flag,corp_merger_allowed_flag) OR le.corp_merger_allowed_flag = (TYPEOF(le.corp_merger_allowed_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_allowed_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_date_Values := IF ( (le.corp_merger_date  IN SET(s.nulls_corp_merger_date,corp_merger_date) OR le.corp_merger_date = (TYPEOF(le.corp_merger_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_desc_Values := IF ( (le.corp_merger_desc  IN SET(s.nulls_corp_merger_desc,corp_merger_desc) OR le.corp_merger_desc = (TYPEOF(le.corp_merger_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_effective_date_Values := IF ( (le.corp_merger_effective_date  IN SET(s.nulls_corp_merger_effective_date,corp_merger_effective_date) OR le.corp_merger_effective_date = (TYPEOF(le.corp_merger_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_id_Values := IF ( (le.corp_merger_id  IN SET(s.nulls_corp_merger_id,corp_merger_id) OR le.corp_merger_id = (TYPEOF(le.corp_merger_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_indicator_Values := IF ( (le.corp_merger_indicator  IN SET(s.nulls_corp_merger_indicator,corp_merger_indicator) OR le.corp_merger_indicator = (TYPEOF(le.corp_merger_indicator))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_indicator)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_name_Values := IF ( (le.corp_merger_name  IN SET(s.nulls_corp_merger_name,corp_merger_name) OR le.corp_merger_name = (TYPEOF(le.corp_merger_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_type_converted_to_cd_Values := IF ( (le.corp_merger_type_converted_to_cd  IN SET(s.nulls_corp_merger_type_converted_to_cd,corp_merger_type_converted_to_cd) OR le.corp_merger_type_converted_to_cd = (TYPEOF(le.corp_merger_type_converted_to_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_type_converted_to_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_type_converted_to_desc_Values := IF ( (le.corp_merger_type_converted_to_desc  IN SET(s.nulls_corp_merger_type_converted_to_desc,corp_merger_type_converted_to_desc) OR le.corp_merger_type_converted_to_desc = (TYPEOF(le.corp_merger_type_converted_to_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_type_converted_to_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_naics_desc_Values := IF ( (le.corp_naics_desc  IN SET(s.nulls_corp_naics_desc,corp_naics_desc) OR le.corp_naics_desc = (TYPEOF(le.corp_naics_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_naics_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_effective_date_Values := IF ( (le.corp_name_effective_date  IN SET(s.nulls_corp_name_effective_date,corp_name_effective_date) OR le.corp_name_effective_date = (TYPEOF(le.corp_name_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_date_Values := IF ( (le.corp_name_reservation_date  IN SET(s.nulls_corp_name_reservation_date,corp_name_reservation_date) OR le.corp_name_reservation_date = (TYPEOF(le.corp_name_reservation_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_desc_Values := IF ( (le.corp_name_reservation_desc  IN SET(s.nulls_corp_name_reservation_desc,corp_name_reservation_desc) OR le.corp_name_reservation_desc = (TYPEOF(le.corp_name_reservation_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_expiration_date_Values := IF ( (le.corp_name_reservation_expiration_date  IN SET(s.nulls_corp_name_reservation_expiration_date,corp_name_reservation_expiration_date) OR le.corp_name_reservation_expiration_date = (TYPEOF(le.corp_name_reservation_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_nbr_Values := IF ( (le.corp_name_reservation_nbr  IN SET(s.nulls_corp_name_reservation_nbr,corp_name_reservation_nbr) OR le.corp_name_reservation_nbr = (TYPEOF(le.corp_name_reservation_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_type_Values := IF ( (le.corp_name_reservation_type  IN SET(s.nulls_corp_name_reservation_type,corp_name_reservation_type) OR le.corp_name_reservation_type = (TYPEOF(le.corp_name_reservation_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_cd_Values := IF ( (le.corp_name_status_cd  IN SET(s.nulls_corp_name_status_cd,corp_name_status_cd) OR le.corp_name_status_cd = (TYPEOF(le.corp_name_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_date_Values := IF ( (le.corp_name_status_date  IN SET(s.nulls_corp_name_status_date,corp_name_status_date) OR le.corp_name_status_date = (TYPEOF(le.corp_name_status_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_desc_Values := IF ( (le.corp_name_status_desc  IN SET(s.nulls_corp_name_status_desc,corp_name_status_desc) OR le.corp_name_status_desc = (TYPEOF(le.corp_name_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_non_profit_irs_approved_purpose_Values := IF ( (le.corp_non_profit_irs_approved_purpose  IN SET(s.nulls_corp_non_profit_irs_approved_purpose,corp_non_profit_irs_approved_purpose) OR le.corp_non_profit_irs_approved_purpose = (TYPEOF(le.corp_non_profit_irs_approved_purpose))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_non_profit_irs_approved_purpose)}],SALT34.Layout_FieldValueList));
  SELF.corp_non_profit_solicit_donations_Values := IF ( (le.corp_non_profit_solicit_donations  IN SET(s.nulls_corp_non_profit_solicit_donations,corp_non_profit_solicit_donations) OR le.corp_non_profit_solicit_donations = (TYPEOF(le.corp_non_profit_solicit_donations))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_non_profit_solicit_donations)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_amendments_Values := IF ( (le.corp_nbr_of_amendments  IN SET(s.nulls_corp_nbr_of_amendments,corp_nbr_of_amendments) OR le.corp_nbr_of_amendments = (TYPEOF(le.corp_nbr_of_amendments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_amendments)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_initial_llc_members_Values := IF ( (le.corp_nbr_of_initial_llc_members  IN SET(s.nulls_corp_nbr_of_initial_llc_members,corp_nbr_of_initial_llc_members) OR le.corp_nbr_of_initial_llc_members = (TYPEOF(le.corp_nbr_of_initial_llc_members))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_initial_llc_members)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_partners_Values := IF ( (le.corp_nbr_of_partners  IN SET(s.nulls_corp_nbr_of_partners,corp_nbr_of_partners) OR le.corp_nbr_of_partners = (TYPEOF(le.corp_nbr_of_partners))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_partners)}],SALT34.Layout_FieldValueList));
  SELF.corp_operating_agreement_Values := IF ( (le.corp_operating_agreement  IN SET(s.nulls_corp_operating_agreement,corp_operating_agreement) OR le.corp_operating_agreement = (TYPEOF(le.corp_operating_agreement))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_operating_agreement)}],SALT34.Layout_FieldValueList));
  SELF.corp_opt_in_llc_act_desc_Values := IF ( (le.corp_opt_in_llc_act_desc  IN SET(s.nulls_corp_opt_in_llc_act_desc,corp_opt_in_llc_act_desc) OR le.corp_opt_in_llc_act_desc = (TYPEOF(le.corp_opt_in_llc_act_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_opt_in_llc_act_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_opt_in_llc_act_ind_Values := IF ( (le.corp_opt_in_llc_act_ind  IN SET(s.nulls_corp_opt_in_llc_act_ind,corp_opt_in_llc_act_ind) OR le.corp_opt_in_llc_act_ind = (TYPEOF(le.corp_opt_in_llc_act_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_opt_in_llc_act_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_organizational_comments_Values := IF ( (le.corp_organizational_comments  IN SET(s.nulls_corp_organizational_comments,corp_organizational_comments) OR le.corp_organizational_comments = (TYPEOF(le.corp_organizational_comments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_organizational_comments)}],SALT34.Layout_FieldValueList));
  SELF.corp_partner_contributions_total_Values := IF ( (le.corp_partner_contributions_total  IN SET(s.nulls_corp_partner_contributions_total,corp_partner_contributions_total) OR le.corp_partner_contributions_total = (TYPEOF(le.corp_partner_contributions_total))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partner_contributions_total)}],SALT34.Layout_FieldValueList));
  SELF.corp_partner_terms_Values := IF ( (le.corp_partner_terms  IN SET(s.nulls_corp_partner_terms,corp_partner_terms) OR le.corp_partner_terms = (TYPEOF(le.corp_partner_terms))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partner_terms)}],SALT34.Layout_FieldValueList));
  SELF.corp_percentage_voters_required_to_approve_amendments_Values := IF ( (le.corp_percentage_voters_required_to_approve_amendments  IN SET(s.nulls_corp_percentage_voters_required_to_approve_amendments,corp_percentage_voters_required_to_approve_amendments) OR le.corp_percentage_voters_required_to_approve_amendments = (TYPEOF(le.corp_percentage_voters_required_to_approve_amendments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_percentage_voters_required_to_approve_amendments)}],SALT34.Layout_FieldValueList));
  SELF.corp_profession_Values := IF ( (le.corp_profession  IN SET(s.nulls_corp_profession,corp_profession) OR le.corp_profession = (TYPEOF(le.corp_profession))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_profession)}],SALT34.Layout_FieldValueList));
  SELF.corp_province_Values := IF ( (le.corp_province  IN SET(s.nulls_corp_province,corp_province) OR le.corp_province = (TYPEOF(le.corp_province))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_province)}],SALT34.Layout_FieldValueList));
  SELF.corp_public_mutual_corporation_Values := IF ( (le.corp_public_mutual_corporation  IN SET(s.nulls_corp_public_mutual_corporation,corp_public_mutual_corporation) OR le.corp_public_mutual_corporation = (TYPEOF(le.corp_public_mutual_corporation))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_public_mutual_corporation)}],SALT34.Layout_FieldValueList));
  SELF.corp_purpose_Values := IF ( (le.corp_purpose  IN SET(s.nulls_corp_purpose,corp_purpose) OR le.corp_purpose = (TYPEOF(le.corp_purpose))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_purpose)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_required_flag_Values := IF ( (le.corp_ra_required_flag  IN SET(s.nulls_corp_ra_required_flag,corp_ra_required_flag) OR le.corp_ra_required_flag = (TYPEOF(le.corp_ra_required_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_required_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_registered_counties_Values := IF ( (le.corp_registered_counties  IN SET(s.nulls_corp_registered_counties,corp_registered_counties) OR le.corp_registered_counties = (TYPEOF(le.corp_registered_counties))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_registered_counties)}],SALT34.Layout_FieldValueList));
  SELF.corp_regulated_ind_Values := IF ( (le.corp_regulated_ind  IN SET(s.nulls_corp_regulated_ind,corp_regulated_ind) OR le.corp_regulated_ind = (TYPEOF(le.corp_regulated_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_regulated_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_renewal_date_Values := IF ( (le.corp_renewal_date  IN SET(s.nulls_corp_renewal_date,corp_renewal_date) OR le.corp_renewal_date = (TYPEOF(le.corp_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_standing_other_Values := IF ( (le.corp_standing_other  IN SET(s.nulls_corp_standing_other,corp_standing_other) OR le.corp_standing_other = (TYPEOF(le.corp_standing_other))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_standing_other)}],SALT34.Layout_FieldValueList));
  SELF.corp_survivor_corporation_id_Values := IF ( (le.corp_survivor_corporation_id  IN SET(s.nulls_corp_survivor_corporation_id,corp_survivor_corporation_id) OR le.corp_survivor_corporation_id = (TYPEOF(le.corp_survivor_corporation_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_survivor_corporation_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_base_Values := IF ( (le.corp_tax_base  IN SET(s.nulls_corp_tax_base,corp_tax_base) OR le.corp_tax_base = (TYPEOF(le.corp_tax_base))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_base)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_standing_Values := IF ( (le.corp_tax_standing  IN SET(s.nulls_corp_tax_standing,corp_tax_standing) OR le.corp_tax_standing = (TYPEOF(le.corp_tax_standing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_standing)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_cd_Values := IF ( (le.corp_termination_cd  IN SET(s.nulls_corp_termination_cd,corp_termination_cd) OR le.corp_termination_cd = (TYPEOF(le.corp_termination_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_desc_Values := IF ( (le.corp_termination_desc  IN SET(s.nulls_corp_termination_desc,corp_termination_desc) OR le.corp_termination_desc = (TYPEOF(le.corp_termination_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_date_Values := IF ( (le.corp_termination_date  IN SET(s.nulls_corp_termination_date,corp_termination_date) OR le.corp_termination_date = (TYPEOF(le.corp_termination_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_business_mark_type_Values := IF ( (le.corp_trademark_business_mark_type  IN SET(s.nulls_corp_trademark_business_mark_type,corp_trademark_business_mark_type) OR le.corp_trademark_business_mark_type = (TYPEOF(le.corp_trademark_business_mark_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_business_mark_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_cancelled_date_Values := IF ( (le.corp_trademark_cancelled_date  IN SET(s.nulls_corp_trademark_cancelled_date,corp_trademark_cancelled_date) OR le.corp_trademark_cancelled_date = (TYPEOF(le.corp_trademark_cancelled_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_cancelled_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc1_Values := IF ( (le.corp_trademark_class_desc1  IN SET(s.nulls_corp_trademark_class_desc1,corp_trademark_class_desc1) OR le.corp_trademark_class_desc1 = (TYPEOF(le.corp_trademark_class_desc1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc2_Values := IF ( (le.corp_trademark_class_desc2  IN SET(s.nulls_corp_trademark_class_desc2,corp_trademark_class_desc2) OR le.corp_trademark_class_desc2 = (TYPEOF(le.corp_trademark_class_desc2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc3_Values := IF ( (le.corp_trademark_class_desc3  IN SET(s.nulls_corp_trademark_class_desc3,corp_trademark_class_desc3) OR le.corp_trademark_class_desc3 = (TYPEOF(le.corp_trademark_class_desc3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc3)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc4_Values := IF ( (le.corp_trademark_class_desc4  IN SET(s.nulls_corp_trademark_class_desc4,corp_trademark_class_desc4) OR le.corp_trademark_class_desc4 = (TYPEOF(le.corp_trademark_class_desc4))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc4)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc5_Values := IF ( (le.corp_trademark_class_desc5  IN SET(s.nulls_corp_trademark_class_desc5,corp_trademark_class_desc5) OR le.corp_trademark_class_desc5 = (TYPEOF(le.corp_trademark_class_desc5))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc5)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc6_Values := IF ( (le.corp_trademark_class_desc6  IN SET(s.nulls_corp_trademark_class_desc6,corp_trademark_class_desc6) OR le.corp_trademark_class_desc6 = (TYPEOF(le.corp_trademark_class_desc6))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc6)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_classification_nbr_Values := IF ( (le.corp_trademark_classification_nbr  IN SET(s.nulls_corp_trademark_classification_nbr,corp_trademark_classification_nbr) OR le.corp_trademark_classification_nbr = (TYPEOF(le.corp_trademark_classification_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_classification_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_disclaimer1_Values := IF ( (le.corp_trademark_disclaimer1  IN SET(s.nulls_corp_trademark_disclaimer1,corp_trademark_disclaimer1) OR le.corp_trademark_disclaimer1 = (TYPEOF(le.corp_trademark_disclaimer1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_disclaimer1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_disclaimer2_Values := IF ( (le.corp_trademark_disclaimer2  IN SET(s.nulls_corp_trademark_disclaimer2,corp_trademark_disclaimer2) OR le.corp_trademark_disclaimer2 = (TYPEOF(le.corp_trademark_disclaimer2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_disclaimer2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_expiration_date_Values := IF ( (le.corp_trademark_expiration_date  IN SET(s.nulls_corp_trademark_expiration_date,corp_trademark_expiration_date) OR le.corp_trademark_expiration_date = (TYPEOF(le.corp_trademark_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_filing_date_Values := IF ( (le.corp_trademark_filing_date  IN SET(s.nulls_corp_trademark_filing_date,corp_trademark_filing_date) OR le.corp_trademark_filing_date = (TYPEOF(le.corp_trademark_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_first_use_date_Values := IF ( (le.corp_trademark_first_use_date  IN SET(s.nulls_corp_trademark_first_use_date,corp_trademark_first_use_date) OR le.corp_trademark_first_use_date = (TYPEOF(le.corp_trademark_first_use_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_first_use_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_first_use_date_in_state_Values := IF ( (le.corp_trademark_first_use_date_in_state  IN SET(s.nulls_corp_trademark_first_use_date_in_state,corp_trademark_first_use_date_in_state) OR le.corp_trademark_first_use_date_in_state = (TYPEOF(le.corp_trademark_first_use_date_in_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_first_use_date_in_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_keywords_Values := IF ( (le.corp_trademark_keywords  IN SET(s.nulls_corp_trademark_keywords,corp_trademark_keywords) OR le.corp_trademark_keywords = (TYPEOF(le.corp_trademark_keywords))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_keywords)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_logo_Values := IF ( (le.corp_trademark_logo  IN SET(s.nulls_corp_trademark_logo,corp_trademark_logo) OR le.corp_trademark_logo = (TYPEOF(le.corp_trademark_logo))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_logo)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_name_expiration_date_Values := IF ( (le.corp_trademark_name_expiration_date  IN SET(s.nulls_corp_trademark_name_expiration_date,corp_trademark_name_expiration_date) OR le.corp_trademark_name_expiration_date = (TYPEOF(le.corp_trademark_name_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_name_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_nbr_Values := IF ( (le.corp_trademark_nbr  IN SET(s.nulls_corp_trademark_nbr,corp_trademark_nbr) OR le.corp_trademark_nbr = (TYPEOF(le.corp_trademark_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_renewal_date_Values := IF ( (le.corp_trademark_renewal_date  IN SET(s.nulls_corp_trademark_renewal_date,corp_trademark_renewal_date) OR le.corp_trademark_renewal_date = (TYPEOF(le.corp_trademark_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_status_Values := IF ( (le.corp_trademark_status  IN SET(s.nulls_corp_trademark_status,corp_trademark_status) OR le.corp_trademark_status = (TYPEOF(le.corp_trademark_status))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_status)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_1_Values := IF ( (le.corp_trademark_used_1  IN SET(s.nulls_corp_trademark_used_1,corp_trademark_used_1) OR le.corp_trademark_used_1 = (TYPEOF(le.corp_trademark_used_1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_2_Values := IF ( (le.corp_trademark_used_2  IN SET(s.nulls_corp_trademark_used_2,corp_trademark_used_2) OR le.corp_trademark_used_2 = (TYPEOF(le.corp_trademark_used_2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_3_Values := IF ( (le.corp_trademark_used_3  IN SET(s.nulls_corp_trademark_used_3,corp_trademark_used_3) OR le.corp_trademark_used_3 = (TYPEOF(le.corp_trademark_used_3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_3)}],SALT34.Layout_FieldValueList));
  SELF.cont_owner_percentage_Values := IF ( (le.cont_owner_percentage  IN SET(s.nulls_cont_owner_percentage,cont_owner_percentage) OR le.cont_owner_percentage = (TYPEOF(le.cont_owner_percentage))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_owner_percentage)}],SALT34.Layout_FieldValueList));
  SELF.cont_country_Values := IF ( (le.cont_country  IN SET(s.nulls_cont_country,cont_country) OR le.cont_country = (TYPEOF(le.cont_country))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_country)}],SALT34.Layout_FieldValueList));
  SELF.cont_country_mailing_Values := IF ( (le.cont_country_mailing  IN SET(s.nulls_cont_country_mailing,cont_country_mailing) OR le.cont_country_mailing = (TYPEOF(le.cont_country_mailing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_country_mailing)}],SALT34.Layout_FieldValueList));
  SELF.cont_nondislosure_Values := IF ( (le.cont_nondislosure  IN SET(s.nulls_cont_nondislosure,cont_nondislosure) OR le.cont_nondislosure = (TYPEOF(le.cont_nondislosure))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_nondislosure)}],SALT34.Layout_FieldValueList));
  SELF.cont_prep_addr_line1_Values := IF ( (le.cont_prep_addr_line1  IN SET(s.nulls_cont_prep_addr_line1,cont_prep_addr_line1) OR le.cont_prep_addr_line1 = (TYPEOF(le.cont_prep_addr_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_prep_addr_line1)}],SALT34.Layout_FieldValueList));
  SELF.cont_prep_addr_last_line_Values := IF ( (le.cont_prep_addr_last_line  IN SET(s.nulls_cont_prep_addr_last_line,cont_prep_addr_last_line) OR le.cont_prep_addr_last_line = (TYPEOF(le.cont_prep_addr_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_prep_addr_last_line)}],SALT34.Layout_FieldValueList));
  SELF.recordorigin_Values := IF ( (le.recordorigin  IN SET(s.nulls_recordorigin,recordorigin) OR le.recordorigin = (TYPEOF(le.recordorigin))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recordorigin)}],SALT34.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF. := le.;
  self.dt_vendor_first_reported_Values := IF ( (unsigned)le.dt_vendor_first_reported = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.dt_vendor_first_reported}],SALT34.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( (unsigned)le.dt_vendor_last_reported = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.dt_vendor_last_reported}],SALT34.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( (unsigned)le.dt_first_seen = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.dt_first_seen}],SALT34.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( (unsigned)le.dt_last_seen = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.dt_last_seen}],SALT34.Layout_FieldValueList));
  self.corp_ra_dt_first_seen_Values := IF ( (unsigned)le.corp_ra_dt_first_seen = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.corp_ra_dt_first_seen}],SALT34.Layout_FieldValueList));
  self.corp_ra_dt_last_seen_Values := IF ( (unsigned)le.corp_ra_dt_last_seen = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.corp_ra_dt_last_seen}],SALT34.Layout_FieldValueList));
  SELF.corp_key_Values := IF ( (le.corp_key  IN SET(s.nulls_corp_key,corp_key) OR le.corp_key = (TYPEOF(le.corp_key))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_key)}],SALT34.Layout_FieldValueList));
  SELF.corp_supp_key_Values := IF ( (le.corp_supp_key  IN SET(s.nulls_corp_supp_key,corp_supp_key) OR le.corp_supp_key = (TYPEOF(le.corp_supp_key))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_supp_key)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_Values := IF ( (le.corp_vendor  IN SET(s.nulls_corp_vendor,corp_vendor) OR le.corp_vendor = (TYPEOF(le.corp_vendor))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_county_Values := IF ( (le.corp_vendor_county  IN SET(s.nulls_corp_vendor_county,corp_vendor_county) OR le.corp_vendor_county = (TYPEOF(le.corp_vendor_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_vendor_subcode_Values := IF ( (le.corp_vendor_subcode  IN SET(s.nulls_corp_vendor_subcode,corp_vendor_subcode) OR le.corp_vendor_subcode = (TYPEOF(le.corp_vendor_subcode))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_vendor_subcode)}],SALT34.Layout_FieldValueList));
  SELF.corp_state_origin_Values := IF ( (le.corp_state_origin  IN SET(s.nulls_corp_state_origin,corp_state_origin) OR le.corp_state_origin = (TYPEOF(le.corp_state_origin))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_state_origin)}],SALT34.Layout_FieldValueList));
  self.corp_process_date_Values := IF ( (unsigned)le.corp_process_date = 0,dataset([],SALT34.Layout_FieldValueList),dataset([{(SALT34.StrType)le.corp_process_date}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_sos_charter_nbr_Values := IF ( (le.corp_orig_sos_charter_nbr  IN SET(s.nulls_corp_orig_sos_charter_nbr,corp_orig_sos_charter_nbr) OR le.corp_orig_sos_charter_nbr = (TYPEOF(le.corp_orig_sos_charter_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_legal_name_Values := IF ( (le.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name) OR le.corp_legal_name = (TYPEOF(le.corp_legal_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_legal_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_ln_name_type_cd_Values := IF ( (le.corp_ln_name_type_cd  IN SET(s.nulls_corp_ln_name_type_cd,corp_ln_name_type_cd) OR le.corp_ln_name_type_cd = (TYPEOF(le.corp_ln_name_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ln_name_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ln_name_type_desc_Values := IF ( (le.corp_ln_name_type_desc  IN SET(s.nulls_corp_ln_name_type_desc,corp_ln_name_type_desc) OR le.corp_ln_name_type_desc = (TYPEOF(le.corp_ln_name_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ln_name_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_supp_nbr_Values := IF ( (le.corp_supp_nbr  IN SET(s.nulls_corp_supp_nbr,corp_supp_nbr) OR le.corp_supp_nbr = (TYPEOF(le.corp_supp_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_supp_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_comment_Values := IF ( (le.corp_name_comment  IN SET(s.nulls_corp_name_comment,corp_name_comment) OR le.corp_name_comment = (TYPEOF(le.corp_name_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_type_cd_Values := IF ( (le.corp_address1_type_cd  IN SET(s.nulls_corp_address1_type_cd,corp_address1_type_cd) OR le.corp_address1_type_cd = (TYPEOF(le.corp_address1_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_type_desc_Values := IF ( (le.corp_address1_type_desc  IN SET(s.nulls_corp_address1_type_desc,corp_address1_type_desc) OR le.corp_address1_type_desc = (TYPEOF(le.corp_address1_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line1_Values := IF ( (le.corp_address1_line1  IN SET(s.nulls_corp_address1_line1,corp_address1_line1) OR le.corp_address1_line1 = (TYPEOF(le.corp_address1_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line2_Values := IF ( (le.corp_address1_line2  IN SET(s.nulls_corp_address1_line2,corp_address1_line2) OR le.corp_address1_line2 = (TYPEOF(le.corp_address1_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_line3_Values := IF ( (le.corp_address1_line3  IN SET(s.nulls_corp_address1_line3,corp_address1_line3) OR le.corp_address1_line3 = (TYPEOF(le.corp_address1_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_address1_effective_date_Values := IF ( (le.corp_address1_effective_date  IN SET(s.nulls_corp_address1_effective_date,corp_address1_effective_date) OR le.corp_address1_effective_date = (TYPEOF(le.corp_address1_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address1_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_type_cd_Values := IF ( (le.corp_address2_type_cd  IN SET(s.nulls_corp_address2_type_cd,corp_address2_type_cd) OR le.corp_address2_type_cd = (TYPEOF(le.corp_address2_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_type_desc_Values := IF ( (le.corp_address2_type_desc  IN SET(s.nulls_corp_address2_type_desc,corp_address2_type_desc) OR le.corp_address2_type_desc = (TYPEOF(le.corp_address2_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line1_Values := IF ( (le.corp_address2_line1  IN SET(s.nulls_corp_address2_line1,corp_address2_line1) OR le.corp_address2_line1 = (TYPEOF(le.corp_address2_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line2_Values := IF ( (le.corp_address2_line2  IN SET(s.nulls_corp_address2_line2,corp_address2_line2) OR le.corp_address2_line2 = (TYPEOF(le.corp_address2_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_line3_Values := IF ( (le.corp_address2_line3  IN SET(s.nulls_corp_address2_line3,corp_address2_line3) OR le.corp_address2_line3 = (TYPEOF(le.corp_address2_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_address2_effective_date_Values := IF ( (le.corp_address2_effective_date  IN SET(s.nulls_corp_address2_effective_date,corp_address2_effective_date) OR le.corp_address2_effective_date = (TYPEOF(le.corp_address2_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address2_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_Values := IF ( (le.corp_phone_number  IN SET(s.nulls_corp_phone_number,corp_phone_number) OR le.corp_phone_number = (TYPEOF(le.corp_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_type_cd_Values := IF ( (le.corp_phone_number_type_cd  IN SET(s.nulls_corp_phone_number_type_cd,corp_phone_number_type_cd) OR le.corp_phone_number_type_cd = (TYPEOF(le.corp_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_phone_number_type_desc_Values := IF ( (le.corp_phone_number_type_desc  IN SET(s.nulls_corp_phone_number_type_desc,corp_phone_number_type_desc) OR le.corp_phone_number_type_desc = (TYPEOF(le.corp_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_fax_nbr_Values := IF ( (le.corp_fax_nbr  IN SET(s.nulls_corp_fax_nbr,corp_fax_nbr) OR le.corp_fax_nbr = (TYPEOF(le.corp_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_email_address_Values := IF ( (le.corp_email_address  IN SET(s.nulls_corp_email_address,corp_email_address) OR le.corp_email_address = (TYPEOF(le.corp_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_email_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_web_address_Values := IF ( (le.corp_web_address  IN SET(s.nulls_corp_web_address,corp_web_address) OR le.corp_web_address = (TYPEOF(le.corp_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_reference_nbr_Values := IF ( (le.corp_filing_reference_nbr  IN SET(s.nulls_corp_filing_reference_nbr,corp_filing_reference_nbr) OR le.corp_filing_reference_nbr = (TYPEOF(le.corp_filing_reference_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_reference_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_date_Values := IF ( (le.corp_filing_date  IN SET(s.nulls_corp_filing_date,corp_filing_date) OR le.corp_filing_date = (TYPEOF(le.corp_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_cd_Values := IF ( (le.corp_filing_cd  IN SET(s.nulls_corp_filing_cd,corp_filing_cd) OR le.corp_filing_cd = (TYPEOF(le.corp_filing_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_filing_desc_Values := IF ( (le.corp_filing_desc  IN SET(s.nulls_corp_filing_desc,corp_filing_desc) OR le.corp_filing_desc = (TYPEOF(le.corp_filing_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_filing_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_cd_Values := IF ( (le.corp_status_cd  IN SET(s.nulls_corp_status_cd,corp_status_cd) OR le.corp_status_cd = (TYPEOF(le.corp_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_desc_Values := IF ( (le.corp_status_desc  IN SET(s.nulls_corp_status_desc,corp_status_desc) OR le.corp_status_desc = (TYPEOF(le.corp_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_date_Values := IF ( (le.corp_status_date  IN SET(s.nulls_corp_status_date,corp_status_date) OR le.corp_status_date = (TYPEOF(le.corp_status_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_standing_Values := IF ( (le.corp_standing  IN SET(s.nulls_corp_standing,corp_standing) OR le.corp_standing = (TYPEOF(le.corp_standing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_standing)}],SALT34.Layout_FieldValueList));
  SELF.corp_status_comment_Values := IF ( (le.corp_status_comment  IN SET(s.nulls_corp_status_comment,corp_status_comment) OR le.corp_status_comment = (TYPEOF(le.corp_status_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_status_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_ticker_symbol_Values := IF ( (le.corp_ticker_symbol  IN SET(s.nulls_corp_ticker_symbol,corp_ticker_symbol) OR le.corp_ticker_symbol = (TYPEOF(le.corp_ticker_symbol))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ticker_symbol)}],SALT34.Layout_FieldValueList));
  SELF.corp_stock_exchange_Values := IF ( (le.corp_stock_exchange  IN SET(s.nulls_corp_stock_exchange,corp_stock_exchange) OR le.corp_stock_exchange = (TYPEOF(le.corp_stock_exchange))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_stock_exchange)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_state_Values := IF ( (le.corp_inc_state  IN SET(s.nulls_corp_inc_state,corp_inc_state) OR le.corp_inc_state = (TYPEOF(le.corp_inc_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_county_Values := IF ( (le.corp_inc_county  IN SET(s.nulls_corp_inc_county,corp_inc_county) OR le.corp_inc_county = (TYPEOF(le.corp_inc_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_inc_date_Values := IF ( (le.corp_inc_date  IN SET(s.nulls_corp_inc_date,corp_inc_date) OR le.corp_inc_date = (TYPEOF(le.corp_inc_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_inc_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_anniversary_month_Values := IF ( (le.corp_anniversary_month  IN SET(s.nulls_corp_anniversary_month,corp_anniversary_month) OR le.corp_anniversary_month = (TYPEOF(le.corp_anniversary_month))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_anniversary_month)}],SALT34.Layout_FieldValueList));
  SELF.corp_fed_tax_id_Values := IF ( (le.corp_fed_tax_id  IN SET(s.nulls_corp_fed_tax_id,corp_fed_tax_id) OR le.corp_fed_tax_id = (TYPEOF(le.corp_fed_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fed_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_state_tax_id_Values := IF ( (le.corp_state_tax_id  IN SET(s.nulls_corp_state_tax_id,corp_state_tax_id) OR le.corp_state_tax_id = (TYPEOF(le.corp_state_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_state_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_cd_Values := IF ( (le.corp_term_exist_cd  IN SET(s.nulls_corp_term_exist_cd,corp_term_exist_cd) OR le.corp_term_exist_cd = (TYPEOF(le.corp_term_exist_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_exp_Values := IF ( (le.corp_term_exist_exp  IN SET(s.nulls_corp_term_exist_exp,corp_term_exist_exp) OR le.corp_term_exist_exp = (TYPEOF(le.corp_term_exist_exp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_exp)}],SALT34.Layout_FieldValueList));
  SELF.corp_term_exist_desc_Values := IF ( (le.corp_term_exist_desc  IN SET(s.nulls_corp_term_exist_desc,corp_term_exist_desc) OR le.corp_term_exist_desc = (TYPEOF(le.corp_term_exist_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_term_exist_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_foreign_domestic_ind_Values := IF ( (le.corp_foreign_domestic_ind  IN SET(s.nulls_corp_foreign_domestic_ind,corp_foreign_domestic_ind) OR le.corp_foreign_domestic_ind = (TYPEOF(le.corp_foreign_domestic_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_foreign_domestic_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_cd_Values := IF ( (le.corp_forgn_state_cd  IN SET(s.nulls_corp_forgn_state_cd,corp_forgn_state_cd) OR le.corp_forgn_state_cd = (TYPEOF(le.corp_forgn_state_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_desc_Values := IF ( (le.corp_forgn_state_desc  IN SET(s.nulls_corp_forgn_state_desc,corp_forgn_state_desc) OR le.corp_forgn_state_desc = (TYPEOF(le.corp_forgn_state_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_sos_charter_nbr_Values := IF ( (le.corp_forgn_sos_charter_nbr  IN SET(s.nulls_corp_forgn_sos_charter_nbr,corp_forgn_sos_charter_nbr) OR le.corp_forgn_sos_charter_nbr = (TYPEOF(le.corp_forgn_sos_charter_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_sos_charter_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_date_Values := IF ( (le.corp_forgn_date  IN SET(s.nulls_corp_forgn_date,corp_forgn_date) OR le.corp_forgn_date = (TYPEOF(le.corp_forgn_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_fed_tax_id_Values := IF ( (le.corp_forgn_fed_tax_id  IN SET(s.nulls_corp_forgn_fed_tax_id,corp_forgn_fed_tax_id) OR le.corp_forgn_fed_tax_id = (TYPEOF(le.corp_forgn_fed_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_fed_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_state_tax_id_Values := IF ( (le.corp_forgn_state_tax_id  IN SET(s.nulls_corp_forgn_state_tax_id,corp_forgn_state_tax_id) OR le.corp_forgn_state_tax_id = (TYPEOF(le.corp_forgn_state_tax_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_state_tax_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_cd_Values := IF ( (le.corp_forgn_term_exist_cd  IN SET(s.nulls_corp_forgn_term_exist_cd,corp_forgn_term_exist_cd) OR le.corp_forgn_term_exist_cd = (TYPEOF(le.corp_forgn_term_exist_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_exp_Values := IF ( (le.corp_forgn_term_exist_exp  IN SET(s.nulls_corp_forgn_term_exist_exp,corp_forgn_term_exist_exp) OR le.corp_forgn_term_exist_exp = (TYPEOF(le.corp_forgn_term_exist_exp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_exp)}],SALT34.Layout_FieldValueList));
  SELF.corp_forgn_term_exist_desc_Values := IF ( (le.corp_forgn_term_exist_desc  IN SET(s.nulls_corp_forgn_term_exist_desc,corp_forgn_term_exist_desc) OR le.corp_forgn_term_exist_desc = (TYPEOF(le.corp_forgn_term_exist_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_forgn_term_exist_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_org_structure_cd_Values := IF ( (le.corp_orig_org_structure_cd  IN SET(s.nulls_corp_orig_org_structure_cd,corp_orig_org_structure_cd) OR le.corp_orig_org_structure_cd = (TYPEOF(le.corp_orig_org_structure_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_org_structure_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_org_structure_desc_Values := IF ( (le.corp_orig_org_structure_desc  IN SET(s.nulls_corp_orig_org_structure_desc,corp_orig_org_structure_desc) OR le.corp_orig_org_structure_desc = (TYPEOF(le.corp_orig_org_structure_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_org_structure_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_for_profit_ind_Values := IF ( (le.corp_for_profit_ind  IN SET(s.nulls_corp_for_profit_ind,corp_for_profit_ind) OR le.corp_for_profit_ind = (TYPEOF(le.corp_for_profit_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_for_profit_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_public_or_private_ind_Values := IF ( (le.corp_public_or_private_ind  IN SET(s.nulls_corp_public_or_private_ind,corp_public_or_private_ind) OR le.corp_public_or_private_ind = (TYPEOF(le.corp_public_or_private_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_public_or_private_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_sic_code_Values := IF ( (le.corp_sic_code  IN SET(s.nulls_corp_sic_code,corp_sic_code) OR le.corp_sic_code = (TYPEOF(le.corp_sic_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_sic_code)}],SALT34.Layout_FieldValueList));
  SELF.corp_naic_code_Values := IF ( (le.corp_naic_code  IN SET(s.nulls_corp_naic_code,corp_naic_code) OR le.corp_naic_code = (TYPEOF(le.corp_naic_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_naic_code)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_bus_type_cd_Values := IF ( (le.corp_orig_bus_type_cd  IN SET(s.nulls_corp_orig_bus_type_cd,corp_orig_bus_type_cd) OR le.corp_orig_bus_type_cd = (TYPEOF(le.corp_orig_bus_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_bus_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_orig_bus_type_desc_Values := IF ( (le.corp_orig_bus_type_desc  IN SET(s.nulls_corp_orig_bus_type_desc,corp_orig_bus_type_desc) OR le.corp_orig_bus_type_desc = (TYPEOF(le.corp_orig_bus_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_orig_bus_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_entity_desc_Values := IF ( (le.corp_entity_desc  IN SET(s.nulls_corp_entity_desc,corp_entity_desc) OR le.corp_entity_desc = (TYPEOF(le.corp_entity_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_entity_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_certificate_nbr_Values := IF ( (le.corp_certificate_nbr  IN SET(s.nulls_corp_certificate_nbr,corp_certificate_nbr) OR le.corp_certificate_nbr = (TYPEOF(le.corp_certificate_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_certificate_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_internal_nbr_Values := IF ( (le.corp_internal_nbr  IN SET(s.nulls_corp_internal_nbr,corp_internal_nbr) OR le.corp_internal_nbr = (TYPEOF(le.corp_internal_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_internal_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_previous_nbr_Values := IF ( (le.corp_previous_nbr  IN SET(s.nulls_corp_previous_nbr,corp_previous_nbr) OR le.corp_previous_nbr = (TYPEOF(le.corp_previous_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_previous_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_microfilm_nbr_Values := IF ( (le.corp_microfilm_nbr  IN SET(s.nulls_corp_microfilm_nbr,corp_microfilm_nbr) OR le.corp_microfilm_nbr = (TYPEOF(le.corp_microfilm_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_microfilm_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_amendments_filed_Values := IF ( (le.corp_amendments_filed  IN SET(s.nulls_corp_amendments_filed,corp_amendments_filed) OR le.corp_amendments_filed = (TYPEOF(le.corp_amendments_filed))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_amendments_filed)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts_Values := IF ( (le.corp_acts  IN SET(s.nulls_corp_acts,corp_acts) OR le.corp_acts = (TYPEOF(le.corp_acts))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts)}],SALT34.Layout_FieldValueList));
  SELF.corp_partnership_ind_Values := IF ( (le.corp_partnership_ind  IN SET(s.nulls_corp_partnership_ind,corp_partnership_ind) OR le.corp_partnership_ind = (TYPEOF(le.corp_partnership_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partnership_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_mfg_ind_Values := IF ( (le.corp_mfg_ind  IN SET(s.nulls_corp_mfg_ind,corp_mfg_ind) OR le.corp_mfg_ind = (TYPEOF(le.corp_mfg_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_mfg_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_addl_info_Values := IF ( (le.corp_addl_info  IN SET(s.nulls_corp_addl_info,corp_addl_info) OR le.corp_addl_info = (TYPEOF(le.corp_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.corp_taxes_Values := IF ( (le.corp_taxes  IN SET(s.nulls_corp_taxes,corp_taxes) OR le.corp_taxes = (TYPEOF(le.corp_taxes))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_taxes)}],SALT34.Layout_FieldValueList));
  SELF.corp_franchise_taxes_Values := IF ( (le.corp_franchise_taxes  IN SET(s.nulls_corp_franchise_taxes,corp_franchise_taxes) OR le.corp_franchise_taxes = (TYPEOF(le.corp_franchise_taxes))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_franchise_taxes)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_program_cd_Values := IF ( (le.corp_tax_program_cd  IN SET(s.nulls_corp_tax_program_cd,corp_tax_program_cd) OR le.corp_tax_program_cd = (TYPEOF(le.corp_tax_program_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_program_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_program_desc_Values := IF ( (le.corp_tax_program_desc  IN SET(s.nulls_corp_tax_program_desc,corp_tax_program_desc) OR le.corp_tax_program_desc = (TYPEOF(le.corp_tax_program_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_program_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_full_name_Values := IF ( (le.corp_ra_full_name  IN SET(s.nulls_corp_ra_full_name,corp_ra_full_name) OR le.corp_ra_full_name = (TYPEOF(le.corp_ra_full_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_full_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fname_Values := IF ( (le.corp_ra_fname  IN SET(s.nulls_corp_ra_fname,corp_ra_fname) OR le.corp_ra_fname = (TYPEOF(le.corp_ra_fname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_mname_Values := IF ( (le.corp_ra_mname  IN SET(s.nulls_corp_ra_mname,corp_ra_mname) OR le.corp_ra_mname = (TYPEOF(le.corp_ra_mname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_mname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_lname_Values := IF ( (le.corp_ra_lname  IN SET(s.nulls_corp_ra_lname,corp_ra_lname) OR le.corp_ra_lname = (TYPEOF(le.corp_ra_lname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_lname)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_suffix_Values := IF ( (le.corp_ra_suffix  IN SET(s.nulls_corp_ra_suffix,corp_ra_suffix) OR le.corp_ra_suffix = (TYPEOF(le.corp_ra_suffix))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_suffix)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_title_cd_Values := IF ( (le.corp_ra_title_cd  IN SET(s.nulls_corp_ra_title_cd,corp_ra_title_cd) OR le.corp_ra_title_cd = (TYPEOF(le.corp_ra_title_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_title_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_title_desc_Values := IF ( (le.corp_ra_title_desc  IN SET(s.nulls_corp_ra_title_desc,corp_ra_title_desc) OR le.corp_ra_title_desc = (TYPEOF(le.corp_ra_title_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_title_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fein_Values := IF ( (le.corp_ra_fein  IN SET(s.nulls_corp_ra_fein,corp_ra_fein) OR le.corp_ra_fein = (TYPEOF(le.corp_ra_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fein)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_ssn_Values := IF ( (le.corp_ra_ssn  IN SET(s.nulls_corp_ra_ssn,corp_ra_ssn) OR le.corp_ra_ssn = (TYPEOF(le.corp_ra_ssn))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_ssn)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_dob_Values := IF ( (le.corp_ra_dob  IN SET(s.nulls_corp_ra_dob,corp_ra_dob) OR le.corp_ra_dob = (TYPEOF(le.corp_ra_dob))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_dob)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_effective_date_Values := IF ( (le.corp_ra_effective_date  IN SET(s.nulls_corp_ra_effective_date,corp_ra_effective_date) OR le.corp_ra_effective_date = (TYPEOF(le.corp_ra_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_resign_date_Values := IF ( (le.corp_ra_resign_date  IN SET(s.nulls_corp_ra_resign_date,corp_ra_resign_date) OR le.corp_ra_resign_date = (TYPEOF(le.corp_ra_resign_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_resign_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_no_comp_Values := IF ( (le.corp_ra_no_comp  IN SET(s.nulls_corp_ra_no_comp,corp_ra_no_comp) OR le.corp_ra_no_comp = (TYPEOF(le.corp_ra_no_comp))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_no_comp)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_no_comp_igs_Values := IF ( (le.corp_ra_no_comp_igs  IN SET(s.nulls_corp_ra_no_comp_igs,corp_ra_no_comp_igs) OR le.corp_ra_no_comp_igs = (TYPEOF(le.corp_ra_no_comp_igs))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_no_comp_igs)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_addl_info_Values := IF ( (le.corp_ra_addl_info  IN SET(s.nulls_corp_ra_addl_info,corp_ra_addl_info) OR le.corp_ra_addl_info = (TYPEOF(le.corp_ra_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_type_cd_Values := IF ( (le.corp_ra_address_type_cd  IN SET(s.nulls_corp_ra_address_type_cd,corp_ra_address_type_cd) OR le.corp_ra_address_type_cd = (TYPEOF(le.corp_ra_address_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_type_desc_Values := IF ( (le.corp_ra_address_type_desc  IN SET(s.nulls_corp_ra_address_type_desc,corp_ra_address_type_desc) OR le.corp_ra_address_type_desc = (TYPEOF(le.corp_ra_address_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line1_Values := IF ( (le.corp_ra_address_line1  IN SET(s.nulls_corp_ra_address_line1,corp_ra_address_line1) OR le.corp_ra_address_line1 = (TYPEOF(le.corp_ra_address_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line2_Values := IF ( (le.corp_ra_address_line2  IN SET(s.nulls_corp_ra_address_line2,corp_ra_address_line2) OR le.corp_ra_address_line2 = (TYPEOF(le.corp_ra_address_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line2)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_address_line3_Values := IF ( (le.corp_ra_address_line3  IN SET(s.nulls_corp_ra_address_line3,corp_ra_address_line3) OR le.corp_ra_address_line3 = (TYPEOF(le.corp_ra_address_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_address_line3)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_Values := IF ( (le.corp_ra_phone_number  IN SET(s.nulls_corp_ra_phone_number,corp_ra_phone_number) OR le.corp_ra_phone_number = (TYPEOF(le.corp_ra_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_type_cd_Values := IF ( (le.corp_ra_phone_number_type_cd  IN SET(s.nulls_corp_ra_phone_number_type_cd,corp_ra_phone_number_type_cd) OR le.corp_ra_phone_number_type_cd = (TYPEOF(le.corp_ra_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_phone_number_type_desc_Values := IF ( (le.corp_ra_phone_number_type_desc  IN SET(s.nulls_corp_ra_phone_number_type_desc,corp_ra_phone_number_type_desc) OR le.corp_ra_phone_number_type_desc = (TYPEOF(le.corp_ra_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_fax_nbr_Values := IF ( (le.corp_ra_fax_nbr  IN SET(s.nulls_corp_ra_fax_nbr,corp_ra_fax_nbr) OR le.corp_ra_fax_nbr = (TYPEOF(le.corp_ra_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_email_address_Values := IF ( (le.corp_ra_email_address  IN SET(s.nulls_corp_ra_email_address,corp_ra_email_address) OR le.corp_ra_email_address = (TYPEOF(le.corp_ra_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_email_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_web_address_Values := IF ( (le.corp_ra_web_address  IN SET(s.nulls_corp_ra_web_address,corp_ra_web_address) OR le.corp_ra_web_address = (TYPEOF(le.corp_ra_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr1_line1_Values := IF ( (le.corp_prep_addr1_line1  IN SET(s.nulls_corp_prep_addr1_line1,corp_prep_addr1_line1) OR le.corp_prep_addr1_line1 = (TYPEOF(le.corp_prep_addr1_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr1_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr1_last_line_Values := IF ( (le.corp_prep_addr1_last_line  IN SET(s.nulls_corp_prep_addr1_last_line,corp_prep_addr1_last_line) OR le.corp_prep_addr1_last_line = (TYPEOF(le.corp_prep_addr1_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr1_last_line)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr2_line1_Values := IF ( (le.corp_prep_addr2_line1  IN SET(s.nulls_corp_prep_addr2_line1,corp_prep_addr2_line1) OR le.corp_prep_addr2_line1 = (TYPEOF(le.corp_prep_addr2_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr2_line1)}],SALT34.Layout_FieldValueList));
  SELF.corp_prep_addr2_last_line_Values := IF ( (le.corp_prep_addr2_last_line  IN SET(s.nulls_corp_prep_addr2_last_line,corp_prep_addr2_last_line) OR le.corp_prep_addr2_last_line = (TYPEOF(le.corp_prep_addr2_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_prep_addr2_last_line)}],SALT34.Layout_FieldValueList));
  SELF.ra_prep_addr_line1_Values := IF ( (le.ra_prep_addr_line1  IN SET(s.nulls_ra_prep_addr_line1,ra_prep_addr_line1) OR le.ra_prep_addr_line1 = (TYPEOF(le.ra_prep_addr_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.ra_prep_addr_line1)}],SALT34.Layout_FieldValueList));
  SELF.ra_prep_addr_last_line_Values := IF ( (le.ra_prep_addr_last_line  IN SET(s.nulls_ra_prep_addr_last_line,ra_prep_addr_last_line) OR le.ra_prep_addr_last_line = (TYPEOF(le.ra_prep_addr_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.ra_prep_addr_last_line)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_reference_nbr_Values := IF ( (le.cont_filing_reference_nbr  IN SET(s.nulls_cont_filing_reference_nbr,cont_filing_reference_nbr) OR le.cont_filing_reference_nbr = (TYPEOF(le.cont_filing_reference_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_reference_nbr)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_date_Values := IF ( (le.cont_filing_date  IN SET(s.nulls_cont_filing_date,cont_filing_date) OR le.cont_filing_date = (TYPEOF(le.cont_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_cd_Values := IF ( (le.cont_filing_cd  IN SET(s.nulls_cont_filing_cd,cont_filing_cd) OR le.cont_filing_cd = (TYPEOF(le.cont_filing_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_filing_desc_Values := IF ( (le.cont_filing_desc  IN SET(s.nulls_cont_filing_desc,cont_filing_desc) OR le.cont_filing_desc = (TYPEOF(le.cont_filing_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_filing_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_type_cd_Values := IF ( (le.cont_type_cd  IN SET(s.nulls_cont_type_cd,cont_type_cd) OR le.cont_type_cd = (TYPEOF(le.cont_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_type_desc_Values := IF ( (le.cont_type_desc  IN SET(s.nulls_cont_type_desc,cont_type_desc) OR le.cont_type_desc = (TYPEOF(le.cont_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_full_name_Values := IF ( (le.cont_full_name  IN SET(s.nulls_cont_full_name,cont_full_name) OR le.cont_full_name = (TYPEOF(le.cont_full_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_full_name)}],SALT34.Layout_FieldValueList));
  SELF.cont_fname_Values := IF ( (le.cont_fname  IN SET(s.nulls_cont_fname,cont_fname) OR le.cont_fname = (TYPEOF(le.cont_fname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fname)}],SALT34.Layout_FieldValueList));
  SELF.cont_mname_Values := IF ( (le.cont_mname  IN SET(s.nulls_cont_mname,cont_mname) OR le.cont_mname = (TYPEOF(le.cont_mname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_mname)}],SALT34.Layout_FieldValueList));
  SELF.cont_lname_Values := IF ( (le.cont_lname  IN SET(s.nulls_cont_lname,cont_lname) OR le.cont_lname = (TYPEOF(le.cont_lname))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_lname)}],SALT34.Layout_FieldValueList));
  SELF.cont_suffix_Values := IF ( (le.cont_suffix  IN SET(s.nulls_cont_suffix,cont_suffix) OR le.cont_suffix = (TYPEOF(le.cont_suffix))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_suffix)}],SALT34.Layout_FieldValueList));
  SELF.cont_title1_desc_Values := IF ( (le.cont_title1_desc  IN SET(s.nulls_cont_title1_desc,cont_title1_desc) OR le.cont_title1_desc = (TYPEOF(le.cont_title1_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title1_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title2_desc_Values := IF ( (le.cont_title2_desc  IN SET(s.nulls_cont_title2_desc,cont_title2_desc) OR le.cont_title2_desc = (TYPEOF(le.cont_title2_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title2_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title3_desc_Values := IF ( (le.cont_title3_desc  IN SET(s.nulls_cont_title3_desc,cont_title3_desc) OR le.cont_title3_desc = (TYPEOF(le.cont_title3_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title3_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title4_desc_Values := IF ( (le.cont_title4_desc  IN SET(s.nulls_cont_title4_desc,cont_title4_desc) OR le.cont_title4_desc = (TYPEOF(le.cont_title4_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title4_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_title5_desc_Values := IF ( (le.cont_title5_desc  IN SET(s.nulls_cont_title5_desc,cont_title5_desc) OR le.cont_title5_desc = (TYPEOF(le.cont_title5_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_title5_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_fein_Values := IF ( (le.cont_fein  IN SET(s.nulls_cont_fein,cont_fein) OR le.cont_fein = (TYPEOF(le.cont_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fein)}],SALT34.Layout_FieldValueList));
  SELF.cont_ssn_Values := IF ( (le.cont_ssn  IN SET(s.nulls_cont_ssn,cont_ssn) OR le.cont_ssn = (TYPEOF(le.cont_ssn))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_ssn)}],SALT34.Layout_FieldValueList));
  SELF.cont_dob_Values := IF ( (le.cont_dob  IN SET(s.nulls_cont_dob,cont_dob) OR le.cont_dob = (TYPEOF(le.cont_dob))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_dob)}],SALT34.Layout_FieldValueList));
  SELF.cont_status_cd_Values := IF ( (le.cont_status_cd  IN SET(s.nulls_cont_status_cd,cont_status_cd) OR le.cont_status_cd = (TYPEOF(le.cont_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_status_desc_Values := IF ( (le.cont_status_desc  IN SET(s.nulls_cont_status_desc,cont_status_desc) OR le.cont_status_desc = (TYPEOF(le.cont_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_date_Values := IF ( (le.cont_effective_date  IN SET(s.nulls_cont_effective_date,cont_effective_date) OR le.cont_effective_date = (TYPEOF(le.cont_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_cd_Values := IF ( (le.cont_effective_cd  IN SET(s.nulls_cont_effective_cd,cont_effective_cd) OR le.cont_effective_cd = (TYPEOF(le.cont_effective_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_effective_desc_Values := IF ( (le.cont_effective_desc  IN SET(s.nulls_cont_effective_desc,cont_effective_desc) OR le.cont_effective_desc = (TYPEOF(le.cont_effective_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_effective_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_addl_info_Values := IF ( (le.cont_addl_info  IN SET(s.nulls_cont_addl_info,cont_addl_info) OR le.cont_addl_info = (TYPEOF(le.cont_addl_info))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_addl_info)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_type_cd_Values := IF ( (le.cont_address_type_cd  IN SET(s.nulls_cont_address_type_cd,cont_address_type_cd) OR le.cont_address_type_cd = (TYPEOF(le.cont_address_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_type_desc_Values := IF ( (le.cont_address_type_desc  IN SET(s.nulls_cont_address_type_desc,cont_address_type_desc) OR le.cont_address_type_desc = (TYPEOF(le.cont_address_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line1_Values := IF ( (le.cont_address_line1  IN SET(s.nulls_cont_address_line1,cont_address_line1) OR le.cont_address_line1 = (TYPEOF(le.cont_address_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line1)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line2_Values := IF ( (le.cont_address_line2  IN SET(s.nulls_cont_address_line2,cont_address_line2) OR le.cont_address_line2 = (TYPEOF(le.cont_address_line2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line2)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_line3_Values := IF ( (le.cont_address_line3  IN SET(s.nulls_cont_address_line3,cont_address_line3) OR le.cont_address_line3 = (TYPEOF(le.cont_address_line3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_line3)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_effective_date_Values := IF ( (le.cont_address_effective_date  IN SET(s.nulls_cont_address_effective_date,cont_address_effective_date) OR le.cont_address_effective_date = (TYPEOF(le.cont_address_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.cont_address_county_Values := IF ( (le.cont_address_county  IN SET(s.nulls_cont_address_county,cont_address_county) OR le.cont_address_county = (TYPEOF(le.cont_address_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_address_county)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_Values := IF ( (le.cont_phone_number  IN SET(s.nulls_cont_phone_number,cont_phone_number) OR le.cont_phone_number = (TYPEOF(le.cont_phone_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_type_cd_Values := IF ( (le.cont_phone_number_type_cd  IN SET(s.nulls_cont_phone_number_type_cd,cont_phone_number_type_cd) OR le.cont_phone_number_type_cd = (TYPEOF(le.cont_phone_number_type_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number_type_cd)}],SALT34.Layout_FieldValueList));
  SELF.cont_phone_number_type_desc_Values := IF ( (le.cont_phone_number_type_desc  IN SET(s.nulls_cont_phone_number_type_desc,cont_phone_number_type_desc) OR le.cont_phone_number_type_desc = (TYPEOF(le.cont_phone_number_type_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_phone_number_type_desc)}],SALT34.Layout_FieldValueList));
  SELF.cont_fax_nbr_Values := IF ( (le.cont_fax_nbr  IN SET(s.nulls_cont_fax_nbr,cont_fax_nbr) OR le.cont_fax_nbr = (TYPEOF(le.cont_fax_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_fax_nbr)}],SALT34.Layout_FieldValueList));
  SELF.cont_email_address_Values := IF ( (le.cont_email_address  IN SET(s.nulls_cont_email_address,cont_email_address) OR le.cont_email_address = (TYPEOF(le.cont_email_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_email_address)}],SALT34.Layout_FieldValueList));
  SELF.cont_web_address_Values := IF ( (le.cont_web_address  IN SET(s.nulls_cont_web_address,cont_web_address) OR le.cont_web_address = (TYPEOF(le.cont_web_address))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_web_address)}],SALT34.Layout_FieldValueList));
  SELF.corp_acres_Values := IF ( (le.corp_acres  IN SET(s.nulls_corp_acres,corp_acres) OR le.corp_acres = (TYPEOF(le.corp_acres))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acres)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_Values := IF ( (le.corp_action  IN SET(s.nulls_corp_action,corp_action) OR le.corp_action = (TYPEOF(le.corp_action))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_date_Values := IF ( (le.corp_action_date  IN SET(s.nulls_corp_action_date,corp_action_date) OR le.corp_action_date = (TYPEOF(le.corp_action_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_employment_security_approval_date_Values := IF ( (le.corp_action_employment_security_approval_date  IN SET(s.nulls_corp_action_employment_security_approval_date,corp_action_employment_security_approval_date) OR le.corp_action_employment_security_approval_date = (TYPEOF(le.corp_action_employment_security_approval_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_employment_security_approval_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_pending_cd_Values := IF ( (le.corp_action_pending_cd  IN SET(s.nulls_corp_action_pending_cd,corp_action_pending_cd) OR le.corp_action_pending_cd = (TYPEOF(le.corp_action_pending_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_pending_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_pending_desc_Values := IF ( (le.corp_action_pending_desc  IN SET(s.nulls_corp_action_pending_desc,corp_action_pending_desc) OR le.corp_action_pending_desc = (TYPEOF(le.corp_action_pending_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_pending_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_statement_of_intent_date_Values := IF ( (le.corp_action_statement_of_intent_date  IN SET(s.nulls_corp_action_statement_of_intent_date,corp_action_statement_of_intent_date) OR le.corp_action_statement_of_intent_date = (TYPEOF(le.corp_action_statement_of_intent_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_statement_of_intent_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_action_tax_dept_approval_date_Values := IF ( (le.corp_action_tax_dept_approval_date  IN SET(s.nulls_corp_action_tax_dept_approval_date,corp_action_tax_dept_approval_date) OR le.corp_action_tax_dept_approval_date = (TYPEOF(le.corp_action_tax_dept_approval_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_action_tax_dept_approval_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts2_Values := IF ( (le.corp_acts2  IN SET(s.nulls_corp_acts2,corp_acts2) OR le.corp_acts2 = (TYPEOF(le.corp_acts2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts2)}],SALT34.Layout_FieldValueList));
  SELF.corp_acts3_Values := IF ( (le.corp_acts3  IN SET(s.nulls_corp_acts3,corp_acts3) OR le.corp_acts3 = (TYPEOF(le.corp_acts3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_acts3)}],SALT34.Layout_FieldValueList));
  SELF.corp_additional_principals_Values := IF ( (le.corp_additional_principals  IN SET(s.nulls_corp_additional_principals,corp_additional_principals) OR le.corp_additional_principals = (TYPEOF(le.corp_additional_principals))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_additional_principals)}],SALT34.Layout_FieldValueList));
  SELF.corp_address_office_type_Values := IF ( (le.corp_address_office_type  IN SET(s.nulls_corp_address_office_type,corp_address_office_type) OR le.corp_address_office_type = (TYPEOF(le.corp_address_office_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_address_office_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_assign_date_Values := IF ( (le.corp_agent_assign_date  IN SET(s.nulls_corp_agent_assign_date,corp_agent_assign_date) OR le.corp_agent_assign_date = (TYPEOF(le.corp_agent_assign_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_assign_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_commercial_Values := IF ( (le.corp_agent_commercial  IN SET(s.nulls_corp_agent_commercial,corp_agent_commercial) OR le.corp_agent_commercial = (TYPEOF(le.corp_agent_commercial))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_commercial)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_country_Values := IF ( (le.corp_agent_country  IN SET(s.nulls_corp_agent_country,corp_agent_country) OR le.corp_agent_country = (TYPEOF(le.corp_agent_country))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_country)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_county_Values := IF ( (le.corp_agent_county  IN SET(s.nulls_corp_agent_county,corp_agent_county) OR le.corp_agent_county = (TYPEOF(le.corp_agent_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_status_cd_Values := IF ( (le.corp_agent_status_cd  IN SET(s.nulls_corp_agent_status_cd,corp_agent_status_cd) OR le.corp_agent_status_cd = (TYPEOF(le.corp_agent_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_status_desc_Values := IF ( (le.corp_agent_status_desc  IN SET(s.nulls_corp_agent_status_desc,corp_agent_status_desc) OR le.corp_agent_status_desc = (TYPEOF(le.corp_agent_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_agent_id_Values := IF ( (le.corp_agent_id  IN SET(s.nulls_corp_agent_id,corp_agent_id) OR le.corp_agent_id = (TYPEOF(le.corp_agent_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agent_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_agriculture_flag_Values := IF ( (le.corp_agriculture_flag  IN SET(s.nulls_corp_agriculture_flag,corp_agriculture_flag) OR le.corp_agriculture_flag = (TYPEOF(le.corp_agriculture_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_agriculture_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_authorized_partners_Values := IF ( (le.corp_authorized_partners  IN SET(s.nulls_corp_authorized_partners,corp_authorized_partners) OR le.corp_authorized_partners = (TYPEOF(le.corp_authorized_partners))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_authorized_partners)}],SALT34.Layout_FieldValueList));
  SELF.corp_comment_Values := IF ( (le.corp_comment  IN SET(s.nulls_corp_comment,corp_comment) OR le.corp_comment = (TYPEOF(le.corp_comment))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_comment)}],SALT34.Layout_FieldValueList));
  SELF.corp_consent_flag_for_protected_name_Values := IF ( (le.corp_consent_flag_for_protected_name  IN SET(s.nulls_corp_consent_flag_for_protected_name,corp_consent_flag_for_protected_name) OR le.corp_consent_flag_for_protected_name = (TYPEOF(le.corp_consent_flag_for_protected_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_consent_flag_for_protected_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_converted_Values := IF ( (le.corp_converted  IN SET(s.nulls_corp_converted,corp_converted) OR le.corp_converted = (TYPEOF(le.corp_converted))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_converted)}],SALT34.Layout_FieldValueList));
  SELF.corp_converted_from_Values := IF ( (le.corp_converted_from  IN SET(s.nulls_corp_converted_from,corp_converted_from) OR le.corp_converted_from = (TYPEOF(le.corp_converted_from))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_converted_from)}],SALT34.Layout_FieldValueList));
  SELF.corp_country_of_formation_Values := IF ( (le.corp_country_of_formation  IN SET(s.nulls_corp_country_of_formation,corp_country_of_formation) OR le.corp_country_of_formation = (TYPEOF(le.corp_country_of_formation))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_country_of_formation)}],SALT34.Layout_FieldValueList));
  SELF.corp_date_of_organization_meeting_Values := IF ( (le.corp_date_of_organization_meeting  IN SET(s.nulls_corp_date_of_organization_meeting,corp_date_of_organization_meeting) OR le.corp_date_of_organization_meeting = (TYPEOF(le.corp_date_of_organization_meeting))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_date_of_organization_meeting)}],SALT34.Layout_FieldValueList));
  SELF.corp_delayed_effective_date_Values := IF ( (le.corp_delayed_effective_date  IN SET(s.nulls_corp_delayed_effective_date,corp_delayed_effective_date) OR le.corp_delayed_effective_date = (TYPEOF(le.corp_delayed_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_delayed_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_directors_from_to_Values := IF ( (le.corp_directors_from_to  IN SET(s.nulls_corp_directors_from_to,corp_directors_from_to) OR le.corp_directors_from_to = (TYPEOF(le.corp_directors_from_to))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_directors_from_to)}],SALT34.Layout_FieldValueList));
  SELF.corp_dissolved_date_Values := IF ( (le.corp_dissolved_date  IN SET(s.nulls_corp_dissolved_date,corp_dissolved_date) OR le.corp_dissolved_date = (TYPEOF(le.corp_dissolved_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_dissolved_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_exemptions_Values := IF ( (le.corp_farm_exemptions  IN SET(s.nulls_corp_farm_exemptions,corp_farm_exemptions) OR le.corp_farm_exemptions = (TYPEOF(le.corp_farm_exemptions))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_exemptions)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_qual_date_Values := IF ( (le.corp_farm_qual_date  IN SET(s.nulls_corp_farm_qual_date,corp_farm_qual_date) OR le.corp_farm_qual_date = (TYPEOF(le.corp_farm_qual_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_qual_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_status_cd_Values := IF ( (le.corp_farm_status_cd  IN SET(s.nulls_corp_farm_status_cd,corp_farm_status_cd) OR le.corp_farm_status_cd = (TYPEOF(le.corp_farm_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_farm_status_desc_Values := IF ( (le.corp_farm_status_desc  IN SET(s.nulls_corp_farm_status_desc,corp_farm_status_desc) OR le.corp_farm_status_desc = (TYPEOF(le.corp_farm_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_farm_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_fiscal_year_month_Values := IF ( (le.corp_fiscal_year_month  IN SET(s.nulls_corp_fiscal_year_month,corp_fiscal_year_month) OR le.corp_fiscal_year_month = (TYPEOF(le.corp_fiscal_year_month))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_fiscal_year_month)}],SALT34.Layout_FieldValueList));
  SELF.corp_foreign_fiduciary_capacity_in_state_Values := IF ( (le.corp_foreign_fiduciary_capacity_in_state  IN SET(s.nulls_corp_foreign_fiduciary_capacity_in_state,corp_foreign_fiduciary_capacity_in_state) OR le.corp_foreign_fiduciary_capacity_in_state = (TYPEOF(le.corp_foreign_fiduciary_capacity_in_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_foreign_fiduciary_capacity_in_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_governing_statute_Values := IF ( (le.corp_governing_statute  IN SET(s.nulls_corp_governing_statute,corp_governing_statute) OR le.corp_governing_statute = (TYPEOF(le.corp_governing_statute))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_governing_statute)}],SALT34.Layout_FieldValueList));
  SELF.corp_has_members_Values := IF ( (le.corp_has_members  IN SET(s.nulls_corp_has_members,corp_has_members) OR le.corp_has_members = (TYPEOF(le.corp_has_members))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_has_members)}],SALT34.Layout_FieldValueList));
  SELF.corp_has_vested_managers_Values := IF ( (le.corp_has_vested_managers  IN SET(s.nulls_corp_has_vested_managers,corp_has_vested_managers) OR le.corp_has_vested_managers = (TYPEOF(le.corp_has_vested_managers))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_has_vested_managers)}],SALT34.Layout_FieldValueList));
  SELF.corp_home_incorporated_county_Values := IF ( (le.corp_home_incorporated_county  IN SET(s.nulls_corp_home_incorporated_county,corp_home_incorporated_county) OR le.corp_home_incorporated_county = (TYPEOF(le.corp_home_incorporated_county))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_home_incorporated_county)}],SALT34.Layout_FieldValueList));
  SELF.corp_home_state_name_Values := IF ( (le.corp_home_state_name  IN SET(s.nulls_corp_home_state_name,corp_home_state_name) OR le.corp_home_state_name = (TYPEOF(le.corp_home_state_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_home_state_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_is_professional_Values := IF ( (le.corp_is_professional  IN SET(s.nulls_corp_is_professional,corp_is_professional) OR le.corp_is_professional = (TYPEOF(le.corp_is_professional))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_is_professional)}],SALT34.Layout_FieldValueList));
  SELF.corp_is_non_profit_irs_approved_Values := IF ( (le.corp_is_non_profit_irs_approved  IN SET(s.nulls_corp_is_non_profit_irs_approved,corp_is_non_profit_irs_approved) OR le.corp_is_non_profit_irs_approved = (TYPEOF(le.corp_is_non_profit_irs_approved))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_is_non_profit_irs_approved)}],SALT34.Layout_FieldValueList));
  SELF.corp_last_renewal_date_Values := IF ( (le.corp_last_renewal_date  IN SET(s.nulls_corp_last_renewal_date,corp_last_renewal_date) OR le.corp_last_renewal_date = (TYPEOF(le.corp_last_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_last_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_last_renewal_year_Values := IF ( (le.corp_last_renewal_year  IN SET(s.nulls_corp_last_renewal_year,corp_last_renewal_year) OR le.corp_last_renewal_year = (TYPEOF(le.corp_last_renewal_year))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_last_renewal_year)}],SALT34.Layout_FieldValueList));
  SELF.corp_license_type_Values := IF ( (le.corp_license_type  IN SET(s.nulls_corp_license_type,corp_license_type) OR le.corp_license_type = (TYPEOF(le.corp_license_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_license_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_llc_managed_desc_Values := IF ( (le.corp_llc_managed_desc  IN SET(s.nulls_corp_llc_managed_desc,corp_llc_managed_desc) OR le.corp_llc_managed_desc = (TYPEOF(le.corp_llc_managed_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_llc_managed_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_llc_managed_ind_Values := IF ( (le.corp_llc_managed_ind  IN SET(s.nulls_corp_llc_managed_ind,corp_llc_managed_ind) OR le.corp_llc_managed_ind = (TYPEOF(le.corp_llc_managed_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_llc_managed_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_management_desc_Values := IF ( (le.corp_management_desc  IN SET(s.nulls_corp_management_desc,corp_management_desc) OR le.corp_management_desc = (TYPEOF(le.corp_management_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_management_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_management_type_Values := IF ( (le.corp_management_type  IN SET(s.nulls_corp_management_type,corp_management_type) OR le.corp_management_type = (TYPEOF(le.corp_management_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_management_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_manager_managed_Values := IF ( (le.corp_manager_managed  IN SET(s.nulls_corp_manager_managed,corp_manager_managed) OR le.corp_manager_managed = (TYPEOF(le.corp_manager_managed))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_manager_managed)}],SALT34.Layout_FieldValueList));
  SELF.corp_merged_corporation_id_Values := IF ( (le.corp_merged_corporation_id  IN SET(s.nulls_corp_merged_corporation_id,corp_merged_corporation_id) OR le.corp_merged_corporation_id = (TYPEOF(le.corp_merged_corporation_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merged_corporation_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_merged_fein_Values := IF ( (le.corp_merged_fein  IN SET(s.nulls_corp_merged_fein,corp_merged_fein) OR le.corp_merged_fein = (TYPEOF(le.corp_merged_fein))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merged_fein)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_allowed_flag_Values := IF ( (le.corp_merger_allowed_flag  IN SET(s.nulls_corp_merger_allowed_flag,corp_merger_allowed_flag) OR le.corp_merger_allowed_flag = (TYPEOF(le.corp_merger_allowed_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_allowed_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_date_Values := IF ( (le.corp_merger_date  IN SET(s.nulls_corp_merger_date,corp_merger_date) OR le.corp_merger_date = (TYPEOF(le.corp_merger_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_desc_Values := IF ( (le.corp_merger_desc  IN SET(s.nulls_corp_merger_desc,corp_merger_desc) OR le.corp_merger_desc = (TYPEOF(le.corp_merger_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_effective_date_Values := IF ( (le.corp_merger_effective_date  IN SET(s.nulls_corp_merger_effective_date,corp_merger_effective_date) OR le.corp_merger_effective_date = (TYPEOF(le.corp_merger_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_id_Values := IF ( (le.corp_merger_id  IN SET(s.nulls_corp_merger_id,corp_merger_id) OR le.corp_merger_id = (TYPEOF(le.corp_merger_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_indicator_Values := IF ( (le.corp_merger_indicator  IN SET(s.nulls_corp_merger_indicator,corp_merger_indicator) OR le.corp_merger_indicator = (TYPEOF(le.corp_merger_indicator))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_indicator)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_name_Values := IF ( (le.corp_merger_name  IN SET(s.nulls_corp_merger_name,corp_merger_name) OR le.corp_merger_name = (TYPEOF(le.corp_merger_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_name)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_type_converted_to_cd_Values := IF ( (le.corp_merger_type_converted_to_cd  IN SET(s.nulls_corp_merger_type_converted_to_cd,corp_merger_type_converted_to_cd) OR le.corp_merger_type_converted_to_cd = (TYPEOF(le.corp_merger_type_converted_to_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_type_converted_to_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_merger_type_converted_to_desc_Values := IF ( (le.corp_merger_type_converted_to_desc  IN SET(s.nulls_corp_merger_type_converted_to_desc,corp_merger_type_converted_to_desc) OR le.corp_merger_type_converted_to_desc = (TYPEOF(le.corp_merger_type_converted_to_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_merger_type_converted_to_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_naics_desc_Values := IF ( (le.corp_naics_desc  IN SET(s.nulls_corp_naics_desc,corp_naics_desc) OR le.corp_naics_desc = (TYPEOF(le.corp_naics_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_naics_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_effective_date_Values := IF ( (le.corp_name_effective_date  IN SET(s.nulls_corp_name_effective_date,corp_name_effective_date) OR le.corp_name_effective_date = (TYPEOF(le.corp_name_effective_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_effective_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_date_Values := IF ( (le.corp_name_reservation_date  IN SET(s.nulls_corp_name_reservation_date,corp_name_reservation_date) OR le.corp_name_reservation_date = (TYPEOF(le.corp_name_reservation_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_desc_Values := IF ( (le.corp_name_reservation_desc  IN SET(s.nulls_corp_name_reservation_desc,corp_name_reservation_desc) OR le.corp_name_reservation_desc = (TYPEOF(le.corp_name_reservation_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_expiration_date_Values := IF ( (le.corp_name_reservation_expiration_date  IN SET(s.nulls_corp_name_reservation_expiration_date,corp_name_reservation_expiration_date) OR le.corp_name_reservation_expiration_date = (TYPEOF(le.corp_name_reservation_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_nbr_Values := IF ( (le.corp_name_reservation_nbr  IN SET(s.nulls_corp_name_reservation_nbr,corp_name_reservation_nbr) OR le.corp_name_reservation_nbr = (TYPEOF(le.corp_name_reservation_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_reservation_type_Values := IF ( (le.corp_name_reservation_type  IN SET(s.nulls_corp_name_reservation_type,corp_name_reservation_type) OR le.corp_name_reservation_type = (TYPEOF(le.corp_name_reservation_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_reservation_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_cd_Values := IF ( (le.corp_name_status_cd  IN SET(s.nulls_corp_name_status_cd,corp_name_status_cd) OR le.corp_name_status_cd = (TYPEOF(le.corp_name_status_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_date_Values := IF ( (le.corp_name_status_date  IN SET(s.nulls_corp_name_status_date,corp_name_status_date) OR le.corp_name_status_date = (TYPEOF(le.corp_name_status_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_name_status_desc_Values := IF ( (le.corp_name_status_desc  IN SET(s.nulls_corp_name_status_desc,corp_name_status_desc) OR le.corp_name_status_desc = (TYPEOF(le.corp_name_status_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_name_status_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_non_profit_irs_approved_purpose_Values := IF ( (le.corp_non_profit_irs_approved_purpose  IN SET(s.nulls_corp_non_profit_irs_approved_purpose,corp_non_profit_irs_approved_purpose) OR le.corp_non_profit_irs_approved_purpose = (TYPEOF(le.corp_non_profit_irs_approved_purpose))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_non_profit_irs_approved_purpose)}],SALT34.Layout_FieldValueList));
  SELF.corp_non_profit_solicit_donations_Values := IF ( (le.corp_non_profit_solicit_donations  IN SET(s.nulls_corp_non_profit_solicit_donations,corp_non_profit_solicit_donations) OR le.corp_non_profit_solicit_donations = (TYPEOF(le.corp_non_profit_solicit_donations))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_non_profit_solicit_donations)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_amendments_Values := IF ( (le.corp_nbr_of_amendments  IN SET(s.nulls_corp_nbr_of_amendments,corp_nbr_of_amendments) OR le.corp_nbr_of_amendments = (TYPEOF(le.corp_nbr_of_amendments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_amendments)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_initial_llc_members_Values := IF ( (le.corp_nbr_of_initial_llc_members  IN SET(s.nulls_corp_nbr_of_initial_llc_members,corp_nbr_of_initial_llc_members) OR le.corp_nbr_of_initial_llc_members = (TYPEOF(le.corp_nbr_of_initial_llc_members))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_initial_llc_members)}],SALT34.Layout_FieldValueList));
  SELF.corp_nbr_of_partners_Values := IF ( (le.corp_nbr_of_partners  IN SET(s.nulls_corp_nbr_of_partners,corp_nbr_of_partners) OR le.corp_nbr_of_partners = (TYPEOF(le.corp_nbr_of_partners))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_nbr_of_partners)}],SALT34.Layout_FieldValueList));
  SELF.corp_operating_agreement_Values := IF ( (le.corp_operating_agreement  IN SET(s.nulls_corp_operating_agreement,corp_operating_agreement) OR le.corp_operating_agreement = (TYPEOF(le.corp_operating_agreement))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_operating_agreement)}],SALT34.Layout_FieldValueList));
  SELF.corp_opt_in_llc_act_desc_Values := IF ( (le.corp_opt_in_llc_act_desc  IN SET(s.nulls_corp_opt_in_llc_act_desc,corp_opt_in_llc_act_desc) OR le.corp_opt_in_llc_act_desc = (TYPEOF(le.corp_opt_in_llc_act_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_opt_in_llc_act_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_opt_in_llc_act_ind_Values := IF ( (le.corp_opt_in_llc_act_ind  IN SET(s.nulls_corp_opt_in_llc_act_ind,corp_opt_in_llc_act_ind) OR le.corp_opt_in_llc_act_ind = (TYPEOF(le.corp_opt_in_llc_act_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_opt_in_llc_act_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_organizational_comments_Values := IF ( (le.corp_organizational_comments  IN SET(s.nulls_corp_organizational_comments,corp_organizational_comments) OR le.corp_organizational_comments = (TYPEOF(le.corp_organizational_comments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_organizational_comments)}],SALT34.Layout_FieldValueList));
  SELF.corp_partner_contributions_total_Values := IF ( (le.corp_partner_contributions_total  IN SET(s.nulls_corp_partner_contributions_total,corp_partner_contributions_total) OR le.corp_partner_contributions_total = (TYPEOF(le.corp_partner_contributions_total))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partner_contributions_total)}],SALT34.Layout_FieldValueList));
  SELF.corp_partner_terms_Values := IF ( (le.corp_partner_terms  IN SET(s.nulls_corp_partner_terms,corp_partner_terms) OR le.corp_partner_terms = (TYPEOF(le.corp_partner_terms))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_partner_terms)}],SALT34.Layout_FieldValueList));
  SELF.corp_percentage_voters_required_to_approve_amendments_Values := IF ( (le.corp_percentage_voters_required_to_approve_amendments  IN SET(s.nulls_corp_percentage_voters_required_to_approve_amendments,corp_percentage_voters_required_to_approve_amendments) OR le.corp_percentage_voters_required_to_approve_amendments = (TYPEOF(le.corp_percentage_voters_required_to_approve_amendments))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_percentage_voters_required_to_approve_amendments)}],SALT34.Layout_FieldValueList));
  SELF.corp_profession_Values := IF ( (le.corp_profession  IN SET(s.nulls_corp_profession,corp_profession) OR le.corp_profession = (TYPEOF(le.corp_profession))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_profession)}],SALT34.Layout_FieldValueList));
  SELF.corp_province_Values := IF ( (le.corp_province  IN SET(s.nulls_corp_province,corp_province) OR le.corp_province = (TYPEOF(le.corp_province))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_province)}],SALT34.Layout_FieldValueList));
  SELF.corp_public_mutual_corporation_Values := IF ( (le.corp_public_mutual_corporation  IN SET(s.nulls_corp_public_mutual_corporation,corp_public_mutual_corporation) OR le.corp_public_mutual_corporation = (TYPEOF(le.corp_public_mutual_corporation))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_public_mutual_corporation)}],SALT34.Layout_FieldValueList));
  SELF.corp_purpose_Values := IF ( (le.corp_purpose  IN SET(s.nulls_corp_purpose,corp_purpose) OR le.corp_purpose = (TYPEOF(le.corp_purpose))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_purpose)}],SALT34.Layout_FieldValueList));
  SELF.corp_ra_required_flag_Values := IF ( (le.corp_ra_required_flag  IN SET(s.nulls_corp_ra_required_flag,corp_ra_required_flag) OR le.corp_ra_required_flag = (TYPEOF(le.corp_ra_required_flag))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_ra_required_flag)}],SALT34.Layout_FieldValueList));
  SELF.corp_registered_counties_Values := IF ( (le.corp_registered_counties  IN SET(s.nulls_corp_registered_counties,corp_registered_counties) OR le.corp_registered_counties = (TYPEOF(le.corp_registered_counties))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_registered_counties)}],SALT34.Layout_FieldValueList));
  SELF.corp_regulated_ind_Values := IF ( (le.corp_regulated_ind  IN SET(s.nulls_corp_regulated_ind,corp_regulated_ind) OR le.corp_regulated_ind = (TYPEOF(le.corp_regulated_ind))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_regulated_ind)}],SALT34.Layout_FieldValueList));
  SELF.corp_renewal_date_Values := IF ( (le.corp_renewal_date  IN SET(s.nulls_corp_renewal_date,corp_renewal_date) OR le.corp_renewal_date = (TYPEOF(le.corp_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_standing_other_Values := IF ( (le.corp_standing_other  IN SET(s.nulls_corp_standing_other,corp_standing_other) OR le.corp_standing_other = (TYPEOF(le.corp_standing_other))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_standing_other)}],SALT34.Layout_FieldValueList));
  SELF.corp_survivor_corporation_id_Values := IF ( (le.corp_survivor_corporation_id  IN SET(s.nulls_corp_survivor_corporation_id,corp_survivor_corporation_id) OR le.corp_survivor_corporation_id = (TYPEOF(le.corp_survivor_corporation_id))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_survivor_corporation_id)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_base_Values := IF ( (le.corp_tax_base  IN SET(s.nulls_corp_tax_base,corp_tax_base) OR le.corp_tax_base = (TYPEOF(le.corp_tax_base))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_base)}],SALT34.Layout_FieldValueList));
  SELF.corp_tax_standing_Values := IF ( (le.corp_tax_standing  IN SET(s.nulls_corp_tax_standing,corp_tax_standing) OR le.corp_tax_standing = (TYPEOF(le.corp_tax_standing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_tax_standing)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_cd_Values := IF ( (le.corp_termination_cd  IN SET(s.nulls_corp_termination_cd,corp_termination_cd) OR le.corp_termination_cd = (TYPEOF(le.corp_termination_cd))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_cd)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_desc_Values := IF ( (le.corp_termination_desc  IN SET(s.nulls_corp_termination_desc,corp_termination_desc) OR le.corp_termination_desc = (TYPEOF(le.corp_termination_desc))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_desc)}],SALT34.Layout_FieldValueList));
  SELF.corp_termination_date_Values := IF ( (le.corp_termination_date  IN SET(s.nulls_corp_termination_date,corp_termination_date) OR le.corp_termination_date = (TYPEOF(le.corp_termination_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_termination_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_business_mark_type_Values := IF ( (le.corp_trademark_business_mark_type  IN SET(s.nulls_corp_trademark_business_mark_type,corp_trademark_business_mark_type) OR le.corp_trademark_business_mark_type = (TYPEOF(le.corp_trademark_business_mark_type))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_business_mark_type)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_cancelled_date_Values := IF ( (le.corp_trademark_cancelled_date  IN SET(s.nulls_corp_trademark_cancelled_date,corp_trademark_cancelled_date) OR le.corp_trademark_cancelled_date = (TYPEOF(le.corp_trademark_cancelled_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_cancelled_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc1_Values := IF ( (le.corp_trademark_class_desc1  IN SET(s.nulls_corp_trademark_class_desc1,corp_trademark_class_desc1) OR le.corp_trademark_class_desc1 = (TYPEOF(le.corp_trademark_class_desc1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc2_Values := IF ( (le.corp_trademark_class_desc2  IN SET(s.nulls_corp_trademark_class_desc2,corp_trademark_class_desc2) OR le.corp_trademark_class_desc2 = (TYPEOF(le.corp_trademark_class_desc2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc3_Values := IF ( (le.corp_trademark_class_desc3  IN SET(s.nulls_corp_trademark_class_desc3,corp_trademark_class_desc3) OR le.corp_trademark_class_desc3 = (TYPEOF(le.corp_trademark_class_desc3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc3)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc4_Values := IF ( (le.corp_trademark_class_desc4  IN SET(s.nulls_corp_trademark_class_desc4,corp_trademark_class_desc4) OR le.corp_trademark_class_desc4 = (TYPEOF(le.corp_trademark_class_desc4))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc4)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc5_Values := IF ( (le.corp_trademark_class_desc5  IN SET(s.nulls_corp_trademark_class_desc5,corp_trademark_class_desc5) OR le.corp_trademark_class_desc5 = (TYPEOF(le.corp_trademark_class_desc5))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc5)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_class_desc6_Values := IF ( (le.corp_trademark_class_desc6  IN SET(s.nulls_corp_trademark_class_desc6,corp_trademark_class_desc6) OR le.corp_trademark_class_desc6 = (TYPEOF(le.corp_trademark_class_desc6))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_class_desc6)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_classification_nbr_Values := IF ( (le.corp_trademark_classification_nbr  IN SET(s.nulls_corp_trademark_classification_nbr,corp_trademark_classification_nbr) OR le.corp_trademark_classification_nbr = (TYPEOF(le.corp_trademark_classification_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_classification_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_disclaimer1_Values := IF ( (le.corp_trademark_disclaimer1  IN SET(s.nulls_corp_trademark_disclaimer1,corp_trademark_disclaimer1) OR le.corp_trademark_disclaimer1 = (TYPEOF(le.corp_trademark_disclaimer1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_disclaimer1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_disclaimer2_Values := IF ( (le.corp_trademark_disclaimer2  IN SET(s.nulls_corp_trademark_disclaimer2,corp_trademark_disclaimer2) OR le.corp_trademark_disclaimer2 = (TYPEOF(le.corp_trademark_disclaimer2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_disclaimer2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_expiration_date_Values := IF ( (le.corp_trademark_expiration_date  IN SET(s.nulls_corp_trademark_expiration_date,corp_trademark_expiration_date) OR le.corp_trademark_expiration_date = (TYPEOF(le.corp_trademark_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_filing_date_Values := IF ( (le.corp_trademark_filing_date  IN SET(s.nulls_corp_trademark_filing_date,corp_trademark_filing_date) OR le.corp_trademark_filing_date = (TYPEOF(le.corp_trademark_filing_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_filing_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_first_use_date_Values := IF ( (le.corp_trademark_first_use_date  IN SET(s.nulls_corp_trademark_first_use_date,corp_trademark_first_use_date) OR le.corp_trademark_first_use_date = (TYPEOF(le.corp_trademark_first_use_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_first_use_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_first_use_date_in_state_Values := IF ( (le.corp_trademark_first_use_date_in_state  IN SET(s.nulls_corp_trademark_first_use_date_in_state,corp_trademark_first_use_date_in_state) OR le.corp_trademark_first_use_date_in_state = (TYPEOF(le.corp_trademark_first_use_date_in_state))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_first_use_date_in_state)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_keywords_Values := IF ( (le.corp_trademark_keywords  IN SET(s.nulls_corp_trademark_keywords,corp_trademark_keywords) OR le.corp_trademark_keywords = (TYPEOF(le.corp_trademark_keywords))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_keywords)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_logo_Values := IF ( (le.corp_trademark_logo  IN SET(s.nulls_corp_trademark_logo,corp_trademark_logo) OR le.corp_trademark_logo = (TYPEOF(le.corp_trademark_logo))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_logo)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_name_expiration_date_Values := IF ( (le.corp_trademark_name_expiration_date  IN SET(s.nulls_corp_trademark_name_expiration_date,corp_trademark_name_expiration_date) OR le.corp_trademark_name_expiration_date = (TYPEOF(le.corp_trademark_name_expiration_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_name_expiration_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_nbr_Values := IF ( (le.corp_trademark_nbr  IN SET(s.nulls_corp_trademark_nbr,corp_trademark_nbr) OR le.corp_trademark_nbr = (TYPEOF(le.corp_trademark_nbr))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_nbr)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_renewal_date_Values := IF ( (le.corp_trademark_renewal_date  IN SET(s.nulls_corp_trademark_renewal_date,corp_trademark_renewal_date) OR le.corp_trademark_renewal_date = (TYPEOF(le.corp_trademark_renewal_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_renewal_date)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_status_Values := IF ( (le.corp_trademark_status  IN SET(s.nulls_corp_trademark_status,corp_trademark_status) OR le.corp_trademark_status = (TYPEOF(le.corp_trademark_status))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_status)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_1_Values := IF ( (le.corp_trademark_used_1  IN SET(s.nulls_corp_trademark_used_1,corp_trademark_used_1) OR le.corp_trademark_used_1 = (TYPEOF(le.corp_trademark_used_1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_1)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_2_Values := IF ( (le.corp_trademark_used_2  IN SET(s.nulls_corp_trademark_used_2,corp_trademark_used_2) OR le.corp_trademark_used_2 = (TYPEOF(le.corp_trademark_used_2))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_2)}],SALT34.Layout_FieldValueList));
  SELF.corp_trademark_used_3_Values := IF ( (le.corp_trademark_used_3  IN SET(s.nulls_corp_trademark_used_3,corp_trademark_used_3) OR le.corp_trademark_used_3 = (TYPEOF(le.corp_trademark_used_3))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.corp_trademark_used_3)}],SALT34.Layout_FieldValueList));
  SELF.cont_owner_percentage_Values := IF ( (le.cont_owner_percentage  IN SET(s.nulls_cont_owner_percentage,cont_owner_percentage) OR le.cont_owner_percentage = (TYPEOF(le.cont_owner_percentage))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_owner_percentage)}],SALT34.Layout_FieldValueList));
  SELF.cont_country_Values := IF ( (le.cont_country  IN SET(s.nulls_cont_country,cont_country) OR le.cont_country = (TYPEOF(le.cont_country))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_country)}],SALT34.Layout_FieldValueList));
  SELF.cont_country_mailing_Values := IF ( (le.cont_country_mailing  IN SET(s.nulls_cont_country_mailing,cont_country_mailing) OR le.cont_country_mailing = (TYPEOF(le.cont_country_mailing))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_country_mailing)}],SALT34.Layout_FieldValueList));
  SELF.cont_nondislosure_Values := IF ( (le.cont_nondislosure  IN SET(s.nulls_cont_nondislosure,cont_nondislosure) OR le.cont_nondislosure = (TYPEOF(le.cont_nondislosure))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_nondislosure)}],SALT34.Layout_FieldValueList));
  SELF.cont_prep_addr_line1_Values := IF ( (le.cont_prep_addr_line1  IN SET(s.nulls_cont_prep_addr_line1,cont_prep_addr_line1) OR le.cont_prep_addr_line1 = (TYPEOF(le.cont_prep_addr_line1))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_prep_addr_line1)}],SALT34.Layout_FieldValueList));
  SELF.cont_prep_addr_last_line_Values := IF ( (le.cont_prep_addr_last_line  IN SET(s.nulls_cont_prep_addr_last_line,cont_prep_addr_last_line) OR le.cont_prep_addr_last_line = (TYPEOF(le.cont_prep_addr_last_line))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.cont_prep_addr_last_line)}],SALT34.Layout_FieldValueList));
  SELF.recordorigin_Values := IF ( (le.recordorigin  IN SET(s.nulls_recordorigin,recordorigin) OR le.recordorigin = (TYPEOF(le.recordorigin))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recordorigin)}],SALT34.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 dt_vendor_first_reported_size := 0;
  UNSIGNED1 dt_vendor_last_reported_size := 0;
  UNSIGNED1 dt_first_seen_size := 0;
  UNSIGNED1 dt_last_seen_size := 0;
  UNSIGNED1 corp_ra_dt_first_seen_size := 0;
  UNSIGNED1 corp_ra_dt_last_seen_size := 0;
  UNSIGNED1 corp_key_size := 0;
  UNSIGNED1 corp_supp_key_size := 0;
  UNSIGNED1 corp_vendor_size := 0;
  UNSIGNED1 corp_vendor_county_size := 0;
  UNSIGNED1 corp_vendor_subcode_size := 0;
  UNSIGNED1 corp_state_origin_size := 0;
  UNSIGNED1 corp_process_date_size := 0;
  UNSIGNED1 corp_orig_sos_charter_nbr_size := 0;
  UNSIGNED1 corp_legal_name_size := 0;
  UNSIGNED1 corp_ln_name_type_cd_size := 0;
  UNSIGNED1 corp_ln_name_type_desc_size := 0;
  UNSIGNED1 corp_supp_nbr_size := 0;
  UNSIGNED1 corp_name_comment_size := 0;
  UNSIGNED1 corp_address1_type_cd_size := 0;
  UNSIGNED1 corp_address1_type_desc_size := 0;
  UNSIGNED1 corp_address1_line1_size := 0;
  UNSIGNED1 corp_address1_line2_size := 0;
  UNSIGNED1 corp_address1_line3_size := 0;
  UNSIGNED1 corp_address1_effective_date_size := 0;
  UNSIGNED1 corp_address2_type_cd_size := 0;
  UNSIGNED1 corp_address2_type_desc_size := 0;
  UNSIGNED1 corp_address2_line1_size := 0;
  UNSIGNED1 corp_address2_line2_size := 0;
  UNSIGNED1 corp_address2_line3_size := 0;
  UNSIGNED1 corp_address2_effective_date_size := 0;
  UNSIGNED1 corp_phone_number_size := 0;
  UNSIGNED1 corp_phone_number_type_cd_size := 0;
  UNSIGNED1 corp_phone_number_type_desc_size := 0;
  UNSIGNED1 corp_fax_nbr_size := 0;
  UNSIGNED1 corp_email_address_size := 0;
  UNSIGNED1 corp_web_address_size := 0;
  UNSIGNED1 corp_filing_reference_nbr_size := 0;
  UNSIGNED1 corp_filing_date_size := 0;
  UNSIGNED1 corp_filing_cd_size := 0;
  UNSIGNED1 corp_filing_desc_size := 0;
  UNSIGNED1 corp_status_cd_size := 0;
  UNSIGNED1 corp_status_desc_size := 0;
  UNSIGNED1 corp_status_date_size := 0;
  UNSIGNED1 corp_standing_size := 0;
  UNSIGNED1 corp_status_comment_size := 0;
  UNSIGNED1 corp_ticker_symbol_size := 0;
  UNSIGNED1 corp_stock_exchange_size := 0;
  UNSIGNED1 corp_inc_state_size := 0;
  UNSIGNED1 corp_inc_county_size := 0;
  UNSIGNED1 corp_inc_date_size := 0;
  UNSIGNED1 corp_anniversary_month_size := 0;
  UNSIGNED1 corp_fed_tax_id_size := 0;
  UNSIGNED1 corp_state_tax_id_size := 0;
  UNSIGNED1 corp_term_exist_cd_size := 0;
  UNSIGNED1 corp_term_exist_exp_size := 0;
  UNSIGNED1 corp_term_exist_desc_size := 0;
  UNSIGNED1 corp_foreign_domestic_ind_size := 0;
  UNSIGNED1 corp_forgn_state_cd_size := 0;
  UNSIGNED1 corp_forgn_state_desc_size := 0;
  UNSIGNED1 corp_forgn_sos_charter_nbr_size := 0;
  UNSIGNED1 corp_forgn_date_size := 0;
  UNSIGNED1 corp_forgn_fed_tax_id_size := 0;
  UNSIGNED1 corp_forgn_state_tax_id_size := 0;
  UNSIGNED1 corp_forgn_term_exist_cd_size := 0;
  UNSIGNED1 corp_forgn_term_exist_exp_size := 0;
  UNSIGNED1 corp_forgn_term_exist_desc_size := 0;
  UNSIGNED1 corp_orig_org_structure_cd_size := 0;
  UNSIGNED1 corp_orig_org_structure_desc_size := 0;
  UNSIGNED1 corp_for_profit_ind_size := 0;
  UNSIGNED1 corp_public_or_private_ind_size := 0;
  UNSIGNED1 corp_sic_code_size := 0;
  UNSIGNED1 corp_naic_code_size := 0;
  UNSIGNED1 corp_orig_bus_type_cd_size := 0;
  UNSIGNED1 corp_orig_bus_type_desc_size := 0;
  UNSIGNED1 corp_entity_desc_size := 0;
  UNSIGNED1 corp_certificate_nbr_size := 0;
  UNSIGNED1 corp_internal_nbr_size := 0;
  UNSIGNED1 corp_previous_nbr_size := 0;
  UNSIGNED1 corp_microfilm_nbr_size := 0;
  UNSIGNED1 corp_amendments_filed_size := 0;
  UNSIGNED1 corp_acts_size := 0;
  UNSIGNED1 corp_partnership_ind_size := 0;
  UNSIGNED1 corp_mfg_ind_size := 0;
  UNSIGNED1 corp_addl_info_size := 0;
  UNSIGNED1 corp_taxes_size := 0;
  UNSIGNED1 corp_franchise_taxes_size := 0;
  UNSIGNED1 corp_tax_program_cd_size := 0;
  UNSIGNED1 corp_tax_program_desc_size := 0;
  UNSIGNED1 corp_ra_full_name_size := 0;
  UNSIGNED1 corp_ra_fname_size := 0;
  UNSIGNED1 corp_ra_mname_size := 0;
  UNSIGNED1 corp_ra_lname_size := 0;
  UNSIGNED1 corp_ra_suffix_size := 0;
  UNSIGNED1 corp_ra_title_cd_size := 0;
  UNSIGNED1 corp_ra_title_desc_size := 0;
  UNSIGNED1 corp_ra_fein_size := 0;
  UNSIGNED1 corp_ra_ssn_size := 0;
  UNSIGNED1 corp_ra_dob_size := 0;
  UNSIGNED1 corp_ra_effective_date_size := 0;
  UNSIGNED1 corp_ra_resign_date_size := 0;
  UNSIGNED1 corp_ra_no_comp_size := 0;
  UNSIGNED1 corp_ra_no_comp_igs_size := 0;
  UNSIGNED1 corp_ra_addl_info_size := 0;
  UNSIGNED1 corp_ra_address_type_cd_size := 0;
  UNSIGNED1 corp_ra_address_type_desc_size := 0;
  UNSIGNED1 corp_ra_address_line1_size := 0;
  UNSIGNED1 corp_ra_address_line2_size := 0;
  UNSIGNED1 corp_ra_address_line3_size := 0;
  UNSIGNED1 corp_ra_phone_number_size := 0;
  UNSIGNED1 corp_ra_phone_number_type_cd_size := 0;
  UNSIGNED1 corp_ra_phone_number_type_desc_size := 0;
  UNSIGNED1 corp_ra_fax_nbr_size := 0;
  UNSIGNED1 corp_ra_email_address_size := 0;
  UNSIGNED1 corp_ra_web_address_size := 0;
  UNSIGNED1 corp_prep_addr1_line1_size := 0;
  UNSIGNED1 corp_prep_addr1_last_line_size := 0;
  UNSIGNED1 corp_prep_addr2_line1_size := 0;
  UNSIGNED1 corp_prep_addr2_last_line_size := 0;
  UNSIGNED1 ra_prep_addr_line1_size := 0;
  UNSIGNED1 ra_prep_addr_last_line_size := 0;
  UNSIGNED1 cont_filing_reference_nbr_size := 0;
  UNSIGNED1 cont_filing_date_size := 0;
  UNSIGNED1 cont_filing_cd_size := 0;
  UNSIGNED1 cont_filing_desc_size := 0;
  UNSIGNED1 cont_type_cd_size := 0;
  UNSIGNED1 cont_type_desc_size := 0;
  UNSIGNED1 cont_full_name_size := 0;
  UNSIGNED1 cont_fname_size := 0;
  UNSIGNED1 cont_mname_size := 0;
  UNSIGNED1 cont_lname_size := 0;
  UNSIGNED1 cont_suffix_size := 0;
  UNSIGNED1 cont_title1_desc_size := 0;
  UNSIGNED1 cont_title2_desc_size := 0;
  UNSIGNED1 cont_title3_desc_size := 0;
  UNSIGNED1 cont_title4_desc_size := 0;
  UNSIGNED1 cont_title5_desc_size := 0;
  UNSIGNED1 cont_fein_size := 0;
  UNSIGNED1 cont_ssn_size := 0;
  UNSIGNED1 cont_dob_size := 0;
  UNSIGNED1 cont_status_cd_size := 0;
  UNSIGNED1 cont_status_desc_size := 0;
  UNSIGNED1 cont_effective_date_size := 0;
  UNSIGNED1 cont_effective_cd_size := 0;
  UNSIGNED1 cont_effective_desc_size := 0;
  UNSIGNED1 cont_addl_info_size := 0;
  UNSIGNED1 cont_address_type_cd_size := 0;
  UNSIGNED1 cont_address_type_desc_size := 0;
  UNSIGNED1 cont_address_line1_size := 0;
  UNSIGNED1 cont_address_line2_size := 0;
  UNSIGNED1 cont_address_line3_size := 0;
  UNSIGNED1 cont_address_effective_date_size := 0;
  UNSIGNED1 cont_address_county_size := 0;
  UNSIGNED1 cont_phone_number_size := 0;
  UNSIGNED1 cont_phone_number_type_cd_size := 0;
  UNSIGNED1 cont_phone_number_type_desc_size := 0;
  UNSIGNED1 cont_fax_nbr_size := 0;
  UNSIGNED1 cont_email_address_size := 0;
  UNSIGNED1 cont_web_address_size := 0;
  UNSIGNED1 corp_acres_size := 0;
  UNSIGNED1 corp_action_size := 0;
  UNSIGNED1 corp_action_date_size := 0;
  UNSIGNED1 corp_action_employment_security_approval_date_size := 0;
  UNSIGNED1 corp_action_pending_cd_size := 0;
  UNSIGNED1 corp_action_pending_desc_size := 0;
  UNSIGNED1 corp_action_statement_of_intent_date_size := 0;
  UNSIGNED1 corp_action_tax_dept_approval_date_size := 0;
  UNSIGNED1 corp_acts2_size := 0;
  UNSIGNED1 corp_acts3_size := 0;
  UNSIGNED1 corp_additional_principals_size := 0;
  UNSIGNED1 corp_address_office_type_size := 0;
  UNSIGNED1 corp_agent_assign_date_size := 0;
  UNSIGNED1 corp_agent_commercial_size := 0;
  UNSIGNED1 corp_agent_country_size := 0;
  UNSIGNED1 corp_agent_county_size := 0;
  UNSIGNED1 corp_agent_status_cd_size := 0;
  UNSIGNED1 corp_agent_status_desc_size := 0;
  UNSIGNED1 corp_agent_id_size := 0;
  UNSIGNED1 corp_agriculture_flag_size := 0;
  UNSIGNED1 corp_authorized_partners_size := 0;
  UNSIGNED1 corp_comment_size := 0;
  UNSIGNED1 corp_consent_flag_for_protected_name_size := 0;
  UNSIGNED1 corp_converted_size := 0;
  UNSIGNED1 corp_converted_from_size := 0;
  UNSIGNED1 corp_country_of_formation_size := 0;
  UNSIGNED1 corp_date_of_organization_meeting_size := 0;
  UNSIGNED1 corp_delayed_effective_date_size := 0;
  UNSIGNED1 corp_directors_from_to_size := 0;
  UNSIGNED1 corp_dissolved_date_size := 0;
  UNSIGNED1 corp_farm_exemptions_size := 0;
  UNSIGNED1 corp_farm_qual_date_size := 0;
  UNSIGNED1 corp_farm_status_cd_size := 0;
  UNSIGNED1 corp_farm_status_desc_size := 0;
  UNSIGNED1 corp_fiscal_year_month_size := 0;
  UNSIGNED1 corp_foreign_fiduciary_capacity_in_state_size := 0;
  UNSIGNED1 corp_governing_statute_size := 0;
  UNSIGNED1 corp_has_members_size := 0;
  UNSIGNED1 corp_has_vested_managers_size := 0;
  UNSIGNED1 corp_home_incorporated_county_size := 0;
  UNSIGNED1 corp_home_state_name_size := 0;
  UNSIGNED1 corp_is_professional_size := 0;
  UNSIGNED1 corp_is_non_profit_irs_approved_size := 0;
  UNSIGNED1 corp_last_renewal_date_size := 0;
  UNSIGNED1 corp_last_renewal_year_size := 0;
  UNSIGNED1 corp_license_type_size := 0;
  UNSIGNED1 corp_llc_managed_desc_size := 0;
  UNSIGNED1 corp_llc_managed_ind_size := 0;
  UNSIGNED1 corp_management_desc_size := 0;
  UNSIGNED1 corp_management_type_size := 0;
  UNSIGNED1 corp_manager_managed_size := 0;
  UNSIGNED1 corp_merged_corporation_id_size := 0;
  UNSIGNED1 corp_merged_fein_size := 0;
  UNSIGNED1 corp_merger_allowed_flag_size := 0;
  UNSIGNED1 corp_merger_date_size := 0;
  UNSIGNED1 corp_merger_desc_size := 0;
  UNSIGNED1 corp_merger_effective_date_size := 0;
  UNSIGNED1 corp_merger_id_size := 0;
  UNSIGNED1 corp_merger_indicator_size := 0;
  UNSIGNED1 corp_merger_name_size := 0;
  UNSIGNED1 corp_merger_type_converted_to_cd_size := 0;
  UNSIGNED1 corp_merger_type_converted_to_desc_size := 0;
  UNSIGNED1 corp_naics_desc_size := 0;
  UNSIGNED1 corp_name_effective_date_size := 0;
  UNSIGNED1 corp_name_reservation_date_size := 0;
  UNSIGNED1 corp_name_reservation_desc_size := 0;
  UNSIGNED1 corp_name_reservation_expiration_date_size := 0;
  UNSIGNED1 corp_name_reservation_nbr_size := 0;
  UNSIGNED1 corp_name_reservation_type_size := 0;
  UNSIGNED1 corp_name_status_cd_size := 0;
  UNSIGNED1 corp_name_status_date_size := 0;
  UNSIGNED1 corp_name_status_desc_size := 0;
  UNSIGNED1 corp_non_profit_irs_approved_purpose_size := 0;
  UNSIGNED1 corp_non_profit_solicit_donations_size := 0;
  UNSIGNED1 corp_nbr_of_amendments_size := 0;
  UNSIGNED1 corp_nbr_of_initial_llc_members_size := 0;
  UNSIGNED1 corp_nbr_of_partners_size := 0;
  UNSIGNED1 corp_operating_agreement_size := 0;
  UNSIGNED1 corp_opt_in_llc_act_desc_size := 0;
  UNSIGNED1 corp_opt_in_llc_act_ind_size := 0;
  UNSIGNED1 corp_organizational_comments_size := 0;
  UNSIGNED1 corp_partner_contributions_total_size := 0;
  UNSIGNED1 corp_partner_terms_size := 0;
  UNSIGNED1 corp_percentage_voters_required_to_approve_amendments_size := 0;
  UNSIGNED1 corp_profession_size := 0;
  UNSIGNED1 corp_province_size := 0;
  UNSIGNED1 corp_public_mutual_corporation_size := 0;
  UNSIGNED1 corp_purpose_size := 0;
  UNSIGNED1 corp_ra_required_flag_size := 0;
  UNSIGNED1 corp_registered_counties_size := 0;
  UNSIGNED1 corp_regulated_ind_size := 0;
  UNSIGNED1 corp_renewal_date_size := 0;
  UNSIGNED1 corp_standing_other_size := 0;
  UNSIGNED1 corp_survivor_corporation_id_size := 0;
  UNSIGNED1 corp_tax_base_size := 0;
  UNSIGNED1 corp_tax_standing_size := 0;
  UNSIGNED1 corp_termination_cd_size := 0;
  UNSIGNED1 corp_termination_desc_size := 0;
  UNSIGNED1 corp_termination_date_size := 0;
  UNSIGNED1 corp_trademark_business_mark_type_size := 0;
  UNSIGNED1 corp_trademark_cancelled_date_size := 0;
  UNSIGNED1 corp_trademark_class_desc1_size := 0;
  UNSIGNED1 corp_trademark_class_desc2_size := 0;
  UNSIGNED1 corp_trademark_class_desc3_size := 0;
  UNSIGNED1 corp_trademark_class_desc4_size := 0;
  UNSIGNED1 corp_trademark_class_desc5_size := 0;
  UNSIGNED1 corp_trademark_class_desc6_size := 0;
  UNSIGNED1 corp_trademark_classification_nbr_size := 0;
  UNSIGNED1 corp_trademark_disclaimer1_size := 0;
  UNSIGNED1 corp_trademark_disclaimer2_size := 0;
  UNSIGNED1 corp_trademark_expiration_date_size := 0;
  UNSIGNED1 corp_trademark_filing_date_size := 0;
  UNSIGNED1 corp_trademark_first_use_date_size := 0;
  UNSIGNED1 corp_trademark_first_use_date_in_state_size := 0;
  UNSIGNED1 corp_trademark_keywords_size := 0;
  UNSIGNED1 corp_trademark_logo_size := 0;
  UNSIGNED1 corp_trademark_name_expiration_date_size := 0;
  UNSIGNED1 corp_trademark_nbr_size := 0;
  UNSIGNED1 corp_trademark_renewal_date_size := 0;
  UNSIGNED1 corp_trademark_status_size := 0;
  UNSIGNED1 corp_trademark_used_1_size := 0;
  UNSIGNED1 corp_trademark_used_2_size := 0;
  UNSIGNED1 corp_trademark_used_3_size := 0;
  UNSIGNED1 cont_owner_percentage_size := 0;
  UNSIGNED1 cont_country_size := 0;
  UNSIGNED1 cont_country_mailing_size := 0;
  UNSIGNED1 cont_nondislosure_size := 0;
  UNSIGNED1 cont_prep_addr_line1_size := 0;
  UNSIGNED1 cont_prep_addr_last_line_size := 0;
  UNSIGNED1 recordorigin_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.dt_vendor_first_reported_size := SALT34.Fn_SwitchSpec(MAX(s.dt_vendor_first_reported_day_switch,s.dt_vendor_first_reported_month_switch,s.dt_vendor_first_reported_year_switch),count(le.dt_vendor_first_reported_values));
  SELF.dt_vendor_last_reported_size := SALT34.Fn_SwitchSpec(MAX(s.dt_vendor_last_reported_day_switch,s.dt_vendor_last_reported_month_switch,s.dt_vendor_last_reported_year_switch),count(le.dt_vendor_last_reported_values));
  SELF.dt_first_seen_size := SALT34.Fn_SwitchSpec(MAX(s.dt_first_seen_day_switch,s.dt_first_seen_month_switch,s.dt_first_seen_year_switch),count(le.dt_first_seen_values));
  SELF.dt_last_seen_size := SALT34.Fn_SwitchSpec(MAX(s.dt_last_seen_day_switch,s.dt_last_seen_month_switch,s.dt_last_seen_year_switch),count(le.dt_last_seen_values));
  SELF.corp_ra_dt_first_seen_size := SALT34.Fn_SwitchSpec(MAX(s.corp_ra_dt_first_seen_day_switch,s.corp_ra_dt_first_seen_month_switch,s.corp_ra_dt_first_seen_year_switch),count(le.corp_ra_dt_first_seen_values));
  SELF.corp_ra_dt_last_seen_size := SALT34.Fn_SwitchSpec(MAX(s.corp_ra_dt_last_seen_day_switch,s.corp_ra_dt_last_seen_month_switch,s.corp_ra_dt_last_seen_year_switch),count(le.corp_ra_dt_last_seen_values));
  SELF.corp_key_size := SALT34.Fn_SwitchSpec(s.corp_key_switch,count(le.corp_key_values));
  SELF.corp_supp_key_size := SALT34.Fn_SwitchSpec(s.corp_supp_key_switch,count(le.corp_supp_key_values));
  SELF.corp_vendor_size := SALT34.Fn_SwitchSpec(s.corp_vendor_switch,count(le.corp_vendor_values));
  SELF.corp_vendor_county_size := SALT34.Fn_SwitchSpec(s.corp_vendor_county_switch,count(le.corp_vendor_county_values));
  SELF.corp_vendor_subcode_size := SALT34.Fn_SwitchSpec(s.corp_vendor_subcode_switch,count(le.corp_vendor_subcode_values));
  SELF.corp_state_origin_size := SALT34.Fn_SwitchSpec(s.corp_state_origin_switch,count(le.corp_state_origin_values));
  SELF.corp_process_date_size := SALT34.Fn_SwitchSpec(MAX(s.corp_process_date_day_switch,s.corp_process_date_month_switch,s.corp_process_date_year_switch),count(le.corp_process_date_values));
  SELF.corp_orig_sos_charter_nbr_size := SALT34.Fn_SwitchSpec(s.corp_orig_sos_charter_nbr_switch,count(le.corp_orig_sos_charter_nbr_values));
  SELF.corp_legal_name_size := SALT34.Fn_SwitchSpec(s.corp_legal_name_switch,count(le.corp_legal_name_values));
  SELF.corp_ln_name_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_ln_name_type_cd_switch,count(le.corp_ln_name_type_cd_values));
  SELF.corp_ln_name_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_ln_name_type_desc_switch,count(le.corp_ln_name_type_desc_values));
  SELF.corp_supp_nbr_size := SALT34.Fn_SwitchSpec(s.corp_supp_nbr_switch,count(le.corp_supp_nbr_values));
  SELF.corp_name_comment_size := SALT34.Fn_SwitchSpec(s.corp_name_comment_switch,count(le.corp_name_comment_values));
  SELF.corp_address1_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_address1_type_cd_switch,count(le.corp_address1_type_cd_values));
  SELF.corp_address1_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_address1_type_desc_switch,count(le.corp_address1_type_desc_values));
  SELF.corp_address1_line1_size := SALT34.Fn_SwitchSpec(s.corp_address1_line1_switch,count(le.corp_address1_line1_values));
  SELF.corp_address1_line2_size := SALT34.Fn_SwitchSpec(s.corp_address1_line2_switch,count(le.corp_address1_line2_values));
  SELF.corp_address1_line3_size := SALT34.Fn_SwitchSpec(s.corp_address1_line3_switch,count(le.corp_address1_line3_values));
  SELF.corp_address1_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_address1_effective_date_switch,count(le.corp_address1_effective_date_values));
  SELF.corp_address2_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_address2_type_cd_switch,count(le.corp_address2_type_cd_values));
  SELF.corp_address2_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_address2_type_desc_switch,count(le.corp_address2_type_desc_values));
  SELF.corp_address2_line1_size := SALT34.Fn_SwitchSpec(s.corp_address2_line1_switch,count(le.corp_address2_line1_values));
  SELF.corp_address2_line2_size := SALT34.Fn_SwitchSpec(s.corp_address2_line2_switch,count(le.corp_address2_line2_values));
  SELF.corp_address2_line3_size := SALT34.Fn_SwitchSpec(s.corp_address2_line3_switch,count(le.corp_address2_line3_values));
  SELF.corp_address2_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_address2_effective_date_switch,count(le.corp_address2_effective_date_values));
  SELF.corp_phone_number_size := SALT34.Fn_SwitchSpec(s.corp_phone_number_switch,count(le.corp_phone_number_values));
  SELF.corp_phone_number_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_phone_number_type_cd_switch,count(le.corp_phone_number_type_cd_values));
  SELF.corp_phone_number_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_phone_number_type_desc_switch,count(le.corp_phone_number_type_desc_values));
  SELF.corp_fax_nbr_size := SALT34.Fn_SwitchSpec(s.corp_fax_nbr_switch,count(le.corp_fax_nbr_values));
  SELF.corp_email_address_size := SALT34.Fn_SwitchSpec(s.corp_email_address_switch,count(le.corp_email_address_values));
  SELF.corp_web_address_size := SALT34.Fn_SwitchSpec(s.corp_web_address_switch,count(le.corp_web_address_values));
  SELF.corp_filing_reference_nbr_size := SALT34.Fn_SwitchSpec(s.corp_filing_reference_nbr_switch,count(le.corp_filing_reference_nbr_values));
  SELF.corp_filing_date_size := SALT34.Fn_SwitchSpec(s.corp_filing_date_switch,count(le.corp_filing_date_values));
  SELF.corp_filing_cd_size := SALT34.Fn_SwitchSpec(s.corp_filing_cd_switch,count(le.corp_filing_cd_values));
  SELF.corp_filing_desc_size := SALT34.Fn_SwitchSpec(s.corp_filing_desc_switch,count(le.corp_filing_desc_values));
  SELF.corp_status_cd_size := SALT34.Fn_SwitchSpec(s.corp_status_cd_switch,count(le.corp_status_cd_values));
  SELF.corp_status_desc_size := SALT34.Fn_SwitchSpec(s.corp_status_desc_switch,count(le.corp_status_desc_values));
  SELF.corp_status_date_size := SALT34.Fn_SwitchSpec(s.corp_status_date_switch,count(le.corp_status_date_values));
  SELF.corp_standing_size := SALT34.Fn_SwitchSpec(s.corp_standing_switch,count(le.corp_standing_values));
  SELF.corp_status_comment_size := SALT34.Fn_SwitchSpec(s.corp_status_comment_switch,count(le.corp_status_comment_values));
  SELF.corp_ticker_symbol_size := SALT34.Fn_SwitchSpec(s.corp_ticker_symbol_switch,count(le.corp_ticker_symbol_values));
  SELF.corp_stock_exchange_size := SALT34.Fn_SwitchSpec(s.corp_stock_exchange_switch,count(le.corp_stock_exchange_values));
  SELF.corp_inc_state_size := SALT34.Fn_SwitchSpec(s.corp_inc_state_switch,count(le.corp_inc_state_values));
  SELF.corp_inc_county_size := SALT34.Fn_SwitchSpec(s.corp_inc_county_switch,count(le.corp_inc_county_values));
  SELF.corp_inc_date_size := SALT34.Fn_SwitchSpec(s.corp_inc_date_switch,count(le.corp_inc_date_values));
  SELF.corp_anniversary_month_size := SALT34.Fn_SwitchSpec(s.corp_anniversary_month_switch,count(le.corp_anniversary_month_values));
  SELF.corp_fed_tax_id_size := SALT34.Fn_SwitchSpec(s.corp_fed_tax_id_switch,count(le.corp_fed_tax_id_values));
  SELF.corp_state_tax_id_size := SALT34.Fn_SwitchSpec(s.corp_state_tax_id_switch,count(le.corp_state_tax_id_values));
  SELF.corp_term_exist_cd_size := SALT34.Fn_SwitchSpec(s.corp_term_exist_cd_switch,count(le.corp_term_exist_cd_values));
  SELF.corp_term_exist_exp_size := SALT34.Fn_SwitchSpec(s.corp_term_exist_exp_switch,count(le.corp_term_exist_exp_values));
  SELF.corp_term_exist_desc_size := SALT34.Fn_SwitchSpec(s.corp_term_exist_desc_switch,count(le.corp_term_exist_desc_values));
  SELF.corp_foreign_domestic_ind_size := SALT34.Fn_SwitchSpec(s.corp_foreign_domestic_ind_switch,count(le.corp_foreign_domestic_ind_values));
  SELF.corp_forgn_state_cd_size := SALT34.Fn_SwitchSpec(s.corp_forgn_state_cd_switch,count(le.corp_forgn_state_cd_values));
  SELF.corp_forgn_state_desc_size := SALT34.Fn_SwitchSpec(s.corp_forgn_state_desc_switch,count(le.corp_forgn_state_desc_values));
  SELF.corp_forgn_sos_charter_nbr_size := SALT34.Fn_SwitchSpec(s.corp_forgn_sos_charter_nbr_switch,count(le.corp_forgn_sos_charter_nbr_values));
  SELF.corp_forgn_date_size := SALT34.Fn_SwitchSpec(s.corp_forgn_date_switch,count(le.corp_forgn_date_values));
  SELF.corp_forgn_fed_tax_id_size := SALT34.Fn_SwitchSpec(s.corp_forgn_fed_tax_id_switch,count(le.corp_forgn_fed_tax_id_values));
  SELF.corp_forgn_state_tax_id_size := SALT34.Fn_SwitchSpec(s.corp_forgn_state_tax_id_switch,count(le.corp_forgn_state_tax_id_values));
  SELF.corp_forgn_term_exist_cd_size := SALT34.Fn_SwitchSpec(s.corp_forgn_term_exist_cd_switch,count(le.corp_forgn_term_exist_cd_values));
  SELF.corp_forgn_term_exist_exp_size := SALT34.Fn_SwitchSpec(s.corp_forgn_term_exist_exp_switch,count(le.corp_forgn_term_exist_exp_values));
  SELF.corp_forgn_term_exist_desc_size := SALT34.Fn_SwitchSpec(s.corp_forgn_term_exist_desc_switch,count(le.corp_forgn_term_exist_desc_values));
  SELF.corp_orig_org_structure_cd_size := SALT34.Fn_SwitchSpec(s.corp_orig_org_structure_cd_switch,count(le.corp_orig_org_structure_cd_values));
  SELF.corp_orig_org_structure_desc_size := SALT34.Fn_SwitchSpec(s.corp_orig_org_structure_desc_switch,count(le.corp_orig_org_structure_desc_values));
  SELF.corp_for_profit_ind_size := SALT34.Fn_SwitchSpec(s.corp_for_profit_ind_switch,count(le.corp_for_profit_ind_values));
  SELF.corp_public_or_private_ind_size := SALT34.Fn_SwitchSpec(s.corp_public_or_private_ind_switch,count(le.corp_public_or_private_ind_values));
  SELF.corp_sic_code_size := SALT34.Fn_SwitchSpec(s.corp_sic_code_switch,count(le.corp_sic_code_values));
  SELF.corp_naic_code_size := SALT34.Fn_SwitchSpec(s.corp_naic_code_switch,count(le.corp_naic_code_values));
  SELF.corp_orig_bus_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_orig_bus_type_cd_switch,count(le.corp_orig_bus_type_cd_values));
  SELF.corp_orig_bus_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_orig_bus_type_desc_switch,count(le.corp_orig_bus_type_desc_values));
  SELF.corp_entity_desc_size := SALT34.Fn_SwitchSpec(s.corp_entity_desc_switch,count(le.corp_entity_desc_values));
  SELF.corp_certificate_nbr_size := SALT34.Fn_SwitchSpec(s.corp_certificate_nbr_switch,count(le.corp_certificate_nbr_values));
  SELF.corp_internal_nbr_size := SALT34.Fn_SwitchSpec(s.corp_internal_nbr_switch,count(le.corp_internal_nbr_values));
  SELF.corp_previous_nbr_size := SALT34.Fn_SwitchSpec(s.corp_previous_nbr_switch,count(le.corp_previous_nbr_values));
  SELF.corp_microfilm_nbr_size := SALT34.Fn_SwitchSpec(s.corp_microfilm_nbr_switch,count(le.corp_microfilm_nbr_values));
  SELF.corp_amendments_filed_size := SALT34.Fn_SwitchSpec(s.corp_amendments_filed_switch,count(le.corp_amendments_filed_values));
  SELF.corp_acts_size := SALT34.Fn_SwitchSpec(s.corp_acts_switch,count(le.corp_acts_values));
  SELF.corp_partnership_ind_size := SALT34.Fn_SwitchSpec(s.corp_partnership_ind_switch,count(le.corp_partnership_ind_values));
  SELF.corp_mfg_ind_size := SALT34.Fn_SwitchSpec(s.corp_mfg_ind_switch,count(le.corp_mfg_ind_values));
  SELF.corp_addl_info_size := SALT34.Fn_SwitchSpec(s.corp_addl_info_switch,count(le.corp_addl_info_values));
  SELF.corp_taxes_size := SALT34.Fn_SwitchSpec(s.corp_taxes_switch,count(le.corp_taxes_values));
  SELF.corp_franchise_taxes_size := SALT34.Fn_SwitchSpec(s.corp_franchise_taxes_switch,count(le.corp_franchise_taxes_values));
  SELF.corp_tax_program_cd_size := SALT34.Fn_SwitchSpec(s.corp_tax_program_cd_switch,count(le.corp_tax_program_cd_values));
  SELF.corp_tax_program_desc_size := SALT34.Fn_SwitchSpec(s.corp_tax_program_desc_switch,count(le.corp_tax_program_desc_values));
  SELF.corp_ra_full_name_size := SALT34.Fn_SwitchSpec(s.corp_ra_full_name_switch,count(le.corp_ra_full_name_values));
  SELF.corp_ra_fname_size := SALT34.Fn_SwitchSpec(s.corp_ra_fname_switch,count(le.corp_ra_fname_values));
  SELF.corp_ra_mname_size := SALT34.Fn_SwitchSpec(s.corp_ra_mname_switch,count(le.corp_ra_mname_values));
  SELF.corp_ra_lname_size := SALT34.Fn_SwitchSpec(s.corp_ra_lname_switch,count(le.corp_ra_lname_values));
  SELF.corp_ra_suffix_size := SALT34.Fn_SwitchSpec(s.corp_ra_suffix_switch,count(le.corp_ra_suffix_values));
  SELF.corp_ra_title_cd_size := SALT34.Fn_SwitchSpec(s.corp_ra_title_cd_switch,count(le.corp_ra_title_cd_values));
  SELF.corp_ra_title_desc_size := SALT34.Fn_SwitchSpec(s.corp_ra_title_desc_switch,count(le.corp_ra_title_desc_values));
  SELF.corp_ra_fein_size := SALT34.Fn_SwitchSpec(s.corp_ra_fein_switch,count(le.corp_ra_fein_values));
  SELF.corp_ra_ssn_size := SALT34.Fn_SwitchSpec(s.corp_ra_ssn_switch,count(le.corp_ra_ssn_values));
  SELF.corp_ra_dob_size := SALT34.Fn_SwitchSpec(s.corp_ra_dob_switch,count(le.corp_ra_dob_values));
  SELF.corp_ra_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_ra_effective_date_switch,count(le.corp_ra_effective_date_values));
  SELF.corp_ra_resign_date_size := SALT34.Fn_SwitchSpec(s.corp_ra_resign_date_switch,count(le.corp_ra_resign_date_values));
  SELF.corp_ra_no_comp_size := SALT34.Fn_SwitchSpec(s.corp_ra_no_comp_switch,count(le.corp_ra_no_comp_values));
  SELF.corp_ra_no_comp_igs_size := SALT34.Fn_SwitchSpec(s.corp_ra_no_comp_igs_switch,count(le.corp_ra_no_comp_igs_values));
  SELF.corp_ra_addl_info_size := SALT34.Fn_SwitchSpec(s.corp_ra_addl_info_switch,count(le.corp_ra_addl_info_values));
  SELF.corp_ra_address_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_ra_address_type_cd_switch,count(le.corp_ra_address_type_cd_values));
  SELF.corp_ra_address_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_ra_address_type_desc_switch,count(le.corp_ra_address_type_desc_values));
  SELF.corp_ra_address_line1_size := SALT34.Fn_SwitchSpec(s.corp_ra_address_line1_switch,count(le.corp_ra_address_line1_values));
  SELF.corp_ra_address_line2_size := SALT34.Fn_SwitchSpec(s.corp_ra_address_line2_switch,count(le.corp_ra_address_line2_values));
  SELF.corp_ra_address_line3_size := SALT34.Fn_SwitchSpec(s.corp_ra_address_line3_switch,count(le.corp_ra_address_line3_values));
  SELF.corp_ra_phone_number_size := SALT34.Fn_SwitchSpec(s.corp_ra_phone_number_switch,count(le.corp_ra_phone_number_values));
  SELF.corp_ra_phone_number_type_cd_size := SALT34.Fn_SwitchSpec(s.corp_ra_phone_number_type_cd_switch,count(le.corp_ra_phone_number_type_cd_values));
  SELF.corp_ra_phone_number_type_desc_size := SALT34.Fn_SwitchSpec(s.corp_ra_phone_number_type_desc_switch,count(le.corp_ra_phone_number_type_desc_values));
  SELF.corp_ra_fax_nbr_size := SALT34.Fn_SwitchSpec(s.corp_ra_fax_nbr_switch,count(le.corp_ra_fax_nbr_values));
  SELF.corp_ra_email_address_size := SALT34.Fn_SwitchSpec(s.corp_ra_email_address_switch,count(le.corp_ra_email_address_values));
  SELF.corp_ra_web_address_size := SALT34.Fn_SwitchSpec(s.corp_ra_web_address_switch,count(le.corp_ra_web_address_values));
  SELF.corp_prep_addr1_line1_size := SALT34.Fn_SwitchSpec(s.corp_prep_addr1_line1_switch,count(le.corp_prep_addr1_line1_values));
  SELF.corp_prep_addr1_last_line_size := SALT34.Fn_SwitchSpec(s.corp_prep_addr1_last_line_switch,count(le.corp_prep_addr1_last_line_values));
  SELF.corp_prep_addr2_line1_size := SALT34.Fn_SwitchSpec(s.corp_prep_addr2_line1_switch,count(le.corp_prep_addr2_line1_values));
  SELF.corp_prep_addr2_last_line_size := SALT34.Fn_SwitchSpec(s.corp_prep_addr2_last_line_switch,count(le.corp_prep_addr2_last_line_values));
  SELF.ra_prep_addr_line1_size := SALT34.Fn_SwitchSpec(s.ra_prep_addr_line1_switch,count(le.ra_prep_addr_line1_values));
  SELF.ra_prep_addr_last_line_size := SALT34.Fn_SwitchSpec(s.ra_prep_addr_last_line_switch,count(le.ra_prep_addr_last_line_values));
  SELF.cont_filing_reference_nbr_size := SALT34.Fn_SwitchSpec(s.cont_filing_reference_nbr_switch,count(le.cont_filing_reference_nbr_values));
  SELF.cont_filing_date_size := SALT34.Fn_SwitchSpec(s.cont_filing_date_switch,count(le.cont_filing_date_values));
  SELF.cont_filing_cd_size := SALT34.Fn_SwitchSpec(s.cont_filing_cd_switch,count(le.cont_filing_cd_values));
  SELF.cont_filing_desc_size := SALT34.Fn_SwitchSpec(s.cont_filing_desc_switch,count(le.cont_filing_desc_values));
  SELF.cont_type_cd_size := SALT34.Fn_SwitchSpec(s.cont_type_cd_switch,count(le.cont_type_cd_values));
  SELF.cont_type_desc_size := SALT34.Fn_SwitchSpec(s.cont_type_desc_switch,count(le.cont_type_desc_values));
  SELF.cont_full_name_size := SALT34.Fn_SwitchSpec(s.cont_full_name_switch,count(le.cont_full_name_values));
  SELF.cont_fname_size := SALT34.Fn_SwitchSpec(s.cont_fname_switch,count(le.cont_fname_values));
  SELF.cont_mname_size := SALT34.Fn_SwitchSpec(s.cont_mname_switch,count(le.cont_mname_values));
  SELF.cont_lname_size := SALT34.Fn_SwitchSpec(s.cont_lname_switch,count(le.cont_lname_values));
  SELF.cont_suffix_size := SALT34.Fn_SwitchSpec(s.cont_suffix_switch,count(le.cont_suffix_values));
  SELF.cont_title1_desc_size := SALT34.Fn_SwitchSpec(s.cont_title1_desc_switch,count(le.cont_title1_desc_values));
  SELF.cont_title2_desc_size := SALT34.Fn_SwitchSpec(s.cont_title2_desc_switch,count(le.cont_title2_desc_values));
  SELF.cont_title3_desc_size := SALT34.Fn_SwitchSpec(s.cont_title3_desc_switch,count(le.cont_title3_desc_values));
  SELF.cont_title4_desc_size := SALT34.Fn_SwitchSpec(s.cont_title4_desc_switch,count(le.cont_title4_desc_values));
  SELF.cont_title5_desc_size := SALT34.Fn_SwitchSpec(s.cont_title5_desc_switch,count(le.cont_title5_desc_values));
  SELF.cont_fein_size := SALT34.Fn_SwitchSpec(s.cont_fein_switch,count(le.cont_fein_values));
  SELF.cont_ssn_size := SALT34.Fn_SwitchSpec(s.cont_ssn_switch,count(le.cont_ssn_values));
  SELF.cont_dob_size := SALT34.Fn_SwitchSpec(s.cont_dob_switch,count(le.cont_dob_values));
  SELF.cont_status_cd_size := SALT34.Fn_SwitchSpec(s.cont_status_cd_switch,count(le.cont_status_cd_values));
  SELF.cont_status_desc_size := SALT34.Fn_SwitchSpec(s.cont_status_desc_switch,count(le.cont_status_desc_values));
  SELF.cont_effective_date_size := SALT34.Fn_SwitchSpec(s.cont_effective_date_switch,count(le.cont_effective_date_values));
  SELF.cont_effective_cd_size := SALT34.Fn_SwitchSpec(s.cont_effective_cd_switch,count(le.cont_effective_cd_values));
  SELF.cont_effective_desc_size := SALT34.Fn_SwitchSpec(s.cont_effective_desc_switch,count(le.cont_effective_desc_values));
  SELF.cont_addl_info_size := SALT34.Fn_SwitchSpec(s.cont_addl_info_switch,count(le.cont_addl_info_values));
  SELF.cont_address_type_cd_size := SALT34.Fn_SwitchSpec(s.cont_address_type_cd_switch,count(le.cont_address_type_cd_values));
  SELF.cont_address_type_desc_size := SALT34.Fn_SwitchSpec(s.cont_address_type_desc_switch,count(le.cont_address_type_desc_values));
  SELF.cont_address_line1_size := SALT34.Fn_SwitchSpec(s.cont_address_line1_switch,count(le.cont_address_line1_values));
  SELF.cont_address_line2_size := SALT34.Fn_SwitchSpec(s.cont_address_line2_switch,count(le.cont_address_line2_values));
  SELF.cont_address_line3_size := SALT34.Fn_SwitchSpec(s.cont_address_line3_switch,count(le.cont_address_line3_values));
  SELF.cont_address_effective_date_size := SALT34.Fn_SwitchSpec(s.cont_address_effective_date_switch,count(le.cont_address_effective_date_values));
  SELF.cont_address_county_size := SALT34.Fn_SwitchSpec(s.cont_address_county_switch,count(le.cont_address_county_values));
  SELF.cont_phone_number_size := SALT34.Fn_SwitchSpec(s.cont_phone_number_switch,count(le.cont_phone_number_values));
  SELF.cont_phone_number_type_cd_size := SALT34.Fn_SwitchSpec(s.cont_phone_number_type_cd_switch,count(le.cont_phone_number_type_cd_values));
  SELF.cont_phone_number_type_desc_size := SALT34.Fn_SwitchSpec(s.cont_phone_number_type_desc_switch,count(le.cont_phone_number_type_desc_values));
  SELF.cont_fax_nbr_size := SALT34.Fn_SwitchSpec(s.cont_fax_nbr_switch,count(le.cont_fax_nbr_values));
  SELF.cont_email_address_size := SALT34.Fn_SwitchSpec(s.cont_email_address_switch,count(le.cont_email_address_values));
  SELF.cont_web_address_size := SALT34.Fn_SwitchSpec(s.cont_web_address_switch,count(le.cont_web_address_values));
  SELF.corp_acres_size := SALT34.Fn_SwitchSpec(s.corp_acres_switch,count(le.corp_acres_values));
  SELF.corp_action_size := SALT34.Fn_SwitchSpec(s.corp_action_switch,count(le.corp_action_values));
  SELF.corp_action_date_size := SALT34.Fn_SwitchSpec(s.corp_action_date_switch,count(le.corp_action_date_values));
  SELF.corp_action_employment_security_approval_date_size := SALT34.Fn_SwitchSpec(s.corp_action_employment_security_approval_date_switch,count(le.corp_action_employment_security_approval_date_values));
  SELF.corp_action_pending_cd_size := SALT34.Fn_SwitchSpec(s.corp_action_pending_cd_switch,count(le.corp_action_pending_cd_values));
  SELF.corp_action_pending_desc_size := SALT34.Fn_SwitchSpec(s.corp_action_pending_desc_switch,count(le.corp_action_pending_desc_values));
  SELF.corp_action_statement_of_intent_date_size := SALT34.Fn_SwitchSpec(s.corp_action_statement_of_intent_date_switch,count(le.corp_action_statement_of_intent_date_values));
  SELF.corp_action_tax_dept_approval_date_size := SALT34.Fn_SwitchSpec(s.corp_action_tax_dept_approval_date_switch,count(le.corp_action_tax_dept_approval_date_values));
  SELF.corp_acts2_size := SALT34.Fn_SwitchSpec(s.corp_acts2_switch,count(le.corp_acts2_values));
  SELF.corp_acts3_size := SALT34.Fn_SwitchSpec(s.corp_acts3_switch,count(le.corp_acts3_values));
  SELF.corp_additional_principals_size := SALT34.Fn_SwitchSpec(s.corp_additional_principals_switch,count(le.corp_additional_principals_values));
  SELF.corp_address_office_type_size := SALT34.Fn_SwitchSpec(s.corp_address_office_type_switch,count(le.corp_address_office_type_values));
  SELF.corp_agent_assign_date_size := SALT34.Fn_SwitchSpec(s.corp_agent_assign_date_switch,count(le.corp_agent_assign_date_values));
  SELF.corp_agent_commercial_size := SALT34.Fn_SwitchSpec(s.corp_agent_commercial_switch,count(le.corp_agent_commercial_values));
  SELF.corp_agent_country_size := SALT34.Fn_SwitchSpec(s.corp_agent_country_switch,count(le.corp_agent_country_values));
  SELF.corp_agent_county_size := SALT34.Fn_SwitchSpec(s.corp_agent_county_switch,count(le.corp_agent_county_values));
  SELF.corp_agent_status_cd_size := SALT34.Fn_SwitchSpec(s.corp_agent_status_cd_switch,count(le.corp_agent_status_cd_values));
  SELF.corp_agent_status_desc_size := SALT34.Fn_SwitchSpec(s.corp_agent_status_desc_switch,count(le.corp_agent_status_desc_values));
  SELF.corp_agent_id_size := SALT34.Fn_SwitchSpec(s.corp_agent_id_switch,count(le.corp_agent_id_values));
  SELF.corp_agriculture_flag_size := SALT34.Fn_SwitchSpec(s.corp_agriculture_flag_switch,count(le.corp_agriculture_flag_values));
  SELF.corp_authorized_partners_size := SALT34.Fn_SwitchSpec(s.corp_authorized_partners_switch,count(le.corp_authorized_partners_values));
  SELF.corp_comment_size := SALT34.Fn_SwitchSpec(s.corp_comment_switch,count(le.corp_comment_values));
  SELF.corp_consent_flag_for_protected_name_size := SALT34.Fn_SwitchSpec(s.corp_consent_flag_for_protected_name_switch,count(le.corp_consent_flag_for_protected_name_values));
  SELF.corp_converted_size := SALT34.Fn_SwitchSpec(s.corp_converted_switch,count(le.corp_converted_values));
  SELF.corp_converted_from_size := SALT34.Fn_SwitchSpec(s.corp_converted_from_switch,count(le.corp_converted_from_values));
  SELF.corp_country_of_formation_size := SALT34.Fn_SwitchSpec(s.corp_country_of_formation_switch,count(le.corp_country_of_formation_values));
  SELF.corp_date_of_organization_meeting_size := SALT34.Fn_SwitchSpec(s.corp_date_of_organization_meeting_switch,count(le.corp_date_of_organization_meeting_values));
  SELF.corp_delayed_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_delayed_effective_date_switch,count(le.corp_delayed_effective_date_values));
  SELF.corp_directors_from_to_size := SALT34.Fn_SwitchSpec(s.corp_directors_from_to_switch,count(le.corp_directors_from_to_values));
  SELF.corp_dissolved_date_size := SALT34.Fn_SwitchSpec(s.corp_dissolved_date_switch,count(le.corp_dissolved_date_values));
  SELF.corp_farm_exemptions_size := SALT34.Fn_SwitchSpec(s.corp_farm_exemptions_switch,count(le.corp_farm_exemptions_values));
  SELF.corp_farm_qual_date_size := SALT34.Fn_SwitchSpec(s.corp_farm_qual_date_switch,count(le.corp_farm_qual_date_values));
  SELF.corp_farm_status_cd_size := SALT34.Fn_SwitchSpec(s.corp_farm_status_cd_switch,count(le.corp_farm_status_cd_values));
  SELF.corp_farm_status_desc_size := SALT34.Fn_SwitchSpec(s.corp_farm_status_desc_switch,count(le.corp_farm_status_desc_values));
  SELF.corp_fiscal_year_month_size := SALT34.Fn_SwitchSpec(s.corp_fiscal_year_month_switch,count(le.corp_fiscal_year_month_values));
  SELF.corp_foreign_fiduciary_capacity_in_state_size := SALT34.Fn_SwitchSpec(s.corp_foreign_fiduciary_capacity_in_state_switch,count(le.corp_foreign_fiduciary_capacity_in_state_values));
  SELF.corp_governing_statute_size := SALT34.Fn_SwitchSpec(s.corp_governing_statute_switch,count(le.corp_governing_statute_values));
  SELF.corp_has_members_size := SALT34.Fn_SwitchSpec(s.corp_has_members_switch,count(le.corp_has_members_values));
  SELF.corp_has_vested_managers_size := SALT34.Fn_SwitchSpec(s.corp_has_vested_managers_switch,count(le.corp_has_vested_managers_values));
  SELF.corp_home_incorporated_county_size := SALT34.Fn_SwitchSpec(s.corp_home_incorporated_county_switch,count(le.corp_home_incorporated_county_values));
  SELF.corp_home_state_name_size := SALT34.Fn_SwitchSpec(s.corp_home_state_name_switch,count(le.corp_home_state_name_values));
  SELF.corp_is_professional_size := SALT34.Fn_SwitchSpec(s.corp_is_professional_switch,count(le.corp_is_professional_values));
  SELF.corp_is_non_profit_irs_approved_size := SALT34.Fn_SwitchSpec(s.corp_is_non_profit_irs_approved_switch,count(le.corp_is_non_profit_irs_approved_values));
  SELF.corp_last_renewal_date_size := SALT34.Fn_SwitchSpec(s.corp_last_renewal_date_switch,count(le.corp_last_renewal_date_values));
  SELF.corp_last_renewal_year_size := SALT34.Fn_SwitchSpec(s.corp_last_renewal_year_switch,count(le.corp_last_renewal_year_values));
  SELF.corp_license_type_size := SALT34.Fn_SwitchSpec(s.corp_license_type_switch,count(le.corp_license_type_values));
  SELF.corp_llc_managed_desc_size := SALT34.Fn_SwitchSpec(s.corp_llc_managed_desc_switch,count(le.corp_llc_managed_desc_values));
  SELF.corp_llc_managed_ind_size := SALT34.Fn_SwitchSpec(s.corp_llc_managed_ind_switch,count(le.corp_llc_managed_ind_values));
  SELF.corp_management_desc_size := SALT34.Fn_SwitchSpec(s.corp_management_desc_switch,count(le.corp_management_desc_values));
  SELF.corp_management_type_size := SALT34.Fn_SwitchSpec(s.corp_management_type_switch,count(le.corp_management_type_values));
  SELF.corp_manager_managed_size := SALT34.Fn_SwitchSpec(s.corp_manager_managed_switch,count(le.corp_manager_managed_values));
  SELF.corp_merged_corporation_id_size := SALT34.Fn_SwitchSpec(s.corp_merged_corporation_id_switch,count(le.corp_merged_corporation_id_values));
  SELF.corp_merged_fein_size := SALT34.Fn_SwitchSpec(s.corp_merged_fein_switch,count(le.corp_merged_fein_values));
  SELF.corp_merger_allowed_flag_size := SALT34.Fn_SwitchSpec(s.corp_merger_allowed_flag_switch,count(le.corp_merger_allowed_flag_values));
  SELF.corp_merger_date_size := SALT34.Fn_SwitchSpec(s.corp_merger_date_switch,count(le.corp_merger_date_values));
  SELF.corp_merger_desc_size := SALT34.Fn_SwitchSpec(s.corp_merger_desc_switch,count(le.corp_merger_desc_values));
  SELF.corp_merger_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_merger_effective_date_switch,count(le.corp_merger_effective_date_values));
  SELF.corp_merger_id_size := SALT34.Fn_SwitchSpec(s.corp_merger_id_switch,count(le.corp_merger_id_values));
  SELF.corp_merger_indicator_size := SALT34.Fn_SwitchSpec(s.corp_merger_indicator_switch,count(le.corp_merger_indicator_values));
  SELF.corp_merger_name_size := SALT34.Fn_SwitchSpec(s.corp_merger_name_switch,count(le.corp_merger_name_values));
  SELF.corp_merger_type_converted_to_cd_size := SALT34.Fn_SwitchSpec(s.corp_merger_type_converted_to_cd_switch,count(le.corp_merger_type_converted_to_cd_values));
  SELF.corp_merger_type_converted_to_desc_size := SALT34.Fn_SwitchSpec(s.corp_merger_type_converted_to_desc_switch,count(le.corp_merger_type_converted_to_desc_values));
  SELF.corp_naics_desc_size := SALT34.Fn_SwitchSpec(s.corp_naics_desc_switch,count(le.corp_naics_desc_values));
  SELF.corp_name_effective_date_size := SALT34.Fn_SwitchSpec(s.corp_name_effective_date_switch,count(le.corp_name_effective_date_values));
  SELF.corp_name_reservation_date_size := SALT34.Fn_SwitchSpec(s.corp_name_reservation_date_switch,count(le.corp_name_reservation_date_values));
  SELF.corp_name_reservation_desc_size := SALT34.Fn_SwitchSpec(s.corp_name_reservation_desc_switch,count(le.corp_name_reservation_desc_values));
  SELF.corp_name_reservation_expiration_date_size := SALT34.Fn_SwitchSpec(s.corp_name_reservation_expiration_date_switch,count(le.corp_name_reservation_expiration_date_values));
  SELF.corp_name_reservation_nbr_size := SALT34.Fn_SwitchSpec(s.corp_name_reservation_nbr_switch,count(le.corp_name_reservation_nbr_values));
  SELF.corp_name_reservation_type_size := SALT34.Fn_SwitchSpec(s.corp_name_reservation_type_switch,count(le.corp_name_reservation_type_values));
  SELF.corp_name_status_cd_size := SALT34.Fn_SwitchSpec(s.corp_name_status_cd_switch,count(le.corp_name_status_cd_values));
  SELF.corp_name_status_date_size := SALT34.Fn_SwitchSpec(s.corp_name_status_date_switch,count(le.corp_name_status_date_values));
  SELF.corp_name_status_desc_size := SALT34.Fn_SwitchSpec(s.corp_name_status_desc_switch,count(le.corp_name_status_desc_values));
  SELF.corp_non_profit_irs_approved_purpose_size := SALT34.Fn_SwitchSpec(s.corp_non_profit_irs_approved_purpose_switch,count(le.corp_non_profit_irs_approved_purpose_values));
  SELF.corp_non_profit_solicit_donations_size := SALT34.Fn_SwitchSpec(s.corp_non_profit_solicit_donations_switch,count(le.corp_non_profit_solicit_donations_values));
  SELF.corp_nbr_of_amendments_size := SALT34.Fn_SwitchSpec(s.corp_nbr_of_amendments_switch,count(le.corp_nbr_of_amendments_values));
  SELF.corp_nbr_of_initial_llc_members_size := SALT34.Fn_SwitchSpec(s.corp_nbr_of_initial_llc_members_switch,count(le.corp_nbr_of_initial_llc_members_values));
  SELF.corp_nbr_of_partners_size := SALT34.Fn_SwitchSpec(s.corp_nbr_of_partners_switch,count(le.corp_nbr_of_partners_values));
  SELF.corp_operating_agreement_size := SALT34.Fn_SwitchSpec(s.corp_operating_agreement_switch,count(le.corp_operating_agreement_values));
  SELF.corp_opt_in_llc_act_desc_size := SALT34.Fn_SwitchSpec(s.corp_opt_in_llc_act_desc_switch,count(le.corp_opt_in_llc_act_desc_values));
  SELF.corp_opt_in_llc_act_ind_size := SALT34.Fn_SwitchSpec(s.corp_opt_in_llc_act_ind_switch,count(le.corp_opt_in_llc_act_ind_values));
  SELF.corp_organizational_comments_size := SALT34.Fn_SwitchSpec(s.corp_organizational_comments_switch,count(le.corp_organizational_comments_values));
  SELF.corp_partner_contributions_total_size := SALT34.Fn_SwitchSpec(s.corp_partner_contributions_total_switch,count(le.corp_partner_contributions_total_values));
  SELF.corp_partner_terms_size := SALT34.Fn_SwitchSpec(s.corp_partner_terms_switch,count(le.corp_partner_terms_values));
  SELF.corp_percentage_voters_required_to_approve_amendments_size := SALT34.Fn_SwitchSpec(s.corp_percentage_voters_required_to_approve_amendments_switch,count(le.corp_percentage_voters_required_to_approve_amendments_values));
  SELF.corp_profession_size := SALT34.Fn_SwitchSpec(s.corp_profession_switch,count(le.corp_profession_values));
  SELF.corp_province_size := SALT34.Fn_SwitchSpec(s.corp_province_switch,count(le.corp_province_values));
  SELF.corp_public_mutual_corporation_size := SALT34.Fn_SwitchSpec(s.corp_public_mutual_corporation_switch,count(le.corp_public_mutual_corporation_values));
  SELF.corp_purpose_size := SALT34.Fn_SwitchSpec(s.corp_purpose_switch,count(le.corp_purpose_values));
  SELF.corp_ra_required_flag_size := SALT34.Fn_SwitchSpec(s.corp_ra_required_flag_switch,count(le.corp_ra_required_flag_values));
  SELF.corp_registered_counties_size := SALT34.Fn_SwitchSpec(s.corp_registered_counties_switch,count(le.corp_registered_counties_values));
  SELF.corp_regulated_ind_size := SALT34.Fn_SwitchSpec(s.corp_regulated_ind_switch,count(le.corp_regulated_ind_values));
  SELF.corp_renewal_date_size := SALT34.Fn_SwitchSpec(s.corp_renewal_date_switch,count(le.corp_renewal_date_values));
  SELF.corp_standing_other_size := SALT34.Fn_SwitchSpec(s.corp_standing_other_switch,count(le.corp_standing_other_values));
  SELF.corp_survivor_corporation_id_size := SALT34.Fn_SwitchSpec(s.corp_survivor_corporation_id_switch,count(le.corp_survivor_corporation_id_values));
  SELF.corp_tax_base_size := SALT34.Fn_SwitchSpec(s.corp_tax_base_switch,count(le.corp_tax_base_values));
  SELF.corp_tax_standing_size := SALT34.Fn_SwitchSpec(s.corp_tax_standing_switch,count(le.corp_tax_standing_values));
  SELF.corp_termination_cd_size := SALT34.Fn_SwitchSpec(s.corp_termination_cd_switch,count(le.corp_termination_cd_values));
  SELF.corp_termination_desc_size := SALT34.Fn_SwitchSpec(s.corp_termination_desc_switch,count(le.corp_termination_desc_values));
  SELF.corp_termination_date_size := SALT34.Fn_SwitchSpec(s.corp_termination_date_switch,count(le.corp_termination_date_values));
  SELF.corp_trademark_business_mark_type_size := SALT34.Fn_SwitchSpec(s.corp_trademark_business_mark_type_switch,count(le.corp_trademark_business_mark_type_values));
  SELF.corp_trademark_cancelled_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_cancelled_date_switch,count(le.corp_trademark_cancelled_date_values));
  SELF.corp_trademark_class_desc1_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc1_switch,count(le.corp_trademark_class_desc1_values));
  SELF.corp_trademark_class_desc2_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc2_switch,count(le.corp_trademark_class_desc2_values));
  SELF.corp_trademark_class_desc3_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc3_switch,count(le.corp_trademark_class_desc3_values));
  SELF.corp_trademark_class_desc4_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc4_switch,count(le.corp_trademark_class_desc4_values));
  SELF.corp_trademark_class_desc5_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc5_switch,count(le.corp_trademark_class_desc5_values));
  SELF.corp_trademark_class_desc6_size := SALT34.Fn_SwitchSpec(s.corp_trademark_class_desc6_switch,count(le.corp_trademark_class_desc6_values));
  SELF.corp_trademark_classification_nbr_size := SALT34.Fn_SwitchSpec(s.corp_trademark_classification_nbr_switch,count(le.corp_trademark_classification_nbr_values));
  SELF.corp_trademark_disclaimer1_size := SALT34.Fn_SwitchSpec(s.corp_trademark_disclaimer1_switch,count(le.corp_trademark_disclaimer1_values));
  SELF.corp_trademark_disclaimer2_size := SALT34.Fn_SwitchSpec(s.corp_trademark_disclaimer2_switch,count(le.corp_trademark_disclaimer2_values));
  SELF.corp_trademark_expiration_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_expiration_date_switch,count(le.corp_trademark_expiration_date_values));
  SELF.corp_trademark_filing_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_filing_date_switch,count(le.corp_trademark_filing_date_values));
  SELF.corp_trademark_first_use_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_first_use_date_switch,count(le.corp_trademark_first_use_date_values));
  SELF.corp_trademark_first_use_date_in_state_size := SALT34.Fn_SwitchSpec(s.corp_trademark_first_use_date_in_state_switch,count(le.corp_trademark_first_use_date_in_state_values));
  SELF.corp_trademark_keywords_size := SALT34.Fn_SwitchSpec(s.corp_trademark_keywords_switch,count(le.corp_trademark_keywords_values));
  SELF.corp_trademark_logo_size := SALT34.Fn_SwitchSpec(s.corp_trademark_logo_switch,count(le.corp_trademark_logo_values));
  SELF.corp_trademark_name_expiration_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_name_expiration_date_switch,count(le.corp_trademark_name_expiration_date_values));
  SELF.corp_trademark_nbr_size := SALT34.Fn_SwitchSpec(s.corp_trademark_nbr_switch,count(le.corp_trademark_nbr_values));
  SELF.corp_trademark_renewal_date_size := SALT34.Fn_SwitchSpec(s.corp_trademark_renewal_date_switch,count(le.corp_trademark_renewal_date_values));
  SELF.corp_trademark_status_size := SALT34.Fn_SwitchSpec(s.corp_trademark_status_switch,count(le.corp_trademark_status_values));
  SELF.corp_trademark_used_1_size := SALT34.Fn_SwitchSpec(s.corp_trademark_used_1_switch,count(le.corp_trademark_used_1_values));
  SELF.corp_trademark_used_2_size := SALT34.Fn_SwitchSpec(s.corp_trademark_used_2_switch,count(le.corp_trademark_used_2_values));
  SELF.corp_trademark_used_3_size := SALT34.Fn_SwitchSpec(s.corp_trademark_used_3_switch,count(le.corp_trademark_used_3_values));
  SELF.cont_owner_percentage_size := SALT34.Fn_SwitchSpec(s.cont_owner_percentage_switch,count(le.cont_owner_percentage_values));
  SELF.cont_country_size := SALT34.Fn_SwitchSpec(s.cont_country_switch,count(le.cont_country_values));
  SELF.cont_country_mailing_size := SALT34.Fn_SwitchSpec(s.cont_country_mailing_switch,count(le.cont_country_mailing_values));
  SELF.cont_nondislosure_size := SALT34.Fn_SwitchSpec(s.cont_nondislosure_switch,count(le.cont_nondislosure_values));
  SELF.cont_prep_addr_line1_size := SALT34.Fn_SwitchSpec(s.cont_prep_addr_line1_switch,count(le.cont_prep_addr_line1_values));
  SELF.cont_prep_addr_last_line_size := SALT34.Fn_SwitchSpec(s.cont_prep_addr_last_line_switch,count(le.cont_prep_addr_last_line_values));
  SELF.recordorigin_size := SALT34.Fn_SwitchSpec(s.recordorigin_switch,count(le.recordorigin_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.dt_vendor_first_reported_size+t.dt_vendor_last_reported_size+t.dt_first_seen_size+t.dt_last_seen_size+t.corp_ra_dt_first_seen_size+t.corp_ra_dt_last_seen_size+t.corp_key_size+t.corp_supp_key_size+t.corp_vendor_size+t.corp_vendor_county_size+t.corp_vendor_subcode_size+t.corp_state_origin_size+t.corp_process_date_size+t.corp_orig_sos_charter_nbr_size+t.corp_legal_name_size+t.corp_ln_name_type_cd_size+t.corp_ln_name_type_desc_size+t.corp_supp_nbr_size+t.corp_name_comment_size+t.corp_address1_type_cd_size+t.corp_address1_type_desc_size+t.corp_address1_line1_size+t.corp_address1_line2_size+t.corp_address1_line3_size+t.corp_address1_effective_date_size+t.corp_address2_type_cd_size+t.corp_address2_type_desc_size+t.corp_address2_line1_size+t.corp_address2_line2_size+t.corp_address2_line3_size+t.corp_address2_effective_date_size+t.corp_phone_number_size+t.corp_phone_number_type_cd_size+t.corp_phone_number_type_desc_size+t.corp_fax_nbr_size+t.corp_email_address_size+t.corp_web_address_size+t.corp_filing_reference_nbr_size+t.corp_filing_date_size+t.corp_filing_cd_size+t.corp_filing_desc_size+t.corp_status_cd_size+t.corp_status_desc_size+t.corp_status_date_size+t.corp_standing_size+t.corp_status_comment_size+t.corp_ticker_symbol_size+t.corp_stock_exchange_size+t.corp_inc_state_size+t.corp_inc_county_size+t.corp_inc_date_size+t.corp_anniversary_month_size+t.corp_fed_tax_id_size+t.corp_state_tax_id_size+t.corp_term_exist_cd_size+t.corp_term_exist_exp_size+t.corp_term_exist_desc_size+t.corp_foreign_domestic_ind_size+t.corp_forgn_state_cd_size+t.corp_forgn_state_desc_size+t.corp_forgn_sos_charter_nbr_size+t.corp_forgn_date_size+t.corp_forgn_fed_tax_id_size+t.corp_forgn_state_tax_id_size+t.corp_forgn_term_exist_cd_size+t.corp_forgn_term_exist_exp_size+t.corp_forgn_term_exist_desc_size+t.corp_orig_org_structure_cd_size+t.corp_orig_org_structure_desc_size+t.corp_for_profit_ind_size+t.corp_public_or_private_ind_size+t.corp_sic_code_size+t.corp_naic_code_size+t.corp_orig_bus_type_cd_size+t.corp_orig_bus_type_desc_size+t.corp_entity_desc_size+t.corp_certificate_nbr_size+t.corp_internal_nbr_size+t.corp_previous_nbr_size+t.corp_microfilm_nbr_size+t.corp_amendments_filed_size+t.corp_acts_size+t.corp_partnership_ind_size+t.corp_mfg_ind_size+t.corp_addl_info_size+t.corp_taxes_size+t.corp_franchise_taxes_size+t.corp_tax_program_cd_size+t.corp_tax_program_desc_size+t.corp_ra_full_name_size+t.corp_ra_fname_size+t.corp_ra_mname_size+t.corp_ra_lname_size+t.corp_ra_suffix_size+t.corp_ra_title_cd_size+t.corp_ra_title_desc_size+t.corp_ra_fein_size+t.corp_ra_ssn_size+t.corp_ra_dob_size+t.corp_ra_effective_date_size+t.corp_ra_resign_date_size+t.corp_ra_no_comp_size+t.corp_ra_no_comp_igs_size+t.corp_ra_addl_info_size+t.corp_ra_address_type_cd_size+t.corp_ra_address_type_desc_size+t.corp_ra_address_line1_size+t.corp_ra_address_line2_size+t.corp_ra_address_line3_size+t.corp_ra_phone_number_size+t.corp_ra_phone_number_type_cd_size+t.corp_ra_phone_number_type_desc_size+t.corp_ra_fax_nbr_size+t.corp_ra_email_address_size+t.corp_ra_web_address_size+t.corp_prep_addr1_line1_size+t.corp_prep_addr1_last_line_size+t.corp_prep_addr2_line1_size+t.corp_prep_addr2_last_line_size+t.ra_prep_addr_line1_size+t.ra_prep_addr_last_line_size+t.cont_filing_reference_nbr_size+t.cont_filing_date_size+t.cont_filing_cd_size+t.cont_filing_desc_size+t.cont_type_cd_size+t.cont_type_desc_size+t.cont_full_name_size+t.cont_fname_size+t.cont_mname_size+t.cont_lname_size+t.cont_suffix_size+t.cont_title1_desc_size+t.cont_title2_desc_size+t.cont_title3_desc_size+t.cont_title4_desc_size+t.cont_title5_desc_size+t.cont_fein_size+t.cont_ssn_size+t.cont_dob_size+t.cont_status_cd_size+t.cont_status_desc_size+t.cont_effective_date_size+t.cont_effective_cd_size+t.cont_effective_desc_size+t.cont_addl_info_size+t.cont_address_type_cd_size+t.cont_address_type_desc_size+t.cont_address_line1_size+t.cont_address_line2_size+t.cont_address_line3_size+t.cont_address_effective_date_size+t.cont_address_county_size+t.cont_phone_number_size+t.cont_phone_number_type_cd_size+t.cont_phone_number_type_desc_size+t.cont_fax_nbr_size+t.cont_email_address_size+t.cont_web_address_size+t.corp_acres_size+t.corp_action_size+t.corp_action_date_size+t.corp_action_employment_security_approval_date_size+t.corp_action_pending_cd_size+t.corp_action_pending_desc_size+t.corp_action_statement_of_intent_date_size+t.corp_action_tax_dept_approval_date_size+t.corp_acts2_size+t.corp_acts3_size+t.corp_additional_principals_size+t.corp_address_office_type_size+t.corp_agent_assign_date_size+t.corp_agent_commercial_size+t.corp_agent_country_size+t.corp_agent_county_size+t.corp_agent_status_cd_size+t.corp_agent_status_desc_size+t.corp_agent_id_size+t.corp_agriculture_flag_size+t.corp_authorized_partners_size+t.corp_comment_size+t.corp_consent_flag_for_protected_name_size+t.corp_converted_size+t.corp_converted_from_size+t.corp_country_of_formation_size+t.corp_date_of_organization_meeting_size+t.corp_delayed_effective_date_size+t.corp_directors_from_to_size+t.corp_dissolved_date_size+t.corp_farm_exemptions_size+t.corp_farm_qual_date_size+t.corp_farm_status_cd_size+t.corp_farm_status_desc_size+t.corp_fiscal_year_month_size+t.corp_foreign_fiduciary_capacity_in_state_size+t.corp_governing_statute_size+t.corp_has_members_size+t.corp_has_vested_managers_size+t.corp_home_incorporated_county_size+t.corp_home_state_name_size+t.corp_is_professional_size+t.corp_is_non_profit_irs_approved_size+t.corp_last_renewal_date_size+t.corp_last_renewal_year_size+t.corp_license_type_size+t.corp_llc_managed_desc_size+t.corp_llc_managed_ind_size+t.corp_management_desc_size+t.corp_management_type_size+t.corp_manager_managed_size+t.corp_merged_corporation_id_size+t.corp_merged_fein_size+t.corp_merger_allowed_flag_size+t.corp_merger_date_size+t.corp_merger_desc_size+t.corp_merger_effective_date_size+t.corp_merger_id_size+t.corp_merger_indicator_size+t.corp_merger_name_size+t.corp_merger_type_converted_to_cd_size+t.corp_merger_type_converted_to_desc_size+t.corp_naics_desc_size+t.corp_name_effective_date_size+t.corp_name_reservation_date_size+t.corp_name_reservation_desc_size+t.corp_name_reservation_expiration_date_size+t.corp_name_reservation_nbr_size+t.corp_name_reservation_type_size+t.corp_name_status_cd_size+t.corp_name_status_date_size+t.corp_name_status_desc_size+t.corp_non_profit_irs_approved_purpose_size+t.corp_non_profit_solicit_donations_size+t.corp_nbr_of_amendments_size+t.corp_nbr_of_initial_llc_members_size+t.corp_nbr_of_partners_size+t.corp_operating_agreement_size+t.corp_opt_in_llc_act_desc_size+t.corp_opt_in_llc_act_ind_size+t.corp_organizational_comments_size+t.corp_partner_contributions_total_size+t.corp_partner_terms_size+t.corp_percentage_voters_required_to_approve_amendments_size+t.corp_profession_size+t.corp_province_size+t.corp_public_mutual_corporation_size+t.corp_purpose_size+t.corp_ra_required_flag_size+t.corp_registered_counties_size+t.corp_regulated_ind_size+t.corp_renewal_date_size+t.corp_standing_other_size+t.corp_survivor_corporation_id_size+t.corp_tax_base_size+t.corp_tax_standing_size+t.corp_termination_cd_size+t.corp_termination_desc_size+t.corp_termination_date_size+t.corp_trademark_business_mark_type_size+t.corp_trademark_cancelled_date_size+t.corp_trademark_class_desc1_size+t.corp_trademark_class_desc2_size+t.corp_trademark_class_desc3_size+t.corp_trademark_class_desc4_size+t.corp_trademark_class_desc5_size+t.corp_trademark_class_desc6_size+t.corp_trademark_classification_nbr_size+t.corp_trademark_disclaimer1_size+t.corp_trademark_disclaimer2_size+t.corp_trademark_expiration_date_size+t.corp_trademark_filing_date_size+t.corp_trademark_first_use_date_size+t.corp_trademark_first_use_date_in_state_size+t.corp_trademark_keywords_size+t.corp_trademark_logo_size+t.corp_trademark_name_expiration_date_size+t.corp_trademark_nbr_size+t.corp_trademark_renewal_date_size+t.corp_trademark_status_size+t.corp_trademark_used_1_size+t.corp_trademark_used_2_size+t.corp_trademark_used_3_size+t.cont_owner_percentage_size+t.cont_country_size+t.cont_country_mailing_size+t.cont_nondislosure_size+t.cont_prep_addr_line1_size+t.cont_prep_addr_last_line_size+t.recordorigin_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
