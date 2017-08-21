IMPORT ut,SALT33;
IMPORT scrubs_business_credit,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT LinkID_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(LinkID_Layout_Business_Credit)
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_datawarehouse_first_reported_Invalid;
    UNSIGNED1 dt_datawarehouse_last_reported_Invalid;
    UNSIGNED1 sbfe_contributor_number_Invalid;
    UNSIGNED1 contract_account_number_Invalid;
    UNSIGNED1 extracted_date_Invalid;
    UNSIGNED1 cycle_end_date_Invalid;
    UNSIGNED1 account_holder_business_name_Invalid;
    UNSIGNED1 clean_account_holder_business_name_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 clean_dba_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 clean_business_name_Invalid;
    UNSIGNED1 company_website_Invalid;
    UNSIGNED1 original_fname_Invalid;
    UNSIGNED1 original_mname_Invalid;
    UNSIGNED1 original_lname_Invalid;
    UNSIGNED1 original_suffix_Invalid;
    UNSIGNED1 e_mail_address_Invalid;
    UNSIGNED1 guarantor_owner_indicator_Invalid;
    UNSIGNED1 relationship_to_business_indicator_Invalid;
    UNSIGNED1 business_title_Invalid;
    UNSIGNED1 clean_title_Invalid;
    UNSIGNED1 clean_fname_Invalid;
    UNSIGNED1 clean_mname_Invalid;
    UNSIGNED1 clean_lname_Invalid;
    UNSIGNED1 clean_suffix_Invalid;
    UNSIGNED1 original_address_line_1_Invalid;
    UNSIGNED1 original_address_line_2_Invalid;
    UNSIGNED1 original_city_Invalid;
    UNSIGNED1 original_state_Invalid;
    UNSIGNED1 original_zip_code_or_ca_postal_code_Invalid;
    UNSIGNED1 original_postal_code_Invalid;
    UNSIGNED1 original_country_code_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 original_area_code_Invalid;
    UNSIGNED1 original_phone_number_Invalid;
    UNSIGNED1 phone_extension_Invalid;
    UNSIGNED1 primary_phone_indicator_Invalid;
    UNSIGNED1 published_unlisted_indicator_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 federal_taxid_ssn_Invalid;
    UNSIGNED1 federal_taxid_ssn_identifier_Invalid;
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 sbfe_id_Invalid;
    UNSIGNED1 legal_business_structure_Invalid;
    UNSIGNED1 business_established_date_Invalid;
    UNSIGNED1 account_status_1_Invalid;
    UNSIGNED1 account_status_2_Invalid;
    UNSIGNED1 date_account_opened_Invalid;
    UNSIGNED1 date_account_closed_Invalid;
    UNSIGNED1 account_closure_basis_Invalid;
    UNSIGNED1 account_expiration_date_Invalid;
    UNSIGNED1 last_activity_date_Invalid;
    UNSIGNED1 last_activity_type_Invalid;
    UNSIGNED1 recent_activity_indicator_Invalid;
    UNSIGNED1 original_credit_limit_Invalid;
    UNSIGNED1 highest_credit_used_Invalid;
    UNSIGNED1 current_credit_limit_Invalid;
    UNSIGNED1 reporting_indicator_length_Invalid;
    UNSIGNED1 payment_interval_Invalid;
    UNSIGNED1 payment_status_category_Invalid;
    UNSIGNED1 term_of_account_in_months_Invalid;
    UNSIGNED1 first_payment_due_date_Invalid;
    UNSIGNED1 final_payment_due_date_Invalid;
    UNSIGNED1 original_rate_Invalid;
    UNSIGNED1 floating_rate_Invalid;
    UNSIGNED1 grace_period_Invalid;
    UNSIGNED1 payment_category_Invalid;
    UNSIGNED1 payment_history_profile_12_months_Invalid;
    UNSIGNED1 payment_history_profile_13_24_months_Invalid;
    UNSIGNED1 payment_history_profile_25_36_months_Invalid;
    UNSIGNED1 payment_history_profile_37_48_months_Invalid;
    UNSIGNED1 payment_history_length_Invalid;
    UNSIGNED1 year_to_date_purchases_count_Invalid;
    UNSIGNED1 lifetime_to_date_purchases_count_Invalid;
    UNSIGNED1 year_to_date_purchases_sum_amount_Invalid;
    UNSIGNED1 lifetime_to_date_purchases_sum_amount_Invalid;
    UNSIGNED1 payment_amount_scheduled_Invalid;
    UNSIGNED1 recent_payment_amount_Invalid;
    UNSIGNED1 recent_payment_date_Invalid;
    UNSIGNED1 remaining_balance_Invalid;
    UNSIGNED1 carried_over_amount_Invalid;
    UNSIGNED1 new_applied_charges_Invalid;
    UNSIGNED1 balloon_payment_due_Invalid;
    UNSIGNED1 balloon_payment_due_date_Invalid;
    UNSIGNED1 delinquency_date_Invalid;
    UNSIGNED1 days_delinquent_Invalid;
    UNSIGNED1 past_due_amount_Invalid;
    UNSIGNED1 maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid;
    UNSIGNED1 past_due_aging_bucket_type_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_1_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_2_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_3_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_4_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_5_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_6_Invalid;
    UNSIGNED1 past_due_aging_amount_bucket_7_Invalid;
    UNSIGNED1 maximum_number_of_payment_tracking_cycle_periods_provided_Invalid;
    UNSIGNED1 payment_tracking_cycle_type_Invalid;
    UNSIGNED1 payment_tracking_cycle_0_current_Invalid;
    UNSIGNED1 payment_tracking_cycle_1_1_to_30_days_Invalid;
    UNSIGNED1 payment_tracking_cycle_2_31_to_60_days_Invalid;
    UNSIGNED1 payment_tracking_cycle_3_61_to_90_days_Invalid;
    UNSIGNED1 payment_tracking_cycle_4_91_to_120_days_Invalid;
    UNSIGNED1 payment_tracking_cycle_5_121_to_150days_Invalid;
    UNSIGNED1 payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid;
    UNSIGNED1 payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid;
    UNSIGNED1 date_account_was_charged_off_Invalid;
    UNSIGNED1 amount_charged_off_by_creditor_Invalid;
    UNSIGNED1 charge_off_type_indicator_Invalid;
    UNSIGNED1 total_charge_off_recoveries_to_date_Invalid;
    UNSIGNED1 government_guarantee_flag_Invalid;
    UNSIGNED1 government_guarantee_category_Invalid;
    UNSIGNED1 portion_of_account_guaranteed_by_government_Invalid;
    UNSIGNED1 guarantors_indicator_Invalid;
    UNSIGNED1 number_of_guarantors_Invalid;
    UNSIGNED1 owners_indicator_Invalid;
    UNSIGNED1 number_of_principals_Invalid;
    UNSIGNED1 account_update_deletion_indicator_Invalid;
    UNSIGNED1 percent_of_liability_Invalid;
    UNSIGNED1 percent_of_ownership_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(LinkID_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(LinkID_Layout_Business_Credit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.timestamp_Invalid := LinkID_Fields.InValid_timestamp((SALT33.StrType)le.timestamp);
    SELF.process_date_Invalid := LinkID_Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.record_type_Invalid := LinkID_Fields.InValid_record_type((SALT33.StrType)le.record_type);
    SELF.did_Invalid := LinkID_Fields.InValid_did((SALT33.StrType)le.did);
    SELF.did_score_Invalid := LinkID_Fields.InValid_did_score((SALT33.StrType)le.did_score);
    SELF.dt_first_seen_Invalid := LinkID_Fields.InValid_dt_first_seen((SALT33.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := LinkID_Fields.InValid_dt_last_seen((SALT33.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := LinkID_Fields.InValid_dt_vendor_first_reported((SALT33.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := LinkID_Fields.InValid_dt_vendor_last_reported((SALT33.StrType)le.dt_vendor_last_reported);
    SELF.dt_datawarehouse_first_reported_Invalid := LinkID_Fields.InValid_dt_datawarehouse_first_reported((SALT33.StrType)le.dt_datawarehouse_first_reported);
    SELF.dt_datawarehouse_last_reported_Invalid := LinkID_Fields.InValid_dt_datawarehouse_last_reported((SALT33.StrType)le.dt_datawarehouse_last_reported);
    SELF.sbfe_contributor_number_Invalid := LinkID_Fields.InValid_sbfe_contributor_number((SALT33.StrType)le.sbfe_contributor_number);
    SELF.contract_account_number_Invalid := LinkID_Fields.InValid_contract_account_number((SALT33.StrType)le.contract_account_number);
    SELF.extracted_date_Invalid := LinkID_Fields.InValid_extracted_date((SALT33.StrType)le.extracted_date);
    SELF.cycle_end_date_Invalid := LinkID_Fields.InValid_cycle_end_date((SALT33.StrType)le.cycle_end_date);
    SELF.account_holder_business_name_Invalid := LinkID_Fields.InValid_account_holder_business_name((SALT33.StrType)le.account_holder_business_name);
    SELF.clean_account_holder_business_name_Invalid := LinkID_Fields.InValid_clean_account_holder_business_name((SALT33.StrType)le.clean_account_holder_business_name);
    SELF.dba_Invalid := LinkID_Fields.InValid_dba((SALT33.StrType)le.dba);
    SELF.clean_dba_Invalid := LinkID_Fields.InValid_clean_dba((SALT33.StrType)le.clean_dba);
    SELF.business_name_Invalid := LinkID_Fields.InValid_business_name((SALT33.StrType)le.business_name);
    SELF.clean_business_name_Invalid := LinkID_Fields.InValid_clean_business_name((SALT33.StrType)le.clean_business_name);
    SELF.company_website_Invalid := LinkID_Fields.InValid_company_website((SALT33.StrType)le.company_website);
    SELF.original_fname_Invalid := LinkID_Fields.InValid_original_fname((SALT33.StrType)le.original_fname);
    SELF.original_mname_Invalid := LinkID_Fields.InValid_original_mname((SALT33.StrType)le.original_mname);
    SELF.original_lname_Invalid := LinkID_Fields.InValid_original_lname((SALT33.StrType)le.original_lname);
    SELF.original_suffix_Invalid := LinkID_Fields.InValid_original_suffix((SALT33.StrType)le.original_suffix);
    SELF.e_mail_address_Invalid := LinkID_Fields.InValid_e_mail_address((SALT33.StrType)le.e_mail_address);
    SELF.guarantor_owner_indicator_Invalid := LinkID_Fields.InValid_guarantor_owner_indicator((SALT33.StrType)le.guarantor_owner_indicator);
    SELF.relationship_to_business_indicator_Invalid := LinkID_Fields.InValid_relationship_to_business_indicator((SALT33.StrType)le.relationship_to_business_indicator);
    SELF.business_title_Invalid := LinkID_Fields.InValid_business_title((SALT33.StrType)le.business_title);
    SELF.clean_title_Invalid := LinkID_Fields.InValid_clean_title((SALT33.StrType)le.clean_title);
    SELF.clean_fname_Invalid := LinkID_Fields.InValid_clean_fname((SALT33.StrType)le.clean_fname);
    SELF.clean_mname_Invalid := LinkID_Fields.InValid_clean_mname((SALT33.StrType)le.clean_mname);
    SELF.clean_lname_Invalid := LinkID_Fields.InValid_clean_lname((SALT33.StrType)le.clean_lname);
    SELF.clean_suffix_Invalid := LinkID_Fields.InValid_clean_suffix((SALT33.StrType)le.clean_suffix);
    SELF.original_address_line_1_Invalid := LinkID_Fields.InValid_original_address_line_1((SALT33.StrType)le.original_address_line_1);
    SELF.original_address_line_2_Invalid := LinkID_Fields.InValid_original_address_line_2((SALT33.StrType)le.original_address_line_2);
    SELF.original_city_Invalid := LinkID_Fields.InValid_original_city((SALT33.StrType)le.original_city);
    SELF.original_state_Invalid := LinkID_Fields.InValid_original_state((SALT33.StrType)le.original_state);
    SELF.original_zip_code_or_ca_postal_code_Invalid := LinkID_Fields.InValid_original_zip_code_or_ca_postal_code((SALT33.StrType)le.original_zip_code_or_ca_postal_code);
    SELF.original_postal_code_Invalid := LinkID_Fields.InValid_original_postal_code((SALT33.StrType)le.original_postal_code);
    SELF.original_country_code_Invalid := LinkID_Fields.InValid_original_country_code((SALT33.StrType)le.original_country_code);
    SELF.prim_range_Invalid := LinkID_Fields.InValid_prim_range((SALT33.StrType)le.prim_range);
    SELF.predir_Invalid := LinkID_Fields.InValid_predir((SALT33.StrType)le.predir);
    SELF.prim_name_Invalid := LinkID_Fields.InValid_prim_name((SALT33.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := LinkID_Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix);
    SELF.postdir_Invalid := LinkID_Fields.InValid_postdir((SALT33.StrType)le.postdir);
    SELF.unit_desig_Invalid := LinkID_Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig);
    SELF.sec_range_Invalid := LinkID_Fields.InValid_sec_range((SALT33.StrType)le.sec_range);
    SELF.p_city_name_Invalid := LinkID_Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := LinkID_Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name);
    SELF.st_Invalid := LinkID_Fields.InValid_st((SALT33.StrType)le.st);
    SELF.zip_Invalid := LinkID_Fields.InValid_zip((SALT33.StrType)le.zip);
    SELF.zip4_Invalid := LinkID_Fields.InValid_zip4((SALT33.StrType)le.zip4);
    SELF.original_area_code_Invalid := LinkID_Fields.InValid_original_area_code((SALT33.StrType)le.original_area_code);
    SELF.original_phone_number_Invalid := LinkID_Fields.InValid_original_phone_number((SALT33.StrType)le.original_phone_number);
    SELF.phone_extension_Invalid := LinkID_Fields.InValid_phone_extension((SALT33.StrType)le.phone_extension);
    SELF.primary_phone_indicator_Invalid := LinkID_Fields.InValid_primary_phone_indicator((SALT33.StrType)le.primary_phone_indicator);
    SELF.published_unlisted_indicator_Invalid := LinkID_Fields.InValid_published_unlisted_indicator((SALT33.StrType)le.published_unlisted_indicator);
    SELF.phone_type_Invalid := LinkID_Fields.InValid_phone_type((SALT33.StrType)le.phone_type);
    SELF.phone_number_Invalid := LinkID_Fields.InValid_phone_number((SALT33.StrType)le.phone_number);
    SELF.federal_taxid_ssn_Invalid := LinkID_Fields.InValid_federal_taxid_ssn((SALT33.StrType)le.federal_taxid_ssn);
    SELF.federal_taxid_ssn_identifier_Invalid := LinkID_Fields.InValid_federal_taxid_ssn_identifier((SALT33.StrType)le.federal_taxid_ssn_identifier);
    SELF.dotid_Invalid := LinkID_Fields.InValid_dotid((SALT33.StrType)le.dotid);
    SELF.dotscore_Invalid := LinkID_Fields.InValid_dotscore((SALT33.StrType)le.dotscore);
    SELF.dotweight_Invalid := LinkID_Fields.InValid_dotweight((SALT33.StrType)le.dotweight);
    SELF.empid_Invalid := LinkID_Fields.InValid_empid((SALT33.StrType)le.empid);
    SELF.empscore_Invalid := LinkID_Fields.InValid_empscore((SALT33.StrType)le.empscore);
    SELF.empweight_Invalid := LinkID_Fields.InValid_empweight((SALT33.StrType)le.empweight);
    SELF.powid_Invalid := LinkID_Fields.InValid_powid((SALT33.StrType)le.powid);
    SELF.powscore_Invalid := LinkID_Fields.InValid_powscore((SALT33.StrType)le.powscore);
    SELF.powweight_Invalid := LinkID_Fields.InValid_powweight((SALT33.StrType)le.powweight);
    SELF.proxid_Invalid := LinkID_Fields.InValid_proxid((SALT33.StrType)le.proxid);
    SELF.proxscore_Invalid := LinkID_Fields.InValid_proxscore((SALT33.StrType)le.proxscore);
    SELF.proxweight_Invalid := LinkID_Fields.InValid_proxweight((SALT33.StrType)le.proxweight);
    SELF.seleid_Invalid := LinkID_Fields.InValid_seleid((SALT33.StrType)le.seleid);
    SELF.selescore_Invalid := LinkID_Fields.InValid_selescore((SALT33.StrType)le.selescore);
    SELF.seleweight_Invalid := LinkID_Fields.InValid_seleweight((SALT33.StrType)le.seleweight);
    SELF.orgid_Invalid := LinkID_Fields.InValid_orgid((SALT33.StrType)le.orgid);
    SELF.orgscore_Invalid := LinkID_Fields.InValid_orgscore((SALT33.StrType)le.orgscore);
    SELF.orgweight_Invalid := LinkID_Fields.InValid_orgweight((SALT33.StrType)le.orgweight);
    SELF.ultid_Invalid := LinkID_Fields.InValid_ultid((SALT33.StrType)le.ultid);
    SELF.ultscore_Invalid := LinkID_Fields.InValid_ultscore((SALT33.StrType)le.ultscore);
    SELF.ultweight_Invalid := LinkID_Fields.InValid_ultweight((SALT33.StrType)le.ultweight);
    SELF.sbfe_id_Invalid := LinkID_Fields.InValid_sbfe_id((SALT33.StrType)le.sbfe_id);
    SELF.legal_business_structure_Invalid := LinkID_Fields.InValid_legal_business_structure((SALT33.StrType)le.legal_business_structure);
    SELF.business_established_date_Invalid := LinkID_Fields.InValid_business_established_date((SALT33.StrType)le.business_established_date);
    SELF.account_status_1_Invalid := LinkID_Fields.InValid_account_status_1((SALT33.StrType)le.account_status_1);
    SELF.account_status_2_Invalid := LinkID_Fields.InValid_account_status_2((SALT33.StrType)le.account_status_2);
    SELF.date_account_opened_Invalid := LinkID_Fields.InValid_date_account_opened((SALT33.StrType)le.date_account_opened);
    SELF.date_account_closed_Invalid := LinkID_Fields.InValid_date_account_closed((SALT33.StrType)le.date_account_closed);
    SELF.account_closure_basis_Invalid := LinkID_Fields.InValid_account_closure_basis((SALT33.StrType)le.account_closure_basis);
    SELF.account_expiration_date_Invalid := LinkID_Fields.InValid_account_expiration_date((SALT33.StrType)le.account_expiration_date);
    SELF.last_activity_date_Invalid := LinkID_Fields.InValid_last_activity_date((SALT33.StrType)le.last_activity_date);
    SELF.last_activity_type_Invalid := LinkID_Fields.InValid_last_activity_type((SALT33.StrType)le.last_activity_type);
    SELF.recent_activity_indicator_Invalid := LinkID_Fields.InValid_recent_activity_indicator((SALT33.StrType)le.recent_activity_indicator);
    SELF.original_credit_limit_Invalid := LinkID_Fields.InValid_original_credit_limit((SALT33.StrType)le.original_credit_limit);
    SELF.highest_credit_used_Invalid := LinkID_Fields.InValid_highest_credit_used((SALT33.StrType)le.highest_credit_used);
    SELF.current_credit_limit_Invalid := LinkID_Fields.InValid_current_credit_limit((SALT33.StrType)le.current_credit_limit);
    SELF.reporting_indicator_length_Invalid := LinkID_Fields.InValid_reporting_indicator_length((SALT33.StrType)le.reporting_indicator_length);
    SELF.payment_interval_Invalid := LinkID_Fields.InValid_payment_interval((SALT33.StrType)le.payment_interval);
    SELF.payment_status_category_Invalid := LinkID_Fields.InValid_payment_status_category((SALT33.StrType)le.payment_status_category);
    SELF.term_of_account_in_months_Invalid := LinkID_Fields.InValid_term_of_account_in_months((SALT33.StrType)le.term_of_account_in_months);
    SELF.first_payment_due_date_Invalid := LinkID_Fields.InValid_first_payment_due_date((SALT33.StrType)le.first_payment_due_date);
    SELF.final_payment_due_date_Invalid := LinkID_Fields.InValid_final_payment_due_date((SALT33.StrType)le.final_payment_due_date);
    SELF.original_rate_Invalid := LinkID_Fields.InValid_original_rate((SALT33.StrType)le.original_rate);
    SELF.floating_rate_Invalid := LinkID_Fields.InValid_floating_rate((SALT33.StrType)le.floating_rate);
    SELF.grace_period_Invalid := LinkID_Fields.InValid_grace_period((SALT33.StrType)le.grace_period);
    SELF.payment_category_Invalid := LinkID_Fields.InValid_payment_category((SALT33.StrType)le.payment_category);
    SELF.payment_history_profile_12_months_Invalid := LinkID_Fields.InValid_payment_history_profile_12_months((SALT33.StrType)le.payment_history_profile_12_months);
    SELF.payment_history_profile_13_24_months_Invalid := LinkID_Fields.InValid_payment_history_profile_13_24_months((SALT33.StrType)le.payment_history_profile_13_24_months);
    SELF.payment_history_profile_25_36_months_Invalid := LinkID_Fields.InValid_payment_history_profile_25_36_months((SALT33.StrType)le.payment_history_profile_25_36_months);
    SELF.payment_history_profile_37_48_months_Invalid := LinkID_Fields.InValid_payment_history_profile_37_48_months((SALT33.StrType)le.payment_history_profile_37_48_months);
    SELF.payment_history_length_Invalid := LinkID_Fields.InValid_payment_history_length((SALT33.StrType)le.payment_history_length);
    SELF.year_to_date_purchases_count_Invalid := LinkID_Fields.InValid_year_to_date_purchases_count((SALT33.StrType)le.year_to_date_purchases_count);
    SELF.lifetime_to_date_purchases_count_Invalid := LinkID_Fields.InValid_lifetime_to_date_purchases_count((SALT33.StrType)le.lifetime_to_date_purchases_count);
    SELF.year_to_date_purchases_sum_amount_Invalid := LinkID_Fields.InValid_year_to_date_purchases_sum_amount((SALT33.StrType)le.year_to_date_purchases_sum_amount);
    SELF.lifetime_to_date_purchases_sum_amount_Invalid := LinkID_Fields.InValid_lifetime_to_date_purchases_sum_amount((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount);
    SELF.payment_amount_scheduled_Invalid := LinkID_Fields.InValid_payment_amount_scheduled((SALT33.StrType)le.payment_amount_scheduled);
    SELF.recent_payment_amount_Invalid := LinkID_Fields.InValid_recent_payment_amount((SALT33.StrType)le.recent_payment_amount);
    SELF.recent_payment_date_Invalid := LinkID_Fields.InValid_recent_payment_date((SALT33.StrType)le.recent_payment_date);
    SELF.remaining_balance_Invalid := LinkID_Fields.InValid_remaining_balance((SALT33.StrType)le.remaining_balance);
    SELF.carried_over_amount_Invalid := LinkID_Fields.InValid_carried_over_amount((SALT33.StrType)le.carried_over_amount);
    SELF.new_applied_charges_Invalid := LinkID_Fields.InValid_new_applied_charges((SALT33.StrType)le.new_applied_charges);
    SELF.balloon_payment_due_Invalid := LinkID_Fields.InValid_balloon_payment_due((SALT33.StrType)le.balloon_payment_due);
    SELF.balloon_payment_due_date_Invalid := LinkID_Fields.InValid_balloon_payment_due_date((SALT33.StrType)le.balloon_payment_due_date);
    SELF.delinquency_date_Invalid := LinkID_Fields.InValid_delinquency_date((SALT33.StrType)le.delinquency_date);
    SELF.days_delinquent_Invalid := LinkID_Fields.InValid_days_delinquent((SALT33.StrType)le.days_delinquent);
    SELF.past_due_amount_Invalid := LinkID_Fields.InValid_past_due_amount((SALT33.StrType)le.past_due_amount);
    SELF.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid := LinkID_Fields.InValid_maximum_number_of_past_due_aging_amounts_buckets_provided((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided);
    SELF.past_due_aging_bucket_type_Invalid := LinkID_Fields.InValid_past_due_aging_bucket_type((SALT33.StrType)le.past_due_aging_bucket_type);
    SELF.past_due_aging_amount_bucket_1_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_1((SALT33.StrType)le.past_due_aging_amount_bucket_1);
    SELF.past_due_aging_amount_bucket_2_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_2((SALT33.StrType)le.past_due_aging_amount_bucket_2);
    SELF.past_due_aging_amount_bucket_3_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_3((SALT33.StrType)le.past_due_aging_amount_bucket_3);
    SELF.past_due_aging_amount_bucket_4_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_4((SALT33.StrType)le.past_due_aging_amount_bucket_4);
    SELF.past_due_aging_amount_bucket_5_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_5((SALT33.StrType)le.past_due_aging_amount_bucket_5);
    SELF.past_due_aging_amount_bucket_6_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_6((SALT33.StrType)le.past_due_aging_amount_bucket_6);
    SELF.past_due_aging_amount_bucket_7_Invalid := LinkID_Fields.InValid_past_due_aging_amount_bucket_7((SALT33.StrType)le.past_due_aging_amount_bucket_7);
    SELF.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid := LinkID_Fields.InValid_maximum_number_of_payment_tracking_cycle_periods_provided((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided);
    SELF.payment_tracking_cycle_type_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_type((SALT33.StrType)le.payment_tracking_cycle_type);
    SELF.payment_tracking_cycle_0_current_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_0_current((SALT33.StrType)le.payment_tracking_cycle_0_current);
    SELF.payment_tracking_cycle_1_1_to_30_days_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_1_1_to_30_days((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days);
    SELF.payment_tracking_cycle_2_31_to_60_days_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_2_31_to_60_days((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days);
    SELF.payment_tracking_cycle_3_61_to_90_days_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_3_61_to_90_days((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days);
    SELF.payment_tracking_cycle_4_91_to_120_days_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_4_91_to_120_days((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days);
    SELF.payment_tracking_cycle_5_121_to_150days_Invalid := LinkID_Fields.InValid_payment_tracking_cycle_5_121_to_150days((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days);
    SELF.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid := LinkID_Fields.InValid_payment_tracking_number_of_times_cycle_6_151_to_180_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days);
    SELF.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid := LinkID_Fields.InValid_payment_tracking_number_of_times_cycle_7_181_or_greater_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days);
    SELF.date_account_was_charged_off_Invalid := LinkID_Fields.InValid_date_account_was_charged_off((SALT33.StrType)le.date_account_was_charged_off);
    SELF.amount_charged_off_by_creditor_Invalid := LinkID_Fields.InValid_amount_charged_off_by_creditor((SALT33.StrType)le.amount_charged_off_by_creditor);
    SELF.charge_off_type_indicator_Invalid := LinkID_Fields.InValid_charge_off_type_indicator((SALT33.StrType)le.charge_off_type_indicator);
    SELF.total_charge_off_recoveries_to_date_Invalid := LinkID_Fields.InValid_total_charge_off_recoveries_to_date((SALT33.StrType)le.total_charge_off_recoveries_to_date);
    SELF.government_guarantee_flag_Invalid := LinkID_Fields.InValid_government_guarantee_flag((SALT33.StrType)le.government_guarantee_flag);
    SELF.government_guarantee_category_Invalid := LinkID_Fields.InValid_government_guarantee_category((SALT33.StrType)le.government_guarantee_category);
    SELF.portion_of_account_guaranteed_by_government_Invalid := LinkID_Fields.InValid_portion_of_account_guaranteed_by_government((SALT33.StrType)le.portion_of_account_guaranteed_by_government);
    SELF.guarantors_indicator_Invalid := LinkID_Fields.InValid_guarantors_indicator((SALT33.StrType)le.guarantors_indicator);
    SELF.number_of_guarantors_Invalid := LinkID_Fields.InValid_number_of_guarantors((SALT33.StrType)le.number_of_guarantors);
    SELF.owners_indicator_Invalid := LinkID_Fields.InValid_owners_indicator((SALT33.StrType)le.owners_indicator);
    SELF.number_of_principals_Invalid := LinkID_Fields.InValid_number_of_principals((SALT33.StrType)le.number_of_principals);
    SELF.account_update_deletion_indicator_Invalid := LinkID_Fields.InValid_account_update_deletion_indicator((SALT33.StrType)le.account_update_deletion_indicator);
    SELF.percent_of_liability_Invalid := LinkID_Fields.InValid_percent_of_liability((SALT33.StrType)le.percent_of_liability);
    SELF.percent_of_ownership_Invalid := LinkID_Fields.InValid_percent_of_ownership((SALT33.StrType)le.percent_of_ownership);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),LinkID_Layout_Business_Credit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.timestamp_Invalid << 0 ) + ( le.process_date_Invalid << 1 ) + ( le.record_type_Invalid << 2 ) + ( le.did_Invalid << 3 ) + ( le.did_score_Invalid << 4 ) + ( le.dt_first_seen_Invalid << 5 ) + ( le.dt_last_seen_Invalid << 6 ) + ( le.dt_vendor_first_reported_Invalid << 7 ) + ( le.dt_vendor_last_reported_Invalid << 8 ) + ( le.dt_datawarehouse_first_reported_Invalid << 9 ) + ( le.dt_datawarehouse_last_reported_Invalid << 10 ) + ( le.sbfe_contributor_number_Invalid << 11 ) + ( le.contract_account_number_Invalid << 13 ) + ( le.extracted_date_Invalid << 15 ) + ( le.cycle_end_date_Invalid << 17 ) + ( le.account_holder_business_name_Invalid << 19 ) + ( le.clean_account_holder_business_name_Invalid << 20 ) + ( le.dba_Invalid << 21 ) + ( le.clean_dba_Invalid << 22 ) + ( le.business_name_Invalid << 23 ) + ( le.clean_business_name_Invalid << 24 ) + ( le.company_website_Invalid << 25 ) + ( le.original_fname_Invalid << 26 ) + ( le.original_mname_Invalid << 27 ) + ( le.original_lname_Invalid << 28 ) + ( le.original_suffix_Invalid << 29 ) + ( le.e_mail_address_Invalid << 30 ) + ( le.guarantor_owner_indicator_Invalid << 31 ) + ( le.relationship_to_business_indicator_Invalid << 32 ) + ( le.business_title_Invalid << 33 ) + ( le.clean_title_Invalid << 34 ) + ( le.clean_fname_Invalid << 35 ) + ( le.clean_mname_Invalid << 36 ) + ( le.clean_lname_Invalid << 37 ) + ( le.clean_suffix_Invalid << 38 ) + ( le.original_address_line_1_Invalid << 39 ) + ( le.original_address_line_2_Invalid << 40 ) + ( le.original_city_Invalid << 41 ) + ( le.original_state_Invalid << 42 ) + ( le.original_zip_code_or_ca_postal_code_Invalid << 43 ) + ( le.original_postal_code_Invalid << 44 ) + ( le.original_country_code_Invalid << 45 ) + ( le.prim_range_Invalid << 46 ) + ( le.predir_Invalid << 47 ) + ( le.prim_name_Invalid << 48 ) + ( le.addr_suffix_Invalid << 49 ) + ( le.postdir_Invalid << 50 ) + ( le.unit_desig_Invalid << 51 ) + ( le.sec_range_Invalid << 52 ) + ( le.p_city_name_Invalid << 53 ) + ( le.v_city_name_Invalid << 54 ) + ( le.st_Invalid << 55 ) + ( le.zip_Invalid << 56 ) + ( le.zip4_Invalid << 57 ) + ( le.original_area_code_Invalid << 58 ) + ( le.original_phone_number_Invalid << 59 ) + ( le.phone_extension_Invalid << 60 ) + ( le.primary_phone_indicator_Invalid << 61 ) + ( le.published_unlisted_indicator_Invalid << 62 ) + ( le.phone_type_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.phone_number_Invalid << 0 ) + ( le.federal_taxid_ssn_Invalid << 1 ) + ( le.federal_taxid_ssn_identifier_Invalid << 2 ) + ( le.dotid_Invalid << 3 ) + ( le.dotscore_Invalid << 4 ) + ( le.dotweight_Invalid << 5 ) + ( le.empid_Invalid << 6 ) + ( le.empscore_Invalid << 7 ) + ( le.empweight_Invalid << 8 ) + ( le.powid_Invalid << 9 ) + ( le.powscore_Invalid << 10 ) + ( le.powweight_Invalid << 11 ) + ( le.proxid_Invalid << 12 ) + ( le.proxscore_Invalid << 13 ) + ( le.proxweight_Invalid << 14 ) + ( le.seleid_Invalid << 15 ) + ( le.selescore_Invalid << 16 ) + ( le.seleweight_Invalid << 17 ) + ( le.orgid_Invalid << 18 ) + ( le.orgscore_Invalid << 19 ) + ( le.orgweight_Invalid << 20 ) + ( le.ultid_Invalid << 21 ) + ( le.ultscore_Invalid << 22 ) + ( le.ultweight_Invalid << 23 ) + ( le.sbfe_id_Invalid << 24 ) + ( le.legal_business_structure_Invalid << 25 ) + ( le.business_established_date_Invalid << 26 ) + ( le.account_status_1_Invalid << 28 ) + ( le.account_status_2_Invalid << 29 ) + ( le.date_account_opened_Invalid << 30 ) + ( le.date_account_closed_Invalid << 32 ) + ( le.account_closure_basis_Invalid << 34 ) + ( le.account_expiration_date_Invalid << 35 ) + ( le.last_activity_date_Invalid << 37 ) + ( le.last_activity_type_Invalid << 39 ) + ( le.recent_activity_indicator_Invalid << 40 ) + ( le.original_credit_limit_Invalid << 41 ) + ( le.highest_credit_used_Invalid << 42 ) + ( le.current_credit_limit_Invalid << 43 ) + ( le.reporting_indicator_length_Invalid << 44 ) + ( le.payment_interval_Invalid << 45 ) + ( le.payment_status_category_Invalid << 46 ) + ( le.term_of_account_in_months_Invalid << 47 ) + ( le.first_payment_due_date_Invalid << 48 ) + ( le.final_payment_due_date_Invalid << 50 ) + ( le.original_rate_Invalid << 52 ) + ( le.floating_rate_Invalid << 53 ) + ( le.grace_period_Invalid << 54 ) + ( le.payment_category_Invalid << 55 ) + ( le.payment_history_profile_12_months_Invalid << 56 ) + ( le.payment_history_profile_13_24_months_Invalid << 57 ) + ( le.payment_history_profile_25_36_months_Invalid << 58 ) + ( le.payment_history_profile_37_48_months_Invalid << 59 ) + ( le.payment_history_length_Invalid << 60 ) + ( le.year_to_date_purchases_count_Invalid << 61 ) + ( le.lifetime_to_date_purchases_count_Invalid << 62 ) + ( le.year_to_date_purchases_sum_amount_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.lifetime_to_date_purchases_sum_amount_Invalid << 0 ) + ( le.payment_amount_scheduled_Invalid << 1 ) + ( le.recent_payment_amount_Invalid << 2 ) + ( le.recent_payment_date_Invalid << 3 ) + ( le.remaining_balance_Invalid << 5 ) + ( le.carried_over_amount_Invalid << 6 ) + ( le.new_applied_charges_Invalid << 7 ) + ( le.balloon_payment_due_Invalid << 8 ) + ( le.balloon_payment_due_date_Invalid << 9 ) + ( le.delinquency_date_Invalid << 11 ) + ( le.days_delinquent_Invalid << 13 ) + ( le.past_due_amount_Invalid << 14 ) + ( le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid << 15 ) + ( le.past_due_aging_bucket_type_Invalid << 16 ) + ( le.past_due_aging_amount_bucket_1_Invalid << 17 ) + ( le.past_due_aging_amount_bucket_2_Invalid << 18 ) + ( le.past_due_aging_amount_bucket_3_Invalid << 19 ) + ( le.past_due_aging_amount_bucket_4_Invalid << 20 ) + ( le.past_due_aging_amount_bucket_5_Invalid << 21 ) + ( le.past_due_aging_amount_bucket_6_Invalid << 22 ) + ( le.past_due_aging_amount_bucket_7_Invalid << 23 ) + ( le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid << 24 ) + ( le.payment_tracking_cycle_type_Invalid << 25 ) + ( le.payment_tracking_cycle_0_current_Invalid << 26 ) + ( le.payment_tracking_cycle_1_1_to_30_days_Invalid << 27 ) + ( le.payment_tracking_cycle_2_31_to_60_days_Invalid << 28 ) + ( le.payment_tracking_cycle_3_61_to_90_days_Invalid << 29 ) + ( le.payment_tracking_cycle_4_91_to_120_days_Invalid << 30 ) + ( le.payment_tracking_cycle_5_121_to_150days_Invalid << 31 ) + ( le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid << 32 ) + ( le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid << 33 ) + ( le.date_account_was_charged_off_Invalid << 34 ) + ( le.amount_charged_off_by_creditor_Invalid << 36 ) + ( le.charge_off_type_indicator_Invalid << 37 ) + ( le.total_charge_off_recoveries_to_date_Invalid << 38 ) + ( le.government_guarantee_flag_Invalid << 39 ) + ( le.government_guarantee_category_Invalid << 40 ) + ( le.portion_of_account_guaranteed_by_government_Invalid << 41 ) + ( le.guarantors_indicator_Invalid << 42 ) + ( le.number_of_guarantors_Invalid << 43 ) + ( le.owners_indicator_Invalid << 44 ) + ( le.number_of_principals_Invalid << 45 ) + ( le.account_update_deletion_indicator_Invalid << 46 ) + ( le.percent_of_liability_Invalid << 47 ) + ( le.percent_of_ownership_Invalid << 48 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,LinkID_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dt_datawarehouse_first_reported_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.dt_datawarehouse_last_reported_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sbfe_contributor_number_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.contract_account_number_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.extracted_date_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.cycle_end_date_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.account_holder_business_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.clean_account_holder_business_name_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.clean_dba_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.clean_business_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.company_website_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.original_fname_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.original_mname_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.original_lname_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.original_suffix_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.e_mail_address_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.guarantor_owner_indicator_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.relationship_to_business_indicator_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.business_title_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.clean_title_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.clean_fname_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.clean_mname_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.clean_lname_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_suffix_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.original_address_line_1_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.original_address_line_2_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.original_city_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.original_state_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.original_zip_code_or_ca_postal_code_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.original_postal_code_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.original_country_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.original_area_code_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.original_phone_number_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.phone_extension_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.primary_phone_indicator_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.published_unlisted_indicator_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.federal_taxid_ssn_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.federal_taxid_ssn_identifier_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.empid_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.powid_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.sbfe_id_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.legal_business_structure_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.business_established_date_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.account_status_1_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.account_status_2_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.date_account_opened_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.date_account_closed_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.account_closure_basis_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.account_expiration_date_Invalid := (le.ScrubsBits2 >> 35) & 3;
    SELF.last_activity_date_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.last_activity_type_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.recent_activity_indicator_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.original_credit_limit_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.highest_credit_used_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.current_credit_limit_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.reporting_indicator_length_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.payment_interval_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.payment_status_category_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.term_of_account_in_months_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.first_payment_due_date_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.final_payment_due_date_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.original_rate_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.floating_rate_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.grace_period_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.payment_category_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.payment_history_profile_12_months_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.payment_history_profile_13_24_months_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.payment_history_profile_25_36_months_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.payment_history_profile_37_48_months_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.payment_history_length_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.year_to_date_purchases_count_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.lifetime_to_date_purchases_count_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.year_to_date_purchases_sum_amount_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.lifetime_to_date_purchases_sum_amount_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.payment_amount_scheduled_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.recent_payment_amount_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.recent_payment_date_Invalid := (le.ScrubsBits3 >> 3) & 3;
    SELF.remaining_balance_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.carried_over_amount_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.new_applied_charges_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.balloon_payment_due_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.balloon_payment_due_date_Invalid := (le.ScrubsBits3 >> 9) & 3;
    SELF.delinquency_date_Invalid := (le.ScrubsBits3 >> 11) & 3;
    SELF.days_delinquent_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.past_due_amount_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.past_due_aging_bucket_type_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.past_due_aging_amount_bucket_1_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.past_due_aging_amount_bucket_2_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.past_due_aging_amount_bucket_3_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.past_due_aging_amount_bucket_4_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.past_due_aging_amount_bucket_5_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.past_due_aging_amount_bucket_6_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.past_due_aging_amount_bucket_7_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.payment_tracking_cycle_type_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.payment_tracking_cycle_0_current_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.payment_tracking_cycle_1_1_to_30_days_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.payment_tracking_cycle_2_31_to_60_days_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.payment_tracking_cycle_3_61_to_90_days_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.payment_tracking_cycle_4_91_to_120_days_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.payment_tracking_cycle_5_121_to_150days_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.date_account_was_charged_off_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.amount_charged_off_by_creditor_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.charge_off_type_indicator_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.total_charge_off_recoveries_to_date_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.government_guarantee_flag_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.government_guarantee_category_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.portion_of_account_guaranteed_by_government_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.guarantors_indicator_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.number_of_guarantors_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.owners_indicator_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.number_of_principals_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.account_update_deletion_indicator_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.percent_of_liability_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.percent_of_ownership_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_datawarehouse_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_datawarehouse_first_reported_Invalid=1);
    dt_datawarehouse_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_datawarehouse_last_reported_Invalid=1);
    sbfe_contributor_number_ALLOW_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=1);
    sbfe_contributor_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=2);
    sbfe_contributor_number_LENGTH_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=3);
    sbfe_contributor_number_Total_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid>0);
    contract_account_number_ALLOW_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid=1);
    contract_account_number_LENGTH_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid=2);
    contract_account_number_Total_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid>0);
    extracted_date_ALLOW_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=1);
    extracted_date_CUSTOM_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=2);
    extracted_date_LENGTH_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=3);
    extracted_date_Total_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid>0);
    cycle_end_date_ALLOW_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=1);
    cycle_end_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=2);
    cycle_end_date_LENGTH_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=3);
    cycle_end_date_Total_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid>0);
    account_holder_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.account_holder_business_name_Invalid=1);
    clean_account_holder_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_account_holder_business_name_Invalid=1);
    dba_ALLOW_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    clean_dba_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dba_Invalid=1);
    business_name_ALLOW_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    clean_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_business_name_Invalid=1);
    company_website_ALLOW_ErrorCount := COUNT(GROUP,h.company_website_Invalid=1);
    original_fname_ALLOW_ErrorCount := COUNT(GROUP,h.original_fname_Invalid=1);
    original_mname_ALLOW_ErrorCount := COUNT(GROUP,h.original_mname_Invalid=1);
    original_lname_ALLOW_ErrorCount := COUNT(GROUP,h.original_lname_Invalid=1);
    original_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.original_suffix_Invalid=1);
    e_mail_address_ALLOW_ErrorCount := COUNT(GROUP,h.e_mail_address_Invalid=1);
    guarantor_owner_indicator_ENUM_ErrorCount := COUNT(GROUP,h.guarantor_owner_indicator_Invalid=1);
    relationship_to_business_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.relationship_to_business_indicator_Invalid=1);
    business_title_ALLOW_ErrorCount := COUNT(GROUP,h.business_title_Invalid=1);
    clean_title_ALLOW_ErrorCount := COUNT(GROUP,h.clean_title_Invalid=1);
    clean_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=1);
    clean_mname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_mname_Invalid=1);
    clean_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_lname_Invalid=1);
    clean_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_suffix_Invalid=1);
    original_address_line_1_ALLOW_ErrorCount := COUNT(GROUP,h.original_address_line_1_Invalid=1);
    original_address_line_2_ALLOW_ErrorCount := COUNT(GROUP,h.original_address_line_2_Invalid=1);
    original_city_ALLOW_ErrorCount := COUNT(GROUP,h.original_city_Invalid=1);
    original_state_ALLOW_ErrorCount := COUNT(GROUP,h.original_state_Invalid=1);
    original_zip_code_or_ca_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.original_zip_code_or_ca_postal_code_Invalid=1);
    original_postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.original_postal_code_Invalid=1);
    original_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.original_country_code_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    original_area_code_ALLOW_ErrorCount := COUNT(GROUP,h.original_area_code_Invalid=1);
    original_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.original_phone_number_Invalid=1);
    phone_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_extension_Invalid=1);
    primary_phone_indicator_ENUM_ErrorCount := COUNT(GROUP,h.primary_phone_indicator_Invalid=1);
    published_unlisted_indicator_ENUM_ErrorCount := COUNT(GROUP,h.published_unlisted_indicator_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    federal_taxid_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.federal_taxid_ssn_Invalid=1);
    federal_taxid_ssn_identifier_ENUM_ErrorCount := COUNT(GROUP,h.federal_taxid_ssn_identifier_Invalid=1);
    dotid_ALLOW_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ALLOW_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ALLOW_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ALLOW_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ALLOW_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ALLOW_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_ALLOW_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_ALLOW_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_ALLOW_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_ALLOW_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_ALLOW_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_ALLOW_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_ALLOW_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_ALLOW_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_ALLOW_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_ALLOW_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_ALLOW_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_ALLOW_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    sbfe_id_ALLOW_ErrorCount := COUNT(GROUP,h.sbfe_id_Invalid=1);
    legal_business_structure_ENUM_ErrorCount := COUNT(GROUP,h.legal_business_structure_Invalid=1);
    business_established_date_ALLOW_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid=1);
    business_established_date_LENGTH_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid=2);
    business_established_date_Total_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid>0);
    account_status_1_ENUM_ErrorCount := COUNT(GROUP,h.account_status_1_Invalid=1);
    account_status_2_ENUM_ErrorCount := COUNT(GROUP,h.account_status_2_Invalid=1);
    date_account_opened_ALLOW_ErrorCount := COUNT(GROUP,h.date_account_opened_Invalid=1);
    date_account_opened_CUSTOM_ErrorCount := COUNT(GROUP,h.date_account_opened_Invalid=2);
    date_account_opened_LENGTH_ErrorCount := COUNT(GROUP,h.date_account_opened_Invalid=3);
    date_account_opened_Total_ErrorCount := COUNT(GROUP,h.date_account_opened_Invalid>0);
    date_account_closed_ALLOW_ErrorCount := COUNT(GROUP,h.date_account_closed_Invalid=1);
    date_account_closed_CUSTOM_ErrorCount := COUNT(GROUP,h.date_account_closed_Invalid=2);
    date_account_closed_LENGTH_ErrorCount := COUNT(GROUP,h.date_account_closed_Invalid=3);
    date_account_closed_Total_ErrorCount := COUNT(GROUP,h.date_account_closed_Invalid>0);
    account_closure_basis_ENUM_ErrorCount := COUNT(GROUP,h.account_closure_basis_Invalid=1);
    account_expiration_date_ALLOW_ErrorCount := COUNT(GROUP,h.account_expiration_date_Invalid=1);
    account_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.account_expiration_date_Invalid=2);
    account_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.account_expiration_date_Invalid=3);
    account_expiration_date_Total_ErrorCount := COUNT(GROUP,h.account_expiration_date_Invalid>0);
    last_activity_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_activity_date_Invalid=1);
    last_activity_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_activity_date_Invalid=2);
    last_activity_date_LENGTH_ErrorCount := COUNT(GROUP,h.last_activity_date_Invalid=3);
    last_activity_date_Total_ErrorCount := COUNT(GROUP,h.last_activity_date_Invalid>0);
    last_activity_type_ALLOW_ErrorCount := COUNT(GROUP,h.last_activity_type_Invalid=1);
    recent_activity_indicator_ENUM_ErrorCount := COUNT(GROUP,h.recent_activity_indicator_Invalid=1);
    original_credit_limit_ALLOW_ErrorCount := COUNT(GROUP,h.original_credit_limit_Invalid=1);
    highest_credit_used_ALLOW_ErrorCount := COUNT(GROUP,h.highest_credit_used_Invalid=1);
    current_credit_limit_ALLOW_ErrorCount := COUNT(GROUP,h.current_credit_limit_Invalid=1);
    reporting_indicator_length_ENUM_ErrorCount := COUNT(GROUP,h.reporting_indicator_length_Invalid=1);
    payment_interval_ENUM_ErrorCount := COUNT(GROUP,h.payment_interval_Invalid=1);
    payment_status_category_ENUM_ErrorCount := COUNT(GROUP,h.payment_status_category_Invalid=1);
    term_of_account_in_months_ALLOW_ErrorCount := COUNT(GROUP,h.term_of_account_in_months_Invalid=1);
    first_payment_due_date_ALLOW_ErrorCount := COUNT(GROUP,h.first_payment_due_date_Invalid=1);
    first_payment_due_date_CUSTOM_ErrorCount := COUNT(GROUP,h.first_payment_due_date_Invalid=2);
    first_payment_due_date_LENGTH_ErrorCount := COUNT(GROUP,h.first_payment_due_date_Invalid=3);
    first_payment_due_date_Total_ErrorCount := COUNT(GROUP,h.first_payment_due_date_Invalid>0);
    final_payment_due_date_ALLOW_ErrorCount := COUNT(GROUP,h.final_payment_due_date_Invalid=1);
    final_payment_due_date_CUSTOM_ErrorCount := COUNT(GROUP,h.final_payment_due_date_Invalid=2);
    final_payment_due_date_LENGTH_ErrorCount := COUNT(GROUP,h.final_payment_due_date_Invalid=3);
    final_payment_due_date_Total_ErrorCount := COUNT(GROUP,h.final_payment_due_date_Invalid>0);
    original_rate_ALLOW_ErrorCount := COUNT(GROUP,h.original_rate_Invalid=1);
    floating_rate_ALLOW_ErrorCount := COUNT(GROUP,h.floating_rate_Invalid=1);
    grace_period_ALLOW_ErrorCount := COUNT(GROUP,h.grace_period_Invalid=1);
    payment_category_ENUM_ErrorCount := COUNT(GROUP,h.payment_category_Invalid=1);
    payment_history_profile_12_months_ALLOW_ErrorCount := COUNT(GROUP,h.payment_history_profile_12_months_Invalid=1);
    payment_history_profile_13_24_months_ALLOW_ErrorCount := COUNT(GROUP,h.payment_history_profile_13_24_months_Invalid=1);
    payment_history_profile_25_36_months_ALLOW_ErrorCount := COUNT(GROUP,h.payment_history_profile_25_36_months_Invalid=1);
    payment_history_profile_37_48_months_ALLOW_ErrorCount := COUNT(GROUP,h.payment_history_profile_37_48_months_Invalid=1);
    payment_history_length_ALLOW_ErrorCount := COUNT(GROUP,h.payment_history_length_Invalid=1);
    year_to_date_purchases_count_ALLOW_ErrorCount := COUNT(GROUP,h.year_to_date_purchases_count_Invalid=1);
    lifetime_to_date_purchases_count_ALLOW_ErrorCount := COUNT(GROUP,h.lifetime_to_date_purchases_count_Invalid=1);
    year_to_date_purchases_sum_amount_ALLOW_ErrorCount := COUNT(GROUP,h.year_to_date_purchases_sum_amount_Invalid=1);
    lifetime_to_date_purchases_sum_amount_ALLOW_ErrorCount := COUNT(GROUP,h.lifetime_to_date_purchases_sum_amount_Invalid=1);
    payment_amount_scheduled_ALLOW_ErrorCount := COUNT(GROUP,h.payment_amount_scheduled_Invalid=1);
    recent_payment_amount_ALLOW_ErrorCount := COUNT(GROUP,h.recent_payment_amount_Invalid=1);
    recent_payment_date_ALLOW_ErrorCount := COUNT(GROUP,h.recent_payment_date_Invalid=1);
    recent_payment_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_payment_date_Invalid=2);
    recent_payment_date_LENGTH_ErrorCount := COUNT(GROUP,h.recent_payment_date_Invalid=3);
    recent_payment_date_Total_ErrorCount := COUNT(GROUP,h.recent_payment_date_Invalid>0);
    remaining_balance_ALLOW_ErrorCount := COUNT(GROUP,h.remaining_balance_Invalid=1);
    carried_over_amount_ALLOW_ErrorCount := COUNT(GROUP,h.carried_over_amount_Invalid=1);
    new_applied_charges_ALLOW_ErrorCount := COUNT(GROUP,h.new_applied_charges_Invalid=1);
    balloon_payment_due_ALLOW_ErrorCount := COUNT(GROUP,h.balloon_payment_due_Invalid=1);
    balloon_payment_due_date_ALLOW_ErrorCount := COUNT(GROUP,h.balloon_payment_due_date_Invalid=1);
    balloon_payment_due_date_CUSTOM_ErrorCount := COUNT(GROUP,h.balloon_payment_due_date_Invalid=2);
    balloon_payment_due_date_LENGTH_ErrorCount := COUNT(GROUP,h.balloon_payment_due_date_Invalid=3);
    balloon_payment_due_date_Total_ErrorCount := COUNT(GROUP,h.balloon_payment_due_date_Invalid>0);
    delinquency_date_ALLOW_ErrorCount := COUNT(GROUP,h.delinquency_date_Invalid=1);
    delinquency_date_CUSTOM_ErrorCount := COUNT(GROUP,h.delinquency_date_Invalid=2);
    delinquency_date_LENGTH_ErrorCount := COUNT(GROUP,h.delinquency_date_Invalid=3);
    delinquency_date_Total_ErrorCount := COUNT(GROUP,h.delinquency_date_Invalid>0);
    days_delinquent_ALLOW_ErrorCount := COUNT(GROUP,h.days_delinquent_Invalid=1);
    past_due_amount_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_amount_Invalid=1);
    maximum_number_of_past_due_aging_amounts_buckets_provided_ENUM_ErrorCount := COUNT(GROUP,h.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid=1);
    past_due_aging_bucket_type_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_bucket_type_Invalid=1);
    past_due_aging_amount_bucket_1_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_1_Invalid=1);
    past_due_aging_amount_bucket_2_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_2_Invalid=1);
    past_due_aging_amount_bucket_3_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_3_Invalid=1);
    past_due_aging_amount_bucket_4_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_4_Invalid=1);
    past_due_aging_amount_bucket_5_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_5_Invalid=1);
    past_due_aging_amount_bucket_6_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_6_Invalid=1);
    past_due_aging_amount_bucket_7_ALLOW_ErrorCount := COUNT(GROUP,h.past_due_aging_amount_bucket_7_Invalid=1);
    maximum_number_of_payment_tracking_cycle_periods_provided_ENUM_ErrorCount := COUNT(GROUP,h.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid=1);
    payment_tracking_cycle_type_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_type_Invalid=1);
    payment_tracking_cycle_0_current_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_0_current_Invalid=1);
    payment_tracking_cycle_1_1_to_30_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_1_1_to_30_days_Invalid=1);
    payment_tracking_cycle_2_31_to_60_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_2_31_to_60_days_Invalid=1);
    payment_tracking_cycle_3_61_to_90_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_3_61_to_90_days_Invalid=1);
    payment_tracking_cycle_4_91_to_120_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_4_91_to_120_days_Invalid=1);
    payment_tracking_cycle_5_121_to_150days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_cycle_5_121_to_150days_Invalid=1);
    payment_tracking_number_of_times_cycle_6_151_to_180_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid=1);
    payment_tracking_number_of_times_cycle_7_181_or_greater_days_ALLOW_ErrorCount := COUNT(GROUP,h.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid=1);
    date_account_was_charged_off_ALLOW_ErrorCount := COUNT(GROUP,h.date_account_was_charged_off_Invalid=1);
    date_account_was_charged_off_CUSTOM_ErrorCount := COUNT(GROUP,h.date_account_was_charged_off_Invalid=2);
    date_account_was_charged_off_LENGTH_ErrorCount := COUNT(GROUP,h.date_account_was_charged_off_Invalid=3);
    date_account_was_charged_off_Total_ErrorCount := COUNT(GROUP,h.date_account_was_charged_off_Invalid>0);
    amount_charged_off_by_creditor_ALLOW_ErrorCount := COUNT(GROUP,h.amount_charged_off_by_creditor_Invalid=1);
    charge_off_type_indicator_ENUM_ErrorCount := COUNT(GROUP,h.charge_off_type_indicator_Invalid=1);
    total_charge_off_recoveries_to_date_ALLOW_ErrorCount := COUNT(GROUP,h.total_charge_off_recoveries_to_date_Invalid=1);
    government_guarantee_flag_ENUM_ErrorCount := COUNT(GROUP,h.government_guarantee_flag_Invalid=1);
    government_guarantee_category_ENUM_ErrorCount := COUNT(GROUP,h.government_guarantee_category_Invalid=1);
    portion_of_account_guaranteed_by_government_ALLOW_ErrorCount := COUNT(GROUP,h.portion_of_account_guaranteed_by_government_Invalid=1);
    guarantors_indicator_ENUM_ErrorCount := COUNT(GROUP,h.guarantors_indicator_Invalid=1);
    number_of_guarantors_ALLOW_ErrorCount := COUNT(GROUP,h.number_of_guarantors_Invalid=1);
    owners_indicator_ENUM_ErrorCount := COUNT(GROUP,h.owners_indicator_Invalid=1);
    number_of_principals_ALLOW_ErrorCount := COUNT(GROUP,h.number_of_principals_Invalid=1);
    account_update_deletion_indicator_ENUM_ErrorCount := COUNT(GROUP,h.account_update_deletion_indicator_Invalid=1);
    percent_of_liability_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_liability_Invalid=1);
    percent_of_ownership_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_ownership_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.timestamp_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.did_Invalid,le.did_score_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_datawarehouse_first_reported_Invalid,le.dt_datawarehouse_last_reported_Invalid,le.sbfe_contributor_number_Invalid,le.contract_account_number_Invalid,le.extracted_date_Invalid,le.cycle_end_date_Invalid,le.account_holder_business_name_Invalid,le.clean_account_holder_business_name_Invalid,le.dba_Invalid,le.clean_dba_Invalid,le.business_name_Invalid,le.clean_business_name_Invalid,le.company_website_Invalid,le.original_fname_Invalid,le.original_mname_Invalid,le.original_lname_Invalid,le.original_suffix_Invalid,le.e_mail_address_Invalid,le.guarantor_owner_indicator_Invalid,le.relationship_to_business_indicator_Invalid,le.business_title_Invalid,le.clean_title_Invalid,le.clean_fname_Invalid,le.clean_mname_Invalid,le.clean_lname_Invalid,le.clean_suffix_Invalid,le.original_address_line_1_Invalid,le.original_address_line_2_Invalid,le.original_city_Invalid,le.original_state_Invalid,le.original_zip_code_or_ca_postal_code_Invalid,le.original_postal_code_Invalid,le.original_country_code_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.original_area_code_Invalid,le.original_phone_number_Invalid,le.phone_extension_Invalid,le.primary_phone_indicator_Invalid,le.published_unlisted_indicator_Invalid,le.phone_type_Invalid,le.phone_number_Invalid,le.federal_taxid_ssn_Invalid,le.federal_taxid_ssn_identifier_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.sbfe_id_Invalid,le.legal_business_structure_Invalid,le.business_established_date_Invalid,le.account_status_1_Invalid,le.account_status_2_Invalid,le.date_account_opened_Invalid,le.date_account_closed_Invalid,le.account_closure_basis_Invalid,le.account_expiration_date_Invalid,le.last_activity_date_Invalid,le.last_activity_type_Invalid,le.recent_activity_indicator_Invalid,le.original_credit_limit_Invalid,le.highest_credit_used_Invalid,le.current_credit_limit_Invalid,le.reporting_indicator_length_Invalid,le.payment_interval_Invalid,le.payment_status_category_Invalid,le.term_of_account_in_months_Invalid,le.first_payment_due_date_Invalid,le.final_payment_due_date_Invalid,le.original_rate_Invalid,le.floating_rate_Invalid,le.grace_period_Invalid,le.payment_category_Invalid,le.payment_history_profile_12_months_Invalid,le.payment_history_profile_13_24_months_Invalid,le.payment_history_profile_25_36_months_Invalid,le.payment_history_profile_37_48_months_Invalid,le.payment_history_length_Invalid,le.year_to_date_purchases_count_Invalid,le.lifetime_to_date_purchases_count_Invalid,le.year_to_date_purchases_sum_amount_Invalid,le.lifetime_to_date_purchases_sum_amount_Invalid,le.payment_amount_scheduled_Invalid,le.recent_payment_amount_Invalid,le.recent_payment_date_Invalid,le.remaining_balance_Invalid,le.carried_over_amount_Invalid,le.new_applied_charges_Invalid,le.balloon_payment_due_Invalid,le.balloon_payment_due_date_Invalid,le.delinquency_date_Invalid,le.days_delinquent_Invalid,le.past_due_amount_Invalid,le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid,le.past_due_aging_bucket_type_Invalid,le.past_due_aging_amount_bucket_1_Invalid,le.past_due_aging_amount_bucket_2_Invalid,le.past_due_aging_amount_bucket_3_Invalid,le.past_due_aging_amount_bucket_4_Invalid,le.past_due_aging_amount_bucket_5_Invalid,le.past_due_aging_amount_bucket_6_Invalid,le.past_due_aging_amount_bucket_7_Invalid,le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid,le.payment_tracking_cycle_type_Invalid,le.payment_tracking_cycle_0_current_Invalid,le.payment_tracking_cycle_1_1_to_30_days_Invalid,le.payment_tracking_cycle_2_31_to_60_days_Invalid,le.payment_tracking_cycle_3_61_to_90_days_Invalid,le.payment_tracking_cycle_4_91_to_120_days_Invalid,le.payment_tracking_cycle_5_121_to_150days_Invalid,le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid,le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid,le.date_account_was_charged_off_Invalid,le.amount_charged_off_by_creditor_Invalid,le.charge_off_type_indicator_Invalid,le.total_charge_off_recoveries_to_date_Invalid,le.government_guarantee_flag_Invalid,le.government_guarantee_category_Invalid,le.portion_of_account_guaranteed_by_government_Invalid,le.guarantors_indicator_Invalid,le.number_of_guarantors_Invalid,le.owners_indicator_Invalid,le.number_of_principals_Invalid,le.account_update_deletion_indicator_Invalid,le.percent_of_liability_Invalid,le.percent_of_ownership_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,LinkID_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),LinkID_Fields.InvalidMessage_process_date(le.process_date_Invalid),LinkID_Fields.InvalidMessage_record_type(le.record_type_Invalid),LinkID_Fields.InvalidMessage_did(le.did_Invalid),LinkID_Fields.InvalidMessage_did_score(le.did_score_Invalid),LinkID_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),LinkID_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),LinkID_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),LinkID_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),LinkID_Fields.InvalidMessage_dt_datawarehouse_first_reported(le.dt_datawarehouse_first_reported_Invalid),LinkID_Fields.InvalidMessage_dt_datawarehouse_last_reported(le.dt_datawarehouse_last_reported_Invalid),LinkID_Fields.InvalidMessage_sbfe_contributor_number(le.sbfe_contributor_number_Invalid),LinkID_Fields.InvalidMessage_contract_account_number(le.contract_account_number_Invalid),LinkID_Fields.InvalidMessage_extracted_date(le.extracted_date_Invalid),LinkID_Fields.InvalidMessage_cycle_end_date(le.cycle_end_date_Invalid),LinkID_Fields.InvalidMessage_account_holder_business_name(le.account_holder_business_name_Invalid),LinkID_Fields.InvalidMessage_clean_account_holder_business_name(le.clean_account_holder_business_name_Invalid),LinkID_Fields.InvalidMessage_dba(le.dba_Invalid),LinkID_Fields.InvalidMessage_clean_dba(le.clean_dba_Invalid),LinkID_Fields.InvalidMessage_business_name(le.business_name_Invalid),LinkID_Fields.InvalidMessage_clean_business_name(le.clean_business_name_Invalid),LinkID_Fields.InvalidMessage_company_website(le.company_website_Invalid),LinkID_Fields.InvalidMessage_original_fname(le.original_fname_Invalid),LinkID_Fields.InvalidMessage_original_mname(le.original_mname_Invalid),LinkID_Fields.InvalidMessage_original_lname(le.original_lname_Invalid),LinkID_Fields.InvalidMessage_original_suffix(le.original_suffix_Invalid),LinkID_Fields.InvalidMessage_e_mail_address(le.e_mail_address_Invalid),LinkID_Fields.InvalidMessage_guarantor_owner_indicator(le.guarantor_owner_indicator_Invalid),LinkID_Fields.InvalidMessage_relationship_to_business_indicator(le.relationship_to_business_indicator_Invalid),LinkID_Fields.InvalidMessage_business_title(le.business_title_Invalid),LinkID_Fields.InvalidMessage_clean_title(le.clean_title_Invalid),LinkID_Fields.InvalidMessage_clean_fname(le.clean_fname_Invalid),LinkID_Fields.InvalidMessage_clean_mname(le.clean_mname_Invalid),LinkID_Fields.InvalidMessage_clean_lname(le.clean_lname_Invalid),LinkID_Fields.InvalidMessage_clean_suffix(le.clean_suffix_Invalid),LinkID_Fields.InvalidMessage_original_address_line_1(le.original_address_line_1_Invalid),LinkID_Fields.InvalidMessage_original_address_line_2(le.original_address_line_2_Invalid),LinkID_Fields.InvalidMessage_original_city(le.original_city_Invalid),LinkID_Fields.InvalidMessage_original_state(le.original_state_Invalid),LinkID_Fields.InvalidMessage_original_zip_code_or_ca_postal_code(le.original_zip_code_or_ca_postal_code_Invalid),LinkID_Fields.InvalidMessage_original_postal_code(le.original_postal_code_Invalid),LinkID_Fields.InvalidMessage_original_country_code(le.original_country_code_Invalid),LinkID_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),LinkID_Fields.InvalidMessage_predir(le.predir_Invalid),LinkID_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),LinkID_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),LinkID_Fields.InvalidMessage_postdir(le.postdir_Invalid),LinkID_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),LinkID_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),LinkID_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),LinkID_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),LinkID_Fields.InvalidMessage_st(le.st_Invalid),LinkID_Fields.InvalidMessage_zip(le.zip_Invalid),LinkID_Fields.InvalidMessage_zip4(le.zip4_Invalid),LinkID_Fields.InvalidMessage_original_area_code(le.original_area_code_Invalid),LinkID_Fields.InvalidMessage_original_phone_number(le.original_phone_number_Invalid),LinkID_Fields.InvalidMessage_phone_extension(le.phone_extension_Invalid),LinkID_Fields.InvalidMessage_primary_phone_indicator(le.primary_phone_indicator_Invalid),LinkID_Fields.InvalidMessage_published_unlisted_indicator(le.published_unlisted_indicator_Invalid),LinkID_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),LinkID_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),LinkID_Fields.InvalidMessage_federal_taxid_ssn(le.federal_taxid_ssn_Invalid),LinkID_Fields.InvalidMessage_federal_taxid_ssn_identifier(le.federal_taxid_ssn_identifier_Invalid),LinkID_Fields.InvalidMessage_dotid(le.dotid_Invalid),LinkID_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),LinkID_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),LinkID_Fields.InvalidMessage_empid(le.empid_Invalid),LinkID_Fields.InvalidMessage_empscore(le.empscore_Invalid),LinkID_Fields.InvalidMessage_empweight(le.empweight_Invalid),LinkID_Fields.InvalidMessage_powid(le.powid_Invalid),LinkID_Fields.InvalidMessage_powscore(le.powscore_Invalid),LinkID_Fields.InvalidMessage_powweight(le.powweight_Invalid),LinkID_Fields.InvalidMessage_proxid(le.proxid_Invalid),LinkID_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),LinkID_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),LinkID_Fields.InvalidMessage_seleid(le.seleid_Invalid),LinkID_Fields.InvalidMessage_selescore(le.selescore_Invalid),LinkID_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),LinkID_Fields.InvalidMessage_orgid(le.orgid_Invalid),LinkID_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),LinkID_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),LinkID_Fields.InvalidMessage_ultid(le.ultid_Invalid),LinkID_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),LinkID_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),LinkID_Fields.InvalidMessage_sbfe_id(le.sbfe_id_Invalid),LinkID_Fields.InvalidMessage_legal_business_structure(le.legal_business_structure_Invalid),LinkID_Fields.InvalidMessage_business_established_date(le.business_established_date_Invalid),LinkID_Fields.InvalidMessage_account_status_1(le.account_status_1_Invalid),LinkID_Fields.InvalidMessage_account_status_2(le.account_status_2_Invalid),LinkID_Fields.InvalidMessage_date_account_opened(le.date_account_opened_Invalid),LinkID_Fields.InvalidMessage_date_account_closed(le.date_account_closed_Invalid),LinkID_Fields.InvalidMessage_account_closure_basis(le.account_closure_basis_Invalid),LinkID_Fields.InvalidMessage_account_expiration_date(le.account_expiration_date_Invalid),LinkID_Fields.InvalidMessage_last_activity_date(le.last_activity_date_Invalid),LinkID_Fields.InvalidMessage_last_activity_type(le.last_activity_type_Invalid),LinkID_Fields.InvalidMessage_recent_activity_indicator(le.recent_activity_indicator_Invalid),LinkID_Fields.InvalidMessage_original_credit_limit(le.original_credit_limit_Invalid),LinkID_Fields.InvalidMessage_highest_credit_used(le.highest_credit_used_Invalid),LinkID_Fields.InvalidMessage_current_credit_limit(le.current_credit_limit_Invalid),LinkID_Fields.InvalidMessage_reporting_indicator_length(le.reporting_indicator_length_Invalid),LinkID_Fields.InvalidMessage_payment_interval(le.payment_interval_Invalid),LinkID_Fields.InvalidMessage_payment_status_category(le.payment_status_category_Invalid),LinkID_Fields.InvalidMessage_term_of_account_in_months(le.term_of_account_in_months_Invalid),LinkID_Fields.InvalidMessage_first_payment_due_date(le.first_payment_due_date_Invalid),LinkID_Fields.InvalidMessage_final_payment_due_date(le.final_payment_due_date_Invalid),LinkID_Fields.InvalidMessage_original_rate(le.original_rate_Invalid),LinkID_Fields.InvalidMessage_floating_rate(le.floating_rate_Invalid),LinkID_Fields.InvalidMessage_grace_period(le.grace_period_Invalid),LinkID_Fields.InvalidMessage_payment_category(le.payment_category_Invalid),LinkID_Fields.InvalidMessage_payment_history_profile_12_months(le.payment_history_profile_12_months_Invalid),LinkID_Fields.InvalidMessage_payment_history_profile_13_24_months(le.payment_history_profile_13_24_months_Invalid),LinkID_Fields.InvalidMessage_payment_history_profile_25_36_months(le.payment_history_profile_25_36_months_Invalid),LinkID_Fields.InvalidMessage_payment_history_profile_37_48_months(le.payment_history_profile_37_48_months_Invalid),LinkID_Fields.InvalidMessage_payment_history_length(le.payment_history_length_Invalid),LinkID_Fields.InvalidMessage_year_to_date_purchases_count(le.year_to_date_purchases_count_Invalid),LinkID_Fields.InvalidMessage_lifetime_to_date_purchases_count(le.lifetime_to_date_purchases_count_Invalid),LinkID_Fields.InvalidMessage_year_to_date_purchases_sum_amount(le.year_to_date_purchases_sum_amount_Invalid),LinkID_Fields.InvalidMessage_lifetime_to_date_purchases_sum_amount(le.lifetime_to_date_purchases_sum_amount_Invalid),LinkID_Fields.InvalidMessage_payment_amount_scheduled(le.payment_amount_scheduled_Invalid),LinkID_Fields.InvalidMessage_recent_payment_amount(le.recent_payment_amount_Invalid),LinkID_Fields.InvalidMessage_recent_payment_date(le.recent_payment_date_Invalid),LinkID_Fields.InvalidMessage_remaining_balance(le.remaining_balance_Invalid),LinkID_Fields.InvalidMessage_carried_over_amount(le.carried_over_amount_Invalid),LinkID_Fields.InvalidMessage_new_applied_charges(le.new_applied_charges_Invalid),LinkID_Fields.InvalidMessage_balloon_payment_due(le.balloon_payment_due_Invalid),LinkID_Fields.InvalidMessage_balloon_payment_due_date(le.balloon_payment_due_date_Invalid),LinkID_Fields.InvalidMessage_delinquency_date(le.delinquency_date_Invalid),LinkID_Fields.InvalidMessage_days_delinquent(le.days_delinquent_Invalid),LinkID_Fields.InvalidMessage_past_due_amount(le.past_due_amount_Invalid),LinkID_Fields.InvalidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_bucket_type(le.past_due_aging_bucket_type_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_1(le.past_due_aging_amount_bucket_1_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_2(le.past_due_aging_amount_bucket_2_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_3(le.past_due_aging_amount_bucket_3_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_4(le.past_due_aging_amount_bucket_4_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_5(le.past_due_aging_amount_bucket_5_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_6(le.past_due_aging_amount_bucket_6_Invalid),LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_7(le.past_due_aging_amount_bucket_7_Invalid),LinkID_Fields.InvalidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_type(le.payment_tracking_cycle_type_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_0_current(le.payment_tracking_cycle_0_current_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_1_1_to_30_days(le.payment_tracking_cycle_1_1_to_30_days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_2_31_to_60_days(le.payment_tracking_cycle_2_31_to_60_days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_3_61_to_90_days(le.payment_tracking_cycle_3_61_to_90_days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_4_91_to_120_days(le.payment_tracking_cycle_4_91_to_120_days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_cycle_5_121_to_150days(le.payment_tracking_cycle_5_121_to_150days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid),LinkID_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid),LinkID_Fields.InvalidMessage_date_account_was_charged_off(le.date_account_was_charged_off_Invalid),LinkID_Fields.InvalidMessage_amount_charged_off_by_creditor(le.amount_charged_off_by_creditor_Invalid),LinkID_Fields.InvalidMessage_charge_off_type_indicator(le.charge_off_type_indicator_Invalid),LinkID_Fields.InvalidMessage_total_charge_off_recoveries_to_date(le.total_charge_off_recoveries_to_date_Invalid),LinkID_Fields.InvalidMessage_government_guarantee_flag(le.government_guarantee_flag_Invalid),LinkID_Fields.InvalidMessage_government_guarantee_category(le.government_guarantee_category_Invalid),LinkID_Fields.InvalidMessage_portion_of_account_guaranteed_by_government(le.portion_of_account_guaranteed_by_government_Invalid),LinkID_Fields.InvalidMessage_guarantors_indicator(le.guarantors_indicator_Invalid),LinkID_Fields.InvalidMessage_number_of_guarantors(le.number_of_guarantors_Invalid),LinkID_Fields.InvalidMessage_owners_indicator(le.owners_indicator_Invalid),LinkID_Fields.InvalidMessage_number_of_principals(le.number_of_principals_Invalid),LinkID_Fields.InvalidMessage_account_update_deletion_indicator(le.account_update_deletion_indicator_Invalid),LinkID_Fields.InvalidMessage_percent_of_liability(le.percent_of_liability_Invalid),LinkID_Fields.InvalidMessage_percent_of_ownership(le.percent_of_ownership_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_datawarehouse_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_datawarehouse_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sbfe_contributor_number_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.contract_account_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.extracted_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cycle_end_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_holder_business_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_account_holder_business_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_business_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.e_mail_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.guarantor_owner_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.relationship_to_business_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_address_line_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_address_line_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_zip_code_or_ca_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_area_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary_phone_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.published_unlisted_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.federal_taxid_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.federal_taxid_ssn_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sbfe_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.legal_business_structure_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.business_established_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_status_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.account_status_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_account_opened_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_account_closed_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_closure_basis_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.account_expiration_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_activity_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_activity_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recent_activity_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.original_credit_limit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.highest_credit_used_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.current_credit_limit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reporting_indicator_length_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.payment_interval_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.payment_status_category_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.term_of_account_in_months_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_payment_due_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.final_payment_due_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_rate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.floating_rate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.grace_period_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_category_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.payment_history_profile_12_months_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_history_profile_13_24_months_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_history_profile_25_36_months_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_history_profile_37_48_months_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_history_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_to_date_purchases_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lifetime_to_date_purchases_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_to_date_purchases_sum_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lifetime_to_date_purchases_sum_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_amount_scheduled_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recent_payment_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recent_payment_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.remaining_balance_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carried_over_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.new_applied_charges_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.balloon_payment_due_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.balloon_payment_due_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.delinquency_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.days_delinquent_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.past_due_aging_bucket_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.past_due_aging_amount_bucket_7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_0_current_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_1_1_to_30_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_2_31_to_60_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_3_61_to_90_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_4_91_to_120_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_cycle_5_121_to_150days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_account_was_charged_off_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.amount_charged_off_by_creditor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.charge_off_type_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.total_charge_off_recoveries_to_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.government_guarantee_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.government_guarantee_category_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.portion_of_account_guaranteed_by_government_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.guarantors_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.number_of_guarantors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.owners_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.number_of_principals_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.account_update_deletion_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.percent_of_liability_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.percent_of_ownership_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'timestamp','process_date','record_type','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_datawarehouse_first_reported','dt_datawarehouse_last_reported','sbfe_contributor_number','contract_account_number','extracted_date','cycle_end_date','account_holder_business_name','clean_account_holder_business_name','dba','clean_dba','business_name','clean_business_name','company_website','original_fname','original_mname','original_lname','original_suffix','e_mail_address','guarantor_owner_indicator','relationship_to_business_indicator','business_title','clean_title','clean_fname','clean_mname','clean_lname','clean_suffix','original_address_line_1','original_address_line_2','original_city','original_state','original_zip_code_or_ca_postal_code','original_postal_code','original_country_code','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','original_area_code','original_phone_number','phone_extension','primary_phone_indicator','published_unlisted_indicator','phone_type','phone_number','federal_taxid_ssn','federal_taxid_ssn_identifier','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','sbfe_id','legal_business_structure','business_established_date','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator','percent_of_liability','percent_of_ownership','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_timestamp','invalid_process_date','invalid_invalid_record_type','invalid_did','invalid_did_score','invalid_dt_first_seen','invalid_dt_last_seen','invalid_dt_vendor_first_reported','invalid_dt_vendor_last_reported','invalid_dt_datawarehouse_first_reported','invalid_dt_datawarehouse_last_reported','invalid_sbfe_contributor_num','invalid_contractacc_num','invalid_extracted_date','invalid_cycleend_date','invalid_accholder_businessname','invalid_cln_accholder_businessname','invalid_dba','invalid_cln_dba','invalid_business_name','invalid_cln_business_name','invalid_comp_website','invalid_first_name','invalid_middle_name','invalid_last_name','invalid_suffix','invalid_e_mail_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_business_title','invalid_cln_title','invalid_cln_fname','invalid_cln_mname','invalid_cln_lname','invalid_cln_suffix','invalid_orig_address_line_1','invalid_orig_address_line_2','invalid_orig_city','invalid_orig_state','invalid_orig_zip_code_or_ca_postal_code','invalid_orig_postal_code','invalid_orig_country_code','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_addr_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_p_city_name','invalid_v_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_orig_area_code','invalid_orig_telephone_number','invalid_telephone_extension','invalid_primary_telephone_indicator','invalid_published_unlisted_indicator','invalid_phonetype','invalid_phonenumber','invalid_federal_tax_id_ssn','invalid_federal_tax_id_ssn_identifier','invalid_dotid','invalid_dotscore','invalid_dotweight','invalid_empid','invalid_empscore','invalid_empweight','invalid_powid','invalid_powscore','invalid_powweight','invalid_proxid','invalid_proxscore','invalid_proxweight','invalid_seleid','invalid_selescore','invalid_seleweight','invalid_orgid','invalid_orgscore','invalid_orgweight','invalid_ultid','invalid_ultscore','invalid_ultweight','invalid_sbfe_id','invalid_legal_busi_structure','invalid_busi_established_date','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_origrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_number_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_past_due_aging_amount_bucket','invalid_maximum_number_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_num','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator','invalid_percent','invalid_percent','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.timestamp,(SALT33.StrType)le.process_date,(SALT33.StrType)le.record_type,(SALT33.StrType)le.did,(SALT33.StrType)le.did_score,(SALT33.StrType)le.dt_first_seen,(SALT33.StrType)le.dt_last_seen,(SALT33.StrType)le.dt_vendor_first_reported,(SALT33.StrType)le.dt_vendor_last_reported,(SALT33.StrType)le.dt_datawarehouse_first_reported,(SALT33.StrType)le.dt_datawarehouse_last_reported,(SALT33.StrType)le.sbfe_contributor_number,(SALT33.StrType)le.contract_account_number,(SALT33.StrType)le.extracted_date,(SALT33.StrType)le.cycle_end_date,(SALT33.StrType)le.account_holder_business_name,(SALT33.StrType)le.clean_account_holder_business_name,(SALT33.StrType)le.dba,(SALT33.StrType)le.clean_dba,(SALT33.StrType)le.business_name,(SALT33.StrType)le.clean_business_name,(SALT33.StrType)le.company_website,(SALT33.StrType)le.original_fname,(SALT33.StrType)le.original_mname,(SALT33.StrType)le.original_lname,(SALT33.StrType)le.original_suffix,(SALT33.StrType)le.e_mail_address,(SALT33.StrType)le.guarantor_owner_indicator,(SALT33.StrType)le.relationship_to_business_indicator,(SALT33.StrType)le.business_title,(SALT33.StrType)le.clean_title,(SALT33.StrType)le.clean_fname,(SALT33.StrType)le.clean_mname,(SALT33.StrType)le.clean_lname,(SALT33.StrType)le.clean_suffix,(SALT33.StrType)le.original_address_line_1,(SALT33.StrType)le.original_address_line_2,(SALT33.StrType)le.original_city,(SALT33.StrType)le.original_state,(SALT33.StrType)le.original_zip_code_or_ca_postal_code,(SALT33.StrType)le.original_postal_code,(SALT33.StrType)le.original_country_code,(SALT33.StrType)le.prim_range,(SALT33.StrType)le.predir,(SALT33.StrType)le.prim_name,(SALT33.StrType)le.addr_suffix,(SALT33.StrType)le.postdir,(SALT33.StrType)le.unit_desig,(SALT33.StrType)le.sec_range,(SALT33.StrType)le.p_city_name,(SALT33.StrType)le.v_city_name,(SALT33.StrType)le.st,(SALT33.StrType)le.zip,(SALT33.StrType)le.zip4,(SALT33.StrType)le.original_area_code,(SALT33.StrType)le.original_phone_number,(SALT33.StrType)le.phone_extension,(SALT33.StrType)le.primary_phone_indicator,(SALT33.StrType)le.published_unlisted_indicator,(SALT33.StrType)le.phone_type,(SALT33.StrType)le.phone_number,(SALT33.StrType)le.federal_taxid_ssn,(SALT33.StrType)le.federal_taxid_ssn_identifier,(SALT33.StrType)le.dotid,(SALT33.StrType)le.dotscore,(SALT33.StrType)le.dotweight,(SALT33.StrType)le.empid,(SALT33.StrType)le.empscore,(SALT33.StrType)le.empweight,(SALT33.StrType)le.powid,(SALT33.StrType)le.powscore,(SALT33.StrType)le.powweight,(SALT33.StrType)le.proxid,(SALT33.StrType)le.proxscore,(SALT33.StrType)le.proxweight,(SALT33.StrType)le.seleid,(SALT33.StrType)le.selescore,(SALT33.StrType)le.seleweight,(SALT33.StrType)le.orgid,(SALT33.StrType)le.orgscore,(SALT33.StrType)le.orgweight,(SALT33.StrType)le.ultid,(SALT33.StrType)le.ultscore,(SALT33.StrType)le.ultweight,(SALT33.StrType)le.sbfe_id,(SALT33.StrType)le.legal_business_structure,(SALT33.StrType)le.business_established_date,(SALT33.StrType)le.account_status_1,(SALT33.StrType)le.account_status_2,(SALT33.StrType)le.date_account_opened,(SALT33.StrType)le.date_account_closed,(SALT33.StrType)le.account_closure_basis,(SALT33.StrType)le.account_expiration_date,(SALT33.StrType)le.last_activity_date,(SALT33.StrType)le.last_activity_type,(SALT33.StrType)le.recent_activity_indicator,(SALT33.StrType)le.original_credit_limit,(SALT33.StrType)le.highest_credit_used,(SALT33.StrType)le.current_credit_limit,(SALT33.StrType)le.reporting_indicator_length,(SALT33.StrType)le.payment_interval,(SALT33.StrType)le.payment_status_category,(SALT33.StrType)le.term_of_account_in_months,(SALT33.StrType)le.first_payment_due_date,(SALT33.StrType)le.final_payment_due_date,(SALT33.StrType)le.original_rate,(SALT33.StrType)le.floating_rate,(SALT33.StrType)le.grace_period,(SALT33.StrType)le.payment_category,(SALT33.StrType)le.payment_history_profile_12_months,(SALT33.StrType)le.payment_history_profile_13_24_months,(SALT33.StrType)le.payment_history_profile_25_36_months,(SALT33.StrType)le.payment_history_profile_37_48_months,(SALT33.StrType)le.payment_history_length,(SALT33.StrType)le.year_to_date_purchases_count,(SALT33.StrType)le.lifetime_to_date_purchases_count,(SALT33.StrType)le.year_to_date_purchases_sum_amount,(SALT33.StrType)le.lifetime_to_date_purchases_sum_amount,(SALT33.StrType)le.payment_amount_scheduled,(SALT33.StrType)le.recent_payment_amount,(SALT33.StrType)le.recent_payment_date,(SALT33.StrType)le.remaining_balance,(SALT33.StrType)le.carried_over_amount,(SALT33.StrType)le.new_applied_charges,(SALT33.StrType)le.balloon_payment_due,(SALT33.StrType)le.balloon_payment_due_date,(SALT33.StrType)le.delinquency_date,(SALT33.StrType)le.days_delinquent,(SALT33.StrType)le.past_due_amount,(SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided,(SALT33.StrType)le.past_due_aging_bucket_type,(SALT33.StrType)le.past_due_aging_amount_bucket_1,(SALT33.StrType)le.past_due_aging_amount_bucket_2,(SALT33.StrType)le.past_due_aging_amount_bucket_3,(SALT33.StrType)le.past_due_aging_amount_bucket_4,(SALT33.StrType)le.past_due_aging_amount_bucket_5,(SALT33.StrType)le.past_due_aging_amount_bucket_6,(SALT33.StrType)le.past_due_aging_amount_bucket_7,(SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided,(SALT33.StrType)le.payment_tracking_cycle_type,(SALT33.StrType)le.payment_tracking_cycle_0_current,(SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days,(SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days,(SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days,(SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days,(SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days,(SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days,(SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days,(SALT33.StrType)le.date_account_was_charged_off,(SALT33.StrType)le.amount_charged_off_by_creditor,(SALT33.StrType)le.charge_off_type_indicator,(SALT33.StrType)le.total_charge_off_recoveries_to_date,(SALT33.StrType)le.government_guarantee_flag,(SALT33.StrType)le.government_guarantee_category,(SALT33.StrType)le.portion_of_account_guaranteed_by_government,(SALT33.StrType)le.guarantors_indicator,(SALT33.StrType)le.number_of_guarantors,(SALT33.StrType)le.owners_indicator,(SALT33.StrType)le.number_of_principals,(SALT33.StrType)le.account_update_deletion_indicator,(SALT33.StrType)le.percent_of_liability,(SALT33.StrType)le.percent_of_ownership,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,162,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'timestamp:invalid_timestamp:ALLOW'
          ,'process_date:invalid_process_date:ALLOW'
          ,'record_type:invalid_invalid_record_type:ALLOW'
          ,'did:invalid_did:ALLOW'
          ,'did_score:invalid_did_score:ALLOW'
          ,'dt_first_seen:invalid_dt_first_seen:ALLOW'
          ,'dt_last_seen:invalid_dt_last_seen:ALLOW'
          ,'dt_vendor_first_reported:invalid_dt_vendor_first_reported:ALLOW'
          ,'dt_vendor_last_reported:invalid_dt_vendor_last_reported:ALLOW'
          ,'dt_datawarehouse_first_reported:invalid_dt_datawarehouse_first_reported:ALLOW'
          ,'dt_datawarehouse_last_reported:invalid_dt_datawarehouse_last_reported:ALLOW'
          ,'sbfe_contributor_number:invalid_sbfe_contributor_num:ALLOW','sbfe_contributor_number:invalid_sbfe_contributor_num:CUSTOM','sbfe_contributor_number:invalid_sbfe_contributor_num:LENGTH'
          ,'contract_account_number:invalid_contractacc_num:ALLOW','contract_account_number:invalid_contractacc_num:LENGTH'
          ,'extracted_date:invalid_extracted_date:ALLOW','extracted_date:invalid_extracted_date:CUSTOM','extracted_date:invalid_extracted_date:LENGTH'
          ,'cycle_end_date:invalid_cycleend_date:ALLOW','cycle_end_date:invalid_cycleend_date:CUSTOM','cycle_end_date:invalid_cycleend_date:LENGTH'
          ,'account_holder_business_name:invalid_accholder_businessname:ALLOW'
          ,'clean_account_holder_business_name:invalid_cln_accholder_businessname:ALLOW'
          ,'dba:invalid_dba:ALLOW'
          ,'clean_dba:invalid_cln_dba:ALLOW'
          ,'business_name:invalid_business_name:ALLOW'
          ,'clean_business_name:invalid_cln_business_name:ALLOW'
          ,'company_website:invalid_comp_website:ALLOW'
          ,'original_fname:invalid_first_name:ALLOW'
          ,'original_mname:invalid_middle_name:ALLOW'
          ,'original_lname:invalid_last_name:ALLOW'
          ,'original_suffix:invalid_suffix:ALLOW'
          ,'e_mail_address:invalid_e_mail_address:ALLOW'
          ,'guarantor_owner_indicator:invalid_guarantor_owner_indicator:ENUM'
          ,'relationship_to_business_indicator:invalid_relationship_to_business_indicator:ALLOW'
          ,'business_title:invalid_business_title:ALLOW'
          ,'clean_title:invalid_cln_title:ALLOW'
          ,'clean_fname:invalid_cln_fname:ALLOW'
          ,'clean_mname:invalid_cln_mname:ALLOW'
          ,'clean_lname:invalid_cln_lname:ALLOW'
          ,'clean_suffix:invalid_cln_suffix:ALLOW'
          ,'original_address_line_1:invalid_orig_address_line_1:ALLOW'
          ,'original_address_line_2:invalid_orig_address_line_2:ALLOW'
          ,'original_city:invalid_orig_city:ALLOW'
          ,'original_state:invalid_orig_state:ALLOW'
          ,'original_zip_code_or_ca_postal_code:invalid_orig_zip_code_or_ca_postal_code:ALLOW'
          ,'original_postal_code:invalid_orig_postal_code:ALLOW'
          ,'original_country_code:invalid_orig_country_code:ALLOW'
          ,'prim_range:invalid_prim_range:ALLOW'
          ,'predir:invalid_predir:ALLOW'
          ,'prim_name:invalid_prim_name:ALLOW'
          ,'addr_suffix:invalid_addr_suffix:ALLOW'
          ,'postdir:invalid_postdir:ALLOW'
          ,'unit_desig:invalid_unit_desig:ALLOW'
          ,'sec_range:invalid_sec_range:ALLOW'
          ,'p_city_name:invalid_p_city_name:ALLOW'
          ,'v_city_name:invalid_v_city_name:ALLOW'
          ,'st:invalid_st:ALLOW'
          ,'zip:invalid_zip:ALLOW'
          ,'zip4:invalid_zip4:ALLOW'
          ,'original_area_code:invalid_orig_area_code:ALLOW'
          ,'original_phone_number:invalid_orig_telephone_number:ALLOW'
          ,'phone_extension:invalid_telephone_extension:ALLOW'
          ,'primary_phone_indicator:invalid_primary_telephone_indicator:ENUM'
          ,'published_unlisted_indicator:invalid_published_unlisted_indicator:ENUM'
          ,'phone_type:invalid_phonetype:ENUM'
          ,'phone_number:invalid_phonenumber:ALLOW'
          ,'federal_taxid_ssn:invalid_federal_tax_id_ssn:ALLOW'
          ,'federal_taxid_ssn_identifier:invalid_federal_tax_id_ssn_identifier:ENUM'
          ,'dotid:invalid_dotid:ALLOW'
          ,'dotscore:invalid_dotscore:ALLOW'
          ,'dotweight:invalid_dotweight:ALLOW'
          ,'empid:invalid_empid:ALLOW'
          ,'empscore:invalid_empscore:ALLOW'
          ,'empweight:invalid_empweight:ALLOW'
          ,'powid:invalid_powid:ALLOW'
          ,'powscore:invalid_powscore:ALLOW'
          ,'powweight:invalid_powweight:ALLOW'
          ,'proxid:invalid_proxid:ALLOW'
          ,'proxscore:invalid_proxscore:ALLOW'
          ,'proxweight:invalid_proxweight:ALLOW'
          ,'seleid:invalid_seleid:ALLOW'
          ,'selescore:invalid_selescore:ALLOW'
          ,'seleweight:invalid_seleweight:ALLOW'
          ,'orgid:invalid_orgid:ALLOW'
          ,'orgscore:invalid_orgscore:ALLOW'
          ,'orgweight:invalid_orgweight:ALLOW'
          ,'ultid:invalid_ultid:ALLOW'
          ,'ultscore:invalid_ultscore:ALLOW'
          ,'ultweight:invalid_ultweight:ALLOW'
          ,'sbfe_id:invalid_sbfe_id:ALLOW'
          ,'legal_business_structure:invalid_legal_busi_structure:ENUM'
          ,'business_established_date:invalid_busi_established_date:ALLOW','business_established_date:invalid_busi_established_date:LENGTH'
          ,'account_status_1:invalid_acc_status1:ENUM'
          ,'account_status_2:invalid_acc_status2:ENUM'
          ,'date_account_opened:invalid_dateaccopened:ALLOW','date_account_opened:invalid_dateaccopened:CUSTOM','date_account_opened:invalid_dateaccopened:LENGTH'
          ,'date_account_closed:invalid_dateaccclosed:ALLOW','date_account_closed:invalid_dateaccclosed:CUSTOM','date_account_closed:invalid_dateaccclosed:LENGTH'
          ,'account_closure_basis:invalid_accountcloseurebasis:ENUM'
          ,'account_expiration_date:invalid_accexpirationdate:ALLOW','account_expiration_date:invalid_accexpirationdate:CUSTOM','account_expiration_date:invalid_accexpirationdate:LENGTH'
          ,'last_activity_date:invalid_lastactivitydate:ALLOW','last_activity_date:invalid_lastactivitydate:CUSTOM','last_activity_date:invalid_lastactivitydate:LENGTH'
          ,'last_activity_type:invalid_lastactivitytype:ALLOW'
          ,'recent_activity_indicator:invalid_recentactivityindicator:ENUM'
          ,'original_credit_limit:invalid_origcreditlimit:ALLOW'
          ,'highest_credit_used:invalid_highestcreditused:ALLOW'
          ,'current_credit_limit:invalid_currentcreditlimit:ALLOW'
          ,'reporting_indicator_length:invalid_reporterindicatorlength:ENUM'
          ,'payment_interval:invalid_paymentinterval:ENUM'
          ,'payment_status_category:invalid_paymentstatuscategory:ENUM'
          ,'term_of_account_in_months:invalid_termofacc_months:ALLOW'
          ,'first_payment_due_date:invalid_firstpymtduedate:ALLOW','first_payment_due_date:invalid_firstpymtduedate:CUSTOM','first_payment_due_date:invalid_firstpymtduedate:LENGTH'
          ,'final_payment_due_date:invalid_finalpymtduedate:ALLOW','final_payment_due_date:invalid_finalpymtduedate:CUSTOM','final_payment_due_date:invalid_finalpymtduedate:LENGTH'
          ,'original_rate:invalid_origrate:ALLOW'
          ,'floating_rate:invalid_origrate:ALLOW'
          ,'grace_period:invalid_graceperiod:ALLOW'
          ,'payment_category:invalid_paymentcategory:ENUM'
          ,'payment_history_profile_12_months:invalid_pymthistprofile12:ALLOW'
          ,'payment_history_profile_13_24_months:invalid_pymthistprofile13_24:ALLOW'
          ,'payment_history_profile_25_36_months:invalid_pymthistprofile25_36:ALLOW'
          ,'payment_history_profile_37_48_months:invalid_pymthistprofile37_48:ALLOW'
          ,'payment_history_length:invalid_pymthistlength:ALLOW'
          ,'year_to_date_purchases_count:invalid_ytd_purchasescount:ALLOW'
          ,'lifetime_to_date_purchases_count:invalid_ltd_purchasescount:ALLOW'
          ,'year_to_date_purchases_sum_amount:invalid_ytd_purchasessumamt:ALLOW'
          ,'lifetime_to_date_purchases_sum_amount:invalid_ltd_purchasessumamt:ALLOW'
          ,'payment_amount_scheduled:invalid_pymtamtscheduled:ALLOW'
          ,'recent_payment_amount:invalid_recentpymtamt:ALLOW'
          ,'recent_payment_date:invalid_recentpaymentdate:ALLOW','recent_payment_date:invalid_recentpaymentdate:CUSTOM','recent_payment_date:invalid_recentpaymentdate:LENGTH'
          ,'remaining_balance:invalid_remainingbalance:ALLOW'
          ,'carried_over_amount:invalid_carriedoveramt:ALLOW'
          ,'new_applied_charges:invalid_newappliedcharges:ALLOW'
          ,'balloon_payment_due:invalid_balloonpymtdue:ALLOW'
          ,'balloon_payment_due_date:invalid_balloonpymtduedate:ALLOW','balloon_payment_due_date:invalid_balloonpymtduedate:CUSTOM','balloon_payment_due_date:invalid_balloonpymtduedate:LENGTH'
          ,'delinquency_date:invalid_delinquencydate:ALLOW','delinquency_date:invalid_delinquencydate:CUSTOM','delinquency_date:invalid_delinquencydate:LENGTH'
          ,'days_delinquent:invalid_daysdelinquent:ALLOW'
          ,'past_due_amount:invalid_pastdueamt:ALLOW'
          ,'maximum_number_of_past_due_aging_amounts_buckets_provided:invalid_maximum_number_bucket:ENUM'
          ,'past_due_aging_bucket_type:invalid_past_due_aging_bucket_type:ALLOW'
          ,'past_due_aging_amount_bucket_1:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_2:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_3:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_4:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_5:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_6:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'past_due_aging_amount_bucket_7:invalid_past_due_aging_amount_bucket:ALLOW'
          ,'maximum_number_of_payment_tracking_cycle_periods_provided:invalid_maximum_number_tracking:ENUM'
          ,'payment_tracking_cycle_type:invalid_payment_tracking_cycle_type:ALLOW'
          ,'payment_tracking_cycle_0_current:invalid_num:ALLOW'
          ,'payment_tracking_cycle_1_1_to_30_days:invalid_num:ALLOW'
          ,'payment_tracking_cycle_2_31_to_60_days:invalid_num:ALLOW'
          ,'payment_tracking_cycle_3_61_to_90_days:invalid_num:ALLOW'
          ,'payment_tracking_cycle_4_91_to_120_days:invalid_num:ALLOW'
          ,'payment_tracking_cycle_5_121_to_150days:invalid_num:ALLOW'
          ,'payment_tracking_number_of_times_cycle_6_151_to_180_days:invalid_num:ALLOW'
          ,'payment_tracking_number_of_times_cycle_7_181_or_greater_days:invalid_num:ALLOW'
          ,'date_account_was_charged_off:invalid_date_account_was_charged_off:ALLOW','date_account_was_charged_off:invalid_date_account_was_charged_off:CUSTOM','date_account_was_charged_off:invalid_date_account_was_charged_off:LENGTH'
          ,'amount_charged_off_by_creditor:invalid_amount_charged_off_by_creditor:ALLOW'
          ,'charge_off_type_indicator:invalid_charge_off_type_indicator:ENUM'
          ,'total_charge_off_recoveries_to_date:invalid_total_charge_off_recoveries_to_date:ALLOW'
          ,'government_guarantee_flag:invalid_government_guarantee_flag:ENUM'
          ,'government_guarantee_category:invalid_government_guarantee_category:ENUM'
          ,'portion_of_account_guaranteed_by_government:invalid_num:ALLOW'
          ,'guarantors_indicator:invalid_guarantors_indicator:ENUM'
          ,'number_of_guarantors:invalid_number_of_guarantors:ALLOW'
          ,'owners_indicator:invalid_owners_indicator:ENUM'
          ,'number_of_principals:invalid_number_of_principals:ALLOW'
          ,'account_update_deletion_indicator:invalid_account_update_deletion_indicator:ENUM'
          ,'percent_of_liability:invalid_percent:ALLOW'
          ,'percent_of_ownership:invalid_percent:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,LinkID_Fields.InvalidMessage_timestamp(1)
          ,LinkID_Fields.InvalidMessage_process_date(1)
          ,LinkID_Fields.InvalidMessage_record_type(1)
          ,LinkID_Fields.InvalidMessage_did(1)
          ,LinkID_Fields.InvalidMessage_did_score(1)
          ,LinkID_Fields.InvalidMessage_dt_first_seen(1)
          ,LinkID_Fields.InvalidMessage_dt_last_seen(1)
          ,LinkID_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,LinkID_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,LinkID_Fields.InvalidMessage_dt_datawarehouse_first_reported(1)
          ,LinkID_Fields.InvalidMessage_dt_datawarehouse_last_reported(1)
          ,LinkID_Fields.InvalidMessage_sbfe_contributor_number(1),LinkID_Fields.InvalidMessage_sbfe_contributor_number(2),LinkID_Fields.InvalidMessage_sbfe_contributor_number(3)
          ,LinkID_Fields.InvalidMessage_contract_account_number(1),LinkID_Fields.InvalidMessage_contract_account_number(2)
          ,LinkID_Fields.InvalidMessage_extracted_date(1),LinkID_Fields.InvalidMessage_extracted_date(2),LinkID_Fields.InvalidMessage_extracted_date(3)
          ,LinkID_Fields.InvalidMessage_cycle_end_date(1),LinkID_Fields.InvalidMessage_cycle_end_date(2),LinkID_Fields.InvalidMessage_cycle_end_date(3)
          ,LinkID_Fields.InvalidMessage_account_holder_business_name(1)
          ,LinkID_Fields.InvalidMessage_clean_account_holder_business_name(1)
          ,LinkID_Fields.InvalidMessage_dba(1)
          ,LinkID_Fields.InvalidMessage_clean_dba(1)
          ,LinkID_Fields.InvalidMessage_business_name(1)
          ,LinkID_Fields.InvalidMessage_clean_business_name(1)
          ,LinkID_Fields.InvalidMessage_company_website(1)
          ,LinkID_Fields.InvalidMessage_original_fname(1)
          ,LinkID_Fields.InvalidMessage_original_mname(1)
          ,LinkID_Fields.InvalidMessage_original_lname(1)
          ,LinkID_Fields.InvalidMessage_original_suffix(1)
          ,LinkID_Fields.InvalidMessage_e_mail_address(1)
          ,LinkID_Fields.InvalidMessage_guarantor_owner_indicator(1)
          ,LinkID_Fields.InvalidMessage_relationship_to_business_indicator(1)
          ,LinkID_Fields.InvalidMessage_business_title(1)
          ,LinkID_Fields.InvalidMessage_clean_title(1)
          ,LinkID_Fields.InvalidMessage_clean_fname(1)
          ,LinkID_Fields.InvalidMessage_clean_mname(1)
          ,LinkID_Fields.InvalidMessage_clean_lname(1)
          ,LinkID_Fields.InvalidMessage_clean_suffix(1)
          ,LinkID_Fields.InvalidMessage_original_address_line_1(1)
          ,LinkID_Fields.InvalidMessage_original_address_line_2(1)
          ,LinkID_Fields.InvalidMessage_original_city(1)
          ,LinkID_Fields.InvalidMessage_original_state(1)
          ,LinkID_Fields.InvalidMessage_original_zip_code_or_ca_postal_code(1)
          ,LinkID_Fields.InvalidMessage_original_postal_code(1)
          ,LinkID_Fields.InvalidMessage_original_country_code(1)
          ,LinkID_Fields.InvalidMessage_prim_range(1)
          ,LinkID_Fields.InvalidMessage_predir(1)
          ,LinkID_Fields.InvalidMessage_prim_name(1)
          ,LinkID_Fields.InvalidMessage_addr_suffix(1)
          ,LinkID_Fields.InvalidMessage_postdir(1)
          ,LinkID_Fields.InvalidMessage_unit_desig(1)
          ,LinkID_Fields.InvalidMessage_sec_range(1)
          ,LinkID_Fields.InvalidMessage_p_city_name(1)
          ,LinkID_Fields.InvalidMessage_v_city_name(1)
          ,LinkID_Fields.InvalidMessage_st(1)
          ,LinkID_Fields.InvalidMessage_zip(1)
          ,LinkID_Fields.InvalidMessage_zip4(1)
          ,LinkID_Fields.InvalidMessage_original_area_code(1)
          ,LinkID_Fields.InvalidMessage_original_phone_number(1)
          ,LinkID_Fields.InvalidMessage_phone_extension(1)
          ,LinkID_Fields.InvalidMessage_primary_phone_indicator(1)
          ,LinkID_Fields.InvalidMessage_published_unlisted_indicator(1)
          ,LinkID_Fields.InvalidMessage_phone_type(1)
          ,LinkID_Fields.InvalidMessage_phone_number(1)
          ,LinkID_Fields.InvalidMessage_federal_taxid_ssn(1)
          ,LinkID_Fields.InvalidMessage_federal_taxid_ssn_identifier(1)
          ,LinkID_Fields.InvalidMessage_dotid(1)
          ,LinkID_Fields.InvalidMessage_dotscore(1)
          ,LinkID_Fields.InvalidMessage_dotweight(1)
          ,LinkID_Fields.InvalidMessage_empid(1)
          ,LinkID_Fields.InvalidMessage_empscore(1)
          ,LinkID_Fields.InvalidMessage_empweight(1)
          ,LinkID_Fields.InvalidMessage_powid(1)
          ,LinkID_Fields.InvalidMessage_powscore(1)
          ,LinkID_Fields.InvalidMessage_powweight(1)
          ,LinkID_Fields.InvalidMessage_proxid(1)
          ,LinkID_Fields.InvalidMessage_proxscore(1)
          ,LinkID_Fields.InvalidMessage_proxweight(1)
          ,LinkID_Fields.InvalidMessage_seleid(1)
          ,LinkID_Fields.InvalidMessage_selescore(1)
          ,LinkID_Fields.InvalidMessage_seleweight(1)
          ,LinkID_Fields.InvalidMessage_orgid(1)
          ,LinkID_Fields.InvalidMessage_orgscore(1)
          ,LinkID_Fields.InvalidMessage_orgweight(1)
          ,LinkID_Fields.InvalidMessage_ultid(1)
          ,LinkID_Fields.InvalidMessage_ultscore(1)
          ,LinkID_Fields.InvalidMessage_ultweight(1)
          ,LinkID_Fields.InvalidMessage_sbfe_id(1)
          ,LinkID_Fields.InvalidMessage_legal_business_structure(1)
          ,LinkID_Fields.InvalidMessage_business_established_date(1),LinkID_Fields.InvalidMessage_business_established_date(2)
          ,LinkID_Fields.InvalidMessage_account_status_1(1)
          ,LinkID_Fields.InvalidMessage_account_status_2(1)
          ,LinkID_Fields.InvalidMessage_date_account_opened(1),LinkID_Fields.InvalidMessage_date_account_opened(2),LinkID_Fields.InvalidMessage_date_account_opened(3)
          ,LinkID_Fields.InvalidMessage_date_account_closed(1),LinkID_Fields.InvalidMessage_date_account_closed(2),LinkID_Fields.InvalidMessage_date_account_closed(3)
          ,LinkID_Fields.InvalidMessage_account_closure_basis(1)
          ,LinkID_Fields.InvalidMessage_account_expiration_date(1),LinkID_Fields.InvalidMessage_account_expiration_date(2),LinkID_Fields.InvalidMessage_account_expiration_date(3)
          ,LinkID_Fields.InvalidMessage_last_activity_date(1),LinkID_Fields.InvalidMessage_last_activity_date(2),LinkID_Fields.InvalidMessage_last_activity_date(3)
          ,LinkID_Fields.InvalidMessage_last_activity_type(1)
          ,LinkID_Fields.InvalidMessage_recent_activity_indicator(1)
          ,LinkID_Fields.InvalidMessage_original_credit_limit(1)
          ,LinkID_Fields.InvalidMessage_highest_credit_used(1)
          ,LinkID_Fields.InvalidMessage_current_credit_limit(1)
          ,LinkID_Fields.InvalidMessage_reporting_indicator_length(1)
          ,LinkID_Fields.InvalidMessage_payment_interval(1)
          ,LinkID_Fields.InvalidMessage_payment_status_category(1)
          ,LinkID_Fields.InvalidMessage_term_of_account_in_months(1)
          ,LinkID_Fields.InvalidMessage_first_payment_due_date(1),LinkID_Fields.InvalidMessage_first_payment_due_date(2),LinkID_Fields.InvalidMessage_first_payment_due_date(3)
          ,LinkID_Fields.InvalidMessage_final_payment_due_date(1),LinkID_Fields.InvalidMessage_final_payment_due_date(2),LinkID_Fields.InvalidMessage_final_payment_due_date(3)
          ,LinkID_Fields.InvalidMessage_original_rate(1)
          ,LinkID_Fields.InvalidMessage_floating_rate(1)
          ,LinkID_Fields.InvalidMessage_grace_period(1)
          ,LinkID_Fields.InvalidMessage_payment_category(1)
          ,LinkID_Fields.InvalidMessage_payment_history_profile_12_months(1)
          ,LinkID_Fields.InvalidMessage_payment_history_profile_13_24_months(1)
          ,LinkID_Fields.InvalidMessage_payment_history_profile_25_36_months(1)
          ,LinkID_Fields.InvalidMessage_payment_history_profile_37_48_months(1)
          ,LinkID_Fields.InvalidMessage_payment_history_length(1)
          ,LinkID_Fields.InvalidMessage_year_to_date_purchases_count(1)
          ,LinkID_Fields.InvalidMessage_lifetime_to_date_purchases_count(1)
          ,LinkID_Fields.InvalidMessage_year_to_date_purchases_sum_amount(1)
          ,LinkID_Fields.InvalidMessage_lifetime_to_date_purchases_sum_amount(1)
          ,LinkID_Fields.InvalidMessage_payment_amount_scheduled(1)
          ,LinkID_Fields.InvalidMessage_recent_payment_amount(1)
          ,LinkID_Fields.InvalidMessage_recent_payment_date(1),LinkID_Fields.InvalidMessage_recent_payment_date(2),LinkID_Fields.InvalidMessage_recent_payment_date(3)
          ,LinkID_Fields.InvalidMessage_remaining_balance(1)
          ,LinkID_Fields.InvalidMessage_carried_over_amount(1)
          ,LinkID_Fields.InvalidMessage_new_applied_charges(1)
          ,LinkID_Fields.InvalidMessage_balloon_payment_due(1)
          ,LinkID_Fields.InvalidMessage_balloon_payment_due_date(1),LinkID_Fields.InvalidMessage_balloon_payment_due_date(2),LinkID_Fields.InvalidMessage_balloon_payment_due_date(3)
          ,LinkID_Fields.InvalidMessage_delinquency_date(1),LinkID_Fields.InvalidMessage_delinquency_date(2),LinkID_Fields.InvalidMessage_delinquency_date(3)
          ,LinkID_Fields.InvalidMessage_days_delinquent(1)
          ,LinkID_Fields.InvalidMessage_past_due_amount(1)
          ,LinkID_Fields.InvalidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_bucket_type(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_1(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_2(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_3(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_4(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_5(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_6(1)
          ,LinkID_Fields.InvalidMessage_past_due_aging_amount_bucket_7(1)
          ,LinkID_Fields.InvalidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_type(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_0_current(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_1_1_to_30_days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_2_31_to_60_days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_3_61_to_90_days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_4_91_to_120_days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_cycle_5_121_to_150days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(1)
          ,LinkID_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(1)
          ,LinkID_Fields.InvalidMessage_date_account_was_charged_off(1),LinkID_Fields.InvalidMessage_date_account_was_charged_off(2),LinkID_Fields.InvalidMessage_date_account_was_charged_off(3)
          ,LinkID_Fields.InvalidMessage_amount_charged_off_by_creditor(1)
          ,LinkID_Fields.InvalidMessage_charge_off_type_indicator(1)
          ,LinkID_Fields.InvalidMessage_total_charge_off_recoveries_to_date(1)
          ,LinkID_Fields.InvalidMessage_government_guarantee_flag(1)
          ,LinkID_Fields.InvalidMessage_government_guarantee_category(1)
          ,LinkID_Fields.InvalidMessage_portion_of_account_guaranteed_by_government(1)
          ,LinkID_Fields.InvalidMessage_guarantors_indicator(1)
          ,LinkID_Fields.InvalidMessage_number_of_guarantors(1)
          ,LinkID_Fields.InvalidMessage_owners_indicator(1)
          ,LinkID_Fields.InvalidMessage_number_of_principals(1)
          ,LinkID_Fields.InvalidMessage_account_update_deletion_indicator(1)
          ,LinkID_Fields.InvalidMessage_percent_of_liability(1)
          ,LinkID_Fields.InvalidMessage_percent_of_ownership(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.timestamp_ALLOW_ErrorCount
          ,le.process_date_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_datawarehouse_first_reported_ALLOW_ErrorCount
          ,le.dt_datawarehouse_last_reported_ALLOW_ErrorCount
          ,le.sbfe_contributor_number_ALLOW_ErrorCount,le.sbfe_contributor_number_CUSTOM_ErrorCount,le.sbfe_contributor_number_LENGTH_ErrorCount
          ,le.contract_account_number_ALLOW_ErrorCount,le.contract_account_number_LENGTH_ErrorCount
          ,le.extracted_date_ALLOW_ErrorCount,le.extracted_date_CUSTOM_ErrorCount,le.extracted_date_LENGTH_ErrorCount
          ,le.cycle_end_date_ALLOW_ErrorCount,le.cycle_end_date_CUSTOM_ErrorCount,le.cycle_end_date_LENGTH_ErrorCount
          ,le.account_holder_business_name_ALLOW_ErrorCount
          ,le.clean_account_holder_business_name_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.clean_dba_ALLOW_ErrorCount
          ,le.business_name_ALLOW_ErrorCount
          ,le.clean_business_name_ALLOW_ErrorCount
          ,le.company_website_ALLOW_ErrorCount
          ,le.original_fname_ALLOW_ErrorCount
          ,le.original_mname_ALLOW_ErrorCount
          ,le.original_lname_ALLOW_ErrorCount
          ,le.original_suffix_ALLOW_ErrorCount
          ,le.e_mail_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.business_title_ALLOW_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount
          ,le.clean_suffix_ALLOW_ErrorCount
          ,le.original_address_line_1_ALLOW_ErrorCount
          ,le.original_address_line_2_ALLOW_ErrorCount
          ,le.original_city_ALLOW_ErrorCount
          ,le.original_state_ALLOW_ErrorCount
          ,le.original_zip_code_or_ca_postal_code_ALLOW_ErrorCount
          ,le.original_postal_code_ALLOW_ErrorCount
          ,le.original_country_code_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.original_area_code_ALLOW_ErrorCount
          ,le.original_phone_number_ALLOW_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.primary_phone_indicator_ENUM_ErrorCount
          ,le.published_unlisted_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.federal_taxid_ssn_ALLOW_ErrorCount
          ,le.federal_taxid_ssn_identifier_ENUM_ErrorCount
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.sbfe_id_ALLOW_ErrorCount
          ,le.legal_business_structure_ENUM_ErrorCount
          ,le.business_established_date_ALLOW_ErrorCount,le.business_established_date_LENGTH_ErrorCount
          ,le.account_status_1_ENUM_ErrorCount
          ,le.account_status_2_ENUM_ErrorCount
          ,le.date_account_opened_ALLOW_ErrorCount,le.date_account_opened_CUSTOM_ErrorCount,le.date_account_opened_LENGTH_ErrorCount
          ,le.date_account_closed_ALLOW_ErrorCount,le.date_account_closed_CUSTOM_ErrorCount,le.date_account_closed_LENGTH_ErrorCount
          ,le.account_closure_basis_ENUM_ErrorCount
          ,le.account_expiration_date_ALLOW_ErrorCount,le.account_expiration_date_CUSTOM_ErrorCount,le.account_expiration_date_LENGTH_ErrorCount
          ,le.last_activity_date_ALLOW_ErrorCount,le.last_activity_date_CUSTOM_ErrorCount,le.last_activity_date_LENGTH_ErrorCount
          ,le.last_activity_type_ALLOW_ErrorCount
          ,le.recent_activity_indicator_ENUM_ErrorCount
          ,le.original_credit_limit_ALLOW_ErrorCount
          ,le.highest_credit_used_ALLOW_ErrorCount
          ,le.current_credit_limit_ALLOW_ErrorCount
          ,le.reporting_indicator_length_ENUM_ErrorCount
          ,le.payment_interval_ENUM_ErrorCount
          ,le.payment_status_category_ENUM_ErrorCount
          ,le.term_of_account_in_months_ALLOW_ErrorCount
          ,le.first_payment_due_date_ALLOW_ErrorCount,le.first_payment_due_date_CUSTOM_ErrorCount,le.first_payment_due_date_LENGTH_ErrorCount
          ,le.final_payment_due_date_ALLOW_ErrorCount,le.final_payment_due_date_CUSTOM_ErrorCount,le.final_payment_due_date_LENGTH_ErrorCount
          ,le.original_rate_ALLOW_ErrorCount
          ,le.floating_rate_ALLOW_ErrorCount
          ,le.grace_period_ALLOW_ErrorCount
          ,le.payment_category_ENUM_ErrorCount
          ,le.payment_history_profile_12_months_ALLOW_ErrorCount
          ,le.payment_history_profile_13_24_months_ALLOW_ErrorCount
          ,le.payment_history_profile_25_36_months_ALLOW_ErrorCount
          ,le.payment_history_profile_37_48_months_ALLOW_ErrorCount
          ,le.payment_history_length_ALLOW_ErrorCount
          ,le.year_to_date_purchases_count_ALLOW_ErrorCount
          ,le.lifetime_to_date_purchases_count_ALLOW_ErrorCount
          ,le.year_to_date_purchases_sum_amount_ALLOW_ErrorCount
          ,le.lifetime_to_date_purchases_sum_amount_ALLOW_ErrorCount
          ,le.payment_amount_scheduled_ALLOW_ErrorCount
          ,le.recent_payment_amount_ALLOW_ErrorCount
          ,le.recent_payment_date_ALLOW_ErrorCount,le.recent_payment_date_CUSTOM_ErrorCount,le.recent_payment_date_LENGTH_ErrorCount
          ,le.remaining_balance_ALLOW_ErrorCount
          ,le.carried_over_amount_ALLOW_ErrorCount
          ,le.new_applied_charges_ALLOW_ErrorCount
          ,le.balloon_payment_due_ALLOW_ErrorCount
          ,le.balloon_payment_due_date_ALLOW_ErrorCount,le.balloon_payment_due_date_CUSTOM_ErrorCount,le.balloon_payment_due_date_LENGTH_ErrorCount
          ,le.delinquency_date_ALLOW_ErrorCount,le.delinquency_date_CUSTOM_ErrorCount,le.delinquency_date_LENGTH_ErrorCount
          ,le.days_delinquent_ALLOW_ErrorCount
          ,le.past_due_amount_ALLOW_ErrorCount
          ,le.maximum_number_of_past_due_aging_amounts_buckets_provided_ENUM_ErrorCount
          ,le.past_due_aging_bucket_type_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_1_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_2_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_3_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_4_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_5_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_6_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_7_ALLOW_ErrorCount
          ,le.maximum_number_of_payment_tracking_cycle_periods_provided_ENUM_ErrorCount
          ,le.payment_tracking_cycle_type_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_0_current_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_1_1_to_30_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_2_31_to_60_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_3_61_to_90_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_4_91_to_120_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_5_121_to_150days_ALLOW_ErrorCount
          ,le.payment_tracking_number_of_times_cycle_6_151_to_180_days_ALLOW_ErrorCount
          ,le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_ALLOW_ErrorCount
          ,le.date_account_was_charged_off_ALLOW_ErrorCount,le.date_account_was_charged_off_CUSTOM_ErrorCount,le.date_account_was_charged_off_LENGTH_ErrorCount
          ,le.amount_charged_off_by_creditor_ALLOW_ErrorCount
          ,le.charge_off_type_indicator_ENUM_ErrorCount
          ,le.total_charge_off_recoveries_to_date_ALLOW_ErrorCount
          ,le.government_guarantee_flag_ENUM_ErrorCount
          ,le.government_guarantee_category_ENUM_ErrorCount
          ,le.portion_of_account_guaranteed_by_government_ALLOW_ErrorCount
          ,le.guarantors_indicator_ENUM_ErrorCount
          ,le.number_of_guarantors_ALLOW_ErrorCount
          ,le.owners_indicator_ENUM_ErrorCount
          ,le.number_of_principals_ALLOW_ErrorCount
          ,le.account_update_deletion_indicator_ENUM_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.timestamp_ALLOW_ErrorCount
          ,le.process_date_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.dt_first_seen_ALLOW_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount
          ,le.dt_datawarehouse_first_reported_ALLOW_ErrorCount
          ,le.dt_datawarehouse_last_reported_ALLOW_ErrorCount
          ,le.sbfe_contributor_number_ALLOW_ErrorCount,le.sbfe_contributor_number_CUSTOM_ErrorCount,le.sbfe_contributor_number_LENGTH_ErrorCount
          ,le.contract_account_number_ALLOW_ErrorCount,le.contract_account_number_LENGTH_ErrorCount
          ,le.extracted_date_ALLOW_ErrorCount,le.extracted_date_CUSTOM_ErrorCount,le.extracted_date_LENGTH_ErrorCount
          ,le.cycle_end_date_ALLOW_ErrorCount,le.cycle_end_date_CUSTOM_ErrorCount,le.cycle_end_date_LENGTH_ErrorCount
          ,le.account_holder_business_name_ALLOW_ErrorCount
          ,le.clean_account_holder_business_name_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.clean_dba_ALLOW_ErrorCount
          ,le.business_name_ALLOW_ErrorCount
          ,le.clean_business_name_ALLOW_ErrorCount
          ,le.company_website_ALLOW_ErrorCount
          ,le.original_fname_ALLOW_ErrorCount
          ,le.original_mname_ALLOW_ErrorCount
          ,le.original_lname_ALLOW_ErrorCount
          ,le.original_suffix_ALLOW_ErrorCount
          ,le.e_mail_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.business_title_ALLOW_ErrorCount
          ,le.clean_title_ALLOW_ErrorCount
          ,le.clean_fname_ALLOW_ErrorCount
          ,le.clean_mname_ALLOW_ErrorCount
          ,le.clean_lname_ALLOW_ErrorCount
          ,le.clean_suffix_ALLOW_ErrorCount
          ,le.original_address_line_1_ALLOW_ErrorCount
          ,le.original_address_line_2_ALLOW_ErrorCount
          ,le.original_city_ALLOW_ErrorCount
          ,le.original_state_ALLOW_ErrorCount
          ,le.original_zip_code_or_ca_postal_code_ALLOW_ErrorCount
          ,le.original_postal_code_ALLOW_ErrorCount
          ,le.original_country_code_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.original_area_code_ALLOW_ErrorCount
          ,le.original_phone_number_ALLOW_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.primary_phone_indicator_ENUM_ErrorCount
          ,le.published_unlisted_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.federal_taxid_ssn_ALLOW_ErrorCount
          ,le.federal_taxid_ssn_identifier_ENUM_ErrorCount
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.sbfe_id_ALLOW_ErrorCount
          ,le.legal_business_structure_ENUM_ErrorCount
          ,le.business_established_date_ALLOW_ErrorCount,le.business_established_date_LENGTH_ErrorCount
          ,le.account_status_1_ENUM_ErrorCount
          ,le.account_status_2_ENUM_ErrorCount
          ,le.date_account_opened_ALLOW_ErrorCount,le.date_account_opened_CUSTOM_ErrorCount,le.date_account_opened_LENGTH_ErrorCount
          ,le.date_account_closed_ALLOW_ErrorCount,le.date_account_closed_CUSTOM_ErrorCount,le.date_account_closed_LENGTH_ErrorCount
          ,le.account_closure_basis_ENUM_ErrorCount
          ,le.account_expiration_date_ALLOW_ErrorCount,le.account_expiration_date_CUSTOM_ErrorCount,le.account_expiration_date_LENGTH_ErrorCount
          ,le.last_activity_date_ALLOW_ErrorCount,le.last_activity_date_CUSTOM_ErrorCount,le.last_activity_date_LENGTH_ErrorCount
          ,le.last_activity_type_ALLOW_ErrorCount
          ,le.recent_activity_indicator_ENUM_ErrorCount
          ,le.original_credit_limit_ALLOW_ErrorCount
          ,le.highest_credit_used_ALLOW_ErrorCount
          ,le.current_credit_limit_ALLOW_ErrorCount
          ,le.reporting_indicator_length_ENUM_ErrorCount
          ,le.payment_interval_ENUM_ErrorCount
          ,le.payment_status_category_ENUM_ErrorCount
          ,le.term_of_account_in_months_ALLOW_ErrorCount
          ,le.first_payment_due_date_ALLOW_ErrorCount,le.first_payment_due_date_CUSTOM_ErrorCount,le.first_payment_due_date_LENGTH_ErrorCount
          ,le.final_payment_due_date_ALLOW_ErrorCount,le.final_payment_due_date_CUSTOM_ErrorCount,le.final_payment_due_date_LENGTH_ErrorCount
          ,le.original_rate_ALLOW_ErrorCount
          ,le.floating_rate_ALLOW_ErrorCount
          ,le.grace_period_ALLOW_ErrorCount
          ,le.payment_category_ENUM_ErrorCount
          ,le.payment_history_profile_12_months_ALLOW_ErrorCount
          ,le.payment_history_profile_13_24_months_ALLOW_ErrorCount
          ,le.payment_history_profile_25_36_months_ALLOW_ErrorCount
          ,le.payment_history_profile_37_48_months_ALLOW_ErrorCount
          ,le.payment_history_length_ALLOW_ErrorCount
          ,le.year_to_date_purchases_count_ALLOW_ErrorCount
          ,le.lifetime_to_date_purchases_count_ALLOW_ErrorCount
          ,le.year_to_date_purchases_sum_amount_ALLOW_ErrorCount
          ,le.lifetime_to_date_purchases_sum_amount_ALLOW_ErrorCount
          ,le.payment_amount_scheduled_ALLOW_ErrorCount
          ,le.recent_payment_amount_ALLOW_ErrorCount
          ,le.recent_payment_date_ALLOW_ErrorCount,le.recent_payment_date_CUSTOM_ErrorCount,le.recent_payment_date_LENGTH_ErrorCount
          ,le.remaining_balance_ALLOW_ErrorCount
          ,le.carried_over_amount_ALLOW_ErrorCount
          ,le.new_applied_charges_ALLOW_ErrorCount
          ,le.balloon_payment_due_ALLOW_ErrorCount
          ,le.balloon_payment_due_date_ALLOW_ErrorCount,le.balloon_payment_due_date_CUSTOM_ErrorCount,le.balloon_payment_due_date_LENGTH_ErrorCount
          ,le.delinquency_date_ALLOW_ErrorCount,le.delinquency_date_CUSTOM_ErrorCount,le.delinquency_date_LENGTH_ErrorCount
          ,le.days_delinquent_ALLOW_ErrorCount
          ,le.past_due_amount_ALLOW_ErrorCount
          ,le.maximum_number_of_past_due_aging_amounts_buckets_provided_ENUM_ErrorCount
          ,le.past_due_aging_bucket_type_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_1_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_2_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_3_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_4_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_5_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_6_ALLOW_ErrorCount
          ,le.past_due_aging_amount_bucket_7_ALLOW_ErrorCount
          ,le.maximum_number_of_payment_tracking_cycle_periods_provided_ENUM_ErrorCount
          ,le.payment_tracking_cycle_type_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_0_current_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_1_1_to_30_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_2_31_to_60_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_3_61_to_90_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_4_91_to_120_days_ALLOW_ErrorCount
          ,le.payment_tracking_cycle_5_121_to_150days_ALLOW_ErrorCount
          ,le.payment_tracking_number_of_times_cycle_6_151_to_180_days_ALLOW_ErrorCount
          ,le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_ALLOW_ErrorCount
          ,le.date_account_was_charged_off_ALLOW_ErrorCount,le.date_account_was_charged_off_CUSTOM_ErrorCount,le.date_account_was_charged_off_LENGTH_ErrorCount
          ,le.amount_charged_off_by_creditor_ALLOW_ErrorCount
          ,le.charge_off_type_indicator_ENUM_ErrorCount
          ,le.total_charge_off_recoveries_to_date_ALLOW_ErrorCount
          ,le.government_guarantee_flag_ENUM_ErrorCount
          ,le.government_guarantee_category_ENUM_ErrorCount
          ,le.portion_of_account_guaranteed_by_government_ALLOW_ErrorCount
          ,le.guarantors_indicator_ENUM_ErrorCount
          ,le.number_of_guarantors_ALLOW_ErrorCount
          ,le.owners_indicator_ENUM_ErrorCount
          ,le.number_of_principals_ALLOW_ErrorCount
          ,le.account_update_deletion_indicator_ENUM_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,190,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
