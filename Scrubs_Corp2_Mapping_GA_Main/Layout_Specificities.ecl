IMPORT SALT34;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_in_file;
EXPORT dt_vendor_first_reported_year_ChildRec := RECORD
  UNSIGNED2 dt_vendor_first_reported_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_first_reported_month_ChildRec := RECORD
  UNSIGNED2 dt_vendor_first_reported_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_first_reported_day_ChildRec := RECORD
  UNSIGNED2 dt_vendor_first_reported_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_last_reported_year_ChildRec := RECORD
  UNSIGNED2 dt_vendor_last_reported_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_last_reported_month_ChildRec := RECORD
  UNSIGNED2 dt_vendor_last_reported_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_vendor_last_reported_day_ChildRec := RECORD
  UNSIGNED2 dt_vendor_last_reported_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_first_seen_year_ChildRec := RECORD
  UNSIGNED2 dt_first_seen_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_first_seen_month_ChildRec := RECORD
  UNSIGNED2 dt_first_seen_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_first_seen_day_ChildRec := RECORD
  UNSIGNED2 dt_first_seen_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_last_seen_year_ChildRec := RECORD
  UNSIGNED2 dt_last_seen_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_last_seen_month_ChildRec := RECORD
  UNSIGNED2 dt_last_seen_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT dt_last_seen_day_ChildRec := RECORD
  UNSIGNED2 dt_last_seen_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_first_seen_year_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_first_seen_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_first_seen_month_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_first_seen_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_first_seen_day_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_first_seen_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_last_seen_year_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_last_seen_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_last_seen_month_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_last_seen_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dt_last_seen_day_ChildRec := RECORD
  UNSIGNED2 corp_ra_dt_last_seen_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_key_ChildRec := RECORD
  TYPEOF(l.corp_key) corp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_supp_key_ChildRec := RECORD
  TYPEOF(l.corp_supp_key) corp_supp_key;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_vendor_ChildRec := RECORD
  TYPEOF(l.corp_vendor) corp_vendor;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_vendor_county_ChildRec := RECORD
  TYPEOF(l.corp_vendor_county) corp_vendor_county;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_vendor_subcode_ChildRec := RECORD
  TYPEOF(l.corp_vendor_subcode) corp_vendor_subcode;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_state_origin_ChildRec := RECORD
  TYPEOF(l.corp_state_origin) corp_state_origin;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_process_date_year_ChildRec := RECORD
  UNSIGNED2 corp_process_date_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_process_date_month_ChildRec := RECORD
  UNSIGNED2 corp_process_date_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_process_date_day_ChildRec := RECORD
  UNSIGNED2 corp_process_date_day;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_orig_sos_charter_nbr_ChildRec := RECORD
  TYPEOF(l.corp_orig_sos_charter_nbr) corp_orig_sos_charter_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_legal_name_ChildRec := RECORD
  TYPEOF(l.corp_legal_name) corp_legal_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ln_name_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_ln_name_type_cd) corp_ln_name_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ln_name_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_ln_name_type_desc) corp_ln_name_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_supp_nbr_ChildRec := RECORD
  TYPEOF(l.corp_supp_nbr) corp_supp_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_comment_ChildRec := RECORD
  TYPEOF(l.corp_name_comment) corp_name_comment;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_address1_type_cd) corp_address1_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_address1_type_desc) corp_address1_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_line1_ChildRec := RECORD
  TYPEOF(l.corp_address1_line1) corp_address1_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_line2_ChildRec := RECORD
  TYPEOF(l.corp_address1_line2) corp_address1_line2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_line3_ChildRec := RECORD
  TYPEOF(l.corp_address1_line3) corp_address1_line3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address1_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_address1_effective_date) corp_address1_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_address2_type_cd) corp_address2_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_address2_type_desc) corp_address2_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_line1_ChildRec := RECORD
  TYPEOF(l.corp_address2_line1) corp_address2_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_line2_ChildRec := RECORD
  TYPEOF(l.corp_address2_line2) corp_address2_line2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_line3_ChildRec := RECORD
  TYPEOF(l.corp_address2_line3) corp_address2_line3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address2_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_address2_effective_date) corp_address2_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_phone_number_ChildRec := RECORD
  TYPEOF(l.corp_phone_number) corp_phone_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_phone_number_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_phone_number_type_cd) corp_phone_number_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_phone_number_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_phone_number_type_desc) corp_phone_number_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_fax_nbr_ChildRec := RECORD
  TYPEOF(l.corp_fax_nbr) corp_fax_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_email_address_ChildRec := RECORD
  TYPEOF(l.corp_email_address) corp_email_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_web_address_ChildRec := RECORD
  TYPEOF(l.corp_web_address) corp_web_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_filing_reference_nbr_ChildRec := RECORD
  TYPEOF(l.corp_filing_reference_nbr) corp_filing_reference_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_filing_date_ChildRec := RECORD
  TYPEOF(l.corp_filing_date) corp_filing_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_filing_cd_ChildRec := RECORD
  TYPEOF(l.corp_filing_cd) corp_filing_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_filing_desc_ChildRec := RECORD
  TYPEOF(l.corp_filing_desc) corp_filing_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_status_cd_ChildRec := RECORD
  TYPEOF(l.corp_status_cd) corp_status_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_status_desc_ChildRec := RECORD
  TYPEOF(l.corp_status_desc) corp_status_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_status_date_ChildRec := RECORD
  TYPEOF(l.corp_status_date) corp_status_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_standing_ChildRec := RECORD
  TYPEOF(l.corp_standing) corp_standing;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_status_comment_ChildRec := RECORD
  TYPEOF(l.corp_status_comment) corp_status_comment;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ticker_symbol_ChildRec := RECORD
  TYPEOF(l.corp_ticker_symbol) corp_ticker_symbol;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_stock_exchange_ChildRec := RECORD
  TYPEOF(l.corp_stock_exchange) corp_stock_exchange;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_inc_state_ChildRec := RECORD
  TYPEOF(l.corp_inc_state) corp_inc_state;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_inc_county_ChildRec := RECORD
  TYPEOF(l.corp_inc_county) corp_inc_county;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_inc_date_ChildRec := RECORD
  TYPEOF(l.corp_inc_date) corp_inc_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_anniversary_month_ChildRec := RECORD
  TYPEOF(l.corp_anniversary_month) corp_anniversary_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_fed_tax_id_ChildRec := RECORD
  TYPEOF(l.corp_fed_tax_id) corp_fed_tax_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_state_tax_id_ChildRec := RECORD
  TYPEOF(l.corp_state_tax_id) corp_state_tax_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_term_exist_cd_ChildRec := RECORD
  TYPEOF(l.corp_term_exist_cd) corp_term_exist_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_term_exist_exp_ChildRec := RECORD
  TYPEOF(l.corp_term_exist_exp) corp_term_exist_exp;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_term_exist_desc_ChildRec := RECORD
  TYPEOF(l.corp_term_exist_desc) corp_term_exist_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_foreign_domestic_ind_ChildRec := RECORD
  TYPEOF(l.corp_foreign_domestic_ind) corp_foreign_domestic_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_state_cd_ChildRec := RECORD
  TYPEOF(l.corp_forgn_state_cd) corp_forgn_state_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_state_desc_ChildRec := RECORD
  TYPEOF(l.corp_forgn_state_desc) corp_forgn_state_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_sos_charter_nbr_ChildRec := RECORD
  TYPEOF(l.corp_forgn_sos_charter_nbr) corp_forgn_sos_charter_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_date_ChildRec := RECORD
  TYPEOF(l.corp_forgn_date) corp_forgn_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_fed_tax_id_ChildRec := RECORD
  TYPEOF(l.corp_forgn_fed_tax_id) corp_forgn_fed_tax_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_state_tax_id_ChildRec := RECORD
  TYPEOF(l.corp_forgn_state_tax_id) corp_forgn_state_tax_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_term_exist_cd_ChildRec := RECORD
  TYPEOF(l.corp_forgn_term_exist_cd) corp_forgn_term_exist_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_term_exist_exp_ChildRec := RECORD
  TYPEOF(l.corp_forgn_term_exist_exp) corp_forgn_term_exist_exp;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_forgn_term_exist_desc_ChildRec := RECORD
  TYPEOF(l.corp_forgn_term_exist_desc) corp_forgn_term_exist_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_orig_org_structure_cd_ChildRec := RECORD
  TYPEOF(l.corp_orig_org_structure_cd) corp_orig_org_structure_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_orig_org_structure_desc_ChildRec := RECORD
  TYPEOF(l.corp_orig_org_structure_desc) corp_orig_org_structure_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_for_profit_ind_ChildRec := RECORD
  TYPEOF(l.corp_for_profit_ind) corp_for_profit_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_public_or_private_ind_ChildRec := RECORD
  TYPEOF(l.corp_public_or_private_ind) corp_public_or_private_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_sic_code_ChildRec := RECORD
  TYPEOF(l.corp_sic_code) corp_sic_code;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_naic_code_ChildRec := RECORD
  TYPEOF(l.corp_naic_code) corp_naic_code;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_orig_bus_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_orig_bus_type_cd) corp_orig_bus_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_orig_bus_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_orig_bus_type_desc) corp_orig_bus_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_entity_desc_ChildRec := RECORD
  TYPEOF(l.corp_entity_desc) corp_entity_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_certificate_nbr_ChildRec := RECORD
  TYPEOF(l.corp_certificate_nbr) corp_certificate_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_internal_nbr_ChildRec := RECORD
  TYPEOF(l.corp_internal_nbr) corp_internal_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_previous_nbr_ChildRec := RECORD
  TYPEOF(l.corp_previous_nbr) corp_previous_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_microfilm_nbr_ChildRec := RECORD
  TYPEOF(l.corp_microfilm_nbr) corp_microfilm_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_amendments_filed_ChildRec := RECORD
  TYPEOF(l.corp_amendments_filed) corp_amendments_filed;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_acts_ChildRec := RECORD
  TYPEOF(l.corp_acts) corp_acts;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_partnership_ind_ChildRec := RECORD
  TYPEOF(l.corp_partnership_ind) corp_partnership_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_mfg_ind_ChildRec := RECORD
  TYPEOF(l.corp_mfg_ind) corp_mfg_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_addl_info_ChildRec := RECORD
  TYPEOF(l.corp_addl_info) corp_addl_info;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_taxes_ChildRec := RECORD
  TYPEOF(l.corp_taxes) corp_taxes;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_franchise_taxes_ChildRec := RECORD
  TYPEOF(l.corp_franchise_taxes) corp_franchise_taxes;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_tax_program_cd_ChildRec := RECORD
  TYPEOF(l.corp_tax_program_cd) corp_tax_program_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_tax_program_desc_ChildRec := RECORD
  TYPEOF(l.corp_tax_program_desc) corp_tax_program_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_full_name_ChildRec := RECORD
  TYPEOF(l.corp_ra_full_name) corp_ra_full_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_fname_ChildRec := RECORD
  TYPEOF(l.corp_ra_fname) corp_ra_fname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_mname_ChildRec := RECORD
  TYPEOF(l.corp_ra_mname) corp_ra_mname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_lname_ChildRec := RECORD
  TYPEOF(l.corp_ra_lname) corp_ra_lname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_suffix_ChildRec := RECORD
  TYPEOF(l.corp_ra_suffix) corp_ra_suffix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_title_cd_ChildRec := RECORD
  TYPEOF(l.corp_ra_title_cd) corp_ra_title_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_title_desc_ChildRec := RECORD
  TYPEOF(l.corp_ra_title_desc) corp_ra_title_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_fein_ChildRec := RECORD
  TYPEOF(l.corp_ra_fein) corp_ra_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_ssn_ChildRec := RECORD
  TYPEOF(l.corp_ra_ssn) corp_ra_ssn;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_dob_ChildRec := RECORD
  TYPEOF(l.corp_ra_dob) corp_ra_dob;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_ra_effective_date) corp_ra_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_resign_date_ChildRec := RECORD
  TYPEOF(l.corp_ra_resign_date) corp_ra_resign_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_no_comp_ChildRec := RECORD
  TYPEOF(l.corp_ra_no_comp) corp_ra_no_comp;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_no_comp_igs_ChildRec := RECORD
  TYPEOF(l.corp_ra_no_comp_igs) corp_ra_no_comp_igs;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_addl_info_ChildRec := RECORD
  TYPEOF(l.corp_ra_addl_info) corp_ra_addl_info;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_address_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_ra_address_type_cd) corp_ra_address_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_address_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_ra_address_type_desc) corp_ra_address_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_address_line1_ChildRec := RECORD
  TYPEOF(l.corp_ra_address_line1) corp_ra_address_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_address_line2_ChildRec := RECORD
  TYPEOF(l.corp_ra_address_line2) corp_ra_address_line2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_address_line3_ChildRec := RECORD
  TYPEOF(l.corp_ra_address_line3) corp_ra_address_line3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_phone_number_ChildRec := RECORD
  TYPEOF(l.corp_ra_phone_number) corp_ra_phone_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_phone_number_type_cd_ChildRec := RECORD
  TYPEOF(l.corp_ra_phone_number_type_cd) corp_ra_phone_number_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_phone_number_type_desc_ChildRec := RECORD
  TYPEOF(l.corp_ra_phone_number_type_desc) corp_ra_phone_number_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_fax_nbr_ChildRec := RECORD
  TYPEOF(l.corp_ra_fax_nbr) corp_ra_fax_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_email_address_ChildRec := RECORD
  TYPEOF(l.corp_ra_email_address) corp_ra_email_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_web_address_ChildRec := RECORD
  TYPEOF(l.corp_ra_web_address) corp_ra_web_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_prep_addr1_line1_ChildRec := RECORD
  TYPEOF(l.corp_prep_addr1_line1) corp_prep_addr1_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_prep_addr1_last_line_ChildRec := RECORD
  TYPEOF(l.corp_prep_addr1_last_line) corp_prep_addr1_last_line;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_prep_addr2_line1_ChildRec := RECORD
  TYPEOF(l.corp_prep_addr2_line1) corp_prep_addr2_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_prep_addr2_last_line_ChildRec := RECORD
  TYPEOF(l.corp_prep_addr2_last_line) corp_prep_addr2_last_line;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ra_prep_addr_line1_ChildRec := RECORD
  TYPEOF(l.ra_prep_addr_line1) ra_prep_addr_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT ra_prep_addr_last_line_ChildRec := RECORD
  TYPEOF(l.ra_prep_addr_last_line) ra_prep_addr_last_line;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_filing_reference_nbr_ChildRec := RECORD
  TYPEOF(l.cont_filing_reference_nbr) cont_filing_reference_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_filing_date_ChildRec := RECORD
  TYPEOF(l.cont_filing_date) cont_filing_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_filing_cd_ChildRec := RECORD
  TYPEOF(l.cont_filing_cd) cont_filing_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_filing_desc_ChildRec := RECORD
  TYPEOF(l.cont_filing_desc) cont_filing_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_type_cd_ChildRec := RECORD
  TYPEOF(l.cont_type_cd) cont_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_type_desc_ChildRec := RECORD
  TYPEOF(l.cont_type_desc) cont_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_full_name_ChildRec := RECORD
  TYPEOF(l.cont_full_name) cont_full_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_fname_ChildRec := RECORD
  TYPEOF(l.cont_fname) cont_fname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_mname_ChildRec := RECORD
  TYPEOF(l.cont_mname) cont_mname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_lname_ChildRec := RECORD
  TYPEOF(l.cont_lname) cont_lname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_suffix_ChildRec := RECORD
  TYPEOF(l.cont_suffix) cont_suffix;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_title1_desc_ChildRec := RECORD
  TYPEOF(l.cont_title1_desc) cont_title1_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_title2_desc_ChildRec := RECORD
  TYPEOF(l.cont_title2_desc) cont_title2_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_title3_desc_ChildRec := RECORD
  TYPEOF(l.cont_title3_desc) cont_title3_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_title4_desc_ChildRec := RECORD
  TYPEOF(l.cont_title4_desc) cont_title4_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_title5_desc_ChildRec := RECORD
  TYPEOF(l.cont_title5_desc) cont_title5_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_fein_ChildRec := RECORD
  TYPEOF(l.cont_fein) cont_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_ssn_ChildRec := RECORD
  TYPEOF(l.cont_ssn) cont_ssn;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_dob_ChildRec := RECORD
  TYPEOF(l.cont_dob) cont_dob;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_status_cd_ChildRec := RECORD
  TYPEOF(l.cont_status_cd) cont_status_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_status_desc_ChildRec := RECORD
  TYPEOF(l.cont_status_desc) cont_status_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_effective_date_ChildRec := RECORD
  TYPEOF(l.cont_effective_date) cont_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_effective_cd_ChildRec := RECORD
  TYPEOF(l.cont_effective_cd) cont_effective_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_effective_desc_ChildRec := RECORD
  TYPEOF(l.cont_effective_desc) cont_effective_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_addl_info_ChildRec := RECORD
  TYPEOF(l.cont_addl_info) cont_addl_info;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_type_cd_ChildRec := RECORD
  TYPEOF(l.cont_address_type_cd) cont_address_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_type_desc_ChildRec := RECORD
  TYPEOF(l.cont_address_type_desc) cont_address_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_line1_ChildRec := RECORD
  TYPEOF(l.cont_address_line1) cont_address_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_line2_ChildRec := RECORD
  TYPEOF(l.cont_address_line2) cont_address_line2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_line3_ChildRec := RECORD
  TYPEOF(l.cont_address_line3) cont_address_line3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_effective_date_ChildRec := RECORD
  TYPEOF(l.cont_address_effective_date) cont_address_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_address_county_ChildRec := RECORD
  TYPEOF(l.cont_address_county) cont_address_county;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_phone_number_ChildRec := RECORD
  TYPEOF(l.cont_phone_number) cont_phone_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_phone_number_type_cd_ChildRec := RECORD
  TYPEOF(l.cont_phone_number_type_cd) cont_phone_number_type_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_phone_number_type_desc_ChildRec := RECORD
  TYPEOF(l.cont_phone_number_type_desc) cont_phone_number_type_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_fax_nbr_ChildRec := RECORD
  TYPEOF(l.cont_fax_nbr) cont_fax_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_email_address_ChildRec := RECORD
  TYPEOF(l.cont_email_address) cont_email_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_web_address_ChildRec := RECORD
  TYPEOF(l.cont_web_address) cont_web_address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_acres_ChildRec := RECORD
  TYPEOF(l.corp_acres) corp_acres;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_ChildRec := RECORD
  TYPEOF(l.corp_action) corp_action;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_date_ChildRec := RECORD
  TYPEOF(l.corp_action_date) corp_action_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_employment_security_approval_date_ChildRec := RECORD
  TYPEOF(l.corp_action_employment_security_approval_date) corp_action_employment_security_approval_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_pending_cd_ChildRec := RECORD
  TYPEOF(l.corp_action_pending_cd) corp_action_pending_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_pending_desc_ChildRec := RECORD
  TYPEOF(l.corp_action_pending_desc) corp_action_pending_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_statement_of_intent_date_ChildRec := RECORD
  TYPEOF(l.corp_action_statement_of_intent_date) corp_action_statement_of_intent_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_action_tax_dept_approval_date_ChildRec := RECORD
  TYPEOF(l.corp_action_tax_dept_approval_date) corp_action_tax_dept_approval_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_acts2_ChildRec := RECORD
  TYPEOF(l.corp_acts2) corp_acts2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_acts3_ChildRec := RECORD
  TYPEOF(l.corp_acts3) corp_acts3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_additional_principals_ChildRec := RECORD
  TYPEOF(l.corp_additional_principals) corp_additional_principals;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_address_office_type_ChildRec := RECORD
  TYPEOF(l.corp_address_office_type) corp_address_office_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_assign_date_ChildRec := RECORD
  TYPEOF(l.corp_agent_assign_date) corp_agent_assign_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_commercial_ChildRec := RECORD
  TYPEOF(l.corp_agent_commercial) corp_agent_commercial;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_country_ChildRec := RECORD
  TYPEOF(l.corp_agent_country) corp_agent_country;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_county_ChildRec := RECORD
  TYPEOF(l.corp_agent_county) corp_agent_county;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_status_cd_ChildRec := RECORD
  TYPEOF(l.corp_agent_status_cd) corp_agent_status_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_status_desc_ChildRec := RECORD
  TYPEOF(l.corp_agent_status_desc) corp_agent_status_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agent_id_ChildRec := RECORD
  TYPEOF(l.corp_agent_id) corp_agent_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_agriculture_flag_ChildRec := RECORD
  TYPEOF(l.corp_agriculture_flag) corp_agriculture_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_authorized_partners_ChildRec := RECORD
  TYPEOF(l.corp_authorized_partners) corp_authorized_partners;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_comment_ChildRec := RECORD
  TYPEOF(l.corp_comment) corp_comment;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_consent_flag_for_protected_name_ChildRec := RECORD
  TYPEOF(l.corp_consent_flag_for_protected_name) corp_consent_flag_for_protected_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_converted_ChildRec := RECORD
  TYPEOF(l.corp_converted) corp_converted;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_converted_from_ChildRec := RECORD
  TYPEOF(l.corp_converted_from) corp_converted_from;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_country_of_formation_ChildRec := RECORD
  TYPEOF(l.corp_country_of_formation) corp_country_of_formation;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_date_of_organization_meeting_ChildRec := RECORD
  TYPEOF(l.corp_date_of_organization_meeting) corp_date_of_organization_meeting;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_delayed_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_delayed_effective_date) corp_delayed_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_directors_from_to_ChildRec := RECORD
  TYPEOF(l.corp_directors_from_to) corp_directors_from_to;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_dissolved_date_ChildRec := RECORD
  TYPEOF(l.corp_dissolved_date) corp_dissolved_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_farm_exemptions_ChildRec := RECORD
  TYPEOF(l.corp_farm_exemptions) corp_farm_exemptions;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_farm_qual_date_ChildRec := RECORD
  TYPEOF(l.corp_farm_qual_date) corp_farm_qual_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_farm_status_cd_ChildRec := RECORD
  TYPEOF(l.corp_farm_status_cd) corp_farm_status_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_farm_status_desc_ChildRec := RECORD
  TYPEOF(l.corp_farm_status_desc) corp_farm_status_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_fiscal_year_month_ChildRec := RECORD
  TYPEOF(l.corp_fiscal_year_month) corp_fiscal_year_month;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_foreign_fiduciary_capacity_in_state_ChildRec := RECORD
  TYPEOF(l.corp_foreign_fiduciary_capacity_in_state) corp_foreign_fiduciary_capacity_in_state;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_governing_statute_ChildRec := RECORD
  TYPEOF(l.corp_governing_statute) corp_governing_statute;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_has_members_ChildRec := RECORD
  TYPEOF(l.corp_has_members) corp_has_members;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_has_vested_managers_ChildRec := RECORD
  TYPEOF(l.corp_has_vested_managers) corp_has_vested_managers;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_home_incorporated_county_ChildRec := RECORD
  TYPEOF(l.corp_home_incorporated_county) corp_home_incorporated_county;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_home_state_name_ChildRec := RECORD
  TYPEOF(l.corp_home_state_name) corp_home_state_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_is_professional_ChildRec := RECORD
  TYPEOF(l.corp_is_professional) corp_is_professional;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_is_non_profit_irs_approved_ChildRec := RECORD
  TYPEOF(l.corp_is_non_profit_irs_approved) corp_is_non_profit_irs_approved;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_last_renewal_date_ChildRec := RECORD
  TYPEOF(l.corp_last_renewal_date) corp_last_renewal_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_last_renewal_year_ChildRec := RECORD
  TYPEOF(l.corp_last_renewal_year) corp_last_renewal_year;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_license_type_ChildRec := RECORD
  TYPEOF(l.corp_license_type) corp_license_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_llc_managed_desc_ChildRec := RECORD
  TYPEOF(l.corp_llc_managed_desc) corp_llc_managed_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_llc_managed_ind_ChildRec := RECORD
  TYPEOF(l.corp_llc_managed_ind) corp_llc_managed_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_management_desc_ChildRec := RECORD
  TYPEOF(l.corp_management_desc) corp_management_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_management_type_ChildRec := RECORD
  TYPEOF(l.corp_management_type) corp_management_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_manager_managed_ChildRec := RECORD
  TYPEOF(l.corp_manager_managed) corp_manager_managed;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merged_corporation_id_ChildRec := RECORD
  TYPEOF(l.corp_merged_corporation_id) corp_merged_corporation_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merged_fein_ChildRec := RECORD
  TYPEOF(l.corp_merged_fein) corp_merged_fein;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_allowed_flag_ChildRec := RECORD
  TYPEOF(l.corp_merger_allowed_flag) corp_merger_allowed_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_date_ChildRec := RECORD
  TYPEOF(l.corp_merger_date) corp_merger_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_desc_ChildRec := RECORD
  TYPEOF(l.corp_merger_desc) corp_merger_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_merger_effective_date) corp_merger_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_id_ChildRec := RECORD
  TYPEOF(l.corp_merger_id) corp_merger_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_indicator_ChildRec := RECORD
  TYPEOF(l.corp_merger_indicator) corp_merger_indicator;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_name_ChildRec := RECORD
  TYPEOF(l.corp_merger_name) corp_merger_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_type_converted_to_cd_ChildRec := RECORD
  TYPEOF(l.corp_merger_type_converted_to_cd) corp_merger_type_converted_to_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_merger_type_converted_to_desc_ChildRec := RECORD
  TYPEOF(l.corp_merger_type_converted_to_desc) corp_merger_type_converted_to_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_naics_desc_ChildRec := RECORD
  TYPEOF(l.corp_naics_desc) corp_naics_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_effective_date_ChildRec := RECORD
  TYPEOF(l.corp_name_effective_date) corp_name_effective_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_reservation_date_ChildRec := RECORD
  TYPEOF(l.corp_name_reservation_date) corp_name_reservation_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_reservation_desc_ChildRec := RECORD
  TYPEOF(l.corp_name_reservation_desc) corp_name_reservation_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_reservation_expiration_date_ChildRec := RECORD
  TYPEOF(l.corp_name_reservation_expiration_date) corp_name_reservation_expiration_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_reservation_nbr_ChildRec := RECORD
  TYPEOF(l.corp_name_reservation_nbr) corp_name_reservation_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_reservation_type_ChildRec := RECORD
  TYPEOF(l.corp_name_reservation_type) corp_name_reservation_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_status_cd_ChildRec := RECORD
  TYPEOF(l.corp_name_status_cd) corp_name_status_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_status_date_ChildRec := RECORD
  TYPEOF(l.corp_name_status_date) corp_name_status_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_name_status_desc_ChildRec := RECORD
  TYPEOF(l.corp_name_status_desc) corp_name_status_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_non_profit_irs_approved_purpose_ChildRec := RECORD
  TYPEOF(l.corp_non_profit_irs_approved_purpose) corp_non_profit_irs_approved_purpose;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_non_profit_solicit_donations_ChildRec := RECORD
  TYPEOF(l.corp_non_profit_solicit_donations) corp_non_profit_solicit_donations;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_nbr_of_amendments_ChildRec := RECORD
  TYPEOF(l.corp_nbr_of_amendments) corp_nbr_of_amendments;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_nbr_of_initial_llc_members_ChildRec := RECORD
  TYPEOF(l.corp_nbr_of_initial_llc_members) corp_nbr_of_initial_llc_members;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_nbr_of_partners_ChildRec := RECORD
  TYPEOF(l.corp_nbr_of_partners) corp_nbr_of_partners;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_operating_agreement_ChildRec := RECORD
  TYPEOF(l.corp_operating_agreement) corp_operating_agreement;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_opt_in_llc_act_desc_ChildRec := RECORD
  TYPEOF(l.corp_opt_in_llc_act_desc) corp_opt_in_llc_act_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_opt_in_llc_act_ind_ChildRec := RECORD
  TYPEOF(l.corp_opt_in_llc_act_ind) corp_opt_in_llc_act_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_organizational_comments_ChildRec := RECORD
  TYPEOF(l.corp_organizational_comments) corp_organizational_comments;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_partner_contributions_total_ChildRec := RECORD
  TYPEOF(l.corp_partner_contributions_total) corp_partner_contributions_total;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_partner_terms_ChildRec := RECORD
  TYPEOF(l.corp_partner_terms) corp_partner_terms;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_percentage_voters_required_to_approve_amendments_ChildRec := RECORD
  TYPEOF(l.corp_percentage_voters_required_to_approve_amendments) corp_percentage_voters_required_to_approve_amendments;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_profession_ChildRec := RECORD
  TYPEOF(l.corp_profession) corp_profession;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_province_ChildRec := RECORD
  TYPEOF(l.corp_province) corp_province;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_public_mutual_corporation_ChildRec := RECORD
  TYPEOF(l.corp_public_mutual_corporation) corp_public_mutual_corporation;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_purpose_ChildRec := RECORD
  TYPEOF(l.corp_purpose) corp_purpose;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_ra_required_flag_ChildRec := RECORD
  TYPEOF(l.corp_ra_required_flag) corp_ra_required_flag;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_registered_counties_ChildRec := RECORD
  TYPEOF(l.corp_registered_counties) corp_registered_counties;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_regulated_ind_ChildRec := RECORD
  TYPEOF(l.corp_regulated_ind) corp_regulated_ind;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_renewal_date_ChildRec := RECORD
  TYPEOF(l.corp_renewal_date) corp_renewal_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_standing_other_ChildRec := RECORD
  TYPEOF(l.corp_standing_other) corp_standing_other;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_survivor_corporation_id_ChildRec := RECORD
  TYPEOF(l.corp_survivor_corporation_id) corp_survivor_corporation_id;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_tax_base_ChildRec := RECORD
  TYPEOF(l.corp_tax_base) corp_tax_base;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_tax_standing_ChildRec := RECORD
  TYPEOF(l.corp_tax_standing) corp_tax_standing;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_termination_cd_ChildRec := RECORD
  TYPEOF(l.corp_termination_cd) corp_termination_cd;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_termination_desc_ChildRec := RECORD
  TYPEOF(l.corp_termination_desc) corp_termination_desc;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_termination_date_ChildRec := RECORD
  TYPEOF(l.corp_termination_date) corp_termination_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_business_mark_type_ChildRec := RECORD
  TYPEOF(l.corp_trademark_business_mark_type) corp_trademark_business_mark_type;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_cancelled_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_cancelled_date) corp_trademark_cancelled_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc1_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc1) corp_trademark_class_desc1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc2_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc2) corp_trademark_class_desc2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc3_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc3) corp_trademark_class_desc3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc4_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc4) corp_trademark_class_desc4;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc5_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc5) corp_trademark_class_desc5;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_class_desc6_ChildRec := RECORD
  TYPEOF(l.corp_trademark_class_desc6) corp_trademark_class_desc6;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_classification_nbr_ChildRec := RECORD
  TYPEOF(l.corp_trademark_classification_nbr) corp_trademark_classification_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_disclaimer1_ChildRec := RECORD
  TYPEOF(l.corp_trademark_disclaimer1) corp_trademark_disclaimer1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_disclaimer2_ChildRec := RECORD
  TYPEOF(l.corp_trademark_disclaimer2) corp_trademark_disclaimer2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_expiration_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_expiration_date) corp_trademark_expiration_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_filing_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_filing_date) corp_trademark_filing_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_first_use_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_first_use_date) corp_trademark_first_use_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_first_use_date_in_state_ChildRec := RECORD
  TYPEOF(l.corp_trademark_first_use_date_in_state) corp_trademark_first_use_date_in_state;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_keywords_ChildRec := RECORD
  TYPEOF(l.corp_trademark_keywords) corp_trademark_keywords;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_logo_ChildRec := RECORD
  TYPEOF(l.corp_trademark_logo) corp_trademark_logo;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_name_expiration_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_name_expiration_date) corp_trademark_name_expiration_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_nbr_ChildRec := RECORD
  TYPEOF(l.corp_trademark_nbr) corp_trademark_nbr;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_renewal_date_ChildRec := RECORD
  TYPEOF(l.corp_trademark_renewal_date) corp_trademark_renewal_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_status_ChildRec := RECORD
  TYPEOF(l.corp_trademark_status) corp_trademark_status;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_used_1_ChildRec := RECORD
  TYPEOF(l.corp_trademark_used_1) corp_trademark_used_1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_used_2_ChildRec := RECORD
  TYPEOF(l.corp_trademark_used_2) corp_trademark_used_2;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT corp_trademark_used_3_ChildRec := RECORD
  TYPEOF(l.corp_trademark_used_3) corp_trademark_used_3;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_owner_percentage_ChildRec := RECORD
  TYPEOF(l.cont_owner_percentage) cont_owner_percentage;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_country_ChildRec := RECORD
  TYPEOF(l.cont_country) cont_country;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_country_mailing_ChildRec := RECORD
  TYPEOF(l.cont_country_mailing) cont_country_mailing;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_nondislosure_ChildRec := RECORD
  TYPEOF(l.cont_nondislosure) cont_nondislosure;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_prep_addr_line1_ChildRec := RECORD
  TYPEOF(l.cont_prep_addr_line1) cont_prep_addr_line1;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT cont_prep_addr_last_line_ChildRec := RECORD
  TYPEOF(l.cont_prep_addr_last_line) cont_prep_addr_last_line;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT recordorigin_ChildRec := RECORD
  TYPEOF(l.recordorigin) recordorigin;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 dt_vendor_first_reported_year_specificity;
  REAL4 dt_vendor_first_reported_year_switch;
  REAL4 dt_vendor_first_reported_year_maximum;
  DATASET(dt_vendor_first_reported_year_ChildRec) nulls_dt_vendor_first_reported_year {MAXCOUNT(100)};
  REAL4 dt_vendor_first_reported_month_specificity;
  REAL4 dt_vendor_first_reported_month_switch;
  REAL4 dt_vendor_first_reported_month_maximum;
  DATASET(dt_vendor_first_reported_month_ChildRec) nulls_dt_vendor_first_reported_month {MAXCOUNT(100)};
  REAL4 dt_vendor_first_reported_day_specificity;
  REAL4 dt_vendor_first_reported_day_switch;
  REAL4 dt_vendor_first_reported_day_maximum;
  DATASET(dt_vendor_first_reported_day_ChildRec) nulls_dt_vendor_first_reported_day {MAXCOUNT(100)};
  REAL4 dt_vendor_last_reported_year_specificity;
  REAL4 dt_vendor_last_reported_year_switch;
  REAL4 dt_vendor_last_reported_year_maximum;
  DATASET(dt_vendor_last_reported_year_ChildRec) nulls_dt_vendor_last_reported_year {MAXCOUNT(100)};
  REAL4 dt_vendor_last_reported_month_specificity;
  REAL4 dt_vendor_last_reported_month_switch;
  REAL4 dt_vendor_last_reported_month_maximum;
  DATASET(dt_vendor_last_reported_month_ChildRec) nulls_dt_vendor_last_reported_month {MAXCOUNT(100)};
  REAL4 dt_vendor_last_reported_day_specificity;
  REAL4 dt_vendor_last_reported_day_switch;
  REAL4 dt_vendor_last_reported_day_maximum;
  DATASET(dt_vendor_last_reported_day_ChildRec) nulls_dt_vendor_last_reported_day {MAXCOUNT(100)};
  REAL4 dt_first_seen_year_specificity;
  REAL4 dt_first_seen_year_switch;
  REAL4 dt_first_seen_year_maximum;
  DATASET(dt_first_seen_year_ChildRec) nulls_dt_first_seen_year {MAXCOUNT(100)};
  REAL4 dt_first_seen_month_specificity;
  REAL4 dt_first_seen_month_switch;
  REAL4 dt_first_seen_month_maximum;
  DATASET(dt_first_seen_month_ChildRec) nulls_dt_first_seen_month {MAXCOUNT(100)};
  REAL4 dt_first_seen_day_specificity;
  REAL4 dt_first_seen_day_switch;
  REAL4 dt_first_seen_day_maximum;
  DATASET(dt_first_seen_day_ChildRec) nulls_dt_first_seen_day {MAXCOUNT(100)};
  REAL4 dt_last_seen_year_specificity;
  REAL4 dt_last_seen_year_switch;
  REAL4 dt_last_seen_year_maximum;
  DATASET(dt_last_seen_year_ChildRec) nulls_dt_last_seen_year {MAXCOUNT(100)};
  REAL4 dt_last_seen_month_specificity;
  REAL4 dt_last_seen_month_switch;
  REAL4 dt_last_seen_month_maximum;
  DATASET(dt_last_seen_month_ChildRec) nulls_dt_last_seen_month {MAXCOUNT(100)};
  REAL4 dt_last_seen_day_specificity;
  REAL4 dt_last_seen_day_switch;
  REAL4 dt_last_seen_day_maximum;
  DATASET(dt_last_seen_day_ChildRec) nulls_dt_last_seen_day {MAXCOUNT(100)};
  REAL4 corp_ra_dt_first_seen_year_specificity;
  REAL4 corp_ra_dt_first_seen_year_switch;
  REAL4 corp_ra_dt_first_seen_year_maximum;
  DATASET(corp_ra_dt_first_seen_year_ChildRec) nulls_corp_ra_dt_first_seen_year {MAXCOUNT(100)};
  REAL4 corp_ra_dt_first_seen_month_specificity;
  REAL4 corp_ra_dt_first_seen_month_switch;
  REAL4 corp_ra_dt_first_seen_month_maximum;
  DATASET(corp_ra_dt_first_seen_month_ChildRec) nulls_corp_ra_dt_first_seen_month {MAXCOUNT(100)};
  REAL4 corp_ra_dt_first_seen_day_specificity;
  REAL4 corp_ra_dt_first_seen_day_switch;
  REAL4 corp_ra_dt_first_seen_day_maximum;
  DATASET(corp_ra_dt_first_seen_day_ChildRec) nulls_corp_ra_dt_first_seen_day {MAXCOUNT(100)};
  REAL4 corp_ra_dt_last_seen_year_specificity;
  REAL4 corp_ra_dt_last_seen_year_switch;
  REAL4 corp_ra_dt_last_seen_year_maximum;
  DATASET(corp_ra_dt_last_seen_year_ChildRec) nulls_corp_ra_dt_last_seen_year {MAXCOUNT(100)};
  REAL4 corp_ra_dt_last_seen_month_specificity;
  REAL4 corp_ra_dt_last_seen_month_switch;
  REAL4 corp_ra_dt_last_seen_month_maximum;
  DATASET(corp_ra_dt_last_seen_month_ChildRec) nulls_corp_ra_dt_last_seen_month {MAXCOUNT(100)};
  REAL4 corp_ra_dt_last_seen_day_specificity;
  REAL4 corp_ra_dt_last_seen_day_switch;
  REAL4 corp_ra_dt_last_seen_day_maximum;
  DATASET(corp_ra_dt_last_seen_day_ChildRec) nulls_corp_ra_dt_last_seen_day {MAXCOUNT(100)};
  REAL4 corp_key_specificity;
  REAL4 corp_key_switch;
  REAL4 corp_key_maximum;
  DATASET(corp_key_ChildRec) nulls_corp_key {MAXCOUNT(100)};
  REAL4 corp_supp_key_specificity;
  REAL4 corp_supp_key_switch;
  REAL4 corp_supp_key_maximum;
  DATASET(corp_supp_key_ChildRec) nulls_corp_supp_key {MAXCOUNT(100)};
  REAL4 corp_vendor_specificity;
  REAL4 corp_vendor_switch;
  REAL4 corp_vendor_maximum;
  DATASET(corp_vendor_ChildRec) nulls_corp_vendor {MAXCOUNT(100)};
  REAL4 corp_vendor_county_specificity;
  REAL4 corp_vendor_county_switch;
  REAL4 corp_vendor_county_maximum;
  DATASET(corp_vendor_county_ChildRec) nulls_corp_vendor_county {MAXCOUNT(100)};
  REAL4 corp_vendor_subcode_specificity;
  REAL4 corp_vendor_subcode_switch;
  REAL4 corp_vendor_subcode_maximum;
  DATASET(corp_vendor_subcode_ChildRec) nulls_corp_vendor_subcode {MAXCOUNT(100)};
  REAL4 corp_state_origin_specificity;
  REAL4 corp_state_origin_switch;
  REAL4 corp_state_origin_maximum;
  DATASET(corp_state_origin_ChildRec) nulls_corp_state_origin {MAXCOUNT(100)};
  REAL4 corp_process_date_year_specificity;
  REAL4 corp_process_date_year_switch;
  REAL4 corp_process_date_year_maximum;
  DATASET(corp_process_date_year_ChildRec) nulls_corp_process_date_year {MAXCOUNT(100)};
  REAL4 corp_process_date_month_specificity;
  REAL4 corp_process_date_month_switch;
  REAL4 corp_process_date_month_maximum;
  DATASET(corp_process_date_month_ChildRec) nulls_corp_process_date_month {MAXCOUNT(100)};
  REAL4 corp_process_date_day_specificity;
  REAL4 corp_process_date_day_switch;
  REAL4 corp_process_date_day_maximum;
  DATASET(corp_process_date_day_ChildRec) nulls_corp_process_date_day {MAXCOUNT(100)};
  REAL4 corp_orig_sos_charter_nbr_specificity;
  REAL4 corp_orig_sos_charter_nbr_switch;
  REAL4 corp_orig_sos_charter_nbr_maximum;
  DATASET(corp_orig_sos_charter_nbr_ChildRec) nulls_corp_orig_sos_charter_nbr {MAXCOUNT(100)};
  REAL4 corp_legal_name_specificity;
  REAL4 corp_legal_name_switch;
  REAL4 corp_legal_name_maximum;
  DATASET(corp_legal_name_ChildRec) nulls_corp_legal_name {MAXCOUNT(100)};
  REAL4 corp_ln_name_type_cd_specificity;
  REAL4 corp_ln_name_type_cd_switch;
  REAL4 corp_ln_name_type_cd_maximum;
  DATASET(corp_ln_name_type_cd_ChildRec) nulls_corp_ln_name_type_cd {MAXCOUNT(100)};
  REAL4 corp_ln_name_type_desc_specificity;
  REAL4 corp_ln_name_type_desc_switch;
  REAL4 corp_ln_name_type_desc_maximum;
  DATASET(corp_ln_name_type_desc_ChildRec) nulls_corp_ln_name_type_desc {MAXCOUNT(100)};
  REAL4 corp_supp_nbr_specificity;
  REAL4 corp_supp_nbr_switch;
  REAL4 corp_supp_nbr_maximum;
  DATASET(corp_supp_nbr_ChildRec) nulls_corp_supp_nbr {MAXCOUNT(100)};
  REAL4 corp_name_comment_specificity;
  REAL4 corp_name_comment_switch;
  REAL4 corp_name_comment_maximum;
  DATASET(corp_name_comment_ChildRec) nulls_corp_name_comment {MAXCOUNT(100)};
  REAL4 corp_address1_type_cd_specificity;
  REAL4 corp_address1_type_cd_switch;
  REAL4 corp_address1_type_cd_maximum;
  DATASET(corp_address1_type_cd_ChildRec) nulls_corp_address1_type_cd {MAXCOUNT(100)};
  REAL4 corp_address1_type_desc_specificity;
  REAL4 corp_address1_type_desc_switch;
  REAL4 corp_address1_type_desc_maximum;
  DATASET(corp_address1_type_desc_ChildRec) nulls_corp_address1_type_desc {MAXCOUNT(100)};
  REAL4 corp_address1_line1_specificity;
  REAL4 corp_address1_line1_switch;
  REAL4 corp_address1_line1_maximum;
  DATASET(corp_address1_line1_ChildRec) nulls_corp_address1_line1 {MAXCOUNT(100)};
  REAL4 corp_address1_line2_specificity;
  REAL4 corp_address1_line2_switch;
  REAL4 corp_address1_line2_maximum;
  DATASET(corp_address1_line2_ChildRec) nulls_corp_address1_line2 {MAXCOUNT(100)};
  REAL4 corp_address1_line3_specificity;
  REAL4 corp_address1_line3_switch;
  REAL4 corp_address1_line3_maximum;
  DATASET(corp_address1_line3_ChildRec) nulls_corp_address1_line3 {MAXCOUNT(100)};
  REAL4 corp_address1_effective_date_specificity;
  REAL4 corp_address1_effective_date_switch;
  REAL4 corp_address1_effective_date_maximum;
  DATASET(corp_address1_effective_date_ChildRec) nulls_corp_address1_effective_date {MAXCOUNT(100)};
  REAL4 corp_address2_type_cd_specificity;
  REAL4 corp_address2_type_cd_switch;
  REAL4 corp_address2_type_cd_maximum;
  DATASET(corp_address2_type_cd_ChildRec) nulls_corp_address2_type_cd {MAXCOUNT(100)};
  REAL4 corp_address2_type_desc_specificity;
  REAL4 corp_address2_type_desc_switch;
  REAL4 corp_address2_type_desc_maximum;
  DATASET(corp_address2_type_desc_ChildRec) nulls_corp_address2_type_desc {MAXCOUNT(100)};
  REAL4 corp_address2_line1_specificity;
  REAL4 corp_address2_line1_switch;
  REAL4 corp_address2_line1_maximum;
  DATASET(corp_address2_line1_ChildRec) nulls_corp_address2_line1 {MAXCOUNT(100)};
  REAL4 corp_address2_line2_specificity;
  REAL4 corp_address2_line2_switch;
  REAL4 corp_address2_line2_maximum;
  DATASET(corp_address2_line2_ChildRec) nulls_corp_address2_line2 {MAXCOUNT(100)};
  REAL4 corp_address2_line3_specificity;
  REAL4 corp_address2_line3_switch;
  REAL4 corp_address2_line3_maximum;
  DATASET(corp_address2_line3_ChildRec) nulls_corp_address2_line3 {MAXCOUNT(100)};
  REAL4 corp_address2_effective_date_specificity;
  REAL4 corp_address2_effective_date_switch;
  REAL4 corp_address2_effective_date_maximum;
  DATASET(corp_address2_effective_date_ChildRec) nulls_corp_address2_effective_date {MAXCOUNT(100)};
  REAL4 corp_phone_number_specificity;
  REAL4 corp_phone_number_switch;
  REAL4 corp_phone_number_maximum;
  DATASET(corp_phone_number_ChildRec) nulls_corp_phone_number {MAXCOUNT(100)};
  REAL4 corp_phone_number_type_cd_specificity;
  REAL4 corp_phone_number_type_cd_switch;
  REAL4 corp_phone_number_type_cd_maximum;
  DATASET(corp_phone_number_type_cd_ChildRec) nulls_corp_phone_number_type_cd {MAXCOUNT(100)};
  REAL4 corp_phone_number_type_desc_specificity;
  REAL4 corp_phone_number_type_desc_switch;
  REAL4 corp_phone_number_type_desc_maximum;
  DATASET(corp_phone_number_type_desc_ChildRec) nulls_corp_phone_number_type_desc {MAXCOUNT(100)};
  REAL4 corp_fax_nbr_specificity;
  REAL4 corp_fax_nbr_switch;
  REAL4 corp_fax_nbr_maximum;
  DATASET(corp_fax_nbr_ChildRec) nulls_corp_fax_nbr {MAXCOUNT(100)};
  REAL4 corp_email_address_specificity;
  REAL4 corp_email_address_switch;
  REAL4 corp_email_address_maximum;
  DATASET(corp_email_address_ChildRec) nulls_corp_email_address {MAXCOUNT(100)};
  REAL4 corp_web_address_specificity;
  REAL4 corp_web_address_switch;
  REAL4 corp_web_address_maximum;
  DATASET(corp_web_address_ChildRec) nulls_corp_web_address {MAXCOUNT(100)};
  REAL4 corp_filing_reference_nbr_specificity;
  REAL4 corp_filing_reference_nbr_switch;
  REAL4 corp_filing_reference_nbr_maximum;
  DATASET(corp_filing_reference_nbr_ChildRec) nulls_corp_filing_reference_nbr {MAXCOUNT(100)};
  REAL4 corp_filing_date_specificity;
  REAL4 corp_filing_date_switch;
  REAL4 corp_filing_date_maximum;
  DATASET(corp_filing_date_ChildRec) nulls_corp_filing_date {MAXCOUNT(100)};
  REAL4 corp_filing_cd_specificity;
  REAL4 corp_filing_cd_switch;
  REAL4 corp_filing_cd_maximum;
  DATASET(corp_filing_cd_ChildRec) nulls_corp_filing_cd {MAXCOUNT(100)};
  REAL4 corp_filing_desc_specificity;
  REAL4 corp_filing_desc_switch;
  REAL4 corp_filing_desc_maximum;
  DATASET(corp_filing_desc_ChildRec) nulls_corp_filing_desc {MAXCOUNT(100)};
  REAL4 corp_status_cd_specificity;
  REAL4 corp_status_cd_switch;
  REAL4 corp_status_cd_maximum;
  DATASET(corp_status_cd_ChildRec) nulls_corp_status_cd {MAXCOUNT(100)};
  REAL4 corp_status_desc_specificity;
  REAL4 corp_status_desc_switch;
  REAL4 corp_status_desc_maximum;
  DATASET(corp_status_desc_ChildRec) nulls_corp_status_desc {MAXCOUNT(100)};
  REAL4 corp_status_date_specificity;
  REAL4 corp_status_date_switch;
  REAL4 corp_status_date_maximum;
  DATASET(corp_status_date_ChildRec) nulls_corp_status_date {MAXCOUNT(100)};
  REAL4 corp_standing_specificity;
  REAL4 corp_standing_switch;
  REAL4 corp_standing_maximum;
  DATASET(corp_standing_ChildRec) nulls_corp_standing {MAXCOUNT(100)};
  REAL4 corp_status_comment_specificity;
  REAL4 corp_status_comment_switch;
  REAL4 corp_status_comment_maximum;
  DATASET(corp_status_comment_ChildRec) nulls_corp_status_comment {MAXCOUNT(100)};
  REAL4 corp_ticker_symbol_specificity;
  REAL4 corp_ticker_symbol_switch;
  REAL4 corp_ticker_symbol_maximum;
  DATASET(corp_ticker_symbol_ChildRec) nulls_corp_ticker_symbol {MAXCOUNT(100)};
  REAL4 corp_stock_exchange_specificity;
  REAL4 corp_stock_exchange_switch;
  REAL4 corp_stock_exchange_maximum;
  DATASET(corp_stock_exchange_ChildRec) nulls_corp_stock_exchange {MAXCOUNT(100)};
  REAL4 corp_inc_state_specificity;
  REAL4 corp_inc_state_switch;
  REAL4 corp_inc_state_maximum;
  DATASET(corp_inc_state_ChildRec) nulls_corp_inc_state {MAXCOUNT(100)};
  REAL4 corp_inc_county_specificity;
  REAL4 corp_inc_county_switch;
  REAL4 corp_inc_county_maximum;
  DATASET(corp_inc_county_ChildRec) nulls_corp_inc_county {MAXCOUNT(100)};
  REAL4 corp_inc_date_specificity;
  REAL4 corp_inc_date_switch;
  REAL4 corp_inc_date_maximum;
  DATASET(corp_inc_date_ChildRec) nulls_corp_inc_date {MAXCOUNT(100)};
  REAL4 corp_anniversary_month_specificity;
  REAL4 corp_anniversary_month_switch;
  REAL4 corp_anniversary_month_maximum;
  DATASET(corp_anniversary_month_ChildRec) nulls_corp_anniversary_month {MAXCOUNT(100)};
  REAL4 corp_fed_tax_id_specificity;
  REAL4 corp_fed_tax_id_switch;
  REAL4 corp_fed_tax_id_maximum;
  DATASET(corp_fed_tax_id_ChildRec) nulls_corp_fed_tax_id {MAXCOUNT(100)};
  REAL4 corp_state_tax_id_specificity;
  REAL4 corp_state_tax_id_switch;
  REAL4 corp_state_tax_id_maximum;
  DATASET(corp_state_tax_id_ChildRec) nulls_corp_state_tax_id {MAXCOUNT(100)};
  REAL4 corp_term_exist_cd_specificity;
  REAL4 corp_term_exist_cd_switch;
  REAL4 corp_term_exist_cd_maximum;
  DATASET(corp_term_exist_cd_ChildRec) nulls_corp_term_exist_cd {MAXCOUNT(100)};
  REAL4 corp_term_exist_exp_specificity;
  REAL4 corp_term_exist_exp_switch;
  REAL4 corp_term_exist_exp_maximum;
  DATASET(corp_term_exist_exp_ChildRec) nulls_corp_term_exist_exp {MAXCOUNT(100)};
  REAL4 corp_term_exist_desc_specificity;
  REAL4 corp_term_exist_desc_switch;
  REAL4 corp_term_exist_desc_maximum;
  DATASET(corp_term_exist_desc_ChildRec) nulls_corp_term_exist_desc {MAXCOUNT(100)};
  REAL4 corp_foreign_domestic_ind_specificity;
  REAL4 corp_foreign_domestic_ind_switch;
  REAL4 corp_foreign_domestic_ind_maximum;
  DATASET(corp_foreign_domestic_ind_ChildRec) nulls_corp_foreign_domestic_ind {MAXCOUNT(100)};
  REAL4 corp_forgn_state_cd_specificity;
  REAL4 corp_forgn_state_cd_switch;
  REAL4 corp_forgn_state_cd_maximum;
  DATASET(corp_forgn_state_cd_ChildRec) nulls_corp_forgn_state_cd {MAXCOUNT(100)};
  REAL4 corp_forgn_state_desc_specificity;
  REAL4 corp_forgn_state_desc_switch;
  REAL4 corp_forgn_state_desc_maximum;
  DATASET(corp_forgn_state_desc_ChildRec) nulls_corp_forgn_state_desc {MAXCOUNT(100)};
  REAL4 corp_forgn_sos_charter_nbr_specificity;
  REAL4 corp_forgn_sos_charter_nbr_switch;
  REAL4 corp_forgn_sos_charter_nbr_maximum;
  DATASET(corp_forgn_sos_charter_nbr_ChildRec) nulls_corp_forgn_sos_charter_nbr {MAXCOUNT(100)};
  REAL4 corp_forgn_date_specificity;
  REAL4 corp_forgn_date_switch;
  REAL4 corp_forgn_date_maximum;
  DATASET(corp_forgn_date_ChildRec) nulls_corp_forgn_date {MAXCOUNT(100)};
  REAL4 corp_forgn_fed_tax_id_specificity;
  REAL4 corp_forgn_fed_tax_id_switch;
  REAL4 corp_forgn_fed_tax_id_maximum;
  DATASET(corp_forgn_fed_tax_id_ChildRec) nulls_corp_forgn_fed_tax_id {MAXCOUNT(100)};
  REAL4 corp_forgn_state_tax_id_specificity;
  REAL4 corp_forgn_state_tax_id_switch;
  REAL4 corp_forgn_state_tax_id_maximum;
  DATASET(corp_forgn_state_tax_id_ChildRec) nulls_corp_forgn_state_tax_id {MAXCOUNT(100)};
  REAL4 corp_forgn_term_exist_cd_specificity;
  REAL4 corp_forgn_term_exist_cd_switch;
  REAL4 corp_forgn_term_exist_cd_maximum;
  DATASET(corp_forgn_term_exist_cd_ChildRec) nulls_corp_forgn_term_exist_cd {MAXCOUNT(100)};
  REAL4 corp_forgn_term_exist_exp_specificity;
  REAL4 corp_forgn_term_exist_exp_switch;
  REAL4 corp_forgn_term_exist_exp_maximum;
  DATASET(corp_forgn_term_exist_exp_ChildRec) nulls_corp_forgn_term_exist_exp {MAXCOUNT(100)};
  REAL4 corp_forgn_term_exist_desc_specificity;
  REAL4 corp_forgn_term_exist_desc_switch;
  REAL4 corp_forgn_term_exist_desc_maximum;
  DATASET(corp_forgn_term_exist_desc_ChildRec) nulls_corp_forgn_term_exist_desc {MAXCOUNT(100)};
  REAL4 corp_orig_org_structure_cd_specificity;
  REAL4 corp_orig_org_structure_cd_switch;
  REAL4 corp_orig_org_structure_cd_maximum;
  DATASET(corp_orig_org_structure_cd_ChildRec) nulls_corp_orig_org_structure_cd {MAXCOUNT(100)};
  REAL4 corp_orig_org_structure_desc_specificity;
  REAL4 corp_orig_org_structure_desc_switch;
  REAL4 corp_orig_org_structure_desc_maximum;
  DATASET(corp_orig_org_structure_desc_ChildRec) nulls_corp_orig_org_structure_desc {MAXCOUNT(100)};
  REAL4 corp_for_profit_ind_specificity;
  REAL4 corp_for_profit_ind_switch;
  REAL4 corp_for_profit_ind_maximum;
  DATASET(corp_for_profit_ind_ChildRec) nulls_corp_for_profit_ind {MAXCOUNT(100)};
  REAL4 corp_public_or_private_ind_specificity;
  REAL4 corp_public_or_private_ind_switch;
  REAL4 corp_public_or_private_ind_maximum;
  DATASET(corp_public_or_private_ind_ChildRec) nulls_corp_public_or_private_ind {MAXCOUNT(100)};
  REAL4 corp_sic_code_specificity;
  REAL4 corp_sic_code_switch;
  REAL4 corp_sic_code_maximum;
  DATASET(corp_sic_code_ChildRec) nulls_corp_sic_code {MAXCOUNT(100)};
  REAL4 corp_naic_code_specificity;
  REAL4 corp_naic_code_switch;
  REAL4 corp_naic_code_maximum;
  DATASET(corp_naic_code_ChildRec) nulls_corp_naic_code {MAXCOUNT(100)};
  REAL4 corp_orig_bus_type_cd_specificity;
  REAL4 corp_orig_bus_type_cd_switch;
  REAL4 corp_orig_bus_type_cd_maximum;
  DATASET(corp_orig_bus_type_cd_ChildRec) nulls_corp_orig_bus_type_cd {MAXCOUNT(100)};
  REAL4 corp_orig_bus_type_desc_specificity;
  REAL4 corp_orig_bus_type_desc_switch;
  REAL4 corp_orig_bus_type_desc_maximum;
  DATASET(corp_orig_bus_type_desc_ChildRec) nulls_corp_orig_bus_type_desc {MAXCOUNT(100)};
  REAL4 corp_entity_desc_specificity;
  REAL4 corp_entity_desc_switch;
  REAL4 corp_entity_desc_maximum;
  DATASET(corp_entity_desc_ChildRec) nulls_corp_entity_desc {MAXCOUNT(100)};
  REAL4 corp_certificate_nbr_specificity;
  REAL4 corp_certificate_nbr_switch;
  REAL4 corp_certificate_nbr_maximum;
  DATASET(corp_certificate_nbr_ChildRec) nulls_corp_certificate_nbr {MAXCOUNT(100)};
  REAL4 corp_internal_nbr_specificity;
  REAL4 corp_internal_nbr_switch;
  REAL4 corp_internal_nbr_maximum;
  DATASET(corp_internal_nbr_ChildRec) nulls_corp_internal_nbr {MAXCOUNT(100)};
  REAL4 corp_previous_nbr_specificity;
  REAL4 corp_previous_nbr_switch;
  REAL4 corp_previous_nbr_maximum;
  DATASET(corp_previous_nbr_ChildRec) nulls_corp_previous_nbr {MAXCOUNT(100)};
  REAL4 corp_microfilm_nbr_specificity;
  REAL4 corp_microfilm_nbr_switch;
  REAL4 corp_microfilm_nbr_maximum;
  DATASET(corp_microfilm_nbr_ChildRec) nulls_corp_microfilm_nbr {MAXCOUNT(100)};
  REAL4 corp_amendments_filed_specificity;
  REAL4 corp_amendments_filed_switch;
  REAL4 corp_amendments_filed_maximum;
  DATASET(corp_amendments_filed_ChildRec) nulls_corp_amendments_filed {MAXCOUNT(100)};
  REAL4 corp_acts_specificity;
  REAL4 corp_acts_switch;
  REAL4 corp_acts_maximum;
  DATASET(corp_acts_ChildRec) nulls_corp_acts {MAXCOUNT(100)};
  REAL4 corp_partnership_ind_specificity;
  REAL4 corp_partnership_ind_switch;
  REAL4 corp_partnership_ind_maximum;
  DATASET(corp_partnership_ind_ChildRec) nulls_corp_partnership_ind {MAXCOUNT(100)};
  REAL4 corp_mfg_ind_specificity;
  REAL4 corp_mfg_ind_switch;
  REAL4 corp_mfg_ind_maximum;
  DATASET(corp_mfg_ind_ChildRec) nulls_corp_mfg_ind {MAXCOUNT(100)};
  REAL4 corp_addl_info_specificity;
  REAL4 corp_addl_info_switch;
  REAL4 corp_addl_info_maximum;
  DATASET(corp_addl_info_ChildRec) nulls_corp_addl_info {MAXCOUNT(100)};
  REAL4 corp_taxes_specificity;
  REAL4 corp_taxes_switch;
  REAL4 corp_taxes_maximum;
  DATASET(corp_taxes_ChildRec) nulls_corp_taxes {MAXCOUNT(100)};
  REAL4 corp_franchise_taxes_specificity;
  REAL4 corp_franchise_taxes_switch;
  REAL4 corp_franchise_taxes_maximum;
  DATASET(corp_franchise_taxes_ChildRec) nulls_corp_franchise_taxes {MAXCOUNT(100)};
  REAL4 corp_tax_program_cd_specificity;
  REAL4 corp_tax_program_cd_switch;
  REAL4 corp_tax_program_cd_maximum;
  DATASET(corp_tax_program_cd_ChildRec) nulls_corp_tax_program_cd {MAXCOUNT(100)};
  REAL4 corp_tax_program_desc_specificity;
  REAL4 corp_tax_program_desc_switch;
  REAL4 corp_tax_program_desc_maximum;
  DATASET(corp_tax_program_desc_ChildRec) nulls_corp_tax_program_desc {MAXCOUNT(100)};
  REAL4 corp_ra_full_name_specificity;
  REAL4 corp_ra_full_name_switch;
  REAL4 corp_ra_full_name_maximum;
  DATASET(corp_ra_full_name_ChildRec) nulls_corp_ra_full_name {MAXCOUNT(100)};
  REAL4 corp_ra_fname_specificity;
  REAL4 corp_ra_fname_switch;
  REAL4 corp_ra_fname_maximum;
  DATASET(corp_ra_fname_ChildRec) nulls_corp_ra_fname {MAXCOUNT(100)};
  REAL4 corp_ra_mname_specificity;
  REAL4 corp_ra_mname_switch;
  REAL4 corp_ra_mname_maximum;
  DATASET(corp_ra_mname_ChildRec) nulls_corp_ra_mname {MAXCOUNT(100)};
  REAL4 corp_ra_lname_specificity;
  REAL4 corp_ra_lname_switch;
  REAL4 corp_ra_lname_maximum;
  DATASET(corp_ra_lname_ChildRec) nulls_corp_ra_lname {MAXCOUNT(100)};
  REAL4 corp_ra_suffix_specificity;
  REAL4 corp_ra_suffix_switch;
  REAL4 corp_ra_suffix_maximum;
  DATASET(corp_ra_suffix_ChildRec) nulls_corp_ra_suffix {MAXCOUNT(100)};
  REAL4 corp_ra_title_cd_specificity;
  REAL4 corp_ra_title_cd_switch;
  REAL4 corp_ra_title_cd_maximum;
  DATASET(corp_ra_title_cd_ChildRec) nulls_corp_ra_title_cd {MAXCOUNT(100)};
  REAL4 corp_ra_title_desc_specificity;
  REAL4 corp_ra_title_desc_switch;
  REAL4 corp_ra_title_desc_maximum;
  DATASET(corp_ra_title_desc_ChildRec) nulls_corp_ra_title_desc {MAXCOUNT(100)};
  REAL4 corp_ra_fein_specificity;
  REAL4 corp_ra_fein_switch;
  REAL4 corp_ra_fein_maximum;
  DATASET(corp_ra_fein_ChildRec) nulls_corp_ra_fein {MAXCOUNT(100)};
  REAL4 corp_ra_ssn_specificity;
  REAL4 corp_ra_ssn_switch;
  REAL4 corp_ra_ssn_maximum;
  DATASET(corp_ra_ssn_ChildRec) nulls_corp_ra_ssn {MAXCOUNT(100)};
  REAL4 corp_ra_dob_specificity;
  REAL4 corp_ra_dob_switch;
  REAL4 corp_ra_dob_maximum;
  DATASET(corp_ra_dob_ChildRec) nulls_corp_ra_dob {MAXCOUNT(100)};
  REAL4 corp_ra_effective_date_specificity;
  REAL4 corp_ra_effective_date_switch;
  REAL4 corp_ra_effective_date_maximum;
  DATASET(corp_ra_effective_date_ChildRec) nulls_corp_ra_effective_date {MAXCOUNT(100)};
  REAL4 corp_ra_resign_date_specificity;
  REAL4 corp_ra_resign_date_switch;
  REAL4 corp_ra_resign_date_maximum;
  DATASET(corp_ra_resign_date_ChildRec) nulls_corp_ra_resign_date {MAXCOUNT(100)};
  REAL4 corp_ra_no_comp_specificity;
  REAL4 corp_ra_no_comp_switch;
  REAL4 corp_ra_no_comp_maximum;
  DATASET(corp_ra_no_comp_ChildRec) nulls_corp_ra_no_comp {MAXCOUNT(100)};
  REAL4 corp_ra_no_comp_igs_specificity;
  REAL4 corp_ra_no_comp_igs_switch;
  REAL4 corp_ra_no_comp_igs_maximum;
  DATASET(corp_ra_no_comp_igs_ChildRec) nulls_corp_ra_no_comp_igs {MAXCOUNT(100)};
  REAL4 corp_ra_addl_info_specificity;
  REAL4 corp_ra_addl_info_switch;
  REAL4 corp_ra_addl_info_maximum;
  DATASET(corp_ra_addl_info_ChildRec) nulls_corp_ra_addl_info {MAXCOUNT(100)};
  REAL4 corp_ra_address_type_cd_specificity;
  REAL4 corp_ra_address_type_cd_switch;
  REAL4 corp_ra_address_type_cd_maximum;
  DATASET(corp_ra_address_type_cd_ChildRec) nulls_corp_ra_address_type_cd {MAXCOUNT(100)};
  REAL4 corp_ra_address_type_desc_specificity;
  REAL4 corp_ra_address_type_desc_switch;
  REAL4 corp_ra_address_type_desc_maximum;
  DATASET(corp_ra_address_type_desc_ChildRec) nulls_corp_ra_address_type_desc {MAXCOUNT(100)};
  REAL4 corp_ra_address_line1_specificity;
  REAL4 corp_ra_address_line1_switch;
  REAL4 corp_ra_address_line1_maximum;
  DATASET(corp_ra_address_line1_ChildRec) nulls_corp_ra_address_line1 {MAXCOUNT(100)};
  REAL4 corp_ra_address_line2_specificity;
  REAL4 corp_ra_address_line2_switch;
  REAL4 corp_ra_address_line2_maximum;
  DATASET(corp_ra_address_line2_ChildRec) nulls_corp_ra_address_line2 {MAXCOUNT(100)};
  REAL4 corp_ra_address_line3_specificity;
  REAL4 corp_ra_address_line3_switch;
  REAL4 corp_ra_address_line3_maximum;
  DATASET(corp_ra_address_line3_ChildRec) nulls_corp_ra_address_line3 {MAXCOUNT(100)};
  REAL4 corp_ra_phone_number_specificity;
  REAL4 corp_ra_phone_number_switch;
  REAL4 corp_ra_phone_number_maximum;
  DATASET(corp_ra_phone_number_ChildRec) nulls_corp_ra_phone_number {MAXCOUNT(100)};
  REAL4 corp_ra_phone_number_type_cd_specificity;
  REAL4 corp_ra_phone_number_type_cd_switch;
  REAL4 corp_ra_phone_number_type_cd_maximum;
  DATASET(corp_ra_phone_number_type_cd_ChildRec) nulls_corp_ra_phone_number_type_cd {MAXCOUNT(100)};
  REAL4 corp_ra_phone_number_type_desc_specificity;
  REAL4 corp_ra_phone_number_type_desc_switch;
  REAL4 corp_ra_phone_number_type_desc_maximum;
  DATASET(corp_ra_phone_number_type_desc_ChildRec) nulls_corp_ra_phone_number_type_desc {MAXCOUNT(100)};
  REAL4 corp_ra_fax_nbr_specificity;
  REAL4 corp_ra_fax_nbr_switch;
  REAL4 corp_ra_fax_nbr_maximum;
  DATASET(corp_ra_fax_nbr_ChildRec) nulls_corp_ra_fax_nbr {MAXCOUNT(100)};
  REAL4 corp_ra_email_address_specificity;
  REAL4 corp_ra_email_address_switch;
  REAL4 corp_ra_email_address_maximum;
  DATASET(corp_ra_email_address_ChildRec) nulls_corp_ra_email_address {MAXCOUNT(100)};
  REAL4 corp_ra_web_address_specificity;
  REAL4 corp_ra_web_address_switch;
  REAL4 corp_ra_web_address_maximum;
  DATASET(corp_ra_web_address_ChildRec) nulls_corp_ra_web_address {MAXCOUNT(100)};
  REAL4 corp_prep_addr1_line1_specificity;
  REAL4 corp_prep_addr1_line1_switch;
  REAL4 corp_prep_addr1_line1_maximum;
  DATASET(corp_prep_addr1_line1_ChildRec) nulls_corp_prep_addr1_line1 {MAXCOUNT(100)};
  REAL4 corp_prep_addr1_last_line_specificity;
  REAL4 corp_prep_addr1_last_line_switch;
  REAL4 corp_prep_addr1_last_line_maximum;
  DATASET(corp_prep_addr1_last_line_ChildRec) nulls_corp_prep_addr1_last_line {MAXCOUNT(100)};
  REAL4 corp_prep_addr2_line1_specificity;
  REAL4 corp_prep_addr2_line1_switch;
  REAL4 corp_prep_addr2_line1_maximum;
  DATASET(corp_prep_addr2_line1_ChildRec) nulls_corp_prep_addr2_line1 {MAXCOUNT(100)};
  REAL4 corp_prep_addr2_last_line_specificity;
  REAL4 corp_prep_addr2_last_line_switch;
  REAL4 corp_prep_addr2_last_line_maximum;
  DATASET(corp_prep_addr2_last_line_ChildRec) nulls_corp_prep_addr2_last_line {MAXCOUNT(100)};
  REAL4 ra_prep_addr_line1_specificity;
  REAL4 ra_prep_addr_line1_switch;
  REAL4 ra_prep_addr_line1_maximum;
  DATASET(ra_prep_addr_line1_ChildRec) nulls_ra_prep_addr_line1 {MAXCOUNT(100)};
  REAL4 ra_prep_addr_last_line_specificity;
  REAL4 ra_prep_addr_last_line_switch;
  REAL4 ra_prep_addr_last_line_maximum;
  DATASET(ra_prep_addr_last_line_ChildRec) nulls_ra_prep_addr_last_line {MAXCOUNT(100)};
  REAL4 cont_filing_reference_nbr_specificity;
  REAL4 cont_filing_reference_nbr_switch;
  REAL4 cont_filing_reference_nbr_maximum;
  DATASET(cont_filing_reference_nbr_ChildRec) nulls_cont_filing_reference_nbr {MAXCOUNT(100)};
  REAL4 cont_filing_date_specificity;
  REAL4 cont_filing_date_switch;
  REAL4 cont_filing_date_maximum;
  DATASET(cont_filing_date_ChildRec) nulls_cont_filing_date {MAXCOUNT(100)};
  REAL4 cont_filing_cd_specificity;
  REAL4 cont_filing_cd_switch;
  REAL4 cont_filing_cd_maximum;
  DATASET(cont_filing_cd_ChildRec) nulls_cont_filing_cd {MAXCOUNT(100)};
  REAL4 cont_filing_desc_specificity;
  REAL4 cont_filing_desc_switch;
  REAL4 cont_filing_desc_maximum;
  DATASET(cont_filing_desc_ChildRec) nulls_cont_filing_desc {MAXCOUNT(100)};
  REAL4 cont_type_cd_specificity;
  REAL4 cont_type_cd_switch;
  REAL4 cont_type_cd_maximum;
  DATASET(cont_type_cd_ChildRec) nulls_cont_type_cd {MAXCOUNT(100)};
  REAL4 cont_type_desc_specificity;
  REAL4 cont_type_desc_switch;
  REAL4 cont_type_desc_maximum;
  DATASET(cont_type_desc_ChildRec) nulls_cont_type_desc {MAXCOUNT(100)};
  REAL4 cont_full_name_specificity;
  REAL4 cont_full_name_switch;
  REAL4 cont_full_name_maximum;
  DATASET(cont_full_name_ChildRec) nulls_cont_full_name {MAXCOUNT(100)};
  REAL4 cont_fname_specificity;
  REAL4 cont_fname_switch;
  REAL4 cont_fname_maximum;
  DATASET(cont_fname_ChildRec) nulls_cont_fname {MAXCOUNT(100)};
  REAL4 cont_mname_specificity;
  REAL4 cont_mname_switch;
  REAL4 cont_mname_maximum;
  DATASET(cont_mname_ChildRec) nulls_cont_mname {MAXCOUNT(100)};
  REAL4 cont_lname_specificity;
  REAL4 cont_lname_switch;
  REAL4 cont_lname_maximum;
  DATASET(cont_lname_ChildRec) nulls_cont_lname {MAXCOUNT(100)};
  REAL4 cont_suffix_specificity;
  REAL4 cont_suffix_switch;
  REAL4 cont_suffix_maximum;
  DATASET(cont_suffix_ChildRec) nulls_cont_suffix {MAXCOUNT(100)};
  REAL4 cont_title1_desc_specificity;
  REAL4 cont_title1_desc_switch;
  REAL4 cont_title1_desc_maximum;
  DATASET(cont_title1_desc_ChildRec) nulls_cont_title1_desc {MAXCOUNT(100)};
  REAL4 cont_title2_desc_specificity;
  REAL4 cont_title2_desc_switch;
  REAL4 cont_title2_desc_maximum;
  DATASET(cont_title2_desc_ChildRec) nulls_cont_title2_desc {MAXCOUNT(100)};
  REAL4 cont_title3_desc_specificity;
  REAL4 cont_title3_desc_switch;
  REAL4 cont_title3_desc_maximum;
  DATASET(cont_title3_desc_ChildRec) nulls_cont_title3_desc {MAXCOUNT(100)};
  REAL4 cont_title4_desc_specificity;
  REAL4 cont_title4_desc_switch;
  REAL4 cont_title4_desc_maximum;
  DATASET(cont_title4_desc_ChildRec) nulls_cont_title4_desc {MAXCOUNT(100)};
  REAL4 cont_title5_desc_specificity;
  REAL4 cont_title5_desc_switch;
  REAL4 cont_title5_desc_maximum;
  DATASET(cont_title5_desc_ChildRec) nulls_cont_title5_desc {MAXCOUNT(100)};
  REAL4 cont_fein_specificity;
  REAL4 cont_fein_switch;
  REAL4 cont_fein_maximum;
  DATASET(cont_fein_ChildRec) nulls_cont_fein {MAXCOUNT(100)};
  REAL4 cont_ssn_specificity;
  REAL4 cont_ssn_switch;
  REAL4 cont_ssn_maximum;
  DATASET(cont_ssn_ChildRec) nulls_cont_ssn {MAXCOUNT(100)};
  REAL4 cont_dob_specificity;
  REAL4 cont_dob_switch;
  REAL4 cont_dob_maximum;
  DATASET(cont_dob_ChildRec) nulls_cont_dob {MAXCOUNT(100)};
  REAL4 cont_status_cd_specificity;
  REAL4 cont_status_cd_switch;
  REAL4 cont_status_cd_maximum;
  DATASET(cont_status_cd_ChildRec) nulls_cont_status_cd {MAXCOUNT(100)};
  REAL4 cont_status_desc_specificity;
  REAL4 cont_status_desc_switch;
  REAL4 cont_status_desc_maximum;
  DATASET(cont_status_desc_ChildRec) nulls_cont_status_desc {MAXCOUNT(100)};
  REAL4 cont_effective_date_specificity;
  REAL4 cont_effective_date_switch;
  REAL4 cont_effective_date_maximum;
  DATASET(cont_effective_date_ChildRec) nulls_cont_effective_date {MAXCOUNT(100)};
  REAL4 cont_effective_cd_specificity;
  REAL4 cont_effective_cd_switch;
  REAL4 cont_effective_cd_maximum;
  DATASET(cont_effective_cd_ChildRec) nulls_cont_effective_cd {MAXCOUNT(100)};
  REAL4 cont_effective_desc_specificity;
  REAL4 cont_effective_desc_switch;
  REAL4 cont_effective_desc_maximum;
  DATASET(cont_effective_desc_ChildRec) nulls_cont_effective_desc {MAXCOUNT(100)};
  REAL4 cont_addl_info_specificity;
  REAL4 cont_addl_info_switch;
  REAL4 cont_addl_info_maximum;
  DATASET(cont_addl_info_ChildRec) nulls_cont_addl_info {MAXCOUNT(100)};
  REAL4 cont_address_type_cd_specificity;
  REAL4 cont_address_type_cd_switch;
  REAL4 cont_address_type_cd_maximum;
  DATASET(cont_address_type_cd_ChildRec) nulls_cont_address_type_cd {MAXCOUNT(100)};
  REAL4 cont_address_type_desc_specificity;
  REAL4 cont_address_type_desc_switch;
  REAL4 cont_address_type_desc_maximum;
  DATASET(cont_address_type_desc_ChildRec) nulls_cont_address_type_desc {MAXCOUNT(100)};
  REAL4 cont_address_line1_specificity;
  REAL4 cont_address_line1_switch;
  REAL4 cont_address_line1_maximum;
  DATASET(cont_address_line1_ChildRec) nulls_cont_address_line1 {MAXCOUNT(100)};
  REAL4 cont_address_line2_specificity;
  REAL4 cont_address_line2_switch;
  REAL4 cont_address_line2_maximum;
  DATASET(cont_address_line2_ChildRec) nulls_cont_address_line2 {MAXCOUNT(100)};
  REAL4 cont_address_line3_specificity;
  REAL4 cont_address_line3_switch;
  REAL4 cont_address_line3_maximum;
  DATASET(cont_address_line3_ChildRec) nulls_cont_address_line3 {MAXCOUNT(100)};
  REAL4 cont_address_effective_date_specificity;
  REAL4 cont_address_effective_date_switch;
  REAL4 cont_address_effective_date_maximum;
  DATASET(cont_address_effective_date_ChildRec) nulls_cont_address_effective_date {MAXCOUNT(100)};
  REAL4 cont_address_county_specificity;
  REAL4 cont_address_county_switch;
  REAL4 cont_address_county_maximum;
  DATASET(cont_address_county_ChildRec) nulls_cont_address_county {MAXCOUNT(100)};
  REAL4 cont_phone_number_specificity;
  REAL4 cont_phone_number_switch;
  REAL4 cont_phone_number_maximum;
  DATASET(cont_phone_number_ChildRec) nulls_cont_phone_number {MAXCOUNT(100)};
  REAL4 cont_phone_number_type_cd_specificity;
  REAL4 cont_phone_number_type_cd_switch;
  REAL4 cont_phone_number_type_cd_maximum;
  DATASET(cont_phone_number_type_cd_ChildRec) nulls_cont_phone_number_type_cd {MAXCOUNT(100)};
  REAL4 cont_phone_number_type_desc_specificity;
  REAL4 cont_phone_number_type_desc_switch;
  REAL4 cont_phone_number_type_desc_maximum;
  DATASET(cont_phone_number_type_desc_ChildRec) nulls_cont_phone_number_type_desc {MAXCOUNT(100)};
  REAL4 cont_fax_nbr_specificity;
  REAL4 cont_fax_nbr_switch;
  REAL4 cont_fax_nbr_maximum;
  DATASET(cont_fax_nbr_ChildRec) nulls_cont_fax_nbr {MAXCOUNT(100)};
  REAL4 cont_email_address_specificity;
  REAL4 cont_email_address_switch;
  REAL4 cont_email_address_maximum;
  DATASET(cont_email_address_ChildRec) nulls_cont_email_address {MAXCOUNT(100)};
  REAL4 cont_web_address_specificity;
  REAL4 cont_web_address_switch;
  REAL4 cont_web_address_maximum;
  DATASET(cont_web_address_ChildRec) nulls_cont_web_address {MAXCOUNT(100)};
  REAL4 corp_acres_specificity;
  REAL4 corp_acres_switch;
  REAL4 corp_acres_maximum;
  DATASET(corp_acres_ChildRec) nulls_corp_acres {MAXCOUNT(100)};
  REAL4 corp_action_specificity;
  REAL4 corp_action_switch;
  REAL4 corp_action_maximum;
  DATASET(corp_action_ChildRec) nulls_corp_action {MAXCOUNT(100)};
  REAL4 corp_action_date_specificity;
  REAL4 corp_action_date_switch;
  REAL4 corp_action_date_maximum;
  DATASET(corp_action_date_ChildRec) nulls_corp_action_date {MAXCOUNT(100)};
  REAL4 corp_action_employment_security_approval_date_specificity;
  REAL4 corp_action_employment_security_approval_date_switch;
  REAL4 corp_action_employment_security_approval_date_maximum;
  DATASET(corp_action_employment_security_approval_date_ChildRec) nulls_corp_action_employment_security_approval_date {MAXCOUNT(100)};
  REAL4 corp_action_pending_cd_specificity;
  REAL4 corp_action_pending_cd_switch;
  REAL4 corp_action_pending_cd_maximum;
  DATASET(corp_action_pending_cd_ChildRec) nulls_corp_action_pending_cd {MAXCOUNT(100)};
  REAL4 corp_action_pending_desc_specificity;
  REAL4 corp_action_pending_desc_switch;
  REAL4 corp_action_pending_desc_maximum;
  DATASET(corp_action_pending_desc_ChildRec) nulls_corp_action_pending_desc {MAXCOUNT(100)};
  REAL4 corp_action_statement_of_intent_date_specificity;
  REAL4 corp_action_statement_of_intent_date_switch;
  REAL4 corp_action_statement_of_intent_date_maximum;
  DATASET(corp_action_statement_of_intent_date_ChildRec) nulls_corp_action_statement_of_intent_date {MAXCOUNT(100)};
  REAL4 corp_action_tax_dept_approval_date_specificity;
  REAL4 corp_action_tax_dept_approval_date_switch;
  REAL4 corp_action_tax_dept_approval_date_maximum;
  DATASET(corp_action_tax_dept_approval_date_ChildRec) nulls_corp_action_tax_dept_approval_date {MAXCOUNT(100)};
  REAL4 corp_acts2_specificity;
  REAL4 corp_acts2_switch;
  REAL4 corp_acts2_maximum;
  DATASET(corp_acts2_ChildRec) nulls_corp_acts2 {MAXCOUNT(100)};
  REAL4 corp_acts3_specificity;
  REAL4 corp_acts3_switch;
  REAL4 corp_acts3_maximum;
  DATASET(corp_acts3_ChildRec) nulls_corp_acts3 {MAXCOUNT(100)};
  REAL4 corp_additional_principals_specificity;
  REAL4 corp_additional_principals_switch;
  REAL4 corp_additional_principals_maximum;
  DATASET(corp_additional_principals_ChildRec) nulls_corp_additional_principals {MAXCOUNT(100)};
  REAL4 corp_address_office_type_specificity;
  REAL4 corp_address_office_type_switch;
  REAL4 corp_address_office_type_maximum;
  DATASET(corp_address_office_type_ChildRec) nulls_corp_address_office_type {MAXCOUNT(100)};
  REAL4 corp_agent_assign_date_specificity;
  REAL4 corp_agent_assign_date_switch;
  REAL4 corp_agent_assign_date_maximum;
  DATASET(corp_agent_assign_date_ChildRec) nulls_corp_agent_assign_date {MAXCOUNT(100)};
  REAL4 corp_agent_commercial_specificity;
  REAL4 corp_agent_commercial_switch;
  REAL4 corp_agent_commercial_maximum;
  DATASET(corp_agent_commercial_ChildRec) nulls_corp_agent_commercial {MAXCOUNT(100)};
  REAL4 corp_agent_country_specificity;
  REAL4 corp_agent_country_switch;
  REAL4 corp_agent_country_maximum;
  DATASET(corp_agent_country_ChildRec) nulls_corp_agent_country {MAXCOUNT(100)};
  REAL4 corp_agent_county_specificity;
  REAL4 corp_agent_county_switch;
  REAL4 corp_agent_county_maximum;
  DATASET(corp_agent_county_ChildRec) nulls_corp_agent_county {MAXCOUNT(100)};
  REAL4 corp_agent_status_cd_specificity;
  REAL4 corp_agent_status_cd_switch;
  REAL4 corp_agent_status_cd_maximum;
  DATASET(corp_agent_status_cd_ChildRec) nulls_corp_agent_status_cd {MAXCOUNT(100)};
  REAL4 corp_agent_status_desc_specificity;
  REAL4 corp_agent_status_desc_switch;
  REAL4 corp_agent_status_desc_maximum;
  DATASET(corp_agent_status_desc_ChildRec) nulls_corp_agent_status_desc {MAXCOUNT(100)};
  REAL4 corp_agent_id_specificity;
  REAL4 corp_agent_id_switch;
  REAL4 corp_agent_id_maximum;
  DATASET(corp_agent_id_ChildRec) nulls_corp_agent_id {MAXCOUNT(100)};
  REAL4 corp_agriculture_flag_specificity;
  REAL4 corp_agriculture_flag_switch;
  REAL4 corp_agriculture_flag_maximum;
  DATASET(corp_agriculture_flag_ChildRec) nulls_corp_agriculture_flag {MAXCOUNT(100)};
  REAL4 corp_authorized_partners_specificity;
  REAL4 corp_authorized_partners_switch;
  REAL4 corp_authorized_partners_maximum;
  DATASET(corp_authorized_partners_ChildRec) nulls_corp_authorized_partners {MAXCOUNT(100)};
  REAL4 corp_comment_specificity;
  REAL4 corp_comment_switch;
  REAL4 corp_comment_maximum;
  DATASET(corp_comment_ChildRec) nulls_corp_comment {MAXCOUNT(100)};
  REAL4 corp_consent_flag_for_protected_name_specificity;
  REAL4 corp_consent_flag_for_protected_name_switch;
  REAL4 corp_consent_flag_for_protected_name_maximum;
  DATASET(corp_consent_flag_for_protected_name_ChildRec) nulls_corp_consent_flag_for_protected_name {MAXCOUNT(100)};
  REAL4 corp_converted_specificity;
  REAL4 corp_converted_switch;
  REAL4 corp_converted_maximum;
  DATASET(corp_converted_ChildRec) nulls_corp_converted {MAXCOUNT(100)};
  REAL4 corp_converted_from_specificity;
  REAL4 corp_converted_from_switch;
  REAL4 corp_converted_from_maximum;
  DATASET(corp_converted_from_ChildRec) nulls_corp_converted_from {MAXCOUNT(100)};
  REAL4 corp_country_of_formation_specificity;
  REAL4 corp_country_of_formation_switch;
  REAL4 corp_country_of_formation_maximum;
  DATASET(corp_country_of_formation_ChildRec) nulls_corp_country_of_formation {MAXCOUNT(100)};
  REAL4 corp_date_of_organization_meeting_specificity;
  REAL4 corp_date_of_organization_meeting_switch;
  REAL4 corp_date_of_organization_meeting_maximum;
  DATASET(corp_date_of_organization_meeting_ChildRec) nulls_corp_date_of_organization_meeting {MAXCOUNT(100)};
  REAL4 corp_delayed_effective_date_specificity;
  REAL4 corp_delayed_effective_date_switch;
  REAL4 corp_delayed_effective_date_maximum;
  DATASET(corp_delayed_effective_date_ChildRec) nulls_corp_delayed_effective_date {MAXCOUNT(100)};
  REAL4 corp_directors_from_to_specificity;
  REAL4 corp_directors_from_to_switch;
  REAL4 corp_directors_from_to_maximum;
  DATASET(corp_directors_from_to_ChildRec) nulls_corp_directors_from_to {MAXCOUNT(100)};
  REAL4 corp_dissolved_date_specificity;
  REAL4 corp_dissolved_date_switch;
  REAL4 corp_dissolved_date_maximum;
  DATASET(corp_dissolved_date_ChildRec) nulls_corp_dissolved_date {MAXCOUNT(100)};
  REAL4 corp_farm_exemptions_specificity;
  REAL4 corp_farm_exemptions_switch;
  REAL4 corp_farm_exemptions_maximum;
  DATASET(corp_farm_exemptions_ChildRec) nulls_corp_farm_exemptions {MAXCOUNT(100)};
  REAL4 corp_farm_qual_date_specificity;
  REAL4 corp_farm_qual_date_switch;
  REAL4 corp_farm_qual_date_maximum;
  DATASET(corp_farm_qual_date_ChildRec) nulls_corp_farm_qual_date {MAXCOUNT(100)};
  REAL4 corp_farm_status_cd_specificity;
  REAL4 corp_farm_status_cd_switch;
  REAL4 corp_farm_status_cd_maximum;
  DATASET(corp_farm_status_cd_ChildRec) nulls_corp_farm_status_cd {MAXCOUNT(100)};
  REAL4 corp_farm_status_desc_specificity;
  REAL4 corp_farm_status_desc_switch;
  REAL4 corp_farm_status_desc_maximum;
  DATASET(corp_farm_status_desc_ChildRec) nulls_corp_farm_status_desc {MAXCOUNT(100)};
  REAL4 corp_fiscal_year_month_specificity;
  REAL4 corp_fiscal_year_month_switch;
  REAL4 corp_fiscal_year_month_maximum;
  DATASET(corp_fiscal_year_month_ChildRec) nulls_corp_fiscal_year_month {MAXCOUNT(100)};
  REAL4 corp_foreign_fiduciary_capacity_in_state_specificity;
  REAL4 corp_foreign_fiduciary_capacity_in_state_switch;
  REAL4 corp_foreign_fiduciary_capacity_in_state_maximum;
  DATASET(corp_foreign_fiduciary_capacity_in_state_ChildRec) nulls_corp_foreign_fiduciary_capacity_in_state {MAXCOUNT(100)};
  REAL4 corp_governing_statute_specificity;
  REAL4 corp_governing_statute_switch;
  REAL4 corp_governing_statute_maximum;
  DATASET(corp_governing_statute_ChildRec) nulls_corp_governing_statute {MAXCOUNT(100)};
  REAL4 corp_has_members_specificity;
  REAL4 corp_has_members_switch;
  REAL4 corp_has_members_maximum;
  DATASET(corp_has_members_ChildRec) nulls_corp_has_members {MAXCOUNT(100)};
  REAL4 corp_has_vested_managers_specificity;
  REAL4 corp_has_vested_managers_switch;
  REAL4 corp_has_vested_managers_maximum;
  DATASET(corp_has_vested_managers_ChildRec) nulls_corp_has_vested_managers {MAXCOUNT(100)};
  REAL4 corp_home_incorporated_county_specificity;
  REAL4 corp_home_incorporated_county_switch;
  REAL4 corp_home_incorporated_county_maximum;
  DATASET(corp_home_incorporated_county_ChildRec) nulls_corp_home_incorporated_county {MAXCOUNT(100)};
  REAL4 corp_home_state_name_specificity;
  REAL4 corp_home_state_name_switch;
  REAL4 corp_home_state_name_maximum;
  DATASET(corp_home_state_name_ChildRec) nulls_corp_home_state_name {MAXCOUNT(100)};
  REAL4 corp_is_professional_specificity;
  REAL4 corp_is_professional_switch;
  REAL4 corp_is_professional_maximum;
  DATASET(corp_is_professional_ChildRec) nulls_corp_is_professional {MAXCOUNT(100)};
  REAL4 corp_is_non_profit_irs_approved_specificity;
  REAL4 corp_is_non_profit_irs_approved_switch;
  REAL4 corp_is_non_profit_irs_approved_maximum;
  DATASET(corp_is_non_profit_irs_approved_ChildRec) nulls_corp_is_non_profit_irs_approved {MAXCOUNT(100)};
  REAL4 corp_last_renewal_date_specificity;
  REAL4 corp_last_renewal_date_switch;
  REAL4 corp_last_renewal_date_maximum;
  DATASET(corp_last_renewal_date_ChildRec) nulls_corp_last_renewal_date {MAXCOUNT(100)};
  REAL4 corp_last_renewal_year_specificity;
  REAL4 corp_last_renewal_year_switch;
  REAL4 corp_last_renewal_year_maximum;
  DATASET(corp_last_renewal_year_ChildRec) nulls_corp_last_renewal_year {MAXCOUNT(100)};
  REAL4 corp_license_type_specificity;
  REAL4 corp_license_type_switch;
  REAL4 corp_license_type_maximum;
  DATASET(corp_license_type_ChildRec) nulls_corp_license_type {MAXCOUNT(100)};
  REAL4 corp_llc_managed_desc_specificity;
  REAL4 corp_llc_managed_desc_switch;
  REAL4 corp_llc_managed_desc_maximum;
  DATASET(corp_llc_managed_desc_ChildRec) nulls_corp_llc_managed_desc {MAXCOUNT(100)};
  REAL4 corp_llc_managed_ind_specificity;
  REAL4 corp_llc_managed_ind_switch;
  REAL4 corp_llc_managed_ind_maximum;
  DATASET(corp_llc_managed_ind_ChildRec) nulls_corp_llc_managed_ind {MAXCOUNT(100)};
  REAL4 corp_management_desc_specificity;
  REAL4 corp_management_desc_switch;
  REAL4 corp_management_desc_maximum;
  DATASET(corp_management_desc_ChildRec) nulls_corp_management_desc {MAXCOUNT(100)};
  REAL4 corp_management_type_specificity;
  REAL4 corp_management_type_switch;
  REAL4 corp_management_type_maximum;
  DATASET(corp_management_type_ChildRec) nulls_corp_management_type {MAXCOUNT(100)};
  REAL4 corp_manager_managed_specificity;
  REAL4 corp_manager_managed_switch;
  REAL4 corp_manager_managed_maximum;
  DATASET(corp_manager_managed_ChildRec) nulls_corp_manager_managed {MAXCOUNT(100)};
  REAL4 corp_merged_corporation_id_specificity;
  REAL4 corp_merged_corporation_id_switch;
  REAL4 corp_merged_corporation_id_maximum;
  DATASET(corp_merged_corporation_id_ChildRec) nulls_corp_merged_corporation_id {MAXCOUNT(100)};
  REAL4 corp_merged_fein_specificity;
  REAL4 corp_merged_fein_switch;
  REAL4 corp_merged_fein_maximum;
  DATASET(corp_merged_fein_ChildRec) nulls_corp_merged_fein {MAXCOUNT(100)};
  REAL4 corp_merger_allowed_flag_specificity;
  REAL4 corp_merger_allowed_flag_switch;
  REAL4 corp_merger_allowed_flag_maximum;
  DATASET(corp_merger_allowed_flag_ChildRec) nulls_corp_merger_allowed_flag {MAXCOUNT(100)};
  REAL4 corp_merger_date_specificity;
  REAL4 corp_merger_date_switch;
  REAL4 corp_merger_date_maximum;
  DATASET(corp_merger_date_ChildRec) nulls_corp_merger_date {MAXCOUNT(100)};
  REAL4 corp_merger_desc_specificity;
  REAL4 corp_merger_desc_switch;
  REAL4 corp_merger_desc_maximum;
  DATASET(corp_merger_desc_ChildRec) nulls_corp_merger_desc {MAXCOUNT(100)};
  REAL4 corp_merger_effective_date_specificity;
  REAL4 corp_merger_effective_date_switch;
  REAL4 corp_merger_effective_date_maximum;
  DATASET(corp_merger_effective_date_ChildRec) nulls_corp_merger_effective_date {MAXCOUNT(100)};
  REAL4 corp_merger_id_specificity;
  REAL4 corp_merger_id_switch;
  REAL4 corp_merger_id_maximum;
  DATASET(corp_merger_id_ChildRec) nulls_corp_merger_id {MAXCOUNT(100)};
  REAL4 corp_merger_indicator_specificity;
  REAL4 corp_merger_indicator_switch;
  REAL4 corp_merger_indicator_maximum;
  DATASET(corp_merger_indicator_ChildRec) nulls_corp_merger_indicator {MAXCOUNT(100)};
  REAL4 corp_merger_name_specificity;
  REAL4 corp_merger_name_switch;
  REAL4 corp_merger_name_maximum;
  DATASET(corp_merger_name_ChildRec) nulls_corp_merger_name {MAXCOUNT(100)};
  REAL4 corp_merger_type_converted_to_cd_specificity;
  REAL4 corp_merger_type_converted_to_cd_switch;
  REAL4 corp_merger_type_converted_to_cd_maximum;
  DATASET(corp_merger_type_converted_to_cd_ChildRec) nulls_corp_merger_type_converted_to_cd {MAXCOUNT(100)};
  REAL4 corp_merger_type_converted_to_desc_specificity;
  REAL4 corp_merger_type_converted_to_desc_switch;
  REAL4 corp_merger_type_converted_to_desc_maximum;
  DATASET(corp_merger_type_converted_to_desc_ChildRec) nulls_corp_merger_type_converted_to_desc {MAXCOUNT(100)};
  REAL4 corp_naics_desc_specificity;
  REAL4 corp_naics_desc_switch;
  REAL4 corp_naics_desc_maximum;
  DATASET(corp_naics_desc_ChildRec) nulls_corp_naics_desc {MAXCOUNT(100)};
  REAL4 corp_name_effective_date_specificity;
  REAL4 corp_name_effective_date_switch;
  REAL4 corp_name_effective_date_maximum;
  DATASET(corp_name_effective_date_ChildRec) nulls_corp_name_effective_date {MAXCOUNT(100)};
  REAL4 corp_name_reservation_date_specificity;
  REAL4 corp_name_reservation_date_switch;
  REAL4 corp_name_reservation_date_maximum;
  DATASET(corp_name_reservation_date_ChildRec) nulls_corp_name_reservation_date {MAXCOUNT(100)};
  REAL4 corp_name_reservation_desc_specificity;
  REAL4 corp_name_reservation_desc_switch;
  REAL4 corp_name_reservation_desc_maximum;
  DATASET(corp_name_reservation_desc_ChildRec) nulls_corp_name_reservation_desc {MAXCOUNT(100)};
  REAL4 corp_name_reservation_expiration_date_specificity;
  REAL4 corp_name_reservation_expiration_date_switch;
  REAL4 corp_name_reservation_expiration_date_maximum;
  DATASET(corp_name_reservation_expiration_date_ChildRec) nulls_corp_name_reservation_expiration_date {MAXCOUNT(100)};
  REAL4 corp_name_reservation_nbr_specificity;
  REAL4 corp_name_reservation_nbr_switch;
  REAL4 corp_name_reservation_nbr_maximum;
  DATASET(corp_name_reservation_nbr_ChildRec) nulls_corp_name_reservation_nbr {MAXCOUNT(100)};
  REAL4 corp_name_reservation_type_specificity;
  REAL4 corp_name_reservation_type_switch;
  REAL4 corp_name_reservation_type_maximum;
  DATASET(corp_name_reservation_type_ChildRec) nulls_corp_name_reservation_type {MAXCOUNT(100)};
  REAL4 corp_name_status_cd_specificity;
  REAL4 corp_name_status_cd_switch;
  REAL4 corp_name_status_cd_maximum;
  DATASET(corp_name_status_cd_ChildRec) nulls_corp_name_status_cd {MAXCOUNT(100)};
  REAL4 corp_name_status_date_specificity;
  REAL4 corp_name_status_date_switch;
  REAL4 corp_name_status_date_maximum;
  DATASET(corp_name_status_date_ChildRec) nulls_corp_name_status_date {MAXCOUNT(100)};
  REAL4 corp_name_status_desc_specificity;
  REAL4 corp_name_status_desc_switch;
  REAL4 corp_name_status_desc_maximum;
  DATASET(corp_name_status_desc_ChildRec) nulls_corp_name_status_desc {MAXCOUNT(100)};
  REAL4 corp_non_profit_irs_approved_purpose_specificity;
  REAL4 corp_non_profit_irs_approved_purpose_switch;
  REAL4 corp_non_profit_irs_approved_purpose_maximum;
  DATASET(corp_non_profit_irs_approved_purpose_ChildRec) nulls_corp_non_profit_irs_approved_purpose {MAXCOUNT(100)};
  REAL4 corp_non_profit_solicit_donations_specificity;
  REAL4 corp_non_profit_solicit_donations_switch;
  REAL4 corp_non_profit_solicit_donations_maximum;
  DATASET(corp_non_profit_solicit_donations_ChildRec) nulls_corp_non_profit_solicit_donations {MAXCOUNT(100)};
  REAL4 corp_nbr_of_amendments_specificity;
  REAL4 corp_nbr_of_amendments_switch;
  REAL4 corp_nbr_of_amendments_maximum;
  DATASET(corp_nbr_of_amendments_ChildRec) nulls_corp_nbr_of_amendments {MAXCOUNT(100)};
  REAL4 corp_nbr_of_initial_llc_members_specificity;
  REAL4 corp_nbr_of_initial_llc_members_switch;
  REAL4 corp_nbr_of_initial_llc_members_maximum;
  DATASET(corp_nbr_of_initial_llc_members_ChildRec) nulls_corp_nbr_of_initial_llc_members {MAXCOUNT(100)};
  REAL4 corp_nbr_of_partners_specificity;
  REAL4 corp_nbr_of_partners_switch;
  REAL4 corp_nbr_of_partners_maximum;
  DATASET(corp_nbr_of_partners_ChildRec) nulls_corp_nbr_of_partners {MAXCOUNT(100)};
  REAL4 corp_operating_agreement_specificity;
  REAL4 corp_operating_agreement_switch;
  REAL4 corp_operating_agreement_maximum;
  DATASET(corp_operating_agreement_ChildRec) nulls_corp_operating_agreement {MAXCOUNT(100)};
  REAL4 corp_opt_in_llc_act_desc_specificity;
  REAL4 corp_opt_in_llc_act_desc_switch;
  REAL4 corp_opt_in_llc_act_desc_maximum;
  DATASET(corp_opt_in_llc_act_desc_ChildRec) nulls_corp_opt_in_llc_act_desc {MAXCOUNT(100)};
  REAL4 corp_opt_in_llc_act_ind_specificity;
  REAL4 corp_opt_in_llc_act_ind_switch;
  REAL4 corp_opt_in_llc_act_ind_maximum;
  DATASET(corp_opt_in_llc_act_ind_ChildRec) nulls_corp_opt_in_llc_act_ind {MAXCOUNT(100)};
  REAL4 corp_organizational_comments_specificity;
  REAL4 corp_organizational_comments_switch;
  REAL4 corp_organizational_comments_maximum;
  DATASET(corp_organizational_comments_ChildRec) nulls_corp_organizational_comments {MAXCOUNT(100)};
  REAL4 corp_partner_contributions_total_specificity;
  REAL4 corp_partner_contributions_total_switch;
  REAL4 corp_partner_contributions_total_maximum;
  DATASET(corp_partner_contributions_total_ChildRec) nulls_corp_partner_contributions_total {MAXCOUNT(100)};
  REAL4 corp_partner_terms_specificity;
  REAL4 corp_partner_terms_switch;
  REAL4 corp_partner_terms_maximum;
  DATASET(corp_partner_terms_ChildRec) nulls_corp_partner_terms {MAXCOUNT(100)};
  REAL4 corp_percentage_voters_required_to_approve_amendments_specificity;
  REAL4 corp_percentage_voters_required_to_approve_amendments_switch;
  REAL4 corp_percentage_voters_required_to_approve_amendments_maximum;
  DATASET(corp_percentage_voters_required_to_approve_amendments_ChildRec) nulls_corp_percentage_voters_required_to_approve_amendments {MAXCOUNT(100)};
  REAL4 corp_profession_specificity;
  REAL4 corp_profession_switch;
  REAL4 corp_profession_maximum;
  DATASET(corp_profession_ChildRec) nulls_corp_profession {MAXCOUNT(100)};
  REAL4 corp_province_specificity;
  REAL4 corp_province_switch;
  REAL4 corp_province_maximum;
  DATASET(corp_province_ChildRec) nulls_corp_province {MAXCOUNT(100)};
  REAL4 corp_public_mutual_corporation_specificity;
  REAL4 corp_public_mutual_corporation_switch;
  REAL4 corp_public_mutual_corporation_maximum;
  DATASET(corp_public_mutual_corporation_ChildRec) nulls_corp_public_mutual_corporation {MAXCOUNT(100)};
  REAL4 corp_purpose_specificity;
  REAL4 corp_purpose_switch;
  REAL4 corp_purpose_maximum;
  DATASET(corp_purpose_ChildRec) nulls_corp_purpose {MAXCOUNT(100)};
  REAL4 corp_ra_required_flag_specificity;
  REAL4 corp_ra_required_flag_switch;
  REAL4 corp_ra_required_flag_maximum;
  DATASET(corp_ra_required_flag_ChildRec) nulls_corp_ra_required_flag {MAXCOUNT(100)};
  REAL4 corp_registered_counties_specificity;
  REAL4 corp_registered_counties_switch;
  REAL4 corp_registered_counties_maximum;
  DATASET(corp_registered_counties_ChildRec) nulls_corp_registered_counties {MAXCOUNT(100)};
  REAL4 corp_regulated_ind_specificity;
  REAL4 corp_regulated_ind_switch;
  REAL4 corp_regulated_ind_maximum;
  DATASET(corp_regulated_ind_ChildRec) nulls_corp_regulated_ind {MAXCOUNT(100)};
  REAL4 corp_renewal_date_specificity;
  REAL4 corp_renewal_date_switch;
  REAL4 corp_renewal_date_maximum;
  DATASET(corp_renewal_date_ChildRec) nulls_corp_renewal_date {MAXCOUNT(100)};
  REAL4 corp_standing_other_specificity;
  REAL4 corp_standing_other_switch;
  REAL4 corp_standing_other_maximum;
  DATASET(corp_standing_other_ChildRec) nulls_corp_standing_other {MAXCOUNT(100)};
  REAL4 corp_survivor_corporation_id_specificity;
  REAL4 corp_survivor_corporation_id_switch;
  REAL4 corp_survivor_corporation_id_maximum;
  DATASET(corp_survivor_corporation_id_ChildRec) nulls_corp_survivor_corporation_id {MAXCOUNT(100)};
  REAL4 corp_tax_base_specificity;
  REAL4 corp_tax_base_switch;
  REAL4 corp_tax_base_maximum;
  DATASET(corp_tax_base_ChildRec) nulls_corp_tax_base {MAXCOUNT(100)};
  REAL4 corp_tax_standing_specificity;
  REAL4 corp_tax_standing_switch;
  REAL4 corp_tax_standing_maximum;
  DATASET(corp_tax_standing_ChildRec) nulls_corp_tax_standing {MAXCOUNT(100)};
  REAL4 corp_termination_cd_specificity;
  REAL4 corp_termination_cd_switch;
  REAL4 corp_termination_cd_maximum;
  DATASET(corp_termination_cd_ChildRec) nulls_corp_termination_cd {MAXCOUNT(100)};
  REAL4 corp_termination_desc_specificity;
  REAL4 corp_termination_desc_switch;
  REAL4 corp_termination_desc_maximum;
  DATASET(corp_termination_desc_ChildRec) nulls_corp_termination_desc {MAXCOUNT(100)};
  REAL4 corp_termination_date_specificity;
  REAL4 corp_termination_date_switch;
  REAL4 corp_termination_date_maximum;
  DATASET(corp_termination_date_ChildRec) nulls_corp_termination_date {MAXCOUNT(100)};
  REAL4 corp_trademark_business_mark_type_specificity;
  REAL4 corp_trademark_business_mark_type_switch;
  REAL4 corp_trademark_business_mark_type_maximum;
  DATASET(corp_trademark_business_mark_type_ChildRec) nulls_corp_trademark_business_mark_type {MAXCOUNT(100)};
  REAL4 corp_trademark_cancelled_date_specificity;
  REAL4 corp_trademark_cancelled_date_switch;
  REAL4 corp_trademark_cancelled_date_maximum;
  DATASET(corp_trademark_cancelled_date_ChildRec) nulls_corp_trademark_cancelled_date {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc1_specificity;
  REAL4 corp_trademark_class_desc1_switch;
  REAL4 corp_trademark_class_desc1_maximum;
  DATASET(corp_trademark_class_desc1_ChildRec) nulls_corp_trademark_class_desc1 {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc2_specificity;
  REAL4 corp_trademark_class_desc2_switch;
  REAL4 corp_trademark_class_desc2_maximum;
  DATASET(corp_trademark_class_desc2_ChildRec) nulls_corp_trademark_class_desc2 {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc3_specificity;
  REAL4 corp_trademark_class_desc3_switch;
  REAL4 corp_trademark_class_desc3_maximum;
  DATASET(corp_trademark_class_desc3_ChildRec) nulls_corp_trademark_class_desc3 {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc4_specificity;
  REAL4 corp_trademark_class_desc4_switch;
  REAL4 corp_trademark_class_desc4_maximum;
  DATASET(corp_trademark_class_desc4_ChildRec) nulls_corp_trademark_class_desc4 {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc5_specificity;
  REAL4 corp_trademark_class_desc5_switch;
  REAL4 corp_trademark_class_desc5_maximum;
  DATASET(corp_trademark_class_desc5_ChildRec) nulls_corp_trademark_class_desc5 {MAXCOUNT(100)};
  REAL4 corp_trademark_class_desc6_specificity;
  REAL4 corp_trademark_class_desc6_switch;
  REAL4 corp_trademark_class_desc6_maximum;
  DATASET(corp_trademark_class_desc6_ChildRec) nulls_corp_trademark_class_desc6 {MAXCOUNT(100)};
  REAL4 corp_trademark_classification_nbr_specificity;
  REAL4 corp_trademark_classification_nbr_switch;
  REAL4 corp_trademark_classification_nbr_maximum;
  DATASET(corp_trademark_classification_nbr_ChildRec) nulls_corp_trademark_classification_nbr {MAXCOUNT(100)};
  REAL4 corp_trademark_disclaimer1_specificity;
  REAL4 corp_trademark_disclaimer1_switch;
  REAL4 corp_trademark_disclaimer1_maximum;
  DATASET(corp_trademark_disclaimer1_ChildRec) nulls_corp_trademark_disclaimer1 {MAXCOUNT(100)};
  REAL4 corp_trademark_disclaimer2_specificity;
  REAL4 corp_trademark_disclaimer2_switch;
  REAL4 corp_trademark_disclaimer2_maximum;
  DATASET(corp_trademark_disclaimer2_ChildRec) nulls_corp_trademark_disclaimer2 {MAXCOUNT(100)};
  REAL4 corp_trademark_expiration_date_specificity;
  REAL4 corp_trademark_expiration_date_switch;
  REAL4 corp_trademark_expiration_date_maximum;
  DATASET(corp_trademark_expiration_date_ChildRec) nulls_corp_trademark_expiration_date {MAXCOUNT(100)};
  REAL4 corp_trademark_filing_date_specificity;
  REAL4 corp_trademark_filing_date_switch;
  REAL4 corp_trademark_filing_date_maximum;
  DATASET(corp_trademark_filing_date_ChildRec) nulls_corp_trademark_filing_date {MAXCOUNT(100)};
  REAL4 corp_trademark_first_use_date_specificity;
  REAL4 corp_trademark_first_use_date_switch;
  REAL4 corp_trademark_first_use_date_maximum;
  DATASET(corp_trademark_first_use_date_ChildRec) nulls_corp_trademark_first_use_date {MAXCOUNT(100)};
  REAL4 corp_trademark_first_use_date_in_state_specificity;
  REAL4 corp_trademark_first_use_date_in_state_switch;
  REAL4 corp_trademark_first_use_date_in_state_maximum;
  DATASET(corp_trademark_first_use_date_in_state_ChildRec) nulls_corp_trademark_first_use_date_in_state {MAXCOUNT(100)};
  REAL4 corp_trademark_keywords_specificity;
  REAL4 corp_trademark_keywords_switch;
  REAL4 corp_trademark_keywords_maximum;
  DATASET(corp_trademark_keywords_ChildRec) nulls_corp_trademark_keywords {MAXCOUNT(100)};
  REAL4 corp_trademark_logo_specificity;
  REAL4 corp_trademark_logo_switch;
  REAL4 corp_trademark_logo_maximum;
  DATASET(corp_trademark_logo_ChildRec) nulls_corp_trademark_logo {MAXCOUNT(100)};
  REAL4 corp_trademark_name_expiration_date_specificity;
  REAL4 corp_trademark_name_expiration_date_switch;
  REAL4 corp_trademark_name_expiration_date_maximum;
  DATASET(corp_trademark_name_expiration_date_ChildRec) nulls_corp_trademark_name_expiration_date {MAXCOUNT(100)};
  REAL4 corp_trademark_nbr_specificity;
  REAL4 corp_trademark_nbr_switch;
  REAL4 corp_trademark_nbr_maximum;
  DATASET(corp_trademark_nbr_ChildRec) nulls_corp_trademark_nbr {MAXCOUNT(100)};
  REAL4 corp_trademark_renewal_date_specificity;
  REAL4 corp_trademark_renewal_date_switch;
  REAL4 corp_trademark_renewal_date_maximum;
  DATASET(corp_trademark_renewal_date_ChildRec) nulls_corp_trademark_renewal_date {MAXCOUNT(100)};
  REAL4 corp_trademark_status_specificity;
  REAL4 corp_trademark_status_switch;
  REAL4 corp_trademark_status_maximum;
  DATASET(corp_trademark_status_ChildRec) nulls_corp_trademark_status {MAXCOUNT(100)};
  REAL4 corp_trademark_used_1_specificity;
  REAL4 corp_trademark_used_1_switch;
  REAL4 corp_trademark_used_1_maximum;
  DATASET(corp_trademark_used_1_ChildRec) nulls_corp_trademark_used_1 {MAXCOUNT(100)};
  REAL4 corp_trademark_used_2_specificity;
  REAL4 corp_trademark_used_2_switch;
  REAL4 corp_trademark_used_2_maximum;
  DATASET(corp_trademark_used_2_ChildRec) nulls_corp_trademark_used_2 {MAXCOUNT(100)};
  REAL4 corp_trademark_used_3_specificity;
  REAL4 corp_trademark_used_3_switch;
  REAL4 corp_trademark_used_3_maximum;
  DATASET(corp_trademark_used_3_ChildRec) nulls_corp_trademark_used_3 {MAXCOUNT(100)};
  REAL4 cont_owner_percentage_specificity;
  REAL4 cont_owner_percentage_switch;
  REAL4 cont_owner_percentage_maximum;
  DATASET(cont_owner_percentage_ChildRec) nulls_cont_owner_percentage {MAXCOUNT(100)};
  REAL4 cont_country_specificity;
  REAL4 cont_country_switch;
  REAL4 cont_country_maximum;
  DATASET(cont_country_ChildRec) nulls_cont_country {MAXCOUNT(100)};
  REAL4 cont_country_mailing_specificity;
  REAL4 cont_country_mailing_switch;
  REAL4 cont_country_mailing_maximum;
  DATASET(cont_country_mailing_ChildRec) nulls_cont_country_mailing {MAXCOUNT(100)};
  REAL4 cont_nondislosure_specificity;
  REAL4 cont_nondislosure_switch;
  REAL4 cont_nondislosure_maximum;
  DATASET(cont_nondislosure_ChildRec) nulls_cont_nondislosure {MAXCOUNT(100)};
  REAL4 cont_prep_addr_line1_specificity;
  REAL4 cont_prep_addr_line1_switch;
  REAL4 cont_prep_addr_line1_maximum;
  DATASET(cont_prep_addr_line1_ChildRec) nulls_cont_prep_addr_line1 {MAXCOUNT(100)};
  REAL4 cont_prep_addr_last_line_specificity;
  REAL4 cont_prep_addr_last_line_switch;
  REAL4 cont_prep_addr_last_line_maximum;
  DATASET(cont_prep_addr_last_line_ChildRec) nulls_cont_prep_addr_last_line {MAXCOUNT(100)};
  REAL4 recordorigin_specificity;
  REAL4 recordorigin_switch;
  REAL4 recordorigin_maximum;
  DATASET(recordorigin_ChildRec) nulls_recordorigin {MAXCOUNT(100)};
END;
END;
