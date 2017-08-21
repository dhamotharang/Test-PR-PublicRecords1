IMPORT ut,SALT33;
EXPORT AB_hygiene(dataset(AB_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_parent_sequence_number_pcnt := AVE(GROUP,IF(h.parent_sequence_number = (TYPEOF(h.parent_sequence_number))'',0,100));
    maxlength_parent_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)));
    avelength_parent_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.parent_sequence_number)),h.parent_sequence_number<>(typeof(h.parent_sequence_number))'');
    populated_account_holder_business_name_pcnt := AVE(GROUP,IF(h.account_holder_business_name = (TYPEOF(h.account_holder_business_name))'',0,100));
    maxlength_account_holder_business_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_holder_business_name)));
    avelength_account_holder_business_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_holder_business_name)),h.account_holder_business_name<>(typeof(h.account_holder_business_name))'');
    populated_dba_pcnt := AVE(GROUP,IF(h.dba = (TYPEOF(h.dba))'',0,100));
    maxlength_dba := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dba)));
    avelength_dba := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dba)),h.dba<>(typeof(h.dba))'');
    populated_company_website_pcnt := AVE(GROUP,IF(h.company_website = (TYPEOF(h.company_website))'',0,100));
    maxlength_company_website := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.company_website)));
    avelength_company_website := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.company_website)),h.company_website<>(typeof(h.company_website))'');
    populated_legal_business_structure_pcnt := AVE(GROUP,IF(h.legal_business_structure = (TYPEOF(h.legal_business_structure))'',0,100));
    maxlength_legal_business_structure := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_business_structure)));
    avelength_legal_business_structure := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_business_structure)),h.legal_business_structure<>(typeof(h.legal_business_structure))'');
    populated_business_established_date_pcnt := AVE(GROUP,IF(h.business_established_date = (TYPEOF(h.business_established_date))'',0,100));
    maxlength_business_established_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_established_date)));
    avelength_business_established_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_established_date)),h.business_established_date<>(typeof(h.business_established_date))'');
    populated_contract_account_number_pcnt := AVE(GROUP,IF(h.contract_account_number = (TYPEOF(h.contract_account_number))'',0,100));
    maxlength_contract_account_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.contract_account_number)));
    avelength_contract_account_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.contract_account_number)),h.contract_account_number<>(typeof(h.contract_account_number))'');
    populated_account_type_reported_pcnt := AVE(GROUP,IF(h.account_type_reported = (TYPEOF(h.account_type_reported))'',0,100));
    maxlength_account_type_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_type_reported)));
    avelength_account_type_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_type_reported)),h.account_type_reported<>(typeof(h.account_type_reported))'');
    populated_account_status_1_pcnt := AVE(GROUP,IF(h.account_status_1 = (TYPEOF(h.account_status_1))'',0,100));
    maxlength_account_status_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_1)));
    avelength_account_status_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_1)),h.account_status_1<>(typeof(h.account_status_1))'');
    populated_account_status_2_pcnt := AVE(GROUP,IF(h.account_status_2 = (TYPEOF(h.account_status_2))'',0,100));
    maxlength_account_status_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_2)));
    avelength_account_status_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_status_2)),h.account_status_2<>(typeof(h.account_status_2))'');
    populated_date_account_opened_pcnt := AVE(GROUP,IF(h.date_account_opened = (TYPEOF(h.date_account_opened))'',0,100));
    maxlength_date_account_opened := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_opened)));
    avelength_date_account_opened := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_opened)),h.date_account_opened<>(typeof(h.date_account_opened))'');
    populated_date_account_closed_pcnt := AVE(GROUP,IF(h.date_account_closed = (TYPEOF(h.date_account_closed))'',0,100));
    maxlength_date_account_closed := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_closed)));
    avelength_date_account_closed := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_closed)),h.date_account_closed<>(typeof(h.date_account_closed))'');
    populated_account_closure_basis_pcnt := AVE(GROUP,IF(h.account_closure_basis = (TYPEOF(h.account_closure_basis))'',0,100));
    maxlength_account_closure_basis := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_closure_basis)));
    avelength_account_closure_basis := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_closure_basis)),h.account_closure_basis<>(typeof(h.account_closure_basis))'');
    populated_account_expiration_date_pcnt := AVE(GROUP,IF(h.account_expiration_date = (TYPEOF(h.account_expiration_date))'',0,100));
    maxlength_account_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_expiration_date)));
    avelength_account_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_expiration_date)),h.account_expiration_date<>(typeof(h.account_expiration_date))'');
    populated_last_activity_date_pcnt := AVE(GROUP,IF(h.last_activity_date = (TYPEOF(h.last_activity_date))'',0,100));
    maxlength_last_activity_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_date)));
    avelength_last_activity_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_date)),h.last_activity_date<>(typeof(h.last_activity_date))'');
    populated_last_activity_type_pcnt := AVE(GROUP,IF(h.last_activity_type = (TYPEOF(h.last_activity_type))'',0,100));
    maxlength_last_activity_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_type)));
    avelength_last_activity_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.last_activity_type)),h.last_activity_type<>(typeof(h.last_activity_type))'');
    populated_recent_activity_indicator_pcnt := AVE(GROUP,IF(h.recent_activity_indicator = (TYPEOF(h.recent_activity_indicator))'',0,100));
    maxlength_recent_activity_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_activity_indicator)));
    avelength_recent_activity_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_activity_indicator)),h.recent_activity_indicator<>(typeof(h.recent_activity_indicator))'');
    populated_original_credit_limit_pcnt := AVE(GROUP,IF(h.original_credit_limit = (TYPEOF(h.original_credit_limit))'',0,100));
    maxlength_original_credit_limit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_credit_limit)));
    avelength_original_credit_limit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_credit_limit)),h.original_credit_limit<>(typeof(h.original_credit_limit))'');
    populated_highest_credit_used_pcnt := AVE(GROUP,IF(h.highest_credit_used = (TYPEOF(h.highest_credit_used))'',0,100));
    maxlength_highest_credit_used := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.highest_credit_used)));
    avelength_highest_credit_used := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.highest_credit_used)),h.highest_credit_used<>(typeof(h.highest_credit_used))'');
    populated_current_credit_limit_pcnt := AVE(GROUP,IF(h.current_credit_limit = (TYPEOF(h.current_credit_limit))'',0,100));
    maxlength_current_credit_limit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_credit_limit)));
    avelength_current_credit_limit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.current_credit_limit)),h.current_credit_limit<>(typeof(h.current_credit_limit))'');
    populated_reporting_indicator_length_pcnt := AVE(GROUP,IF(h.reporting_indicator_length = (TYPEOF(h.reporting_indicator_length))'',0,100));
    maxlength_reporting_indicator_length := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reporting_indicator_length)));
    avelength_reporting_indicator_length := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reporting_indicator_length)),h.reporting_indicator_length<>(typeof(h.reporting_indicator_length))'');
    populated_payment_interval_pcnt := AVE(GROUP,IF(h.payment_interval = (TYPEOF(h.payment_interval))'',0,100));
    maxlength_payment_interval := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_interval)));
    avelength_payment_interval := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_interval)),h.payment_interval<>(typeof(h.payment_interval))'');
    populated_payment_status_category_pcnt := AVE(GROUP,IF(h.payment_status_category = (TYPEOF(h.payment_status_category))'',0,100));
    maxlength_payment_status_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_status_category)));
    avelength_payment_status_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_status_category)),h.payment_status_category<>(typeof(h.payment_status_category))'');
    populated_term_of_account_in_months_pcnt := AVE(GROUP,IF(h.term_of_account_in_months = (TYPEOF(h.term_of_account_in_months))'',0,100));
    maxlength_term_of_account_in_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.term_of_account_in_months)));
    avelength_term_of_account_in_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.term_of_account_in_months)),h.term_of_account_in_months<>(typeof(h.term_of_account_in_months))'');
    populated_first_payment_due_date_pcnt := AVE(GROUP,IF(h.first_payment_due_date = (TYPEOF(h.first_payment_due_date))'',0,100));
    maxlength_first_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_payment_due_date)));
    avelength_first_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.first_payment_due_date)),h.first_payment_due_date<>(typeof(h.first_payment_due_date))'');
    populated_final_payment_due_date_pcnt := AVE(GROUP,IF(h.final_payment_due_date = (TYPEOF(h.final_payment_due_date))'',0,100));
    maxlength_final_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.final_payment_due_date)));
    avelength_final_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.final_payment_due_date)),h.final_payment_due_date<>(typeof(h.final_payment_due_date))'');
    populated_original_rate_pcnt := AVE(GROUP,IF(h.original_rate = (TYPEOF(h.original_rate))'',0,100));
    maxlength_original_rate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_rate)));
    avelength_original_rate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.original_rate)),h.original_rate<>(typeof(h.original_rate))'');
    populated_floating_rate_pcnt := AVE(GROUP,IF(h.floating_rate = (TYPEOF(h.floating_rate))'',0,100));
    maxlength_floating_rate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.floating_rate)));
    avelength_floating_rate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.floating_rate)),h.floating_rate<>(typeof(h.floating_rate))'');
    populated_grace_period_pcnt := AVE(GROUP,IF(h.grace_period = (TYPEOF(h.grace_period))'',0,100));
    maxlength_grace_period := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.grace_period)));
    avelength_grace_period := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.grace_period)),h.grace_period<>(typeof(h.grace_period))'');
    populated_payment_category_pcnt := AVE(GROUP,IF(h.payment_category = (TYPEOF(h.payment_category))'',0,100));
    maxlength_payment_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_category)));
    avelength_payment_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_category)),h.payment_category<>(typeof(h.payment_category))'');
    populated_payment_history_profile_12_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_12_months = (TYPEOF(h.payment_history_profile_12_months))'',0,100));
    maxlength_payment_history_profile_12_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_12_months)));
    avelength_payment_history_profile_12_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_12_months)),h.payment_history_profile_12_months<>(typeof(h.payment_history_profile_12_months))'');
    populated_payment_history_profile_13_24_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_13_24_months = (TYPEOF(h.payment_history_profile_13_24_months))'',0,100));
    maxlength_payment_history_profile_13_24_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_13_24_months)));
    avelength_payment_history_profile_13_24_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_13_24_months)),h.payment_history_profile_13_24_months<>(typeof(h.payment_history_profile_13_24_months))'');
    populated_payment_history_profile_25_36_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_25_36_months = (TYPEOF(h.payment_history_profile_25_36_months))'',0,100));
    maxlength_payment_history_profile_25_36_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_25_36_months)));
    avelength_payment_history_profile_25_36_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_25_36_months)),h.payment_history_profile_25_36_months<>(typeof(h.payment_history_profile_25_36_months))'');
    populated_payment_history_profile_37_48_months_pcnt := AVE(GROUP,IF(h.payment_history_profile_37_48_months = (TYPEOF(h.payment_history_profile_37_48_months))'',0,100));
    maxlength_payment_history_profile_37_48_months := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_37_48_months)));
    avelength_payment_history_profile_37_48_months := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_profile_37_48_months)),h.payment_history_profile_37_48_months<>(typeof(h.payment_history_profile_37_48_months))'');
    populated_payment_history_length_pcnt := AVE(GROUP,IF(h.payment_history_length = (TYPEOF(h.payment_history_length))'',0,100));
    maxlength_payment_history_length := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_length)));
    avelength_payment_history_length := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_history_length)),h.payment_history_length<>(typeof(h.payment_history_length))'');
    populated_year_to_date_purchases_count_pcnt := AVE(GROUP,IF(h.year_to_date_purchases_count = (TYPEOF(h.year_to_date_purchases_count))'',0,100));
    maxlength_year_to_date_purchases_count := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_count)));
    avelength_year_to_date_purchases_count := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_count)),h.year_to_date_purchases_count<>(typeof(h.year_to_date_purchases_count))'');
    populated_lifetime_to_date_purchases_count_pcnt := AVE(GROUP,IF(h.lifetime_to_date_purchases_count = (TYPEOF(h.lifetime_to_date_purchases_count))'',0,100));
    maxlength_lifetime_to_date_purchases_count := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_count)));
    avelength_lifetime_to_date_purchases_count := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_count)),h.lifetime_to_date_purchases_count<>(typeof(h.lifetime_to_date_purchases_count))'');
    populated_year_to_date_purchases_sum_amount_pcnt := AVE(GROUP,IF(h.year_to_date_purchases_sum_amount = (TYPEOF(h.year_to_date_purchases_sum_amount))'',0,100));
    maxlength_year_to_date_purchases_sum_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_sum_amount)));
    avelength_year_to_date_purchases_sum_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.year_to_date_purchases_sum_amount)),h.year_to_date_purchases_sum_amount<>(typeof(h.year_to_date_purchases_sum_amount))'');
    populated_lifetime_to_date_purchases_sum_amount_pcnt := AVE(GROUP,IF(h.lifetime_to_date_purchases_sum_amount = (TYPEOF(h.lifetime_to_date_purchases_sum_amount))'',0,100));
    maxlength_lifetime_to_date_purchases_sum_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_sum_amount)));
    avelength_lifetime_to_date_purchases_sum_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lifetime_to_date_purchases_sum_amount)),h.lifetime_to_date_purchases_sum_amount<>(typeof(h.lifetime_to_date_purchases_sum_amount))'');
    populated_payment_amount_scheduled_pcnt := AVE(GROUP,IF(h.payment_amount_scheduled = (TYPEOF(h.payment_amount_scheduled))'',0,100));
    maxlength_payment_amount_scheduled := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_amount_scheduled)));
    avelength_payment_amount_scheduled := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_amount_scheduled)),h.payment_amount_scheduled<>(typeof(h.payment_amount_scheduled))'');
    populated_recent_payment_amount_pcnt := AVE(GROUP,IF(h.recent_payment_amount = (TYPEOF(h.recent_payment_amount))'',0,100));
    maxlength_recent_payment_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_amount)));
    avelength_recent_payment_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_amount)),h.recent_payment_amount<>(typeof(h.recent_payment_amount))'');
    populated_recent_payment_date_pcnt := AVE(GROUP,IF(h.recent_payment_date = (TYPEOF(h.recent_payment_date))'',0,100));
    maxlength_recent_payment_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_date)));
    avelength_recent_payment_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recent_payment_date)),h.recent_payment_date<>(typeof(h.recent_payment_date))'');
    populated_remaining_balance_pcnt := AVE(GROUP,IF(h.remaining_balance = (TYPEOF(h.remaining_balance))'',0,100));
    maxlength_remaining_balance := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.remaining_balance)));
    avelength_remaining_balance := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.remaining_balance)),h.remaining_balance<>(typeof(h.remaining_balance))'');
    populated_carried_over_amount_pcnt := AVE(GROUP,IF(h.carried_over_amount = (TYPEOF(h.carried_over_amount))'',0,100));
    maxlength_carried_over_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.carried_over_amount)));
    avelength_carried_over_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.carried_over_amount)),h.carried_over_amount<>(typeof(h.carried_over_amount))'');
    populated_new_applied_charges_pcnt := AVE(GROUP,IF(h.new_applied_charges = (TYPEOF(h.new_applied_charges))'',0,100));
    maxlength_new_applied_charges := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.new_applied_charges)));
    avelength_new_applied_charges := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.new_applied_charges)),h.new_applied_charges<>(typeof(h.new_applied_charges))'');
    populated_balloon_payment_due_pcnt := AVE(GROUP,IF(h.balloon_payment_due = (TYPEOF(h.balloon_payment_due))'',0,100));
    maxlength_balloon_payment_due := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due)));
    avelength_balloon_payment_due := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due)),h.balloon_payment_due<>(typeof(h.balloon_payment_due))'');
    populated_balloon_payment_due_date_pcnt := AVE(GROUP,IF(h.balloon_payment_due_date = (TYPEOF(h.balloon_payment_due_date))'',0,100));
    maxlength_balloon_payment_due_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due_date)));
    avelength_balloon_payment_due_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.balloon_payment_due_date)),h.balloon_payment_due_date<>(typeof(h.balloon_payment_due_date))'');
    populated_delinquency_date_pcnt := AVE(GROUP,IF(h.delinquency_date = (TYPEOF(h.delinquency_date))'',0,100));
    maxlength_delinquency_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.delinquency_date)));
    avelength_delinquency_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.delinquency_date)),h.delinquency_date<>(typeof(h.delinquency_date))'');
    populated_days_delinquent_pcnt := AVE(GROUP,IF(h.days_delinquent = (TYPEOF(h.days_delinquent))'',0,100));
    maxlength_days_delinquent := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.days_delinquent)));
    avelength_days_delinquent := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.days_delinquent)),h.days_delinquent<>(typeof(h.days_delinquent))'');
    populated_past_due_amount_pcnt := AVE(GROUP,IF(h.past_due_amount = (TYPEOF(h.past_due_amount))'',0,100));
    maxlength_past_due_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_amount)));
    avelength_past_due_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_amount)),h.past_due_amount<>(typeof(h.past_due_amount))'');
    populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt := AVE(GROUP,IF(h.maximum_number_of_past_due_aging_amounts_buckets_provided = (TYPEOF(h.maximum_number_of_past_due_aging_amounts_buckets_provided))'',0,100));
    maxlength_maximum_number_of_past_due_aging_amounts_buckets_provided := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_past_due_aging_amounts_buckets_provided)));
    avelength_maximum_number_of_past_due_aging_amounts_buckets_provided := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_past_due_aging_amounts_buckets_provided)),h.maximum_number_of_past_due_aging_amounts_buckets_provided<>(typeof(h.maximum_number_of_past_due_aging_amounts_buckets_provided))'');
    populated_past_due_aging_bucket_type_pcnt := AVE(GROUP,IF(h.past_due_aging_bucket_type = (TYPEOF(h.past_due_aging_bucket_type))'',0,100));
    maxlength_past_due_aging_bucket_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_bucket_type)));
    avelength_past_due_aging_bucket_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_bucket_type)),h.past_due_aging_bucket_type<>(typeof(h.past_due_aging_bucket_type))'');
    populated_past_due_aging_amount_bucket_1_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_1 = (TYPEOF(h.past_due_aging_amount_bucket_1))'',0,100));
    maxlength_past_due_aging_amount_bucket_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_1)));
    avelength_past_due_aging_amount_bucket_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_1)),h.past_due_aging_amount_bucket_1<>(typeof(h.past_due_aging_amount_bucket_1))'');
    populated_past_due_aging_amount_bucket_2_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_2 = (TYPEOF(h.past_due_aging_amount_bucket_2))'',0,100));
    maxlength_past_due_aging_amount_bucket_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_2)));
    avelength_past_due_aging_amount_bucket_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_2)),h.past_due_aging_amount_bucket_2<>(typeof(h.past_due_aging_amount_bucket_2))'');
    populated_past_due_aging_amount_bucket_3_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_3 = (TYPEOF(h.past_due_aging_amount_bucket_3))'',0,100));
    maxlength_past_due_aging_amount_bucket_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_3)));
    avelength_past_due_aging_amount_bucket_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_3)),h.past_due_aging_amount_bucket_3<>(typeof(h.past_due_aging_amount_bucket_3))'');
    populated_past_due_aging_amount_bucket_4_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_4 = (TYPEOF(h.past_due_aging_amount_bucket_4))'',0,100));
    maxlength_past_due_aging_amount_bucket_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_4)));
    avelength_past_due_aging_amount_bucket_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_4)),h.past_due_aging_amount_bucket_4<>(typeof(h.past_due_aging_amount_bucket_4))'');
    populated_past_due_aging_amount_bucket_5_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_5 = (TYPEOF(h.past_due_aging_amount_bucket_5))'',0,100));
    maxlength_past_due_aging_amount_bucket_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_5)));
    avelength_past_due_aging_amount_bucket_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_5)),h.past_due_aging_amount_bucket_5<>(typeof(h.past_due_aging_amount_bucket_5))'');
    populated_past_due_aging_amount_bucket_6_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_6 = (TYPEOF(h.past_due_aging_amount_bucket_6))'',0,100));
    maxlength_past_due_aging_amount_bucket_6 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_6)));
    avelength_past_due_aging_amount_bucket_6 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_6)),h.past_due_aging_amount_bucket_6<>(typeof(h.past_due_aging_amount_bucket_6))'');
    populated_past_due_aging_amount_bucket_7_pcnt := AVE(GROUP,IF(h.past_due_aging_amount_bucket_7 = (TYPEOF(h.past_due_aging_amount_bucket_7))'',0,100));
    maxlength_past_due_aging_amount_bucket_7 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_7)));
    avelength_past_due_aging_amount_bucket_7 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.past_due_aging_amount_bucket_7)),h.past_due_aging_amount_bucket_7<>(typeof(h.past_due_aging_amount_bucket_7))'');
    populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt := AVE(GROUP,IF(h.maximum_number_of_payment_tracking_cycle_periods_provided = (TYPEOF(h.maximum_number_of_payment_tracking_cycle_periods_provided))'',0,100));
    maxlength_maximum_number_of_payment_tracking_cycle_periods_provided := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_payment_tracking_cycle_periods_provided)));
    avelength_maximum_number_of_payment_tracking_cycle_periods_provided := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.maximum_number_of_payment_tracking_cycle_periods_provided)),h.maximum_number_of_payment_tracking_cycle_periods_provided<>(typeof(h.maximum_number_of_payment_tracking_cycle_periods_provided))'');
    populated_payment_tracking_cycle_type_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_type = (TYPEOF(h.payment_tracking_cycle_type))'',0,100));
    maxlength_payment_tracking_cycle_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_type)));
    avelength_payment_tracking_cycle_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_type)),h.payment_tracking_cycle_type<>(typeof(h.payment_tracking_cycle_type))'');
    populated_payment_tracking_cycle_0_current_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_0_current = (TYPEOF(h.payment_tracking_cycle_0_current))'',0,100));
    maxlength_payment_tracking_cycle_0_current := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_0_current)));
    avelength_payment_tracking_cycle_0_current := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_0_current)),h.payment_tracking_cycle_0_current<>(typeof(h.payment_tracking_cycle_0_current))'');
    populated_payment_tracking_cycle_1_1_to_30_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_1_1_to_30_days = (TYPEOF(h.payment_tracking_cycle_1_1_to_30_days))'',0,100));
    maxlength_payment_tracking_cycle_1_1_to_30_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_1_1_to_30_days)));
    avelength_payment_tracking_cycle_1_1_to_30_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_1_1_to_30_days)),h.payment_tracking_cycle_1_1_to_30_days<>(typeof(h.payment_tracking_cycle_1_1_to_30_days))'');
    populated_payment_tracking_cycle_2_31_to_60_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_2_31_to_60_days = (TYPEOF(h.payment_tracking_cycle_2_31_to_60_days))'',0,100));
    maxlength_payment_tracking_cycle_2_31_to_60_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_2_31_to_60_days)));
    avelength_payment_tracking_cycle_2_31_to_60_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_2_31_to_60_days)),h.payment_tracking_cycle_2_31_to_60_days<>(typeof(h.payment_tracking_cycle_2_31_to_60_days))'');
    populated_payment_tracking_cycle_3_61_to_90_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_3_61_to_90_days = (TYPEOF(h.payment_tracking_cycle_3_61_to_90_days))'',0,100));
    maxlength_payment_tracking_cycle_3_61_to_90_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_3_61_to_90_days)));
    avelength_payment_tracking_cycle_3_61_to_90_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_3_61_to_90_days)),h.payment_tracking_cycle_3_61_to_90_days<>(typeof(h.payment_tracking_cycle_3_61_to_90_days))'');
    populated_payment_tracking_cycle_4_91_to_120_days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_4_91_to_120_days = (TYPEOF(h.payment_tracking_cycle_4_91_to_120_days))'',0,100));
    maxlength_payment_tracking_cycle_4_91_to_120_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_4_91_to_120_days)));
    avelength_payment_tracking_cycle_4_91_to_120_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_4_91_to_120_days)),h.payment_tracking_cycle_4_91_to_120_days<>(typeof(h.payment_tracking_cycle_4_91_to_120_days))'');
    populated_payment_tracking_cycle_5_121_to_150days_pcnt := AVE(GROUP,IF(h.payment_tracking_cycle_5_121_to_150days = (TYPEOF(h.payment_tracking_cycle_5_121_to_150days))'',0,100));
    maxlength_payment_tracking_cycle_5_121_to_150days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_5_121_to_150days)));
    avelength_payment_tracking_cycle_5_121_to_150days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_cycle_5_121_to_150days)),h.payment_tracking_cycle_5_121_to_150days<>(typeof(h.payment_tracking_cycle_5_121_to_150days))'');
    populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt := AVE(GROUP,IF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days = (TYPEOF(h.payment_tracking_number_of_times_cycle_6_151_to_180_days))'',0,100));
    maxlength_payment_tracking_number_of_times_cycle_6_151_to_180_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_6_151_to_180_days)));
    avelength_payment_tracking_number_of_times_cycle_6_151_to_180_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_6_151_to_180_days)),h.payment_tracking_number_of_times_cycle_6_151_to_180_days<>(typeof(h.payment_tracking_number_of_times_cycle_6_151_to_180_days))'');
    populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt := AVE(GROUP,IF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days = (TYPEOF(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days))'',0,100));
    maxlength_payment_tracking_number_of_times_cycle_7_181_or_greater_days := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_7_181_or_greater_days)));
    avelength_payment_tracking_number_of_times_cycle_7_181_or_greater_days := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.payment_tracking_number_of_times_cycle_7_181_or_greater_days)),h.payment_tracking_number_of_times_cycle_7_181_or_greater_days<>(typeof(h.payment_tracking_number_of_times_cycle_7_181_or_greater_days))'');
    populated_date_account_was_charged_off_pcnt := AVE(GROUP,IF(h.date_account_was_charged_off = (TYPEOF(h.date_account_was_charged_off))'',0,100));
    maxlength_date_account_was_charged_off := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_was_charged_off)));
    avelength_date_account_was_charged_off := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_account_was_charged_off)),h.date_account_was_charged_off<>(typeof(h.date_account_was_charged_off))'');
    populated_amount_charged_off_by_creditor_pcnt := AVE(GROUP,IF(h.amount_charged_off_by_creditor = (TYPEOF(h.amount_charged_off_by_creditor))'',0,100));
    maxlength_amount_charged_off_by_creditor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount_charged_off_by_creditor)));
    avelength_amount_charged_off_by_creditor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount_charged_off_by_creditor)),h.amount_charged_off_by_creditor<>(typeof(h.amount_charged_off_by_creditor))'');
    populated_charge_off_type_indicator_pcnt := AVE(GROUP,IF(h.charge_off_type_indicator = (TYPEOF(h.charge_off_type_indicator))'',0,100));
    maxlength_charge_off_type_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.charge_off_type_indicator)));
    avelength_charge_off_type_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.charge_off_type_indicator)),h.charge_off_type_indicator<>(typeof(h.charge_off_type_indicator))'');
    populated_total_charge_off_recoveries_to_date_pcnt := AVE(GROUP,IF(h.total_charge_off_recoveries_to_date = (TYPEOF(h.total_charge_off_recoveries_to_date))'',0,100));
    maxlength_total_charge_off_recoveries_to_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_charge_off_recoveries_to_date)));
    avelength_total_charge_off_recoveries_to_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.total_charge_off_recoveries_to_date)),h.total_charge_off_recoveries_to_date<>(typeof(h.total_charge_off_recoveries_to_date))'');
    populated_government_guarantee_flag_pcnt := AVE(GROUP,IF(h.government_guarantee_flag = (TYPEOF(h.government_guarantee_flag))'',0,100));
    maxlength_government_guarantee_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_flag)));
    avelength_government_guarantee_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_flag)),h.government_guarantee_flag<>(typeof(h.government_guarantee_flag))'');
    populated_government_guarantee_category_pcnt := AVE(GROUP,IF(h.government_guarantee_category = (TYPEOF(h.government_guarantee_category))'',0,100));
    maxlength_government_guarantee_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_category)));
    avelength_government_guarantee_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.government_guarantee_category)),h.government_guarantee_category<>(typeof(h.government_guarantee_category))'');
    populated_portion_of_account_guaranteed_by_government_pcnt := AVE(GROUP,IF(h.portion_of_account_guaranteed_by_government = (TYPEOF(h.portion_of_account_guaranteed_by_government))'',0,100));
    maxlength_portion_of_account_guaranteed_by_government := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.portion_of_account_guaranteed_by_government)));
    avelength_portion_of_account_guaranteed_by_government := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.portion_of_account_guaranteed_by_government)),h.portion_of_account_guaranteed_by_government<>(typeof(h.portion_of_account_guaranteed_by_government))'');
    populated_guarantors_indicator_pcnt := AVE(GROUP,IF(h.guarantors_indicator = (TYPEOF(h.guarantors_indicator))'',0,100));
    maxlength_guarantors_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantors_indicator)));
    avelength_guarantors_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.guarantors_indicator)),h.guarantors_indicator<>(typeof(h.guarantors_indicator))'');
    populated_number_of_guarantors_pcnt := AVE(GROUP,IF(h.number_of_guarantors = (TYPEOF(h.number_of_guarantors))'',0,100));
    maxlength_number_of_guarantors := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_guarantors)));
    avelength_number_of_guarantors := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_guarantors)),h.number_of_guarantors<>(typeof(h.number_of_guarantors))'');
    populated_owners_indicator_pcnt := AVE(GROUP,IF(h.owners_indicator = (TYPEOF(h.owners_indicator))'',0,100));
    maxlength_owners_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.owners_indicator)));
    avelength_owners_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.owners_indicator)),h.owners_indicator<>(typeof(h.owners_indicator))'');
    populated_number_of_principals_pcnt := AVE(GROUP,IF(h.number_of_principals = (TYPEOF(h.number_of_principals))'',0,100));
    maxlength_number_of_principals := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_principals)));
    avelength_number_of_principals := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_of_principals)),h.number_of_principals<>(typeof(h.number_of_principals))'');
    populated_account_update_deletion_indicator_pcnt := AVE(GROUP,IF(h.account_update_deletion_indicator = (TYPEOF(h.account_update_deletion_indicator))'',0,100));
    maxlength_account_update_deletion_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_update_deletion_indicator)));
    avelength_account_update_deletion_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_update_deletion_indicator)),h.account_update_deletion_indicator<>(typeof(h.account_update_deletion_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_parent_sequence_number_pcnt *   0.00 / 100 + T.Populated_account_holder_business_name_pcnt *   0.00 / 100 + T.Populated_dba_pcnt *   0.00 / 100 + T.Populated_company_website_pcnt *   0.00 / 100 + T.Populated_legal_business_structure_pcnt *   0.00 / 100 + T.Populated_business_established_date_pcnt *   0.00 / 100 + T.Populated_contract_account_number_pcnt *   0.00 / 100 + T.Populated_account_type_reported_pcnt *   0.00 / 100 + T.Populated_account_status_1_pcnt *   0.00 / 100 + T.Populated_account_status_2_pcnt *   0.00 / 100 + T.Populated_date_account_opened_pcnt *   0.00 / 100 + T.Populated_date_account_closed_pcnt *   0.00 / 100 + T.Populated_account_closure_basis_pcnt *   0.00 / 100 + T.Populated_account_expiration_date_pcnt *   0.00 / 100 + T.Populated_last_activity_date_pcnt *   0.00 / 100 + T.Populated_last_activity_type_pcnt *   0.00 / 100 + T.Populated_recent_activity_indicator_pcnt *   0.00 / 100 + T.Populated_original_credit_limit_pcnt *   0.00 / 100 + T.Populated_highest_credit_used_pcnt *   0.00 / 100 + T.Populated_current_credit_limit_pcnt *   0.00 / 100 + T.Populated_reporting_indicator_length_pcnt *   0.00 / 100 + T.Populated_payment_interval_pcnt *   0.00 / 100 + T.Populated_payment_status_category_pcnt *   0.00 / 100 + T.Populated_term_of_account_in_months_pcnt *   0.00 / 100 + T.Populated_first_payment_due_date_pcnt *   0.00 / 100 + T.Populated_final_payment_due_date_pcnt *   0.00 / 100 + T.Populated_original_rate_pcnt *   0.00 / 100 + T.Populated_floating_rate_pcnt *   0.00 / 100 + T.Populated_grace_period_pcnt *   0.00 / 100 + T.Populated_payment_category_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_12_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_13_24_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_25_36_months_pcnt *   0.00 / 100 + T.Populated_payment_history_profile_37_48_months_pcnt *   0.00 / 100 + T.Populated_payment_history_length_pcnt *   0.00 / 100 + T.Populated_year_to_date_purchases_count_pcnt *   0.00 / 100 + T.Populated_lifetime_to_date_purchases_count_pcnt *   0.00 / 100 + T.Populated_year_to_date_purchases_sum_amount_pcnt *   0.00 / 100 + T.Populated_lifetime_to_date_purchases_sum_amount_pcnt *   0.00 / 100 + T.Populated_payment_amount_scheduled_pcnt *   0.00 / 100 + T.Populated_recent_payment_amount_pcnt *   0.00 / 100 + T.Populated_recent_payment_date_pcnt *   0.00 / 100 + T.Populated_remaining_balance_pcnt *   0.00 / 100 + T.Populated_carried_over_amount_pcnt *   0.00 / 100 + T.Populated_new_applied_charges_pcnt *   0.00 / 100 + T.Populated_balloon_payment_due_pcnt *   0.00 / 100 + T.Populated_balloon_payment_due_date_pcnt *   0.00 / 100 + T.Populated_delinquency_date_pcnt *   0.00 / 100 + T.Populated_days_delinquent_pcnt *   0.00 / 100 + T.Populated_past_due_amount_pcnt *   0.00 / 100 + T.Populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt *   0.00 / 100 + T.Populated_past_due_aging_bucket_type_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_1_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_2_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_3_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_4_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_5_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_6_pcnt *   0.00 / 100 + T.Populated_past_due_aging_amount_bucket_7_pcnt *   0.00 / 100 + T.Populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_type_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_0_current_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_1_1_to_30_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_2_31_to_60_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_3_61_to_90_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_4_91_to_120_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_cycle_5_121_to_150days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt *   0.00 / 100 + T.Populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt *   0.00 / 100 + T.Populated_date_account_was_charged_off_pcnt *   0.00 / 100 + T.Populated_amount_charged_off_by_creditor_pcnt *   0.00 / 100 + T.Populated_charge_off_type_indicator_pcnt *   0.00 / 100 + T.Populated_total_charge_off_recoveries_to_date_pcnt *   0.00 / 100 + T.Populated_government_guarantee_flag_pcnt *   0.00 / 100 + T.Populated_government_guarantee_category_pcnt *   0.00 / 100 + T.Populated_portion_of_account_guaranteed_by_government_pcnt *   0.00 / 100 + T.Populated_guarantors_indicator_pcnt *   0.00 / 100 + T.Populated_number_of_guarantors_pcnt *   0.00 / 100 + T.Populated_owners_indicator_pcnt *   0.00 / 100 + T.Populated_number_of_principals_pcnt *   0.00 / 100 + T.Populated_account_update_deletion_indicator_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','parent_sequence_number','account_holder_business_name','dba','company_website','legal_business_structure','business_established_date','contract_account_number','account_type_reported','account_status_1','account_status_2','date_account_opened','date_account_closed','account_closure_basis','account_expiration_date','last_activity_date','last_activity_type','recent_activity_indicator','original_credit_limit','highest_credit_used','current_credit_limit','reporting_indicator_length','payment_interval','payment_status_category','term_of_account_in_months','first_payment_due_date','final_payment_due_date','original_rate','floating_rate','grace_period','payment_category','payment_history_profile_12_months','payment_history_profile_13_24_months','payment_history_profile_25_36_months','payment_history_profile_37_48_months','payment_history_length','year_to_date_purchases_count','lifetime_to_date_purchases_count','year_to_date_purchases_sum_amount','lifetime_to_date_purchases_sum_amount','payment_amount_scheduled','recent_payment_amount','recent_payment_date','remaining_balance','carried_over_amount','new_applied_charges','balloon_payment_due','balloon_payment_due_date','delinquency_date','days_delinquent','past_due_amount','maximum_number_of_past_due_aging_amounts_buckets_provided','past_due_aging_bucket_type','past_due_aging_amount_bucket_1','past_due_aging_amount_bucket_2','past_due_aging_amount_bucket_3','past_due_aging_amount_bucket_4','past_due_aging_amount_bucket_5','past_due_aging_amount_bucket_6','past_due_aging_amount_bucket_7','maximum_number_of_payment_tracking_cycle_periods_provided','payment_tracking_cycle_type','payment_tracking_cycle_0_current','payment_tracking_cycle_1_1_to_30_days','payment_tracking_cycle_2_31_to_60_days','payment_tracking_cycle_3_61_to_90_days','payment_tracking_cycle_4_91_to_120_days','payment_tracking_cycle_5_121_to_150days','payment_tracking_number_of_times_cycle_6_151_to_180_days','payment_tracking_number_of_times_cycle_7_181_or_greater_days','date_account_was_charged_off','amount_charged_off_by_creditor','charge_off_type_indicator','total_charge_off_recoveries_to_date','government_guarantee_flag','government_guarantee_category','portion_of_account_guaranteed_by_government','guarantors_indicator','number_of_guarantors','owners_indicator','number_of_principals','account_update_deletion_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_parent_sequence_number_pcnt,le.populated_account_holder_business_name_pcnt,le.populated_dba_pcnt,le.populated_company_website_pcnt,le.populated_legal_business_structure_pcnt,le.populated_business_established_date_pcnt,le.populated_contract_account_number_pcnt,le.populated_account_type_reported_pcnt,le.populated_account_status_1_pcnt,le.populated_account_status_2_pcnt,le.populated_date_account_opened_pcnt,le.populated_date_account_closed_pcnt,le.populated_account_closure_basis_pcnt,le.populated_account_expiration_date_pcnt,le.populated_last_activity_date_pcnt,le.populated_last_activity_type_pcnt,le.populated_recent_activity_indicator_pcnt,le.populated_original_credit_limit_pcnt,le.populated_highest_credit_used_pcnt,le.populated_current_credit_limit_pcnt,le.populated_reporting_indicator_length_pcnt,le.populated_payment_interval_pcnt,le.populated_payment_status_category_pcnt,le.populated_term_of_account_in_months_pcnt,le.populated_first_payment_due_date_pcnt,le.populated_final_payment_due_date_pcnt,le.populated_original_rate_pcnt,le.populated_floating_rate_pcnt,le.populated_grace_period_pcnt,le.populated_payment_category_pcnt,le.populated_payment_history_profile_12_months_pcnt,le.populated_payment_history_profile_13_24_months_pcnt,le.populated_payment_history_profile_25_36_months_pcnt,le.populated_payment_history_profile_37_48_months_pcnt,le.populated_payment_history_length_pcnt,le.populated_year_to_date_purchases_count_pcnt,le.populated_lifetime_to_date_purchases_count_pcnt,le.populated_year_to_date_purchases_sum_amount_pcnt,le.populated_lifetime_to_date_purchases_sum_amount_pcnt,le.populated_payment_amount_scheduled_pcnt,le.populated_recent_payment_amount_pcnt,le.populated_recent_payment_date_pcnt,le.populated_remaining_balance_pcnt,le.populated_carried_over_amount_pcnt,le.populated_new_applied_charges_pcnt,le.populated_balloon_payment_due_pcnt,le.populated_balloon_payment_due_date_pcnt,le.populated_delinquency_date_pcnt,le.populated_days_delinquent_pcnt,le.populated_past_due_amount_pcnt,le.populated_maximum_number_of_past_due_aging_amounts_buckets_provided_pcnt,le.populated_past_due_aging_bucket_type_pcnt,le.populated_past_due_aging_amount_bucket_1_pcnt,le.populated_past_due_aging_amount_bucket_2_pcnt,le.populated_past_due_aging_amount_bucket_3_pcnt,le.populated_past_due_aging_amount_bucket_4_pcnt,le.populated_past_due_aging_amount_bucket_5_pcnt,le.populated_past_due_aging_amount_bucket_6_pcnt,le.populated_past_due_aging_amount_bucket_7_pcnt,le.populated_maximum_number_of_payment_tracking_cycle_periods_provided_pcnt,le.populated_payment_tracking_cycle_type_pcnt,le.populated_payment_tracking_cycle_0_current_pcnt,le.populated_payment_tracking_cycle_1_1_to_30_days_pcnt,le.populated_payment_tracking_cycle_2_31_to_60_days_pcnt,le.populated_payment_tracking_cycle_3_61_to_90_days_pcnt,le.populated_payment_tracking_cycle_4_91_to_120_days_pcnt,le.populated_payment_tracking_cycle_5_121_to_150days_pcnt,le.populated_payment_tracking_number_of_times_cycle_6_151_to_180_days_pcnt,le.populated_payment_tracking_number_of_times_cycle_7_181_or_greater_days_pcnt,le.populated_date_account_was_charged_off_pcnt,le.populated_amount_charged_off_by_creditor_pcnt,le.populated_charge_off_type_indicator_pcnt,le.populated_total_charge_off_recoveries_to_date_pcnt,le.populated_government_guarantee_flag_pcnt,le.populated_government_guarantee_category_pcnt,le.populated_portion_of_account_guaranteed_by_government_pcnt,le.populated_guarantors_indicator_pcnt,le.populated_number_of_guarantors_pcnt,le.populated_owners_indicator_pcnt,le.populated_number_of_principals_pcnt,le.populated_account_update_deletion_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_parent_sequence_number,le.maxlength_account_holder_business_name,le.maxlength_dba,le.maxlength_company_website,le.maxlength_legal_business_structure,le.maxlength_business_established_date,le.maxlength_contract_account_number,le.maxlength_account_type_reported,le.maxlength_account_status_1,le.maxlength_account_status_2,le.maxlength_date_account_opened,le.maxlength_date_account_closed,le.maxlength_account_closure_basis,le.maxlength_account_expiration_date,le.maxlength_last_activity_date,le.maxlength_last_activity_type,le.maxlength_recent_activity_indicator,le.maxlength_original_credit_limit,le.maxlength_highest_credit_used,le.maxlength_current_credit_limit,le.maxlength_reporting_indicator_length,le.maxlength_payment_interval,le.maxlength_payment_status_category,le.maxlength_term_of_account_in_months,le.maxlength_first_payment_due_date,le.maxlength_final_payment_due_date,le.maxlength_original_rate,le.maxlength_floating_rate,le.maxlength_grace_period,le.maxlength_payment_category,le.maxlength_payment_history_profile_12_months,le.maxlength_payment_history_profile_13_24_months,le.maxlength_payment_history_profile_25_36_months,le.maxlength_payment_history_profile_37_48_months,le.maxlength_payment_history_length,le.maxlength_year_to_date_purchases_count,le.maxlength_lifetime_to_date_purchases_count,le.maxlength_year_to_date_purchases_sum_amount,le.maxlength_lifetime_to_date_purchases_sum_amount,le.maxlength_payment_amount_scheduled,le.maxlength_recent_payment_amount,le.maxlength_recent_payment_date,le.maxlength_remaining_balance,le.maxlength_carried_over_amount,le.maxlength_new_applied_charges,le.maxlength_balloon_payment_due,le.maxlength_balloon_payment_due_date,le.maxlength_delinquency_date,le.maxlength_days_delinquent,le.maxlength_past_due_amount,le.maxlength_maximum_number_of_past_due_aging_amounts_buckets_provided,le.maxlength_past_due_aging_bucket_type,le.maxlength_past_due_aging_amount_bucket_1,le.maxlength_past_due_aging_amount_bucket_2,le.maxlength_past_due_aging_amount_bucket_3,le.maxlength_past_due_aging_amount_bucket_4,le.maxlength_past_due_aging_amount_bucket_5,le.maxlength_past_due_aging_amount_bucket_6,le.maxlength_past_due_aging_amount_bucket_7,le.maxlength_maximum_number_of_payment_tracking_cycle_periods_provided,le.maxlength_payment_tracking_cycle_type,le.maxlength_payment_tracking_cycle_0_current,le.maxlength_payment_tracking_cycle_1_1_to_30_days,le.maxlength_payment_tracking_cycle_2_31_to_60_days,le.maxlength_payment_tracking_cycle_3_61_to_90_days,le.maxlength_payment_tracking_cycle_4_91_to_120_days,le.maxlength_payment_tracking_cycle_5_121_to_150days,le.maxlength_payment_tracking_number_of_times_cycle_6_151_to_180_days,le.maxlength_payment_tracking_number_of_times_cycle_7_181_or_greater_days,le.maxlength_date_account_was_charged_off,le.maxlength_amount_charged_off_by_creditor,le.maxlength_charge_off_type_indicator,le.maxlength_total_charge_off_recoveries_to_date,le.maxlength_government_guarantee_flag,le.maxlength_government_guarantee_category,le.maxlength_portion_of_account_guaranteed_by_government,le.maxlength_guarantors_indicator,le.maxlength_number_of_guarantors,le.maxlength_owners_indicator,le.maxlength_number_of_principals,le.maxlength_account_update_deletion_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_parent_sequence_number,le.avelength_account_holder_business_name,le.avelength_dba,le.avelength_company_website,le.avelength_legal_business_structure,le.avelength_business_established_date,le.avelength_contract_account_number,le.avelength_account_type_reported,le.avelength_account_status_1,le.avelength_account_status_2,le.avelength_date_account_opened,le.avelength_date_account_closed,le.avelength_account_closure_basis,le.avelength_account_expiration_date,le.avelength_last_activity_date,le.avelength_last_activity_type,le.avelength_recent_activity_indicator,le.avelength_original_credit_limit,le.avelength_highest_credit_used,le.avelength_current_credit_limit,le.avelength_reporting_indicator_length,le.avelength_payment_interval,le.avelength_payment_status_category,le.avelength_term_of_account_in_months,le.avelength_first_payment_due_date,le.avelength_final_payment_due_date,le.avelength_original_rate,le.avelength_floating_rate,le.avelength_grace_period,le.avelength_payment_category,le.avelength_payment_history_profile_12_months,le.avelength_payment_history_profile_13_24_months,le.avelength_payment_history_profile_25_36_months,le.avelength_payment_history_profile_37_48_months,le.avelength_payment_history_length,le.avelength_year_to_date_purchases_count,le.avelength_lifetime_to_date_purchases_count,le.avelength_year_to_date_purchases_sum_amount,le.avelength_lifetime_to_date_purchases_sum_amount,le.avelength_payment_amount_scheduled,le.avelength_recent_payment_amount,le.avelength_recent_payment_date,le.avelength_remaining_balance,le.avelength_carried_over_amount,le.avelength_new_applied_charges,le.avelength_balloon_payment_due,le.avelength_balloon_payment_due_date,le.avelength_delinquency_date,le.avelength_days_delinquent,le.avelength_past_due_amount,le.avelength_maximum_number_of_past_due_aging_amounts_buckets_provided,le.avelength_past_due_aging_bucket_type,le.avelength_past_due_aging_amount_bucket_1,le.avelength_past_due_aging_amount_bucket_2,le.avelength_past_due_aging_amount_bucket_3,le.avelength_past_due_aging_amount_bucket_4,le.avelength_past_due_aging_amount_bucket_5,le.avelength_past_due_aging_amount_bucket_6,le.avelength_past_due_aging_amount_bucket_7,le.avelength_maximum_number_of_payment_tracking_cycle_periods_provided,le.avelength_payment_tracking_cycle_type,le.avelength_payment_tracking_cycle_0_current,le.avelength_payment_tracking_cycle_1_1_to_30_days,le.avelength_payment_tracking_cycle_2_31_to_60_days,le.avelength_payment_tracking_cycle_3_61_to_90_days,le.avelength_payment_tracking_cycle_4_91_to_120_days,le.avelength_payment_tracking_cycle_5_121_to_150days,le.avelength_payment_tracking_number_of_times_cycle_6_151_to_180_days,le.avelength_payment_tracking_number_of_times_cycle_7_181_or_greater_days,le.avelength_date_account_was_charged_off,le.avelength_amount_charged_off_by_creditor,le.avelength_charge_off_type_indicator,le.avelength_total_charge_off_recoveries_to_date,le.avelength_government_guarantee_flag,le.avelength_government_guarantee_category,le.avelength_portion_of_account_guaranteed_by_government,le.avelength_guarantors_indicator,le.avelength_number_of_guarantors,le.avelength_owners_indicator,le.avelength_number_of_principals,le.avelength_account_update_deletion_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 83, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,83,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 83);
  SELF.FldNo2 := 1 + (C % 83);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.segment_identifier),TRIM((SALT33.StrType)le.file_sequence_number),TRIM((SALT33.StrType)le.parent_sequence_number),TRIM((SALT33.StrType)le.account_holder_business_name),TRIM((SALT33.StrType)le.dba),TRIM((SALT33.StrType)le.company_website),TRIM((SALT33.StrType)le.legal_business_structure),TRIM((SALT33.StrType)le.business_established_date),TRIM((SALT33.StrType)le.contract_account_number),TRIM((SALT33.StrType)le.account_type_reported),TRIM((SALT33.StrType)le.account_status_1),TRIM((SALT33.StrType)le.account_status_2),TRIM((SALT33.StrType)le.date_account_opened),TRIM((SALT33.StrType)le.date_account_closed),TRIM((SALT33.StrType)le.account_closure_basis),TRIM((SALT33.StrType)le.account_expiration_date),TRIM((SALT33.StrType)le.last_activity_date),TRIM((SALT33.StrType)le.last_activity_type),TRIM((SALT33.StrType)le.recent_activity_indicator),TRIM((SALT33.StrType)le.original_credit_limit),TRIM((SALT33.StrType)le.highest_credit_used),TRIM((SALT33.StrType)le.current_credit_limit),TRIM((SALT33.StrType)le.reporting_indicator_length),TRIM((SALT33.StrType)le.payment_interval),TRIM((SALT33.StrType)le.payment_status_category),TRIM((SALT33.StrType)le.term_of_account_in_months),TRIM((SALT33.StrType)le.first_payment_due_date),TRIM((SALT33.StrType)le.final_payment_due_date),TRIM((SALT33.StrType)le.original_rate),TRIM((SALT33.StrType)le.floating_rate),TRIM((SALT33.StrType)le.grace_period),TRIM((SALT33.StrType)le.payment_category),TRIM((SALT33.StrType)le.payment_history_profile_12_months),TRIM((SALT33.StrType)le.payment_history_profile_13_24_months),TRIM((SALT33.StrType)le.payment_history_profile_25_36_months),TRIM((SALT33.StrType)le.payment_history_profile_37_48_months),TRIM((SALT33.StrType)le.payment_history_length),TRIM((SALT33.StrType)le.year_to_date_purchases_count),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_count),TRIM((SALT33.StrType)le.year_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),TRIM((SALT33.StrType)le.payment_amount_scheduled),TRIM((SALT33.StrType)le.recent_payment_amount),TRIM((SALT33.StrType)le.recent_payment_date),TRIM((SALT33.StrType)le.remaining_balance),TRIM((SALT33.StrType)le.carried_over_amount),TRIM((SALT33.StrType)le.new_applied_charges),TRIM((SALT33.StrType)le.balloon_payment_due),TRIM((SALT33.StrType)le.balloon_payment_due_date),TRIM((SALT33.StrType)le.delinquency_date),TRIM((SALT33.StrType)le.days_delinquent),TRIM((SALT33.StrType)le.past_due_amount),TRIM((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),TRIM((SALT33.StrType)le.past_due_aging_bucket_type),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_1),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_2),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_3),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_4),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_5),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_6),TRIM((SALT33.StrType)le.past_due_aging_amount_bucket_7),TRIM((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),TRIM((SALT33.StrType)le.payment_tracking_cycle_type),TRIM((SALT33.StrType)le.payment_tracking_cycle_0_current),TRIM((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),TRIM((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),TRIM((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),TRIM((SALT33.StrType)le.date_account_was_charged_off),TRIM((SALT33.StrType)le.amount_charged_off_by_creditor),TRIM((SALT33.StrType)le.charge_off_type_indicator),TRIM((SALT33.StrType)le.total_charge_off_recoveries_to_date),TRIM((SALT33.StrType)le.government_guarantee_flag),TRIM((SALT33.StrType)le.government_guarantee_category),TRIM((SALT33.StrType)le.portion_of_account_guaranteed_by_government),TRIM((SALT33.StrType)le.guarantors_indicator),TRIM((SALT33.StrType)le.number_of_guarantors),TRIM((SALT33.StrType)le.owners_indicator),TRIM((SALT33.StrType)le.number_of_principals),TRIM((SALT33.StrType)le.account_update_deletion_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),83*83,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'parent_sequence_number'}
      ,{4,'account_holder_business_name'}
      ,{5,'dba'}
      ,{6,'company_website'}
      ,{7,'legal_business_structure'}
      ,{8,'business_established_date'}
      ,{9,'contract_account_number'}
      ,{10,'account_type_reported'}
      ,{11,'account_status_1'}
      ,{12,'account_status_2'}
      ,{13,'date_account_opened'}
      ,{14,'date_account_closed'}
      ,{15,'account_closure_basis'}
      ,{16,'account_expiration_date'}
      ,{17,'last_activity_date'}
      ,{18,'last_activity_type'}
      ,{19,'recent_activity_indicator'}
      ,{20,'original_credit_limit'}
      ,{21,'highest_credit_used'}
      ,{22,'current_credit_limit'}
      ,{23,'reporting_indicator_length'}
      ,{24,'payment_interval'}
      ,{25,'payment_status_category'}
      ,{26,'term_of_account_in_months'}
      ,{27,'first_payment_due_date'}
      ,{28,'final_payment_due_date'}
      ,{29,'original_rate'}
      ,{30,'floating_rate'}
      ,{31,'grace_period'}
      ,{32,'payment_category'}
      ,{33,'payment_history_profile_12_months'}
      ,{34,'payment_history_profile_13_24_months'}
      ,{35,'payment_history_profile_25_36_months'}
      ,{36,'payment_history_profile_37_48_months'}
      ,{37,'payment_history_length'}
      ,{38,'year_to_date_purchases_count'}
      ,{39,'lifetime_to_date_purchases_count'}
      ,{40,'year_to_date_purchases_sum_amount'}
      ,{41,'lifetime_to_date_purchases_sum_amount'}
      ,{42,'payment_amount_scheduled'}
      ,{43,'recent_payment_amount'}
      ,{44,'recent_payment_date'}
      ,{45,'remaining_balance'}
      ,{46,'carried_over_amount'}
      ,{47,'new_applied_charges'}
      ,{48,'balloon_payment_due'}
      ,{49,'balloon_payment_due_date'}
      ,{50,'delinquency_date'}
      ,{51,'days_delinquent'}
      ,{52,'past_due_amount'}
      ,{53,'maximum_number_of_past_due_aging_amounts_buckets_provided'}
      ,{54,'past_due_aging_bucket_type'}
      ,{55,'past_due_aging_amount_bucket_1'}
      ,{56,'past_due_aging_amount_bucket_2'}
      ,{57,'past_due_aging_amount_bucket_3'}
      ,{58,'past_due_aging_amount_bucket_4'}
      ,{59,'past_due_aging_amount_bucket_5'}
      ,{60,'past_due_aging_amount_bucket_6'}
      ,{61,'past_due_aging_amount_bucket_7'}
      ,{62,'maximum_number_of_payment_tracking_cycle_periods_provided'}
      ,{63,'payment_tracking_cycle_type'}
      ,{64,'payment_tracking_cycle_0_current'}
      ,{65,'payment_tracking_cycle_1_1_to_30_days'}
      ,{66,'payment_tracking_cycle_2_31_to_60_days'}
      ,{67,'payment_tracking_cycle_3_61_to_90_days'}
      ,{68,'payment_tracking_cycle_4_91_to_120_days'}
      ,{69,'payment_tracking_cycle_5_121_to_150days'}
      ,{70,'payment_tracking_number_of_times_cycle_6_151_to_180_days'}
      ,{71,'payment_tracking_number_of_times_cycle_7_181_or_greater_days'}
      ,{72,'date_account_was_charged_off'}
      ,{73,'amount_charged_off_by_creditor'}
      ,{74,'charge_off_type_indicator'}
      ,{75,'total_charge_off_recoveries_to_date'}
      ,{76,'government_guarantee_flag'}
      ,{77,'government_guarantee_category'}
      ,{78,'portion_of_account_guaranteed_by_government'}
      ,{79,'guarantors_indicator'}
      ,{80,'number_of_guarantors'}
      ,{81,'owners_indicator'}
      ,{82,'number_of_principals'}
      ,{83,'account_update_deletion_indicator'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AB_Fields.InValid_segment_identifier((SALT33.StrType)le.segment_identifier),
    AB_Fields.InValid_file_sequence_number((SALT33.StrType)le.file_sequence_number),
    AB_Fields.InValid_parent_sequence_number((SALT33.StrType)le.parent_sequence_number),
    AB_Fields.InValid_account_holder_business_name((SALT33.StrType)le.account_holder_business_name),
    AB_Fields.InValid_dba((SALT33.StrType)le.dba),
    AB_Fields.InValid_company_website((SALT33.StrType)le.company_website),
    AB_Fields.InValid_legal_business_structure((SALT33.StrType)le.legal_business_structure),
    AB_Fields.InValid_business_established_date((SALT33.StrType)le.business_established_date),
    AB_Fields.InValid_contract_account_number((SALT33.StrType)le.contract_account_number),
    AB_Fields.InValid_account_type_reported((SALT33.StrType)le.account_type_reported),
    AB_Fields.InValid_account_status_1((SALT33.StrType)le.account_status_1),
    AB_Fields.InValid_account_status_2((SALT33.StrType)le.account_status_2),
    AB_Fields.InValid_date_account_opened((SALT33.StrType)le.date_account_opened),
    AB_Fields.InValid_date_account_closed((SALT33.StrType)le.date_account_closed),
    AB_Fields.InValid_account_closure_basis((SALT33.StrType)le.account_closure_basis),
    AB_Fields.InValid_account_expiration_date((SALT33.StrType)le.account_expiration_date),
    AB_Fields.InValid_last_activity_date((SALT33.StrType)le.last_activity_date),
    AB_Fields.InValid_last_activity_type((SALT33.StrType)le.last_activity_type),
    AB_Fields.InValid_recent_activity_indicator((SALT33.StrType)le.recent_activity_indicator),
    AB_Fields.InValid_original_credit_limit((SALT33.StrType)le.original_credit_limit),
    AB_Fields.InValid_highest_credit_used((SALT33.StrType)le.highest_credit_used),
    AB_Fields.InValid_current_credit_limit((SALT33.StrType)le.current_credit_limit),
    AB_Fields.InValid_reporting_indicator_length((SALT33.StrType)le.reporting_indicator_length),
    AB_Fields.InValid_payment_interval((SALT33.StrType)le.payment_interval),
    AB_Fields.InValid_payment_status_category((SALT33.StrType)le.payment_status_category),
    AB_Fields.InValid_term_of_account_in_months((SALT33.StrType)le.term_of_account_in_months),
    AB_Fields.InValid_first_payment_due_date((SALT33.StrType)le.first_payment_due_date),
    AB_Fields.InValid_final_payment_due_date((SALT33.StrType)le.final_payment_due_date),
    AB_Fields.InValid_original_rate((SALT33.StrType)le.original_rate),
    AB_Fields.InValid_floating_rate((SALT33.StrType)le.floating_rate),
    AB_Fields.InValid_grace_period((SALT33.StrType)le.grace_period),
    AB_Fields.InValid_payment_category((SALT33.StrType)le.payment_category),
    AB_Fields.InValid_payment_history_profile_12_months((SALT33.StrType)le.payment_history_profile_12_months),
    AB_Fields.InValid_payment_history_profile_13_24_months((SALT33.StrType)le.payment_history_profile_13_24_months),
    AB_Fields.InValid_payment_history_profile_25_36_months((SALT33.StrType)le.payment_history_profile_25_36_months),
    AB_Fields.InValid_payment_history_profile_37_48_months((SALT33.StrType)le.payment_history_profile_37_48_months),
    AB_Fields.InValid_payment_history_length((SALT33.StrType)le.payment_history_length),
    AB_Fields.InValid_year_to_date_purchases_count((SALT33.StrType)le.year_to_date_purchases_count),
    AB_Fields.InValid_lifetime_to_date_purchases_count((SALT33.StrType)le.lifetime_to_date_purchases_count),
    AB_Fields.InValid_year_to_date_purchases_sum_amount((SALT33.StrType)le.year_to_date_purchases_sum_amount),
    AB_Fields.InValid_lifetime_to_date_purchases_sum_amount((SALT33.StrType)le.lifetime_to_date_purchases_sum_amount),
    AB_Fields.InValid_payment_amount_scheduled((SALT33.StrType)le.payment_amount_scheduled),
    AB_Fields.InValid_recent_payment_amount((SALT33.StrType)le.recent_payment_amount),
    AB_Fields.InValid_recent_payment_date((SALT33.StrType)le.recent_payment_date),
    AB_Fields.InValid_remaining_balance((SALT33.StrType)le.remaining_balance),
    AB_Fields.InValid_carried_over_amount((SALT33.StrType)le.carried_over_amount),
    AB_Fields.InValid_new_applied_charges((SALT33.StrType)le.new_applied_charges),
    AB_Fields.InValid_balloon_payment_due((SALT33.StrType)le.balloon_payment_due),
    AB_Fields.InValid_balloon_payment_due_date((SALT33.StrType)le.balloon_payment_due_date),
    AB_Fields.InValid_delinquency_date((SALT33.StrType)le.delinquency_date),
    AB_Fields.InValid_days_delinquent((SALT33.StrType)le.days_delinquent),
    AB_Fields.InValid_past_due_amount((SALT33.StrType)le.past_due_amount),
    AB_Fields.InValid_maximum_number_of_past_due_aging_amounts_buckets_provided((SALT33.StrType)le.maximum_number_of_past_due_aging_amounts_buckets_provided),
    AB_Fields.InValid_past_due_aging_bucket_type((SALT33.StrType)le.past_due_aging_bucket_type),
    AB_Fields.InValid_past_due_aging_amount_bucket_1((SALT33.StrType)le.past_due_aging_amount_bucket_1),
    AB_Fields.InValid_past_due_aging_amount_bucket_2((SALT33.StrType)le.past_due_aging_amount_bucket_2),
    AB_Fields.InValid_past_due_aging_amount_bucket_3((SALT33.StrType)le.past_due_aging_amount_bucket_3),
    AB_Fields.InValid_past_due_aging_amount_bucket_4((SALT33.StrType)le.past_due_aging_amount_bucket_4),
    AB_Fields.InValid_past_due_aging_amount_bucket_5((SALT33.StrType)le.past_due_aging_amount_bucket_5),
    AB_Fields.InValid_past_due_aging_amount_bucket_6((SALT33.StrType)le.past_due_aging_amount_bucket_6),
    AB_Fields.InValid_past_due_aging_amount_bucket_7((SALT33.StrType)le.past_due_aging_amount_bucket_7),
    AB_Fields.InValid_maximum_number_of_payment_tracking_cycle_periods_provided((SALT33.StrType)le.maximum_number_of_payment_tracking_cycle_periods_provided),
    AB_Fields.InValid_payment_tracking_cycle_type((SALT33.StrType)le.payment_tracking_cycle_type),
    AB_Fields.InValid_payment_tracking_cycle_0_current((SALT33.StrType)le.payment_tracking_cycle_0_current),
    AB_Fields.InValid_payment_tracking_cycle_1_1_to_30_days((SALT33.StrType)le.payment_tracking_cycle_1_1_to_30_days),
    AB_Fields.InValid_payment_tracking_cycle_2_31_to_60_days((SALT33.StrType)le.payment_tracking_cycle_2_31_to_60_days),
    AB_Fields.InValid_payment_tracking_cycle_3_61_to_90_days((SALT33.StrType)le.payment_tracking_cycle_3_61_to_90_days),
    AB_Fields.InValid_payment_tracking_cycle_4_91_to_120_days((SALT33.StrType)le.payment_tracking_cycle_4_91_to_120_days),
    AB_Fields.InValid_payment_tracking_cycle_5_121_to_150days((SALT33.StrType)le.payment_tracking_cycle_5_121_to_150days),
    AB_Fields.InValid_payment_tracking_number_of_times_cycle_6_151_to_180_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_6_151_to_180_days),
    AB_Fields.InValid_payment_tracking_number_of_times_cycle_7_181_or_greater_days((SALT33.StrType)le.payment_tracking_number_of_times_cycle_7_181_or_greater_days),
    AB_Fields.InValid_date_account_was_charged_off((SALT33.StrType)le.date_account_was_charged_off),
    AB_Fields.InValid_amount_charged_off_by_creditor((SALT33.StrType)le.amount_charged_off_by_creditor),
    AB_Fields.InValid_charge_off_type_indicator((SALT33.StrType)le.charge_off_type_indicator),
    AB_Fields.InValid_total_charge_off_recoveries_to_date((SALT33.StrType)le.total_charge_off_recoveries_to_date),
    AB_Fields.InValid_government_guarantee_flag((SALT33.StrType)le.government_guarantee_flag),
    AB_Fields.InValid_government_guarantee_category((SALT33.StrType)le.government_guarantee_category),
    AB_Fields.InValid_portion_of_account_guaranteed_by_government((SALT33.StrType)le.portion_of_account_guaranteed_by_government),
    AB_Fields.InValid_guarantors_indicator((SALT33.StrType)le.guarantors_indicator),
    AB_Fields.InValid_number_of_guarantors((SALT33.StrType)le.number_of_guarantors),
    AB_Fields.InValid_owners_indicator((SALT33.StrType)le.owners_indicator),
    AB_Fields.InValid_number_of_principals((SALT33.StrType)le.number_of_principals),
    AB_Fields.InValid_account_update_deletion_indicator((SALT33.StrType)le.account_update_deletion_indicator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,83,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := AB_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_segment_num','invalid_parent_sequence_number','invalid_accholder_businessname','invalid_dba','invalid_comp_website','invalid_legal_busi_structure','invalid_busi_established_date','invalid_contractacc_num','invalid_accounttypereported','invalid_acc_status1','invalid_acc_status2','invalid_dateaccopened','invalid_dateaccclosed','invalid_accountcloseurebasis','invalid_accexpirationdate','invalid_lastactivitydate','invalid_lastactivitytype','invalid_recentactivityindicator','invalid_origcreditlimit','invalid_highestcreditused','invalid_currentcreditlimit','invalid_reporterindicatorlength','invalid_paymentinterval','invalid_paymentstatuscategory','invalid_termofacc_months','invalid_firstpymtduedate','invalid_finalpymtduedate','invalid_origrate','invalid_floatingrate','invalid_graceperiod','invalid_paymentcategory','invalid_pymthistprofile12','invalid_pymthistprofile13_24','invalid_pymthistprofile25_36','invalid_pymthistprofile37_48','invalid_pymthistlength','invalid_ytd_purchasescount','invalid_ltd_purchasescount','invalid_ytd_purchasessumamt','invalid_ltd_purchasessumamt','invalid_pymtamtscheduled','invalid_recentpymtamt','invalid_recentpaymentdate','invalid_remainingbalance','invalid_carriedoveramt','invalid_newappliedcharges','invalid_balloonpymtdue','invalid_balloonpymtduedate','invalid_delinquencydate','invalid_daysdelinquent','invalid_pastdueamt','invalid_maximum_num_bucket','invalid_past_due_aging_bucket_type','invalid_past_due_aging_amount_bucket_1','invalid_past_due_aging_amount_bucket_2','invalid_past_due_aging_amount_bucket_3','invalid_past_due_aging_amount_bucket_4','invalid_past_due_aging_amount_bucket_5','invalid_past_due_aging_amount_bucket_6','invalid_past_due_aging_amount_bucket_7','invalid_maximum_num_tracking','invalid_payment_tracking_cycle_type','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_num','invalid_date_account_was_charged_off','invalid_amount_charged_off_by_creditor','invalid_charge_off_type_indicator','invalid_total_charge_off_recoveries_to_date','invalid_government_guarantee_flag','invalid_government_guarantee_category','invalid_num','invalid_guarantors_indicator','invalid_number_of_guarantors','invalid_owners_indicator','invalid_number_of_principals','invalid_account_update_deletion_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AB_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),AB_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),AB_Fields.InValidMessage_parent_sequence_number(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_holder_business_name(TotalErrors.ErrorNum),AB_Fields.InValidMessage_dba(TotalErrors.ErrorNum),AB_Fields.InValidMessage_company_website(TotalErrors.ErrorNum),AB_Fields.InValidMessage_legal_business_structure(TotalErrors.ErrorNum),AB_Fields.InValidMessage_business_established_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_contract_account_number(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_type_reported(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_status_1(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_status_2(TotalErrors.ErrorNum),AB_Fields.InValidMessage_date_account_opened(TotalErrors.ErrorNum),AB_Fields.InValidMessage_date_account_closed(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_closure_basis(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_expiration_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_last_activity_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_last_activity_type(TotalErrors.ErrorNum),AB_Fields.InValidMessage_recent_activity_indicator(TotalErrors.ErrorNum),AB_Fields.InValidMessage_original_credit_limit(TotalErrors.ErrorNum),AB_Fields.InValidMessage_highest_credit_used(TotalErrors.ErrorNum),AB_Fields.InValidMessage_current_credit_limit(TotalErrors.ErrorNum),AB_Fields.InValidMessage_reporting_indicator_length(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_interval(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_status_category(TotalErrors.ErrorNum),AB_Fields.InValidMessage_term_of_account_in_months(TotalErrors.ErrorNum),AB_Fields.InValidMessage_first_payment_due_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_final_payment_due_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_original_rate(TotalErrors.ErrorNum),AB_Fields.InValidMessage_floating_rate(TotalErrors.ErrorNum),AB_Fields.InValidMessage_grace_period(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_category(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_history_profile_12_months(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_history_profile_13_24_months(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_history_profile_25_36_months(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_history_profile_37_48_months(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_history_length(TotalErrors.ErrorNum),AB_Fields.InValidMessage_year_to_date_purchases_count(TotalErrors.ErrorNum),AB_Fields.InValidMessage_lifetime_to_date_purchases_count(TotalErrors.ErrorNum),AB_Fields.InValidMessage_year_to_date_purchases_sum_amount(TotalErrors.ErrorNum),AB_Fields.InValidMessage_lifetime_to_date_purchases_sum_amount(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_amount_scheduled(TotalErrors.ErrorNum),AB_Fields.InValidMessage_recent_payment_amount(TotalErrors.ErrorNum),AB_Fields.InValidMessage_recent_payment_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_remaining_balance(TotalErrors.ErrorNum),AB_Fields.InValidMessage_carried_over_amount(TotalErrors.ErrorNum),AB_Fields.InValidMessage_new_applied_charges(TotalErrors.ErrorNum),AB_Fields.InValidMessage_balloon_payment_due(TotalErrors.ErrorNum),AB_Fields.InValidMessage_balloon_payment_due_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_delinquency_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_days_delinquent(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_amount(TotalErrors.ErrorNum),AB_Fields.InValidMessage_maximum_number_of_past_due_aging_amounts_buckets_provided(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_bucket_type(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_1(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_2(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_3(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_4(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_5(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_6(TotalErrors.ErrorNum),AB_Fields.InValidMessage_past_due_aging_amount_bucket_7(TotalErrors.ErrorNum),AB_Fields.InValidMessage_maximum_number_of_payment_tracking_cycle_periods_provided(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_type(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_0_current(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_1_1_to_30_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_2_31_to_60_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_3_61_to_90_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_4_91_to_120_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_cycle_5_121_to_150days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_number_of_times_cycle_6_151_to_180_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_payment_tracking_number_of_times_cycle_7_181_or_greater_days(TotalErrors.ErrorNum),AB_Fields.InValidMessage_date_account_was_charged_off(TotalErrors.ErrorNum),AB_Fields.InValidMessage_amount_charged_off_by_creditor(TotalErrors.ErrorNum),AB_Fields.InValidMessage_charge_off_type_indicator(TotalErrors.ErrorNum),AB_Fields.InValidMessage_total_charge_off_recoveries_to_date(TotalErrors.ErrorNum),AB_Fields.InValidMessage_government_guarantee_flag(TotalErrors.ErrorNum),AB_Fields.InValidMessage_government_guarantee_category(TotalErrors.ErrorNum),AB_Fields.InValidMessage_portion_of_account_guaranteed_by_government(TotalErrors.ErrorNum),AB_Fields.InValidMessage_guarantors_indicator(TotalErrors.ErrorNum),AB_Fields.InValidMessage_number_of_guarantors(TotalErrors.ErrorNum),AB_Fields.InValidMessage_owners_indicator(TotalErrors.ErrorNum),AB_Fields.InValidMessage_number_of_principals(TotalErrors.ErrorNum),AB_Fields.InValidMessage_account_update_deletion_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
