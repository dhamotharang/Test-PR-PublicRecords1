IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AB_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(AB_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_holder_business_name_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 company_website_Invalid;
    UNSIGNED1 legal_business_structure_Invalid;
    UNSIGNED1 business_established_date_Invalid;
    UNSIGNED1 contract_account_number_Invalid;
    UNSIGNED1 account_type_reported_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(AB_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(AB_Layout_Business_Credit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.segment_identifier_Invalid := AB_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := AB_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := AB_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number);
    SELF.account_holder_business_name_Invalid := AB_Fields.InValid_account_holder_business_name((SALT33.StrType)le.account_holder_business_name);
    SELF.dba_Invalid := AB_Fields.InValid_dba((SALT33.StrType)le.dba);
    SELF.company_website_Invalid := AB_Fields.InValid_company_website((SALT33.StrType)le.company_website);
    SELF.legal_business_structure_Invalid := AB_Fields.InValid_legal_business_structure((SALT33.StrType)le.legal_business_structure);
    SELF.business_established_date_Invalid := AB_Fields.InValid_business_established_date((SALT33.StrType)le.business_established_date);
    SELF.contract_account_number_Invalid := AB_Fields.InValid_contract_account_number((SALT33.StrType)le.contract_account_number);
    SELF.account_type_reported_Invalid := AB_Fields.InValid_account_type_reported((SALT33.StrType)le.account_type_reported);
    SELF.account_status_1_Invalid := AB_Fields.InValid_account_status_1((SALT33.StrType)le.account_status_1);
    SELF.account_status_2_Invalid := AB_Fields.InValid_account_status_2((SALT33.StrType)le.account_status_2);
    SELF.date_account_opened_Invalid := AB_Fields.InValid_date_account_opened((SALT33.StrType)le.date_account_opened);
    SELF.date_account_closed_Invalid := AB_Fields.InValid_date_account_closed((SALT33.StrType)le.date_account_closed);
    SELF.account_closure_basis_Invalid := AB_Fields.InValid_account_closure_basis((SALT33.StrType)le.account_closure_basis);
    SELF.account_expiration_date_Invalid := AB_Fields.InValid_account_expiration_date((SALT33.StrType)le.account_expiration_date);
    SELF.last_activity_date_Invalid := AB_Fields.InValid_last_activity_date((SALT33.StrType)le.last_activity_date);
    SELF.last_activity_type_Invalid := AB_Fields.InValid_last_activity_type((SALT33.StrType)le.last_activity_type);
    SELF.recent_activity_indicator_Invalid := AB_Fields.InValid_recent_activity_indicator((SALT33.StrType)le.recent_activity_indicator);
    SELF.original_credit_limit_Invalid := AB_Fields.InValid_original_credit_limit((SALT33.StrType)le.original_credit_limit);
    SELF.highest_credit_used_Invalid := AB_Fields.InValid_highest_credit_used((SALT33.StrType)le.highest_credit_used);
    SELF.current_credit_limit_Invalid := AB_Fields.InValid_current_credit_limit((SALT33.StrType)le.current_credit_limit);
    SELF.reporting_indicator_length_Invalid := AB_Fields.InValid_reporting_indicator_length((SALT33.StrType)le.reporting_indicator_length);
    SELF.payment_interval_Invalid := AB_Fields.InValid_payment_interval((SALT33.StrType)le.payment_interval);
    SELF.payment_status_category_Invalid := AB_Fields.InValid_payment_status_category((SALT33.StrType)le.payment_status_category);
    SELF.term_of_account_in_months_Invalid := AB_Fields.InValid_term_of_account_in_months((SALT33.StrType)le.term_of_account_in_months);
    SELF.first_payment_due_date_Invalid := AB_Fields.InValid_first_payment_due_date((SALT33.StrType)le.first_payment_due_date);
    SELF.final_payment_due_date_Invalid := AB_Fields.InValid_final_payment_due_date((SALT33.StrType)le.final_payment_due_date);
    SELF.original_rate_Invalid := AB_Fields.InValid_original_rate((SALT33.StrType)le.original_rate);
    SELF.floating_rate_Invalid := AB_Fields.InValid_floating_rate((SALT33.StrType)le.floating_rate);
    SELF.grace_period_Invalid := AB_Fields.InValid_grace_period((SALT33.StrType)le.grace_period);
    SELF.payment_category_Invalid := AB_Fields.InValid_payment_category((SALT33.StrType)le.payment_category);
    SELF.payment_history_profile_12_months_Invalid := AB_Fields.InValid_payment_history_profile_12_months((SALT33.StrType)le.payment_history_profile_12_months);
    SELF.payment_history_profile_13_24_months_Invalid := AB_Fields.InValid_payment_history_profile_13_24_months((SALT33.StrType)le.payment_history_profile_13_24_months);
    SELF.payment_history_profile_25_36_months_Invalid := AB_Fields.InValid_payment_history_profile_25_36_months((SALT33.StrType)le.payment_history_profile_25_36_months);
    SELF.payment_history_profile_37_48_months_Invalid := AB_Fields.InValid_payment_history_profile_37_48_months((SALT33.StrType)le.payment_history_profile_37_48_months);
    SELF.payment_history_length_Invalid := AB_Fields.InValid_payment_history_length((SALT33.StrType)le.payment_history_length);
    SELF.year_to_date_purchases_count_Invalid := AB_Fields.InValid_year_to_date_purchases_count((SALT33.StrType)le.year_to_date_purchases_count);
    SELF.lifetime_to_date_purchases_count_Invalid := AB_Fields.InValid_lifetime_to_date_purchases_count((SALT33.StrType)le.lifetime_to_date_purchases_count);
    SELF.year_to_date_purchases_sum_amount_Invalid := AB_Fields.InValid_year_to_date_purchases_sum_amount((SALT33.StrType)le.year_to_date_purchases_sum_amount);
    SELF.lifetime_to_date_purchases_sum_amount_Invalid := AB_Fields.InValid_lifetime_to_date_purchases_sum_amount((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount);
    SELF.payment_amount_scheduled_Invalid := AB_Fields.InValid_payment_amount_scheduled((SALT33.StrType)le.payment_amount_scheduled);
    SELF.recent_payment_amount_Invalid := AB_Fields.InValid_recent_payment_amount((SALT33.StrType)le.recent_payment_amount);
    SELF.recent_payment_date_Invalid := AB_Fields.InValid_recent_payment_date((SALT33.StrType)le.recent_payment_date);
    SELF.remaining_balance_Invalid := AB_Fields.InValid_remaining_balance((SALT33.StrType)le.remaining_balance);
    SELF.carried_over_amount_Invalid := AB_Fields.InValid_carried_over_amount((SALT33.StrType)le.carried_over_amount);
    SELF.new_applied_charges_Invalid := AB_Fields.InValid_new_applied_charges((SALT33.StrType)le.new_applied_charges);
    SELF.balloon_payment_due_Invalid := AB_Fields.InValid_balloon_payment_due((SALT33.StrType)le.balloon_payment_due);
    SELF.balloon_payment_due_date_Invalid := AB_Fields.InValid_balloon_payment_due_date((SALT33.StrType)le.balloon_payment_due_date);
    SELF.delinquency_date_Invalid := AB_Fields.InValid_delinquency_date((SALT33.StrType)le.delinquency_date);
    SELF.days_delinquent_Invalid := AB_Fields.InValid_days_delinquent((SALT33.StrType)le.days_delinquent);
    SELF.past_due_amount_Invalid := AB_Fields.InValid_past_due_amount((SALT33.StrType)le.past_due_amount);
    SELF.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid := AB_Fields.InValid_maximum_number_of_past_due_aging_amounts_buckets_provided((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided);
    SELF.past_due_aging_bucket_type_Invalid := AB_Fields.InValid_past_due_aging_bucket_type((SALT33.StrType)le.past_due_aging_bucket_type);
    SELF.past_due_aging_amount_bucket_1_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_1((SALT33.StrType)le.past_due_aging_amount_bucket_1);
    SELF.past_due_aging_amount_bucket_2_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_2((SALT33.StrType)le.past_due_aging_amount_bucket_2);
    SELF.past_due_aging_amount_bucket_3_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_3((SALT33.StrType)le.past_due_aging_amount_bucket_3);
    SELF.past_due_aging_amount_bucket_4_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_4((SALT33.StrType)le.past_due_aging_amount_bucket_4);
    SELF.past_due_aging_amount_bucket_5_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_5((SALT33.StrType)le.past_due_aging_amount_bucket_5);
    SELF.past_due_aging_amount_bucket_6_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_6((SALT33.StrType)le.past_due_aging_amount_bucket_6);
    SELF.past_due_aging_amount_bucket_7_Invalid := AB_Fields.InValid_past_due_aging_amount_bucket_7((SALT33.StrType)le.past_due_aging_amount_bucket_7);
    SELF.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid := AB_Fields.InValid_maximum_number_of_payment_tracking_cycle_periods_provided((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided);
    SELF.payment_tracking_cycle_type_Invalid := AB_Fields.InValid_payment_tracking_cycle_type((SALT33.StrType)le.payment_tracking_cycle_type);
    SELF.payment_tracking_cycle_0_current_Invalid := AB_Fields.InValid_payment_tracking_cycle_0_current((SALT33.StrType)le.payment_tracking_cycle_0_current);
    SELF.payment_tracking_cycle_1_1_to_30_days_Invalid := AB_Fields.InValid_payment_tracking_cycle_1_1_to_30_days((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days);
    SELF.payment_tracking_cycle_2_31_to_60_days_Invalid := AB_Fields.InValid_payment_tracking_cycle_2_31_to_60_days((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days);
    SELF.payment_tracking_cycle_3_61_to_90_days_Invalid := AB_Fields.InValid_payment_tracking_cycle_3_61_to_90_days((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days);
    SELF.payment_tracking_cycle_4_91_to_120_days_Invalid := AB_Fields.InValid_payment_tracking_cycle_4_91_to_120_days((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days);
    SELF.payment_tracking_cycle_5_121_to_150days_Invalid := AB_Fields.InValid_payment_tracking_cycle_5_121_to_150days((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days);
    SELF.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid := AB_Fields.InValid_payment_tracking_number_of_times_cycle_6_151_to_180_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days);
    SELF.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid := AB_Fields.InValid_payment_tracking_number_of_times_cycle_7_181_or_greater_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days);
    SELF.date_account_was_charged_off_Invalid := AB_Fields.InValid_date_account_was_charged_off((SALT33.StrType)le.date_account_was_charged_off);
    SELF.amount_charged_off_by_creditor_Invalid := AB_Fields.InValid_amount_charged_off_by_creditor((SALT33.StrType)le.amount_charged_off_by_creditor);
    SELF.charge_off_type_indicator_Invalid := AB_Fields.InValid_charge_off_type_indicator((SALT33.StrType)le.charge_off_type_indicator);
    SELF.total_charge_off_recoveries_to_date_Invalid := AB_Fields.InValid_total_charge_off_recoveries_to_date((SALT33.StrType)le.total_charge_off_recoveries_to_date);
    SELF.government_guarantee_flag_Invalid := AB_Fields.InValid_government_guarantee_flag((SALT33.StrType)le.government_guarantee_flag);
    SELF.government_guarantee_category_Invalid := AB_Fields.InValid_government_guarantee_category((SALT33.StrType)le.government_guarantee_category);
    SELF.portion_of_account_guaranteed_by_government_Invalid := AB_Fields.InValid_portion_of_account_guaranteed_by_government((SALT33.StrType)le.portion_of_account_guaranteed_by_government);
    SELF.guarantors_indicator_Invalid := AB_Fields.InValid_guarantors_indicator((SALT33.StrType)le.guarantors_indicator);
    SELF.number_of_guarantors_Invalid := AB_Fields.InValid_number_of_guarantors((SALT33.StrType)le.number_of_guarantors);
    SELF.owners_indicator_Invalid := AB_Fields.InValid_owners_indicator((SALT33.StrType)le.owners_indicator);
    SELF.number_of_principals_Invalid := AB_Fields.InValid_number_of_principals((SALT33.StrType)le.number_of_principals);
    SELF.account_update_deletion_indicator_Invalid := AB_Fields.InValid_account_update_deletion_indicator((SALT33.StrType)le.account_update_deletion_indicator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),AB_Layout_Business_Credit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_holder_business_name_Invalid << 5 ) + ( le.dba_Invalid << 7 ) + ( le.company_website_Invalid << 8 ) + ( le.legal_business_structure_Invalid << 9 ) + ( le.business_established_date_Invalid << 10 ) + ( le.contract_account_number_Invalid << 12 ) + ( le.account_type_reported_Invalid << 14 ) + ( le.account_status_1_Invalid << 15 ) + ( le.account_status_2_Invalid << 16 ) + ( le.date_account_opened_Invalid << 17 ) + ( le.date_account_closed_Invalid << 19 ) + ( le.account_closure_basis_Invalid << 21 ) + ( le.account_expiration_date_Invalid << 22 ) + ( le.last_activity_date_Invalid << 24 ) + ( le.last_activity_type_Invalid << 26 ) + ( le.recent_activity_indicator_Invalid << 27 ) + ( le.original_credit_limit_Invalid << 28 ) + ( le.highest_credit_used_Invalid << 29 ) + ( le.current_credit_limit_Invalid << 30 ) + ( le.reporting_indicator_length_Invalid << 31 ) + ( le.payment_interval_Invalid << 32 ) + ( le.payment_status_category_Invalid << 33 ) + ( le.term_of_account_in_months_Invalid << 34 ) + ( le.first_payment_due_date_Invalid << 35 ) + ( le.final_payment_due_date_Invalid << 37 ) + ( le.original_rate_Invalid << 39 ) + ( le.floating_rate_Invalid << 40 ) + ( le.grace_period_Invalid << 41 ) + ( le.payment_category_Invalid << 42 ) + ( le.payment_history_profile_12_months_Invalid << 43 ) + ( le.payment_history_profile_13_24_months_Invalid << 44 ) + ( le.payment_history_profile_25_36_months_Invalid << 45 ) + ( le.payment_history_profile_37_48_months_Invalid << 46 ) + ( le.payment_history_length_Invalid << 47 ) + ( le.year_to_date_purchases_count_Invalid << 48 ) + ( le.lifetime_to_date_purchases_count_Invalid << 49 ) + ( le.year_to_date_purchases_sum_amount_Invalid << 50 ) + ( le.lifetime_to_date_purchases_sum_amount_Invalid << 51 ) + ( le.payment_amount_scheduled_Invalid << 52 ) + ( le.recent_payment_amount_Invalid << 53 ) + ( le.recent_payment_date_Invalid << 54 ) + ( le.remaining_balance_Invalid << 56 ) + ( le.carried_over_amount_Invalid << 57 ) + ( le.new_applied_charges_Invalid << 58 ) + ( le.balloon_payment_due_Invalid << 59 ) + ( le.balloon_payment_due_date_Invalid << 60 ) + ( le.delinquency_date_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.days_delinquent_Invalid << 0 ) + ( le.past_due_amount_Invalid << 1 ) + ( le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid << 2 ) + ( le.past_due_aging_bucket_type_Invalid << 3 ) + ( le.past_due_aging_amount_bucket_1_Invalid << 4 ) + ( le.past_due_aging_amount_bucket_2_Invalid << 5 ) + ( le.past_due_aging_amount_bucket_3_Invalid << 6 ) + ( le.past_due_aging_amount_bucket_4_Invalid << 7 ) + ( le.past_due_aging_amount_bucket_5_Invalid << 8 ) + ( le.past_due_aging_amount_bucket_6_Invalid << 9 ) + ( le.past_due_aging_amount_bucket_7_Invalid << 10 ) + ( le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid << 11 ) + ( le.payment_tracking_cycle_type_Invalid << 12 ) + ( le.payment_tracking_cycle_0_current_Invalid << 13 ) + ( le.payment_tracking_cycle_1_1_to_30_days_Invalid << 14 ) + ( le.payment_tracking_cycle_2_31_to_60_days_Invalid << 15 ) + ( le.payment_tracking_cycle_3_61_to_90_days_Invalid << 16 ) + ( le.payment_tracking_cycle_4_91_to_120_days_Invalid << 17 ) + ( le.payment_tracking_cycle_5_121_to_150days_Invalid << 18 ) + ( le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid << 19 ) + ( le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid << 20 ) + ( le.date_account_was_charged_off_Invalid << 21 ) + ( le.amount_charged_off_by_creditor_Invalid << 23 ) + ( le.charge_off_type_indicator_Invalid << 24 ) + ( le.total_charge_off_recoveries_to_date_Invalid << 25 ) + ( le.government_guarantee_flag_Invalid << 26 ) + ( le.government_guarantee_category_Invalid << 27 ) + ( le.portion_of_account_guaranteed_by_government_Invalid << 28 ) + ( le.guarantors_indicator_Invalid << 29 ) + ( le.number_of_guarantors_Invalid << 30 ) + ( le.owners_indicator_Invalid << 31 ) + ( le.number_of_principals_Invalid << 32 ) + ( le.account_update_deletion_indicator_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,AB_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_holder_business_name_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.company_website_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.legal_business_structure_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.business_established_date_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.contract_account_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.account_type_reported_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.account_status_1_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.account_status_2_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.date_account_opened_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.date_account_closed_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.account_closure_basis_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.account_expiration_date_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.last_activity_date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.last_activity_type_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.recent_activity_indicator_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.original_credit_limit_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.highest_credit_used_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.current_credit_limit_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.reporting_indicator_length_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.payment_interval_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.payment_status_category_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.term_of_account_in_months_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.first_payment_due_date_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.final_payment_due_date_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.original_rate_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.floating_rate_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.grace_period_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.payment_category_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.payment_history_profile_12_months_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.payment_history_profile_13_24_months_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.payment_history_profile_25_36_months_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.payment_history_profile_37_48_months_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.payment_history_length_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.year_to_date_purchases_count_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.lifetime_to_date_purchases_count_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.year_to_date_purchases_sum_amount_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.lifetime_to_date_purchases_sum_amount_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.payment_amount_scheduled_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.recent_payment_amount_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.recent_payment_date_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.remaining_balance_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.carried_over_amount_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.new_applied_charges_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.balloon_payment_due_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.balloon_payment_due_date_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.delinquency_date_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.days_delinquent_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.past_due_amount_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.past_due_aging_bucket_type_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.past_due_aging_amount_bucket_1_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.past_due_aging_amount_bucket_2_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.past_due_aging_amount_bucket_3_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.past_due_aging_amount_bucket_4_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.past_due_aging_amount_bucket_5_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.past_due_aging_amount_bucket_6_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.past_due_aging_amount_bucket_7_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.payment_tracking_cycle_type_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.payment_tracking_cycle_0_current_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.payment_tracking_cycle_1_1_to_30_days_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.payment_tracking_cycle_2_31_to_60_days_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.payment_tracking_cycle_3_61_to_90_days_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.payment_tracking_cycle_4_91_to_120_days_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.payment_tracking_cycle_5_121_to_150days_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.date_account_was_charged_off_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.amount_charged_off_by_creditor_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.charge_off_type_indicator_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.total_charge_off_recoveries_to_date_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.government_guarantee_flag_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.government_guarantee_category_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.portion_of_account_guaranteed_by_government_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.guarantors_indicator_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.number_of_guarantors_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.owners_indicator_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.number_of_principals_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.account_update_deletion_indicator_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    segment_identifier_ENUM_ErrorCount := COUNT(GROUP,h.segment_identifier_Invalid=1);
    file_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=1);
    file_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=2);
    file_sequence_number_Total_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid>0);
    parent_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=1);
    parent_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=2);
    parent_sequence_number_Total_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid>0);
    account_holder_business_name_ALLOW_ErrorCount := COUNT(GROUP,h.account_holder_business_name_Invalid=1);
    account_holder_business_name_LENGTH_ErrorCount := COUNT(GROUP,h.account_holder_business_name_Invalid=2);
    account_holder_business_name_Total_ErrorCount := COUNT(GROUP,h.account_holder_business_name_Invalid>0);
    dba_ALLOW_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    company_website_ALLOW_ErrorCount := COUNT(GROUP,h.company_website_Invalid=1);
    legal_business_structure_ENUM_ErrorCount := COUNT(GROUP,h.legal_business_structure_Invalid=1);
    business_established_date_ALLOW_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid=1);
    business_established_date_CUSTOM_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid=2);
    business_established_date_LENGTH_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid=3);
    business_established_date_Total_ErrorCount := COUNT(GROUP,h.business_established_date_Invalid>0);
    contract_account_number_ALLOW_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid=1);
    contract_account_number_LENGTH_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid=2);
    contract_account_number_Total_ErrorCount := COUNT(GROUP,h.contract_account_number_Invalid>0);
    account_type_reported_ENUM_ErrorCount := COUNT(GROUP,h.account_type_reported_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_holder_business_name_Invalid,le.dba_Invalid,le.company_website_Invalid,le.legal_business_structure_Invalid,le.business_established_date_Invalid,le.contract_account_number_Invalid,le.account_type_reported_Invalid,le.account_status_1_Invalid,le.account_status_2_Invalid,le.date_account_opened_Invalid,le.date_account_closed_Invalid,le.account_closure_basis_Invalid,le.account_expiration_date_Invalid,le.last_activity_date_Invalid,le.last_activity_type_Invalid,le.recent_activity_indicator_Invalid,le.original_credit_limit_Invalid,le.highest_credit_used_Invalid,le.current_credit_limit_Invalid,le.reporting_indicator_length_Invalid,le.payment_interval_Invalid,le.payment_status_category_Invalid,le.term_of_account_in_months_Invalid,le.first_payment_due_date_Invalid,le.final_payment_due_date_Invalid,le.original_rate_Invalid,le.floating_rate_Invalid,le.grace_period_Invalid,le.payment_category_Invalid,le.payment_history_profile_12_months_Invalid,le.payment_history_profile_13_24_months_Invalid,le.payment_history_profile_25_36_months_Invalid,le.payment_history_profile_37_48_months_Invalid,le.payment_history_length_Invalid,le.year_to_date_purchases_count_Invalid,le.lifetime_to_date_purchases_count_Invalid,le.year_to_date_purchases_sum_amount_Invalid,le.lifetime_to_date_purchases_sum_amount_Invalid,le.payment_amount_scheduled_Invalid,le.recent_payment_amount_Invalid,le.recent_payment_date_Invalid,le.remaining_balance_Invalid,le.carried_over_amount_Invalid,le.new_applied_charges_Invalid,le.balloon_payment_due_Invalid,le.balloon_payment_due_date_Invalid,le.delinquency_date_Invalid,le.days_delinquent_Invalid,le.past_due_amount_Invalid,le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid,le.past_due_aging_bucket_type_Invalid,le.past_due_aging_amount_bucket_1_Invalid,le.past_due_aging_amount_bucket_2_Invalid,le.past_due_aging_amount_bucket_3_Invalid,le.past_due_aging_amount_bucket_4_Invalid,le.past_due_aging_amount_bucket_5_Invalid,le.past_due_aging_amount_bucket_6_Invalid,le.past_due_aging_amount_bucket_7_Invalid,le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid,le.payment_tracking_cycle_type_Invalid,le.payment_tracking_cycle_0_current_Invalid,le.payment_tracking_cycle_1_1_to_30_days_Invalid,le.payment_tracking_cycle_2_31_to_60_days_Invalid,le.payment_tracking_cycle_3_61_to_90_days_Invalid,le.payment_tracking_cycle_4_91_to_120_days_Invalid,le.payment_tracking_cycle_5_121_to_150days_Invalid,le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid,le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid,le.date_account_was_charged_off_Invalid,le.amount_charged_off_by_creditor_Invalid,le.charge_off_type_indicator_Invalid,le.total_charge_off_recoveries_to_date_Invalid,le.government_guarantee_flag_Invalid,le.government_guarantee_category_Invalid,le.portion_of_account_guaranteed_by_government_Invalid,le.guarantors_indicator_Invalid,le.number_of_guarantors_Invalid,le.owners_indicator_Invalid,le.number_of_principals_Invalid,le.account_update_deletion_indicator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,AB_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),AB_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),AB_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),AB_Fields.InvalidMessage_account_holder_business_name(le.account_holder_business_name_Invalid),AB_Fields.InvalidMessage_dba(le.dba_Invalid),AB_Fields.InvalidMessage_company_website(le.company_website_Invalid),AB_Fields.InvalidMessage_legal_business_structure(le.legal_business_structure_Invalid),AB_Fields.InvalidMessage_business_established_date(le.business_established_date_Invalid),AB_Fields.InvalidMessage_contract_account_number(le.contract_account_number_Invalid),AB_Fields.InvalidMessage_account_type_reported(le.account_type_reported_Invalid),AB_Fields.InvalidMessage_account_status_1(le.account_status_1_Invalid),AB_Fields.InvalidMessage_account_status_2(le.account_status_2_Invalid),AB_Fields.InvalidMessage_date_account_opened(le.date_account_opened_Invalid),AB_Fields.InvalidMessage_date_account_closed(le.date_account_closed_Invalid),AB_Fields.InvalidMessage_account_closure_basis(le.account_closure_basis_Invalid),AB_Fields.InvalidMessage_account_expiration_date(le.account_expiration_date_Invalid),AB_Fields.InvalidMessage_last_activity_date(le.last_activity_date_Invalid),AB_Fields.InvalidMessage_last_activity_type(le.last_activity_type_Invalid),AB_Fields.InvalidMessage_recent_activity_indicator(le.recent_activity_indicator_Invalid),AB_Fields.InvalidMessage_original_credit_limit(le.original_credit_limit_Invalid),AB_Fields.InvalidMessage_highest_credit_used(le.highest_credit_used_Invalid),AB_Fields.InvalidMessage_current_credit_limit(le.current_credit_limit_Invalid),AB_Fields.InvalidMessage_reporting_indicator_length(le.reporting_indicator_length_Invalid),AB_Fields.InvalidMessage_payment_interval(le.payment_interval_Invalid),AB_Fields.InvalidMessage_payment_status_category(le.payment_status_category_Invalid),AB_Fields.InvalidMessage_term_of_account_in_months(le.term_of_account_in_months_Invalid),AB_Fields.InvalidMessage_first_payment_due_date(le.first_payment_due_date_Invalid),AB_Fields.InvalidMessage_final_payment_due_date(le.final_payment_due_date_Invalid),AB_Fields.InvalidMessage_original_rate(le.original_rate_Invalid),AB_Fields.InvalidMessage_floating_rate(le.floating_rate_Invalid),AB_Fields.InvalidMessage_grace_period(le.grace_period_Invalid),AB_Fields.InvalidMessage_payment_category(le.payment_category_Invalid),AB_Fields.InvalidMessage_payment_history_profile_12_months(le.payment_history_profile_12_months_Invalid),AB_Fields.InvalidMessage_payment_history_profile_13_24_months(le.payment_history_profile_13_24_months_Invalid),AB_Fields.InvalidMessage_payment_history_profile_25_36_months(le.payment_history_profile_25_36_months_Invalid),AB_Fields.InvalidMessage_payment_history_profile_37_48_months(le.payment_history_profile_37_48_months_Invalid),AB_Fields.InvalidMessage_payment_history_length(le.payment_history_length_Invalid),AB_Fields.InvalidMessage_year_to_date_purchases_count(le.year_to_date_purchases_count_Invalid),AB_Fields.InvalidMessage_lifetime_to_date_purchases_count(le.lifetime_to_date_purchases_count_Invalid),AB_Fields.InvalidMessage_year_to_date_purchases_sum_amount(le.year_to_date_purchases_sum_amount_Invalid),AB_Fields.InvalidMessage_lifetime_to_date_purchases_sum_amount(le.lifetime_to_date_purchases_sum_amount_Invalid),AB_Fields.InvalidMessage_payment_amount_scheduled(le.payment_amount_scheduled_Invalid),AB_Fields.InvalidMessage_recent_payment_amount(le.recent_payment_amount_Invalid),AB_Fields.InvalidMessage_recent_payment_date(le.recent_payment_date_Invalid),AB_Fields.InvalidMessage_remaining_balance(le.remaining_balance_Invalid),AB_Fields.InvalidMessage_carried_over_amount(le.carried_over_amount_Invalid),AB_Fields.InvalidMessage_new_applied_charges(le.new_applied_charges_Invalid),AB_Fields.InvalidMessage_balloon_payment_due(le.balloon_payment_due_Invalid),AB_Fields.InvalidMessage_balloon_payment_due_date(le.balloon_payment_due_date_Invalid),AB_Fields.InvalidMessage_delinquency_date(le.delinquency_date_Invalid),AB_Fields.InvalidMessage_days_delinquent(le.days_delinquent_Invalid),AB_Fields.InvalidMessage_past_due_amount(le.past_due_amount_Invalid),AB_Fields.InvalidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(le.maximum_number_of_past_due_aging_amounts_buckets_provided_Invalid),AB_Fields.InvalidMessage_past_due_aging_bucket_type(le.past_due_aging_bucket_type_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_1(le.past_due_aging_amount_bucket_1_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_2(le.past_due_aging_amount_bucket_2_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_3(le.past_due_aging_amount_bucket_3_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_4(le.past_due_aging_amount_bucket_4_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_5(le.past_due_aging_amount_bucket_5_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_6(le.past_due_aging_amount_bucket_6_Invalid),AB_Fields.InvalidMessage_past_due_aging_amount_bucket_7(le.past_due_aging_amount_bucket_7_Invalid),AB_Fields.InvalidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(le.maximum_number_of_payment_tracking_cycle_periods_provided_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_type(le.payment_tracking_cycle_type_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_0_current(le.payment_tracking_cycle_0_current_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_1_1_to_30_days(le.payment_tracking_cycle_1_1_to_30_days_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_2_31_to_60_days(le.payment_tracking_cycle_2_31_to_60_days_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_3_61_to_90_days(le.payment_tracking_cycle_3_61_to_90_days_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_4_91_to_120_days(le.payment_tracking_cycle_4_91_to_120_days_Invalid),AB_Fields.InvalidMessage_payment_tracking_cycle_5_121_to_150days(le.payment_tracking_cycle_5_121_to_150days_Invalid),AB_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(le.payment_tracking_number_of_times_cycle_6_151_to_180_days_Invalid),AB_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(le.payment_tracking_number_of_times_cycle_7_181_or_greater_days_Invalid),AB_Fields.InvalidMessage_date_account_was_charged_off(le.date_account_was_charged_off_Invalid),AB_Fields.InvalidMessage_amount_charged_off_by_creditor(le.amount_charged_off_by_creditor_Invalid),AB_Fields.InvalidMessage_charge_off_type_indicator(le.charge_off_type_indicator_Invalid),AB_Fields.InvalidMessage_total_charge_off_recoveries_to_date(le.total_charge_off_recoveries_to_date_Invalid),AB_Fields.InvalidMessage_government_guarantee_flag(le.government_guarantee_flag_Invalid),AB_Fields.InvalidMessage_government_guarantee_category(le.government_guarantee_category_Invalid),AB_Fields.InvalidMessage_portion_of_account_guaranteed_by_government(le.portion_of_account_guaranteed_by_government_Invalid),AB_Fields.InvalidMessage_guarantors_indicator(le.guarantors_indicator_Invalid),AB_Fields.InvalidMessage_number_of_guarantors(le.number_of_guarantors_Invalid),AB_Fields.InvalidMessage_owners_indicator(le.owners_indicator_Invalid),AB_Fields.InvalidMessage_number_of_principals(le.number_of_principals_Invalid),AB_Fields.InvalidMessage_account_update_deletion_indicator(le.account_update_deletion_indicator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_holder_business_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.legal_business_structure_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.business_established_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.contract_account_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.account_type_reported_Invalid,'ENUM','UNKNOWN')
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
          ,CHOOSE(le.account_update_deletion_indicator_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_holder_business_name','dba','company_website','legal_business_structure','business_established_date','contract_account_number','account_type_reported','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_segment_num','invalid_parent_sequence_number','invalid_accholder_businessname','invalid_dba','invalid_comp_website','invalid_legal_busi_structure','invalid_busi_established_date','invalid_contractacc_num','invalid_accounttypereported','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_floatingrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_num_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket_1','invalid_past_due_aging_amount_bucket_2','invalid_past_due_aging_amount_bucket_3','invalid_past_due_aging_amount_bucket_4','invalid_past_due_aging_amount_bucket_5','invalid_past_due_aging_amount_bucket_6','invalid_past_due_aging_amount_bucket_7','invalid_maximum_num_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_num','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.segment_identifier,(SALT33.StrType)le.file_sequence_number,(SALT33.StrType)le.parent_sequence_number,(SALT33.StrType)le.account_holder_business_name,(SALT33.StrType)le.dba,(SALT33.StrType)le.company_website,(SALT33.StrType)le.legal_business_structure,(SALT33.StrType)le.business_established_date,(SALT33.StrType)le.contract_account_number,(SALT33.StrType)le.account_type_reported,(SALT33.StrType)le.account_status_1,(SALT33.StrType)le.account_status_2,(SALT33.StrType)le.date_account_opened,(SALT33.StrType)le.date_account_closed,(SALT33.StrType)le.account_closure_basis,(SALT33.StrType)le.account_expiration_date,(SALT33.StrType)le.last_activity_date,(SALT33.StrType)le.last_activity_type,(SALT33.StrType)le.recent_activity_indicator,(SALT33.StrType)le.original_credit_limit,(SALT33.StrType)le.highest_credit_used,(SALT33.StrType)le.current_credit_limit,(SALT33.StrType)le.reporting_indicator_length,(SALT33.StrType)le.payment_interval,(SALT33.StrType)le.payment_status_category,(SALT33.StrType)le.term_of_account_in_months,(SALT33.StrType)le.first_payment_due_date,(SALT33.StrType)le.final_payment_due_date,(SALT33.StrType)le.original_rate,(SALT33.StrType)le.floating_rate,(SALT33.StrType)le.grace_period,(SALT33.StrType)le.payment_category,(SALT33.StrType)le.payment_history_profile_12_months,(SALT33.StrType)le.payment_history_profile_13_24_months,(SALT33.StrType)le.payment_history_profile_25_36_months,(SALT33.StrType)le.payment_history_profile_37_48_months,(SALT33.StrType)le.payment_history_length,(SALT33.StrType)le.year_to_date_purchases_count,(SALT33.StrType)le.lifetime_to_date_purchases_count,(SALT33.StrType)le.year_to_date_purchases_sum_amount,(SALT33.StrType)le.lifetime_to_date_purchases_sum_amount,(SALT33.StrType)le.payment_amount_scheduled,(SALT33.StrType)le.recent_payment_amount,(SALT33.StrType)le.recent_payment_date,(SALT33.StrType)le.remaining_balance,(SALT33.StrType)le.carried_over_amount,(SALT33.StrType)le.new_applied_charges,(SALT33.StrType)le.balloon_payment_due,(SALT33.StrType)le.balloon_payment_due_date,(SALT33.StrType)le.delinquency_date,(SALT33.StrType)le.days_delinquent,(SALT33.StrType)le.past_due_amount,(SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided,(SALT33.StrType)le.past_due_aging_bucket_type,(SALT33.StrType)le.past_due_aging_amount_bucket_1,(SALT33.StrType)le.past_due_aging_amount_bucket_2,(SALT33.StrType)le.past_due_aging_amount_bucket_3,(SALT33.StrType)le.past_due_aging_amount_bucket_4,(SALT33.StrType)le.past_due_aging_amount_bucket_5,(SALT33.StrType)le.past_due_aging_amount_bucket_6,(SALT33.StrType)le.past_due_aging_amount_bucket_7,(SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided,(SALT33.StrType)le.payment_tracking_cycle_type,(SALT33.StrType)le.payment_tracking_cycle_0_current,(SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days,(SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days,(SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days,(SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days,(SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days,(SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days,(SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days,(SALT33.StrType)le.date_account_was_charged_off,(SALT33.StrType)le.amount_charged_off_by_creditor,(SALT33.StrType)le.charge_off_type_indicator,(SALT33.StrType)le.total_charge_off_recoveries_to_date,(SALT33.StrType)le.government_guarantee_flag,(SALT33.StrType)le.government_guarantee_category,(SALT33.StrType)le.portion_of_account_guaranteed_by_government,(SALT33.StrType)le.guarantors_indicator,(SALT33.StrType)le.number_of_guarantors,(SALT33.StrType)le.owners_indicator,(SALT33.StrType)le.number_of_principals,(SALT33.StrType)le.account_update_deletion_indicator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,83,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_file_segment_num:ALLOW','file_sequence_number:invalid_file_segment_num:LENGTH'
          ,'parent_sequence_number:invalid_parent_sequence_number:ALLOW','parent_sequence_number:invalid_parent_sequence_number:LENGTH'
          ,'account_holder_business_name:invalid_accholder_businessname:ALLOW','account_holder_business_name:invalid_accholder_businessname:LENGTH'
          ,'dba:invalid_dba:ALLOW'
          ,'company_website:invalid_comp_website:ALLOW'
          ,'legal_business_structure:invalid_legal_busi_structure:ENUM'
          ,'business_established_date:invalid_busi_established_date:ALLOW','business_established_date:invalid_busi_established_date:CUSTOM','business_established_date:invalid_busi_established_date:LENGTH'
          ,'contract_account_number:invalid_contractacc_num:ALLOW','contract_account_number:invalid_contractacc_num:LENGTH'
          ,'account_type_reported:invalid_accounttypereported:ENUM'
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
          ,'floating_rate:invalid_floatingrate:ALLOW'
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
          ,'maximum_number_of_past_due_aging_amounts_buckets_provided:invalid_maximum_num_bucket:ENUM'
          ,'past_due_aging_bucket_type:invalid_past_due_aging_bucket_type:ALLOW'
          ,'past_due_aging_amount_bucket_1:invalid_past_due_aging_amount_bucket_1:ALLOW'
          ,'past_due_aging_amount_bucket_2:invalid_past_due_aging_amount_bucket_2:ALLOW'
          ,'past_due_aging_amount_bucket_3:invalid_past_due_aging_amount_bucket_3:ALLOW'
          ,'past_due_aging_amount_bucket_4:invalid_past_due_aging_amount_bucket_4:ALLOW'
          ,'past_due_aging_amount_bucket_5:invalid_past_due_aging_amount_bucket_5:ALLOW'
          ,'past_due_aging_amount_bucket_6:invalid_past_due_aging_amount_bucket_6:ALLOW'
          ,'past_due_aging_amount_bucket_7:invalid_past_due_aging_amount_bucket_7:ALLOW'
          ,'maximum_number_of_payment_tracking_cycle_periods_provided:invalid_maximum_num_tracking:ENUM'
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
          ,'account_update_deletion_indicator:invalid_account_update_deletion_indicator:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,AB_Fields.InvalidMessage_segment_identifier(1)
          ,AB_Fields.InvalidMessage_file_sequence_number(1),AB_Fields.InvalidMessage_file_sequence_number(2)
          ,AB_Fields.InvalidMessage_parent_sequence_number(1),AB_Fields.InvalidMessage_parent_sequence_number(2)
          ,AB_Fields.InvalidMessage_account_holder_business_name(1),AB_Fields.InvalidMessage_account_holder_business_name(2)
          ,AB_Fields.InvalidMessage_dba(1)
          ,AB_Fields.InvalidMessage_company_website(1)
          ,AB_Fields.InvalidMessage_legal_business_structure(1)
          ,AB_Fields.InvalidMessage_business_established_date(1),AB_Fields.InvalidMessage_business_established_date(2),AB_Fields.InvalidMessage_business_established_date(3)
          ,AB_Fields.InvalidMessage_contract_account_number(1),AB_Fields.InvalidMessage_contract_account_number(2)
          ,AB_Fields.InvalidMessage_account_type_reported(1)
          ,AB_Fields.InvalidMessage_account_status_1(1)
          ,AB_Fields.InvalidMessage_account_status_2(1)
          ,AB_Fields.InvalidMessage_date_account_opened(1),AB_Fields.InvalidMessage_date_account_opened(2),AB_Fields.InvalidMessage_date_account_opened(3)
          ,AB_Fields.InvalidMessage_date_account_closed(1),AB_Fields.InvalidMessage_date_account_closed(2),AB_Fields.InvalidMessage_date_account_closed(3)
          ,AB_Fields.InvalidMessage_account_closure_basis(1)
          ,AB_Fields.InvalidMessage_account_expiration_date(1),AB_Fields.InvalidMessage_account_expiration_date(2),AB_Fields.InvalidMessage_account_expiration_date(3)
          ,AB_Fields.InvalidMessage_last_activity_date(1),AB_Fields.InvalidMessage_last_activity_date(2),AB_Fields.InvalidMessage_last_activity_date(3)
          ,AB_Fields.InvalidMessage_last_activity_type(1)
          ,AB_Fields.InvalidMessage_recent_activity_indicator(1)
          ,AB_Fields.InvalidMessage_original_credit_limit(1)
          ,AB_Fields.InvalidMessage_highest_credit_used(1)
          ,AB_Fields.InvalidMessage_current_credit_limit(1)
          ,AB_Fields.InvalidMessage_reporting_indicator_length(1)
          ,AB_Fields.InvalidMessage_payment_interval(1)
          ,AB_Fields.InvalidMessage_payment_status_category(1)
          ,AB_Fields.InvalidMessage_term_of_account_in_months(1)
          ,AB_Fields.InvalidMessage_first_payment_due_date(1),AB_Fields.InvalidMessage_first_payment_due_date(2),AB_Fields.InvalidMessage_first_payment_due_date(3)
          ,AB_Fields.InvalidMessage_final_payment_due_date(1),AB_Fields.InvalidMessage_final_payment_due_date(2),AB_Fields.InvalidMessage_final_payment_due_date(3)
          ,AB_Fields.InvalidMessage_original_rate(1)
          ,AB_Fields.InvalidMessage_floating_rate(1)
          ,AB_Fields.InvalidMessage_grace_period(1)
          ,AB_Fields.InvalidMessage_payment_category(1)
          ,AB_Fields.InvalidMessage_payment_history_profile_12_months(1)
          ,AB_Fields.InvalidMessage_payment_history_profile_13_24_months(1)
          ,AB_Fields.InvalidMessage_payment_history_profile_25_36_months(1)
          ,AB_Fields.InvalidMessage_payment_history_profile_37_48_months(1)
          ,AB_Fields.InvalidMessage_payment_history_length(1)
          ,AB_Fields.InvalidMessage_year_to_date_purchases_count(1)
          ,AB_Fields.InvalidMessage_lifetime_to_date_purchases_count(1)
          ,AB_Fields.InvalidMessage_year_to_date_purchases_sum_amount(1)
          ,AB_Fields.InvalidMessage_lifetime_to_date_purchases_sum_amount(1)
          ,AB_Fields.InvalidMessage_payment_amount_scheduled(1)
          ,AB_Fields.InvalidMessage_recent_payment_amount(1)
          ,AB_Fields.InvalidMessage_recent_payment_date(1),AB_Fields.InvalidMessage_recent_payment_date(2),AB_Fields.InvalidMessage_recent_payment_date(3)
          ,AB_Fields.InvalidMessage_remaining_balance(1)
          ,AB_Fields.InvalidMessage_carried_over_amount(1)
          ,AB_Fields.InvalidMessage_new_applied_charges(1)
          ,AB_Fields.InvalidMessage_balloon_payment_due(1)
          ,AB_Fields.InvalidMessage_balloon_payment_due_date(1),AB_Fields.InvalidMessage_balloon_payment_due_date(2),AB_Fields.InvalidMessage_balloon_payment_due_date(3)
          ,AB_Fields.InvalidMessage_delinquency_date(1),AB_Fields.InvalidMessage_delinquency_date(2),AB_Fields.InvalidMessage_delinquency_date(3)
          ,AB_Fields.InvalidMessage_days_delinquent(1)
          ,AB_Fields.InvalidMessage_past_due_amount(1)
          ,AB_Fields.InvalidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(1)
          ,AB_Fields.InvalidMessage_past_due_aging_bucket_type(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_1(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_2(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_3(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_4(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_5(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_6(1)
          ,AB_Fields.InvalidMessage_past_due_aging_amount_bucket_7(1)
          ,AB_Fields.InvalidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_type(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_0_current(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_1_1_to_30_days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_2_31_to_60_days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_3_61_to_90_days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_4_91_to_120_days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_cycle_5_121_to_150days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(1)
          ,AB_Fields.InvalidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(1)
          ,AB_Fields.InvalidMessage_date_account_was_charged_off(1),AB_Fields.InvalidMessage_date_account_was_charged_off(2),AB_Fields.InvalidMessage_date_account_was_charged_off(3)
          ,AB_Fields.InvalidMessage_amount_charged_off_by_creditor(1)
          ,AB_Fields.InvalidMessage_charge_off_type_indicator(1)
          ,AB_Fields.InvalidMessage_total_charge_off_recoveries_to_date(1)
          ,AB_Fields.InvalidMessage_government_guarantee_flag(1)
          ,AB_Fields.InvalidMessage_government_guarantee_category(1)
          ,AB_Fields.InvalidMessage_portion_of_account_guaranteed_by_government(1)
          ,AB_Fields.InvalidMessage_guarantors_indicator(1)
          ,AB_Fields.InvalidMessage_number_of_guarantors(1)
          ,AB_Fields.InvalidMessage_owners_indicator(1)
          ,AB_Fields.InvalidMessage_number_of_principals(1)
          ,AB_Fields.InvalidMessage_account_update_deletion_indicator(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_holder_business_name_ALLOW_ErrorCount,le.account_holder_business_name_LENGTH_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.company_website_ALLOW_ErrorCount
          ,le.legal_business_structure_ENUM_ErrorCount
          ,le.business_established_date_ALLOW_ErrorCount,le.business_established_date_CUSTOM_ErrorCount,le.business_established_date_LENGTH_ErrorCount
          ,le.contract_account_number_ALLOW_ErrorCount,le.contract_account_number_LENGTH_ErrorCount
          ,le.account_type_reported_ENUM_ErrorCount
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
          ,le.account_update_deletion_indicator_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTH_ErrorCount
          ,le.account_holder_business_name_ALLOW_ErrorCount,le.account_holder_business_name_LENGTH_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.company_website_ALLOW_ErrorCount
          ,le.legal_business_structure_ENUM_ErrorCount
          ,le.business_established_date_ALLOW_ErrorCount,le.business_established_date_CUSTOM_ErrorCount,le.business_established_date_LENGTH_ErrorCount
          ,le.contract_account_number_ALLOW_ErrorCount,le.contract_account_number_LENGTH_ErrorCount
          ,le.account_type_reported_ENUM_ErrorCount
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
          ,le.account_update_deletion_indicator_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,109,Into(LEFT,COUNTER));
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
