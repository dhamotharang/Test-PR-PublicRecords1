 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_classification_source_source_type = '',Input_classification_source_primary_source_entity = '',Input_classification_source_expectation_of_victim_entities = '',Input_classification_source_industry_segment = '',Input_classification_activity_suspected_discrepancy = '',Input_classification_activity_confidence_that_activity_was_deceitful = '',Input_classification_activity_workflow_stage_committed = '',Input_classification_activity_workflow_stage_detected = '',Input_classification_activity_channels = '',Input_classification_activity_category_or_fraudtype = '',Input_classification_activity_description = '',Input_classification_activity_threat = '',Input_classification_activity_exposure = '',Input_classification_activity_write_off_loss = '',Input_classification_activity_mitigated = '',Input_classification_activity_alert_level = '',Input_classification_entity_entity_type = '',Input_classification_entity_entity_sub_type = '',Input_classification_entity_role = '',Input_classification_entity_evidence = '',Input_classification_entity_investigated_count = '',Input_classification_permissible_use_access_fdn_file_info_id = '',Input_classification_permissible_use_access_fdn_file_code = '',Input_classification_permissible_use_access_gc_id = '',Input_classification_permissible_use_access_file_type = '',Input_classification_permissible_use_access_description = '',Input_classification_permissible_use_access_primary_source_entity = '',Input_classification_permissible_use_access_ind_type = '',Input_classification_permissible_use_access_ind_type_description = '',Input_classification_permissible_use_access_update_freq = '',Input_classification_permissible_use_access_expiration_days = '',Input_classification_permissible_use_access_post_contract_expiration_days = '',Input_classification_permissible_use_access_status = '',Input_classification_permissible_use_access_product_include = '',Input_classification_permissible_use_access_date_added = '',Input_classification_permissible_use_access_user_added = '',Input_classification_permissible_use_access_date_changed = '',Input_classification_permissible_use_access_user_changed = '',Input_classification_permissible_use_access_p_industry_segment = '',Input_classification_permissible_use_access_usage_term = '',Input_cleaned_name_title = '',Input_cleaned_name_fname = '',Input_cleaned_name_mname = '',Input_cleaned_name_lname = '',Input_cleaned_name_name_suffix = '',Input_cleaned_name_name_score = '',Input_clean_address_prim_range = '',Input_clean_address_predir = '',Input_clean_address_prim_name = '',Input_clean_address_addr_suffix = '',Input_clean_address_postdir = '',Input_clean_address_unit_desig = '',Input_clean_address_sec_range = '',Input_clean_address_p_city_name = '',Input_clean_address_v_city_name = '',Input_clean_address_st = '',Input_clean_address_zip = '',Input_clean_address_zip4 = '',Input_clean_address_cart = '',Input_clean_address_cr_sort_sz = '',Input_clean_address_lot = '',Input_clean_address_lot_order = '',Input_clean_address_dbpc = '',Input_clean_address_chk_digit = '',Input_clean_address_rec_type = '',Input_clean_address_fips_state = '',Input_clean_address_fips_county = '',Input_clean_address_geo_lat = '',Input_clean_address_geo_long = '',Input_clean_address_msa = '',Input_clean_address_geo_blk = '',Input_clean_address_geo_match = '',Input_clean_address_err_stat = '',Input_clean_phones_phone_number = '',Input_clean_phones_cell_phone = '',Input_clean_phones_work_phone = '',Input_record_id = '',Input_uid = '',Input_customer_id = '',Input_sub_customer_id = '',Input_vendor_id = '',Input_offender_key = '',Input_sub_sub_customer_id = '',Input_customer_event_id = '',Input_sub_customer_event_id = '',Input_sub_sub_customer_event_id = '',Input_ln_product_id = '',Input_ln_sub_product_id = '',Input_ln_sub_sub_product_id = '',Input_ln_product_key = '',Input_ln_report_date = '',Input_ln_report_time = '',Input_reported_date = '',Input_reported_time = '',Input_event_date = '',Input_event_end_date = '',Input_event_location = '',Input_event_type_1 = '',Input_event_type_2 = '',Input_event_type_3 = '',Input_household_id = '',Input_reason_description = '',Input_investigation_referral_case_id = '',Input_investigation_referral_date_opened = '',Input_investigation_referral_date_closed = '',Input_customer_fraud_code_1 = '',Input_customer_fraud_code_2 = '',Input_type_of_referral = '',Input_referral_reason = '',Input_disposition = '',Input_mitigated = '',Input_mitigated_amount = '',Input_external_referral_or_casenumber = '',Input_fraud_point_score = '',Input_customer_person_id = '',Input_raw_title = '',Input_raw_first_name = '',Input_raw_middle_name = '',Input_raw_last_name = '',Input_raw_orig_suffix = '',Input_raw_full_name = '',Input_ssn = '',Input_dob = '',Input_drivers_license = '',Input_drivers_license_state = '',Input_person_date = '',Input_name_type = '',Input_income = '',Input_own_or_rent = '',Input_rawlinkid = '',Input_street_1 = '',Input_street_2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_gps_coordinates = '',Input_address_date = '',Input_address_type = '',Input_appended_provider_id = '',Input_lnpid = '',Input_business_name = '',Input_tin = '',Input_fein = '',Input_npi = '',Input_business_type_1 = '',Input_business_type_2 = '',Input_business_date = '',Input_phone_number = '',Input_cell_phone = '',Input_work_phone = '',Input_contact_type = '',Input_contact_date = '',Input_carrier = '',Input_contact_location = '',Input_contact = '',Input_call_records = '',Input_in_service = '',Input_email_address = '',Input_email_address_type = '',Input_email_date = '',Input_host = '',Input_alias = '',Input_location = '',Input_ip_address = '',Input_ip_address_date = '',Input_version = '',Input_class = '',Input_subnet_mask = '',Input_reserved = '',Input_isp = '',Input_device_id = '',Input_device_date = '',Input_unique_number = '',Input_mac_address = '',Input_serial_number = '',Input_device_type = '',Input_device_identification_provider = '',Input_transaction_id = '',Input_transaction_type = '',Input_amount_of_loss = '',Input_professional_id = '',Input_profession_type = '',Input_corresponding_professional_ids = '',Input_licensed_pr_state = '',Input_source = '',Input_process_date = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_last_reported = '',Input_dt_vendor_first_reported = '',Input_source_rec_id = '',Input_nid = '',Input_name_ind = '',Input_address_1 = '',Input_address_2 = '',Input_rawaid = '',Input_aceaid = '',Input_address_ind = '',Input_did = '',Input_did_score = '',Input_clean_business_name = '',Input_bdid = '',Input_bdid_score = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input___internal_fpos__ = '',OutFile) := MACRO
  IMPORT SALT34,cramos;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_classification_source_source_type)='' )
      '' 
    #ELSE
        IF( le.Input_classification_source_source_type = (TYPEOF(le.Input_classification_source_source_type))'','',':classification_source_source_type')
    #END
 
+    #IF( #TEXT(Input_classification_source_primary_source_entity)='' )
      '' 
    #ELSE
        IF( le.Input_classification_source_primary_source_entity = (TYPEOF(le.Input_classification_source_primary_source_entity))'','',':classification_source_primary_source_entity')
    #END
 
+    #IF( #TEXT(Input_classification_source_expectation_of_victim_entities)='' )
      '' 
    #ELSE
        IF( le.Input_classification_source_expectation_of_victim_entities = (TYPEOF(le.Input_classification_source_expectation_of_victim_entities))'','',':classification_source_expectation_of_victim_entities')
    #END
 
+    #IF( #TEXT(Input_classification_source_industry_segment)='' )
      '' 
    #ELSE
        IF( le.Input_classification_source_industry_segment = (TYPEOF(le.Input_classification_source_industry_segment))'','',':classification_source_industry_segment')
    #END
 
+    #IF( #TEXT(Input_classification_activity_suspected_discrepancy)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_suspected_discrepancy = (TYPEOF(le.Input_classification_activity_suspected_discrepancy))'','',':classification_activity_suspected_discrepancy')
    #END
 
+    #IF( #TEXT(Input_classification_activity_confidence_that_activity_was_deceitful)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_confidence_that_activity_was_deceitful = (TYPEOF(le.Input_classification_activity_confidence_that_activity_was_deceitful))'','',':classification_activity_confidence_that_activity_was_deceitful')
    #END
 
+    #IF( #TEXT(Input_classification_activity_workflow_stage_committed)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_workflow_stage_committed = (TYPEOF(le.Input_classification_activity_workflow_stage_committed))'','',':classification_activity_workflow_stage_committed')
    #END
 
+    #IF( #TEXT(Input_classification_activity_workflow_stage_detected)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_workflow_stage_detected = (TYPEOF(le.Input_classification_activity_workflow_stage_detected))'','',':classification_activity_workflow_stage_detected')
    #END
 
+    #IF( #TEXT(Input_classification_activity_channels)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_channels = (TYPEOF(le.Input_classification_activity_channels))'','',':classification_activity_channels')
    #END
 
+    #IF( #TEXT(Input_classification_activity_category_or_fraudtype)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_category_or_fraudtype = (TYPEOF(le.Input_classification_activity_category_or_fraudtype))'','',':classification_activity_category_or_fraudtype')
    #END
 
+    #IF( #TEXT(Input_classification_activity_description)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_description = (TYPEOF(le.Input_classification_activity_description))'','',':classification_activity_description')
    #END
 
+    #IF( #TEXT(Input_classification_activity_threat)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_threat = (TYPEOF(le.Input_classification_activity_threat))'','',':classification_activity_threat')
    #END
 
+    #IF( #TEXT(Input_classification_activity_exposure)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_exposure = (TYPEOF(le.Input_classification_activity_exposure))'','',':classification_activity_exposure')
    #END
 
+    #IF( #TEXT(Input_classification_activity_write_off_loss)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_write_off_loss = (TYPEOF(le.Input_classification_activity_write_off_loss))'','',':classification_activity_write_off_loss')
    #END
 
+    #IF( #TEXT(Input_classification_activity_mitigated)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_mitigated = (TYPEOF(le.Input_classification_activity_mitigated))'','',':classification_activity_mitigated')
    #END
 
+    #IF( #TEXT(Input_classification_activity_alert_level)='' )
      '' 
    #ELSE
        IF( le.Input_classification_activity_alert_level = (TYPEOF(le.Input_classification_activity_alert_level))'','',':classification_activity_alert_level')
    #END
 
+    #IF( #TEXT(Input_classification_entity_entity_type)='' )
      '' 
    #ELSE
        IF( le.Input_classification_entity_entity_type = (TYPEOF(le.Input_classification_entity_entity_type))'','',':classification_entity_entity_type')
    #END
 
+    #IF( #TEXT(Input_classification_entity_entity_sub_type)='' )
      '' 
    #ELSE
        IF( le.Input_classification_entity_entity_sub_type = (TYPEOF(le.Input_classification_entity_entity_sub_type))'','',':classification_entity_entity_sub_type')
    #END
 
+    #IF( #TEXT(Input_classification_entity_role)='' )
      '' 
    #ELSE
        IF( le.Input_classification_entity_role = (TYPEOF(le.Input_classification_entity_role))'','',':classification_entity_role')
    #END
 
+    #IF( #TEXT(Input_classification_entity_evidence)='' )
      '' 
    #ELSE
        IF( le.Input_classification_entity_evidence = (TYPEOF(le.Input_classification_entity_evidence))'','',':classification_entity_evidence')
    #END
 
+    #IF( #TEXT(Input_classification_entity_investigated_count)='' )
      '' 
    #ELSE
        IF( le.Input_classification_entity_investigated_count = (TYPEOF(le.Input_classification_entity_investigated_count))'','',':classification_entity_investigated_count')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_fdn_file_info_id)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_fdn_file_info_id = (TYPEOF(le.Input_classification_permissible_use_access_fdn_file_info_id))'','',':classification_permissible_use_access_fdn_file_info_id')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_fdn_file_code)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_fdn_file_code = (TYPEOF(le.Input_classification_permissible_use_access_fdn_file_code))'','',':classification_permissible_use_access_fdn_file_code')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_gc_id)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_gc_id = (TYPEOF(le.Input_classification_permissible_use_access_gc_id))'','',':classification_permissible_use_access_gc_id')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_file_type = (TYPEOF(le.Input_classification_permissible_use_access_file_type))'','',':classification_permissible_use_access_file_type')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_description)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_description = (TYPEOF(le.Input_classification_permissible_use_access_description))'','',':classification_permissible_use_access_description')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_primary_source_entity)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_primary_source_entity = (TYPEOF(le.Input_classification_permissible_use_access_primary_source_entity))'','',':classification_permissible_use_access_primary_source_entity')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_ind_type)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_ind_type = (TYPEOF(le.Input_classification_permissible_use_access_ind_type))'','',':classification_permissible_use_access_ind_type')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_ind_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_ind_type_description = (TYPEOF(le.Input_classification_permissible_use_access_ind_type_description))'','',':classification_permissible_use_access_ind_type_description')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_update_freq)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_update_freq = (TYPEOF(le.Input_classification_permissible_use_access_update_freq))'','',':classification_permissible_use_access_update_freq')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_expiration_days)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_expiration_days = (TYPEOF(le.Input_classification_permissible_use_access_expiration_days))'','',':classification_permissible_use_access_expiration_days')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_post_contract_expiration_days)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_post_contract_expiration_days = (TYPEOF(le.Input_classification_permissible_use_access_post_contract_expiration_days))'','',':classification_permissible_use_access_post_contract_expiration_days')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_status)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_status = (TYPEOF(le.Input_classification_permissible_use_access_status))'','',':classification_permissible_use_access_status')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_product_include)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_product_include = (TYPEOF(le.Input_classification_permissible_use_access_product_include))'','',':classification_permissible_use_access_product_include')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_date_added = (TYPEOF(le.Input_classification_permissible_use_access_date_added))'','',':classification_permissible_use_access_date_added')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_user_added)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_user_added = (TYPEOF(le.Input_classification_permissible_use_access_user_added))'','',':classification_permissible_use_access_user_added')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_date_changed)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_date_changed = (TYPEOF(le.Input_classification_permissible_use_access_date_changed))'','',':classification_permissible_use_access_date_changed')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_user_changed)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_user_changed = (TYPEOF(le.Input_classification_permissible_use_access_user_changed))'','',':classification_permissible_use_access_user_changed')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_p_industry_segment)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_p_industry_segment = (TYPEOF(le.Input_classification_permissible_use_access_p_industry_segment))'','',':classification_permissible_use_access_p_industry_segment')
    #END
 
+    #IF( #TEXT(Input_classification_permissible_use_access_usage_term)='' )
      '' 
    #ELSE
        IF( le.Input_classification_permissible_use_access_usage_term = (TYPEOF(le.Input_classification_permissible_use_access_usage_term))'','',':classification_permissible_use_access_usage_term')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_title = (TYPEOF(le.Input_cleaned_name_title))'','',':cleaned_name_title')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_fname = (TYPEOF(le.Input_cleaned_name_fname))'','',':cleaned_name_fname')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_mname)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_mname = (TYPEOF(le.Input_cleaned_name_mname))'','',':cleaned_name_mname')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_lname = (TYPEOF(le.Input_cleaned_name_lname))'','',':cleaned_name_lname')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_name_suffix = (TYPEOF(le.Input_cleaned_name_name_suffix))'','',':cleaned_name_name_suffix')
    #END
 
+    #IF( #TEXT(Input_cleaned_name_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_cleaned_name_name_score = (TYPEOF(le.Input_cleaned_name_name_score))'','',':cleaned_name_name_score')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_range = (TYPEOF(le.Input_clean_address_prim_range))'','',':clean_address_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_predir = (TYPEOF(le.Input_clean_address_predir))'','',':clean_address_predir')
    #END
 
+    #IF( #TEXT(Input_clean_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_prim_name = (TYPEOF(le.Input_clean_address_prim_name))'','',':clean_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_addr_suffix = (TYPEOF(le.Input_clean_address_addr_suffix))'','',':clean_address_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_postdir = (TYPEOF(le.Input_clean_address_postdir))'','',':clean_address_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_address_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_unit_desig = (TYPEOF(le.Input_clean_address_unit_desig))'','',':clean_address_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_address_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_sec_range = (TYPEOF(le.Input_clean_address_sec_range))'','',':clean_address_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_p_city_name = (TYPEOF(le.Input_clean_address_p_city_name))'','',':clean_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_v_city_name = (TYPEOF(le.Input_clean_address_v_city_name))'','',':clean_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_st = (TYPEOF(le.Input_clean_address_st))'','',':clean_address_st')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip = (TYPEOF(le.Input_clean_address_zip))'','',':clean_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_address_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_zip4 = (TYPEOF(le.Input_clean_address_zip4))'','',':clean_address_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_address_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cart = (TYPEOF(le.Input_clean_address_cart))'','',':clean_address_cart')
    #END
 
+    #IF( #TEXT(Input_clean_address_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_cr_sort_sz = (TYPEOF(le.Input_clean_address_cr_sort_sz))'','',':clean_address_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot = (TYPEOF(le.Input_clean_address_lot))'','',':clean_address_lot')
    #END
 
+    #IF( #TEXT(Input_clean_address_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_lot_order = (TYPEOF(le.Input_clean_address_lot_order))'','',':clean_address_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_address_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_dbpc = (TYPEOF(le.Input_clean_address_dbpc))'','',':clean_address_dbpc')
    #END
 
+    #IF( #TEXT(Input_clean_address_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_chk_digit = (TYPEOF(le.Input_clean_address_chk_digit))'','',':clean_address_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_address_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_rec_type = (TYPEOF(le.Input_clean_address_rec_type))'','',':clean_address_rec_type')
    #END
 
+    #IF( #TEXT(Input_clean_address_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_fips_state = (TYPEOF(le.Input_clean_address_fips_state))'','',':clean_address_fips_state')
    #END
 
+    #IF( #TEXT(Input_clean_address_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_fips_county = (TYPEOF(le.Input_clean_address_fips_county))'','',':clean_address_fips_county')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_lat = (TYPEOF(le.Input_clean_address_geo_lat))'','',':clean_address_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_long = (TYPEOF(le.Input_clean_address_geo_long))'','',':clean_address_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_address_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_msa = (TYPEOF(le.Input_clean_address_msa))'','',':clean_address_msa')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_blk = (TYPEOF(le.Input_clean_address_geo_blk))'','',':clean_address_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_address_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_geo_match = (TYPEOF(le.Input_clean_address_geo_match))'','',':clean_address_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_address_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_address_err_stat = (TYPEOF(le.Input_clean_address_err_stat))'','',':clean_address_err_stat')
    #END
 
+    #IF( #TEXT(Input_clean_phones_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_phone_number = (TYPEOF(le.Input_clean_phones_phone_number))'','',':clean_phones_phone_number')
    #END
 
+    #IF( #TEXT(Input_clean_phones_cell_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_cell_phone = (TYPEOF(le.Input_clean_phones_cell_phone))'','',':clean_phones_cell_phone')
    #END
 
+    #IF( #TEXT(Input_clean_phones_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_work_phone = (TYPEOF(le.Input_clean_phones_work_phone))'','',':clean_phones_work_phone')
    #END
 
+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
 
+    #IF( #TEXT(Input_uid)='' )
      '' 
    #ELSE
        IF( le.Input_uid = (TYPEOF(le.Input_uid))'','',':uid')
    #END
 
+    #IF( #TEXT(Input_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_id = (TYPEOF(le.Input_customer_id))'','',':customer_id')
    #END
 
+    #IF( #TEXT(Input_sub_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_customer_id = (TYPEOF(le.Input_sub_customer_id))'','',':sub_customer_id')
    #END
 
+    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (TYPEOF(le.Input_vendor_id))'','',':vendor_id')
    #END
 
+    #IF( #TEXT(Input_offender_key)='' )
      '' 
    #ELSE
        IF( le.Input_offender_key = (TYPEOF(le.Input_offender_key))'','',':offender_key')
    #END
 
+    #IF( #TEXT(Input_sub_sub_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_sub_customer_id = (TYPEOF(le.Input_sub_sub_customer_id))'','',':sub_sub_customer_id')
    #END
 
+    #IF( #TEXT(Input_customer_event_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_event_id = (TYPEOF(le.Input_customer_event_id))'','',':customer_event_id')
    #END
 
+    #IF( #TEXT(Input_sub_customer_event_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_customer_event_id = (TYPEOF(le.Input_sub_customer_event_id))'','',':sub_customer_event_id')
    #END
 
+    #IF( #TEXT(Input_sub_sub_customer_event_id)='' )
      '' 
    #ELSE
        IF( le.Input_sub_sub_customer_event_id = (TYPEOF(le.Input_sub_sub_customer_event_id))'','',':sub_sub_customer_event_id')
    #END
 
+    #IF( #TEXT(Input_ln_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_product_id = (TYPEOF(le.Input_ln_product_id))'','',':ln_product_id')
    #END
 
+    #IF( #TEXT(Input_ln_sub_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_sub_product_id = (TYPEOF(le.Input_ln_sub_product_id))'','',':ln_sub_product_id')
    #END
 
+    #IF( #TEXT(Input_ln_sub_sub_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_sub_sub_product_id = (TYPEOF(le.Input_ln_sub_sub_product_id))'','',':ln_sub_sub_product_id')
    #END
 
+    #IF( #TEXT(Input_ln_product_key)='' )
      '' 
    #ELSE
        IF( le.Input_ln_product_key = (TYPEOF(le.Input_ln_product_key))'','',':ln_product_key')
    #END
 
+    #IF( #TEXT(Input_ln_report_date)='' )
      '' 
    #ELSE
        IF( le.Input_ln_report_date = (TYPEOF(le.Input_ln_report_date))'','',':ln_report_date')
    #END
 
+    #IF( #TEXT(Input_ln_report_time)='' )
      '' 
    #ELSE
        IF( le.Input_ln_report_time = (TYPEOF(le.Input_ln_report_time))'','',':ln_report_time')
    #END
 
+    #IF( #TEXT(Input_reported_date)='' )
      '' 
    #ELSE
        IF( le.Input_reported_date = (TYPEOF(le.Input_reported_date))'','',':reported_date')
    #END
 
+    #IF( #TEXT(Input_reported_time)='' )
      '' 
    #ELSE
        IF( le.Input_reported_time = (TYPEOF(le.Input_reported_time))'','',':reported_time')
    #END
 
+    #IF( #TEXT(Input_event_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_date = (TYPEOF(le.Input_event_date))'','',':event_date')
    #END
 
+    #IF( #TEXT(Input_event_end_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_end_date = (TYPEOF(le.Input_event_end_date))'','',':event_end_date')
    #END
 
+    #IF( #TEXT(Input_event_location)='' )
      '' 
    #ELSE
        IF( le.Input_event_location = (TYPEOF(le.Input_event_location))'','',':event_location')
    #END
 
+    #IF( #TEXT(Input_event_type_1)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_1 = (TYPEOF(le.Input_event_type_1))'','',':event_type_1')
    #END
 
+    #IF( #TEXT(Input_event_type_2)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_2 = (TYPEOF(le.Input_event_type_2))'','',':event_type_2')
    #END
 
+    #IF( #TEXT(Input_event_type_3)='' )
      '' 
    #ELSE
        IF( le.Input_event_type_3 = (TYPEOF(le.Input_event_type_3))'','',':event_type_3')
    #END
 
+    #IF( #TEXT(Input_household_id)='' )
      '' 
    #ELSE
        IF( le.Input_household_id = (TYPEOF(le.Input_household_id))'','',':household_id')
    #END
 
+    #IF( #TEXT(Input_reason_description)='' )
      '' 
    #ELSE
        IF( le.Input_reason_description = (TYPEOF(le.Input_reason_description))'','',':reason_description')
    #END
 
+    #IF( #TEXT(Input_investigation_referral_case_id)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_referral_case_id = (TYPEOF(le.Input_investigation_referral_case_id))'','',':investigation_referral_case_id')
    #END
 
+    #IF( #TEXT(Input_investigation_referral_date_opened)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_referral_date_opened = (TYPEOF(le.Input_investigation_referral_date_opened))'','',':investigation_referral_date_opened')
    #END
 
+    #IF( #TEXT(Input_investigation_referral_date_closed)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_referral_date_closed = (TYPEOF(le.Input_investigation_referral_date_closed))'','',':investigation_referral_date_closed')
    #END
 
+    #IF( #TEXT(Input_customer_fraud_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_customer_fraud_code_1 = (TYPEOF(le.Input_customer_fraud_code_1))'','',':customer_fraud_code_1')
    #END
 
+    #IF( #TEXT(Input_customer_fraud_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_customer_fraud_code_2 = (TYPEOF(le.Input_customer_fraud_code_2))'','',':customer_fraud_code_2')
    #END
 
+    #IF( #TEXT(Input_type_of_referral)='' )
      '' 
    #ELSE
        IF( le.Input_type_of_referral = (TYPEOF(le.Input_type_of_referral))'','',':type_of_referral')
    #END
 
+    #IF( #TEXT(Input_referral_reason)='' )
      '' 
    #ELSE
        IF( le.Input_referral_reason = (TYPEOF(le.Input_referral_reason))'','',':referral_reason')
    #END
 
+    #IF( #TEXT(Input_disposition)='' )
      '' 
    #ELSE
        IF( le.Input_disposition = (TYPEOF(le.Input_disposition))'','',':disposition')
    #END
 
+    #IF( #TEXT(Input_mitigated)='' )
      '' 
    #ELSE
        IF( le.Input_mitigated = (TYPEOF(le.Input_mitigated))'','',':mitigated')
    #END
 
+    #IF( #TEXT(Input_mitigated_amount)='' )
      '' 
    #ELSE
        IF( le.Input_mitigated_amount = (TYPEOF(le.Input_mitigated_amount))'','',':mitigated_amount')
    #END
 
+    #IF( #TEXT(Input_external_referral_or_casenumber)='' )
      '' 
    #ELSE
        IF( le.Input_external_referral_or_casenumber = (TYPEOF(le.Input_external_referral_or_casenumber))'','',':external_referral_or_casenumber')
    #END
 
+    #IF( #TEXT(Input_fraud_point_score)='' )
      '' 
    #ELSE
        IF( le.Input_fraud_point_score = (TYPEOF(le.Input_fraud_point_score))'','',':fraud_point_score')
    #END
 
+    #IF( #TEXT(Input_customer_person_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_person_id = (TYPEOF(le.Input_customer_person_id))'','',':customer_person_id')
    #END
 
+    #IF( #TEXT(Input_raw_title)='' )
      '' 
    #ELSE
        IF( le.Input_raw_title = (TYPEOF(le.Input_raw_title))'','',':raw_title')
    #END
 
+    #IF( #TEXT(Input_raw_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_first_name = (TYPEOF(le.Input_raw_first_name))'','',':raw_first_name')
    #END
 
+    #IF( #TEXT(Input_raw_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_middle_name = (TYPEOF(le.Input_raw_middle_name))'','',':raw_middle_name')
    #END
 
+    #IF( #TEXT(Input_raw_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_last_name = (TYPEOF(le.Input_raw_last_name))'','',':raw_last_name')
    #END
 
+    #IF( #TEXT(Input_raw_orig_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_raw_orig_suffix = (TYPEOF(le.Input_raw_orig_suffix))'','',':raw_orig_suffix')
    #END
 
+    #IF( #TEXT(Input_raw_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_full_name = (TYPEOF(le.Input_raw_full_name))'','',':raw_full_name')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_drivers_license)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license = (TYPEOF(le.Input_drivers_license))'','',':drivers_license')
    #END
 
+    #IF( #TEXT(Input_drivers_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_state = (TYPEOF(le.Input_drivers_license_state))'','',':drivers_license_state')
    #END
 
+    #IF( #TEXT(Input_person_date)='' )
      '' 
    #ELSE
        IF( le.Input_person_date = (TYPEOF(le.Input_person_date))'','',':person_date')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
 
+    #IF( #TEXT(Input_income)='' )
      '' 
    #ELSE
        IF( le.Input_income = (TYPEOF(le.Input_income))'','',':income')
    #END
 
+    #IF( #TEXT(Input_own_or_rent)='' )
      '' 
    #ELSE
        IF( le.Input_own_or_rent = (TYPEOF(le.Input_own_or_rent))'','',':own_or_rent')
    #END
 
+    #IF( #TEXT(Input_rawlinkid)='' )
      '' 
    #ELSE
        IF( le.Input_rawlinkid = (TYPEOF(le.Input_rawlinkid))'','',':rawlinkid')
    #END
 
+    #IF( #TEXT(Input_street_1)='' )
      '' 
    #ELSE
        IF( le.Input_street_1 = (TYPEOF(le.Input_street_1))'','',':street_1')
    #END
 
+    #IF( #TEXT(Input_street_2)='' )
      '' 
    #ELSE
        IF( le.Input_street_2 = (TYPEOF(le.Input_street_2))'','',':street_2')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_gps_coordinates)='' )
      '' 
    #ELSE
        IF( le.Input_gps_coordinates = (TYPEOF(le.Input_gps_coordinates))'','',':gps_coordinates')
    #END
 
+    #IF( #TEXT(Input_address_date)='' )
      '' 
    #ELSE
        IF( le.Input_address_date = (TYPEOF(le.Input_address_date))'','',':address_date')
    #END
 
+    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
 
+    #IF( #TEXT(Input_appended_provider_id)='' )
      '' 
    #ELSE
        IF( le.Input_appended_provider_id = (TYPEOF(le.Input_appended_provider_id))'','',':appended_provider_id')
    #END
 
+    #IF( #TEXT(Input_lnpid)='' )
      '' 
    #ELSE
        IF( le.Input_lnpid = (TYPEOF(le.Input_lnpid))'','',':lnpid')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_tin)='' )
      '' 
    #ELSE
        IF( le.Input_tin = (TYPEOF(le.Input_tin))'','',':tin')
    #END
 
+    #IF( #TEXT(Input_fein)='' )
      '' 
    #ELSE
        IF( le.Input_fein = (TYPEOF(le.Input_fein))'','',':fein')
    #END
 
+    #IF( #TEXT(Input_npi)='' )
      '' 
    #ELSE
        IF( le.Input_npi = (TYPEOF(le.Input_npi))'','',':npi')
    #END
 
+    #IF( #TEXT(Input_business_type_1)='' )
      '' 
    #ELSE
        IF( le.Input_business_type_1 = (TYPEOF(le.Input_business_type_1))'','',':business_type_1')
    #END
 
+    #IF( #TEXT(Input_business_type_2)='' )
      '' 
    #ELSE
        IF( le.Input_business_type_2 = (TYPEOF(le.Input_business_type_2))'','',':business_type_2')
    #END
 
+    #IF( #TEXT(Input_business_date)='' )
      '' 
    #ELSE
        IF( le.Input_business_date = (TYPEOF(le.Input_business_date))'','',':business_date')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_cell_phone)='' )
      '' 
    #ELSE
        IF( le.Input_cell_phone = (TYPEOF(le.Input_cell_phone))'','',':cell_phone')
    #END
 
+    #IF( #TEXT(Input_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone = (TYPEOF(le.Input_work_phone))'','',':work_phone')
    #END
 
+    #IF( #TEXT(Input_contact_type)='' )
      '' 
    #ELSE
        IF( le.Input_contact_type = (TYPEOF(le.Input_contact_type))'','',':contact_type')
    #END
 
+    #IF( #TEXT(Input_contact_date)='' )
      '' 
    #ELSE
        IF( le.Input_contact_date = (TYPEOF(le.Input_contact_date))'','',':contact_date')
    #END
 
+    #IF( #TEXT(Input_carrier)='' )
      '' 
    #ELSE
        IF( le.Input_carrier = (TYPEOF(le.Input_carrier))'','',':carrier')
    #END
 
+    #IF( #TEXT(Input_contact_location)='' )
      '' 
    #ELSE
        IF( le.Input_contact_location = (TYPEOF(le.Input_contact_location))'','',':contact_location')
    #END
 
+    #IF( #TEXT(Input_contact)='' )
      '' 
    #ELSE
        IF( le.Input_contact = (TYPEOF(le.Input_contact))'','',':contact')
    #END
 
+    #IF( #TEXT(Input_call_records)='' )
      '' 
    #ELSE
        IF( le.Input_call_records = (TYPEOF(le.Input_call_records))'','',':call_records')
    #END
 
+    #IF( #TEXT(Input_in_service)='' )
      '' 
    #ELSE
        IF( le.Input_in_service = (TYPEOF(le.Input_in_service))'','',':in_service')
    #END
 
+    #IF( #TEXT(Input_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_email_address = (TYPEOF(le.Input_email_address))'','',':email_address')
    #END
 
+    #IF( #TEXT(Input_email_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_email_address_type = (TYPEOF(le.Input_email_address_type))'','',':email_address_type')
    #END
 
+    #IF( #TEXT(Input_email_date)='' )
      '' 
    #ELSE
        IF( le.Input_email_date = (TYPEOF(le.Input_email_date))'','',':email_date')
    #END
 
+    #IF( #TEXT(Input_host)='' )
      '' 
    #ELSE
        IF( le.Input_host = (TYPEOF(le.Input_host))'','',':host')
    #END
 
+    #IF( #TEXT(Input_alias)='' )
      '' 
    #ELSE
        IF( le.Input_alias = (TYPEOF(le.Input_alias))'','',':alias')
    #END
 
+    #IF( #TEXT(Input_location)='' )
      '' 
    #ELSE
        IF( le.Input_location = (TYPEOF(le.Input_location))'','',':location')
    #END
 
+    #IF( #TEXT(Input_ip_address)='' )
      '' 
    #ELSE
        IF( le.Input_ip_address = (TYPEOF(le.Input_ip_address))'','',':ip_address')
    #END
 
+    #IF( #TEXT(Input_ip_address_date)='' )
      '' 
    #ELSE
        IF( le.Input_ip_address_date = (TYPEOF(le.Input_ip_address_date))'','',':ip_address_date')
    #END
 
+    #IF( #TEXT(Input_version)='' )
      '' 
    #ELSE
        IF( le.Input_version = (TYPEOF(le.Input_version))'','',':version')
    #END
 
+    #IF( #TEXT(Input_class)='' )
      '' 
    #ELSE
        IF( le.Input_class = (TYPEOF(le.Input_class))'','',':class')
    #END
 
+    #IF( #TEXT(Input_subnet_mask)='' )
      '' 
    #ELSE
        IF( le.Input_subnet_mask = (TYPEOF(le.Input_subnet_mask))'','',':subnet_mask')
    #END
 
+    #IF( #TEXT(Input_reserved)='' )
      '' 
    #ELSE
        IF( le.Input_reserved = (TYPEOF(le.Input_reserved))'','',':reserved')
    #END
 
+    #IF( #TEXT(Input_isp)='' )
      '' 
    #ELSE
        IF( le.Input_isp = (TYPEOF(le.Input_isp))'','',':isp')
    #END
 
+    #IF( #TEXT(Input_device_id)='' )
      '' 
    #ELSE
        IF( le.Input_device_id = (TYPEOF(le.Input_device_id))'','',':device_id')
    #END
 
+    #IF( #TEXT(Input_device_date)='' )
      '' 
    #ELSE
        IF( le.Input_device_date = (TYPEOF(le.Input_device_date))'','',':device_date')
    #END
 
+    #IF( #TEXT(Input_unique_number)='' )
      '' 
    #ELSE
        IF( le.Input_unique_number = (TYPEOF(le.Input_unique_number))'','',':unique_number')
    #END
 
+    #IF( #TEXT(Input_mac_address)='' )
      '' 
    #ELSE
        IF( le.Input_mac_address = (TYPEOF(le.Input_mac_address))'','',':mac_address')
    #END
 
+    #IF( #TEXT(Input_serial_number)='' )
      '' 
    #ELSE
        IF( le.Input_serial_number = (TYPEOF(le.Input_serial_number))'','',':serial_number')
    #END
 
+    #IF( #TEXT(Input_device_type)='' )
      '' 
    #ELSE
        IF( le.Input_device_type = (TYPEOF(le.Input_device_type))'','',':device_type')
    #END
 
+    #IF( #TEXT(Input_device_identification_provider)='' )
      '' 
    #ELSE
        IF( le.Input_device_identification_provider = (TYPEOF(le.Input_device_identification_provider))'','',':device_identification_provider')
    #END
 
+    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_transaction_type)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_type = (TYPEOF(le.Input_transaction_type))'','',':transaction_type')
    #END
 
+    #IF( #TEXT(Input_amount_of_loss)='' )
      '' 
    #ELSE
        IF( le.Input_amount_of_loss = (TYPEOF(le.Input_amount_of_loss))'','',':amount_of_loss')
    #END
 
+    #IF( #TEXT(Input_professional_id)='' )
      '' 
    #ELSE
        IF( le.Input_professional_id = (TYPEOF(le.Input_professional_id))'','',':professional_id')
    #END
 
+    #IF( #TEXT(Input_profession_type)='' )
      '' 
    #ELSE
        IF( le.Input_profession_type = (TYPEOF(le.Input_profession_type))'','',':profession_type')
    #END
 
+    #IF( #TEXT(Input_corresponding_professional_ids)='' )
      '' 
    #ELSE
        IF( le.Input_corresponding_professional_ids = (TYPEOF(le.Input_corresponding_professional_ids))'','',':corresponding_professional_ids')
    #END
 
+    #IF( #TEXT(Input_licensed_pr_state)='' )
      '' 
    #ELSE
        IF( le.Input_licensed_pr_state = (TYPEOF(le.Input_licensed_pr_state))'','',':licensed_pr_state')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
 
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
 
+    #IF( #TEXT(Input_name_ind)='' )
      '' 
    #ELSE
        IF( le.Input_name_ind = (TYPEOF(le.Input_name_ind))'','',':name_ind')
    #END
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_aceaid = (TYPEOF(le.Input_aceaid))'','',':aceaid')
    #END
 
+    #IF( #TEXT(Input_address_ind)='' )
      '' 
    #ELSE
        IF( le.Input_address_ind = (TYPEOF(le.Input_address_ind))'','',':address_ind')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_clean_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_business_name = (TYPEOF(le.Input_clean_business_name))'','',':clean_business_name')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input___internal_fpos__)='' )
      '' 
    #ELSE
        IF( le.Input___internal_fpos__ = (TYPEOF(le.Input___internal_fpos__))'','',':__internal_fpos__')
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
