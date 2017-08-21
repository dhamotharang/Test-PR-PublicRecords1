EXPORT MAC_PopulationStatistics(infile,Ref='',Input_segment_identifier = '',Input_file_sequence_number = '',Input_parent_sequence_number = '',Input_account_holder_business_name = '',Input_dba = '',Input_company_website = '',Input_legal_business_structure = '',Input_business_established_date = '',Input_contract_account_number = '',Input_account_type_reported = '',Input_account_status_1 = '',Input_account_status_2 = '',Input_date_account_opened = '',Input_date_account_closed = '',Input_account_closure_basis = '',Input_account_expiration_date = '',Input_last_activity_date = '',Input_last_activity_type = '',Input_recent_activity_indicator = '',Input_original_credit_limit = '',Input_highest_credit_used = '',Input_current_credit_limit = '',Input_reporting_indicator_length = '',Input_payment_interval = '',Input_payment_status_category = '',Input_term_of_account_in_months = '',Input_first_payment_due_date = '',Input_final_payment_due_date = '',Input_original_rate = '',Input_floating_rate = '',Input_grace_period = '',Input_payment_category = '',Input_payment_history_profile_12_months = '',Input_payment_history_profile_13_24_months = '',Input_payment_history_profile_25_36_months = '',Input_payment_history_profile_37_48_months = '',Input_payment_history_length = '',Input_year_to_date_purchases_count = '',Input_lifetime_to_date_purchases_count = '',Input_year_to_date_purchases_sum_amount = '',Input_lifetime_to_date_purchases_sum_amount = '',Input_payment_amount_scheduled = '',Input_recent_payment_amount = '',Input_recent_payment_date = '',Input_remaining_balance = '',Input_carried_over_amount = '',Input_new_applied_charges = '',Input_balloon_payment_due = '',Input_balloon_payment_due_date = '',Input_delinquency_date = '',Input_days_delinquent = '',Input_past_due_amount = '',Input_maximum_number_of_past_due_aging_amounts_buckets_provided = '',Input_past_due_aging_bucket_type = '',Input_past_due_aging_amount_bucket_1 = '',Input_past_due_aging_amount_bucket_2 = '',Input_past_due_aging_amount_bucket_3 = '',Input_past_due_aging_amount_bucket_4 = '',Input_past_due_aging_amount_bucket_5 = '',Input_past_due_aging_amount_bucket_6 = '',Input_past_due_aging_amount_bucket_7 = '',Input_maximum_number_of_payment_tracking_cycle_periods_provided = '',Input_payment_tracking_cycle_type = '',Input_payment_tracking_cycle_0_current = '',Input_payment_tracking_cycle_1_1_to_30_days = '',Input_payment_tracking_cycle_2_31_to_60_days = '',Input_payment_tracking_cycle_3_61_to_90_days = '',Input_payment_tracking_cycle_4_91_to_120_days = '',Input_payment_tracking_cycle_5_121_to_150days = '',Input_payment_tracking_number_of_times_cycle_6_151_to_180_days = '',Input_payment_tracking_number_of_times_cycle_7_181_or_greater_days = '',Input_date_account_was_charged_off = '',Input_amount_charged_off_by_creditor = '',Input_charge_off_type_indicator = '',Input_total_charge_off_recoveries_to_date = '',Input_government_guarantee_flag = '',Input_government_guarantee_category = '',Input_portion_of_account_guaranteed_by_government = '',Input_guarantors_indicator = '',Input_number_of_guarantors = '',Input_owners_indicator = '',Input_number_of_principals = '',Input_account_update_deletion_indicator = '',OutFile) := MACRO
  IMPORT SALT33,Scrubs_Business_Credit;
  #uniquename(of)
  %of% := RECORD
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_segment_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_segment_identifier = (TYPEOF(le.Input_segment_identifier))'','',':segment_identifier')
    #END
+    #IF( #TEXT(Input_file_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_sequence_number = (TYPEOF(le.Input_file_sequence_number))'','',':file_sequence_number')
    #END
+    #IF( #TEXT(Input_parent_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_parent_sequence_number = (TYPEOF(le.Input_parent_sequence_number))'','',':parent_sequence_number')
    #END
+    #IF( #TEXT(Input_account_holder_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_account_holder_business_name = (TYPEOF(le.Input_account_holder_business_name))'','',':account_holder_business_name')
    #END
+    #IF( #TEXT(Input_dba)='' )
      '' 
    #ELSE
        IF( le.Input_dba = (TYPEOF(le.Input_dba))'','',':dba')
    #END
+    #IF( #TEXT(Input_company_website)='' )
      '' 
    #ELSE
        IF( le.Input_company_website = (TYPEOF(le.Input_company_website))'','',':company_website')
    #END
+    #IF( #TEXT(Input_legal_business_structure)='' )
      '' 
    #ELSE
        IF( le.Input_legal_business_structure = (TYPEOF(le.Input_legal_business_structure))'','',':legal_business_structure')
    #END
+    #IF( #TEXT(Input_business_established_date)='' )
      '' 
    #ELSE
        IF( le.Input_business_established_date = (TYPEOF(le.Input_business_established_date))'','',':business_established_date')
    #END
+    #IF( #TEXT(Input_contract_account_number)='' )
      '' 
    #ELSE
        IF( le.Input_contract_account_number = (TYPEOF(le.Input_contract_account_number))'','',':contract_account_number')
    #END
+    #IF( #TEXT(Input_account_type_reported)='' )
      '' 
    #ELSE
        IF( le.Input_account_type_reported = (TYPEOF(le.Input_account_type_reported))'','',':account_type_reported')
    #END
+    #IF( #TEXT(Input_account_status_1)='' )
      '' 
    #ELSE
        IF( le.Input_account_status_1 = (TYPEOF(le.Input_account_status_1))'','',':account_status_1')
    #END
+    #IF( #TEXT(Input_account_status_2)='' )
      '' 
    #ELSE
        IF( le.Input_account_status_2 = (TYPEOF(le.Input_account_status_2))'','',':account_status_2')
    #END
+    #IF( #TEXT(Input_date_account_opened)='' )
      '' 
    #ELSE
        IF( le.Input_date_account_opened = (TYPEOF(le.Input_date_account_opened))'','',':date_account_opened')
    #END
+    #IF( #TEXT(Input_date_account_closed)='' )
      '' 
    #ELSE
        IF( le.Input_date_account_closed = (TYPEOF(le.Input_date_account_closed))'','',':date_account_closed')
    #END
+    #IF( #TEXT(Input_account_closure_basis)='' )
      '' 
    #ELSE
        IF( le.Input_account_closure_basis = (TYPEOF(le.Input_account_closure_basis))'','',':account_closure_basis')
    #END
+    #IF( #TEXT(Input_account_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_account_expiration_date = (TYPEOF(le.Input_account_expiration_date))'','',':account_expiration_date')
    #END
+    #IF( #TEXT(Input_last_activity_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_activity_date = (TYPEOF(le.Input_last_activity_date))'','',':last_activity_date')
    #END
+    #IF( #TEXT(Input_last_activity_type)='' )
      '' 
    #ELSE
        IF( le.Input_last_activity_type = (TYPEOF(le.Input_last_activity_type))'','',':last_activity_type')
    #END
+    #IF( #TEXT(Input_recent_activity_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_recent_activity_indicator = (TYPEOF(le.Input_recent_activity_indicator))'','',':recent_activity_indicator')
    #END
+    #IF( #TEXT(Input_original_credit_limit)='' )
      '' 
    #ELSE
        IF( le.Input_original_credit_limit = (TYPEOF(le.Input_original_credit_limit))'','',':original_credit_limit')
    #END
+    #IF( #TEXT(Input_highest_credit_used)='' )
      '' 
    #ELSE
        IF( le.Input_highest_credit_used = (TYPEOF(le.Input_highest_credit_used))'','',':highest_credit_used')
    #END
+    #IF( #TEXT(Input_current_credit_limit)='' )
      '' 
    #ELSE
        IF( le.Input_current_credit_limit = (TYPEOF(le.Input_current_credit_limit))'','',':current_credit_limit')
    #END
+    #IF( #TEXT(Input_reporting_indicator_length)='' )
      '' 
    #ELSE
        IF( le.Input_reporting_indicator_length = (TYPEOF(le.Input_reporting_indicator_length))'','',':reporting_indicator_length')
    #END
+    #IF( #TEXT(Input_payment_interval)='' )
      '' 
    #ELSE
        IF( le.Input_payment_interval = (TYPEOF(le.Input_payment_interval))'','',':payment_interval')
    #END
+    #IF( #TEXT(Input_payment_status_category)='' )
      '' 
    #ELSE
        IF( le.Input_payment_status_category = (TYPEOF(le.Input_payment_status_category))'','',':payment_status_category')
    #END
+    #IF( #TEXT(Input_term_of_account_in_months)='' )
      '' 
    #ELSE
        IF( le.Input_term_of_account_in_months = (TYPEOF(le.Input_term_of_account_in_months))'','',':term_of_account_in_months')
    #END
+    #IF( #TEXT(Input_first_payment_due_date)='' )
      '' 
    #ELSE
        IF( le.Input_first_payment_due_date = (TYPEOF(le.Input_first_payment_due_date))'','',':first_payment_due_date')
    #END
+    #IF( #TEXT(Input_final_payment_due_date)='' )
      '' 
    #ELSE
        IF( le.Input_final_payment_due_date = (TYPEOF(le.Input_final_payment_due_date))'','',':final_payment_due_date')
    #END
+    #IF( #TEXT(Input_original_rate)='' )
      '' 
    #ELSE
        IF( le.Input_original_rate = (TYPEOF(le.Input_original_rate))'','',':original_rate')
    #END
+    #IF( #TEXT(Input_floating_rate)='' )
      '' 
    #ELSE
        IF( le.Input_floating_rate = (TYPEOF(le.Input_floating_rate))'','',':floating_rate')
    #END
+    #IF( #TEXT(Input_grace_period)='' )
      '' 
    #ELSE
        IF( le.Input_grace_period = (TYPEOF(le.Input_grace_period))'','',':grace_period')
    #END
+    #IF( #TEXT(Input_payment_category)='' )
      '' 
    #ELSE
        IF( le.Input_payment_category = (TYPEOF(le.Input_payment_category))'','',':payment_category')
    #END
+    #IF( #TEXT(Input_payment_history_profile_12_months)='' )
      '' 
    #ELSE
        IF( le.Input_payment_history_profile_12_months = (TYPEOF(le.Input_payment_history_profile_12_months))'','',':payment_history_profile_12_months')
    #END
+    #IF( #TEXT(Input_payment_history_profile_13_24_months)='' )
      '' 
    #ELSE
        IF( le.Input_payment_history_profile_13_24_months = (TYPEOF(le.Input_payment_history_profile_13_24_months))'','',':payment_history_profile_13_24_months')
    #END
+    #IF( #TEXT(Input_payment_history_profile_25_36_months)='' )
      '' 
    #ELSE
        IF( le.Input_payment_history_profile_25_36_months = (TYPEOF(le.Input_payment_history_profile_25_36_months))'','',':payment_history_profile_25_36_months')
    #END
+    #IF( #TEXT(Input_payment_history_profile_37_48_months)='' )
      '' 
    #ELSE
        IF( le.Input_payment_history_profile_37_48_months = (TYPEOF(le.Input_payment_history_profile_37_48_months))'','',':payment_history_profile_37_48_months')
    #END
+    #IF( #TEXT(Input_payment_history_length)='' )
      '' 
    #ELSE
        IF( le.Input_payment_history_length = (TYPEOF(le.Input_payment_history_length))'','',':payment_history_length')
    #END
+    #IF( #TEXT(Input_year_to_date_purchases_count)='' )
      '' 
    #ELSE
        IF( le.Input_year_to_date_purchases_count = (TYPEOF(le.Input_year_to_date_purchases_count))'','',':year_to_date_purchases_count')
    #END
+    #IF( #TEXT(Input_lifetime_to_date_purchases_count)='' )
      '' 
    #ELSE
        IF( le.Input_lifetime_to_date_purchases_count = (TYPEOF(le.Input_lifetime_to_date_purchases_count))'','',':lifetime_to_date_purchases_count')
    #END
+    #IF( #TEXT(Input_year_to_date_purchases_sum_amount)='' )
      '' 
    #ELSE
        IF( le.Input_year_to_date_purchases_sum_amount = (TYPEOF(le.Input_year_to_date_purchases_sum_amount))'','',':year_to_date_purchases_sum_amount')
    #END
+    #IF( #TEXT(Input_lifetime_to_date_purchases_sum_amount)='' )
      '' 
    #ELSE
        IF( le.Input_lifetime_to_date_purchases_sum_amount = (TYPEOF(le.Input_lifetime_to_date_purchases_sum_amount))'','',':lifetime_to_date_purchases_sum_amount')
    #END
+    #IF( #TEXT(Input_payment_amount_scheduled)='' )
      '' 
    #ELSE
        IF( le.Input_payment_amount_scheduled = (TYPEOF(le.Input_payment_amount_scheduled))'','',':payment_amount_scheduled')
    #END
+    #IF( #TEXT(Input_recent_payment_amount)='' )
      '' 
    #ELSE
        IF( le.Input_recent_payment_amount = (TYPEOF(le.Input_recent_payment_amount))'','',':recent_payment_amount')
    #END
+    #IF( #TEXT(Input_recent_payment_date)='' )
      '' 
    #ELSE
        IF( le.Input_recent_payment_date = (TYPEOF(le.Input_recent_payment_date))'','',':recent_payment_date')
    #END
+    #IF( #TEXT(Input_remaining_balance)='' )
      '' 
    #ELSE
        IF( le.Input_remaining_balance = (TYPEOF(le.Input_remaining_balance))'','',':remaining_balance')
    #END
+    #IF( #TEXT(Input_carried_over_amount)='' )
      '' 
    #ELSE
        IF( le.Input_carried_over_amount = (TYPEOF(le.Input_carried_over_amount))'','',':carried_over_amount')
    #END
+    #IF( #TEXT(Input_new_applied_charges)='' )
      '' 
    #ELSE
        IF( le.Input_new_applied_charges = (TYPEOF(le.Input_new_applied_charges))'','',':new_applied_charges')
    #END
+    #IF( #TEXT(Input_balloon_payment_due)='' )
      '' 
    #ELSE
        IF( le.Input_balloon_payment_due = (TYPEOF(le.Input_balloon_payment_due))'','',':balloon_payment_due')
    #END
+    #IF( #TEXT(Input_balloon_payment_due_date)='' )
      '' 
    #ELSE
        IF( le.Input_balloon_payment_due_date = (TYPEOF(le.Input_balloon_payment_due_date))'','',':balloon_payment_due_date')
    #END
+    #IF( #TEXT(Input_delinquency_date)='' )
      '' 
    #ELSE
        IF( le.Input_delinquency_date = (TYPEOF(le.Input_delinquency_date))'','',':delinquency_date')
    #END
+    #IF( #TEXT(Input_days_delinquent)='' )
      '' 
    #ELSE
        IF( le.Input_days_delinquent = (TYPEOF(le.Input_days_delinquent))'','',':days_delinquent')
    #END
+    #IF( #TEXT(Input_past_due_amount)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_amount = (TYPEOF(le.Input_past_due_amount))'','',':past_due_amount')
    #END
+    #IF( #TEXT(Input_maximum_number_of_past_due_aging_amounts_buckets_provided)='' )
      '' 
    #ELSE
        IF( le.Input_maximum_number_of_past_due_aging_amounts_buckets_provided = (TYPEOF(le.Input_maximum_number_of_past_due_aging_amounts_buckets_provided))'','',':maximum_number_of_past_due_aging_amounts_buckets_provided')
    #END
+    #IF( #TEXT(Input_past_due_aging_bucket_type)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_bucket_type = (TYPEOF(le.Input_past_due_aging_bucket_type))'','',':past_due_aging_bucket_type')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_1)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_1 = (TYPEOF(le.Input_past_due_aging_amount_bucket_1))'','',':past_due_aging_amount_bucket_1')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_2)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_2 = (TYPEOF(le.Input_past_due_aging_amount_bucket_2))'','',':past_due_aging_amount_bucket_2')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_3)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_3 = (TYPEOF(le.Input_past_due_aging_amount_bucket_3))'','',':past_due_aging_amount_bucket_3')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_4)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_4 = (TYPEOF(le.Input_past_due_aging_amount_bucket_4))'','',':past_due_aging_amount_bucket_4')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_5)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_5 = (TYPEOF(le.Input_past_due_aging_amount_bucket_5))'','',':past_due_aging_amount_bucket_5')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_6)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_6 = (TYPEOF(le.Input_past_due_aging_amount_bucket_6))'','',':past_due_aging_amount_bucket_6')
    #END
+    #IF( #TEXT(Input_past_due_aging_amount_bucket_7)='' )
      '' 
    #ELSE
        IF( le.Input_past_due_aging_amount_bucket_7 = (TYPEOF(le.Input_past_due_aging_amount_bucket_7))'','',':past_due_aging_amount_bucket_7')
    #END
+    #IF( #TEXT(Input_maximum_number_of_payment_tracking_cycle_periods_provided)='' )
      '' 
    #ELSE
        IF( le.Input_maximum_number_of_payment_tracking_cycle_periods_provided = (TYPEOF(le.Input_maximum_number_of_payment_tracking_cycle_periods_provided))'','',':maximum_number_of_payment_tracking_cycle_periods_provided')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_type)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_type = (TYPEOF(le.Input_payment_tracking_cycle_type))'','',':payment_tracking_cycle_type')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_0_current)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_0_current = (TYPEOF(le.Input_payment_tracking_cycle_0_current))'','',':payment_tracking_cycle_0_current')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_1_1_to_30_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_1_1_to_30_days = (TYPEOF(le.Input_payment_tracking_cycle_1_1_to_30_days))'','',':payment_tracking_cycle_1_1_to_30_days')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_2_31_to_60_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_2_31_to_60_days = (TYPEOF(le.Input_payment_tracking_cycle_2_31_to_60_days))'','',':payment_tracking_cycle_2_31_to_60_days')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_3_61_to_90_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_3_61_to_90_days = (TYPEOF(le.Input_payment_tracking_cycle_3_61_to_90_days))'','',':payment_tracking_cycle_3_61_to_90_days')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_4_91_to_120_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_4_91_to_120_days = (TYPEOF(le.Input_payment_tracking_cycle_4_91_to_120_days))'','',':payment_tracking_cycle_4_91_to_120_days')
    #END
+    #IF( #TEXT(Input_payment_tracking_cycle_5_121_to_150days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_cycle_5_121_to_150days = (TYPEOF(le.Input_payment_tracking_cycle_5_121_to_150days))'','',':payment_tracking_cycle_5_121_to_150days')
    #END
+    #IF( #TEXT(Input_payment_tracking_number_of_times_cycle_6_151_to_180_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_number_of_times_cycle_6_151_to_180_days = (TYPEOF(le.Input_payment_tracking_number_of_times_cycle_6_151_to_180_days))'','',':payment_tracking_number_of_times_cycle_6_151_to_180_days')
    #END
+    #IF( #TEXT(Input_payment_tracking_number_of_times_cycle_7_181_or_greater_days)='' )
      '' 
    #ELSE
        IF( le.Input_payment_tracking_number_of_times_cycle_7_181_or_greater_days = (TYPEOF(le.Input_payment_tracking_number_of_times_cycle_7_181_or_greater_days))'','',':payment_tracking_number_of_times_cycle_7_181_or_greater_days')
    #END
+    #IF( #TEXT(Input_date_account_was_charged_off)='' )
      '' 
    #ELSE
        IF( le.Input_date_account_was_charged_off = (TYPEOF(le.Input_date_account_was_charged_off))'','',':date_account_was_charged_off')
    #END
+    #IF( #TEXT(Input_amount_charged_off_by_creditor)='' )
      '' 
    #ELSE
        IF( le.Input_amount_charged_off_by_creditor = (TYPEOF(le.Input_amount_charged_off_by_creditor))'','',':amount_charged_off_by_creditor')
    #END
+    #IF( #TEXT(Input_charge_off_type_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_charge_off_type_indicator = (TYPEOF(le.Input_charge_off_type_indicator))'','',':charge_off_type_indicator')
    #END
+    #IF( #TEXT(Input_total_charge_off_recoveries_to_date)='' )
      '' 
    #ELSE
        IF( le.Input_total_charge_off_recoveries_to_date = (TYPEOF(le.Input_total_charge_off_recoveries_to_date))'','',':total_charge_off_recoveries_to_date')
    #END
+    #IF( #TEXT(Input_government_guarantee_flag)='' )
      '' 
    #ELSE
        IF( le.Input_government_guarantee_flag = (TYPEOF(le.Input_government_guarantee_flag))'','',':government_guarantee_flag')
    #END
+    #IF( #TEXT(Input_government_guarantee_category)='' )
      '' 
    #ELSE
        IF( le.Input_government_guarantee_category = (TYPEOF(le.Input_government_guarantee_category))'','',':government_guarantee_category')
    #END
+    #IF( #TEXT(Input_portion_of_account_guaranteed_by_government)='' )
      '' 
    #ELSE
        IF( le.Input_portion_of_account_guaranteed_by_government = (TYPEOF(le.Input_portion_of_account_guaranteed_by_government))'','',':portion_of_account_guaranteed_by_government')
    #END
+    #IF( #TEXT(Input_guarantors_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_guarantors_indicator = (TYPEOF(le.Input_guarantors_indicator))'','',':guarantors_indicator')
    #END
+    #IF( #TEXT(Input_number_of_guarantors)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_guarantors = (TYPEOF(le.Input_number_of_guarantors))'','',':number_of_guarantors')
    #END
+    #IF( #TEXT(Input_owners_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_owners_indicator = (TYPEOF(le.Input_owners_indicator))'','',':owners_indicator')
    #END
+    #IF( #TEXT(Input_number_of_principals)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_principals = (TYPEOF(le.Input_number_of_principals))'','',':number_of_principals')
    #END
+    #IF( #TEXT(Input_account_update_deletion_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_account_update_deletion_indicator = (TYPEOF(le.Input_account_update_deletion_indicator))'','',':account_update_deletion_indicator')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
