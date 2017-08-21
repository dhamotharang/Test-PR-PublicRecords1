IMPORT ut,SALT34, cramos;
EXPORT hygiene(dataset(cramos.layout_fdn_keys_main_qa) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_classification_source_source_type_pcnt := AVE(GROUP,IF(h.classification_source_source_type = (TYPEOF(h.classification_source_source_type))'',0,100));
    maxlength_classification_source_source_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_source_type)));
    avelength_classification_source_source_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_source_type)),h.classification_source_source_type<>(typeof(h.classification_source_source_type))'');
    populated_classification_source_primary_source_entity_pcnt := AVE(GROUP,IF(h.classification_source_primary_source_entity = (TYPEOF(h.classification_source_primary_source_entity))'',0,100));
    maxlength_classification_source_primary_source_entity := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_primary_source_entity)));
    avelength_classification_source_primary_source_entity := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_primary_source_entity)),h.classification_source_primary_source_entity<>(typeof(h.classification_source_primary_source_entity))'');
    populated_classification_source_expectation_of_victim_entities_pcnt := AVE(GROUP,IF(h.classification_source_expectation_of_victim_entities = (TYPEOF(h.classification_source_expectation_of_victim_entities))'',0,100));
    maxlength_classification_source_expectation_of_victim_entities := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_expectation_of_victim_entities)));
    avelength_classification_source_expectation_of_victim_entities := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_expectation_of_victim_entities)),h.classification_source_expectation_of_victim_entities<>(typeof(h.classification_source_expectation_of_victim_entities))'');
    populated_classification_source_industry_segment_pcnt := AVE(GROUP,IF(h.classification_source_industry_segment = (TYPEOF(h.classification_source_industry_segment))'',0,100));
    maxlength_classification_source_industry_segment := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_industry_segment)));
    avelength_classification_source_industry_segment := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_source_industry_segment)),h.classification_source_industry_segment<>(typeof(h.classification_source_industry_segment))'');
    populated_classification_activity_suspected_discrepancy_pcnt := AVE(GROUP,IF(h.classification_activity_suspected_discrepancy = (TYPEOF(h.classification_activity_suspected_discrepancy))'',0,100));
    maxlength_classification_activity_suspected_discrepancy := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_suspected_discrepancy)));
    avelength_classification_activity_suspected_discrepancy := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_suspected_discrepancy)),h.classification_activity_suspected_discrepancy<>(typeof(h.classification_activity_suspected_discrepancy))'');
    populated_classification_activity_confidence_that_activity_was_deceitful_pcnt := AVE(GROUP,IF(h.classification_activity_confidence_that_activity_was_deceitful = (TYPEOF(h.classification_activity_confidence_that_activity_was_deceitful))'',0,100));
    maxlength_classification_activity_confidence_that_activity_was_deceitful := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_confidence_that_activity_was_deceitful)));
    avelength_classification_activity_confidence_that_activity_was_deceitful := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_confidence_that_activity_was_deceitful)),h.classification_activity_confidence_that_activity_was_deceitful<>(typeof(h.classification_activity_confidence_that_activity_was_deceitful))'');
    populated_classification_activity_workflow_stage_committed_pcnt := AVE(GROUP,IF(h.classification_activity_workflow_stage_committed = (TYPEOF(h.classification_activity_workflow_stage_committed))'',0,100));
    maxlength_classification_activity_workflow_stage_committed := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_workflow_stage_committed)));
    avelength_classification_activity_workflow_stage_committed := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_workflow_stage_committed)),h.classification_activity_workflow_stage_committed<>(typeof(h.classification_activity_workflow_stage_committed))'');
    populated_classification_activity_workflow_stage_detected_pcnt := AVE(GROUP,IF(h.classification_activity_workflow_stage_detected = (TYPEOF(h.classification_activity_workflow_stage_detected))'',0,100));
    maxlength_classification_activity_workflow_stage_detected := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_workflow_stage_detected)));
    avelength_classification_activity_workflow_stage_detected := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_workflow_stage_detected)),h.classification_activity_workflow_stage_detected<>(typeof(h.classification_activity_workflow_stage_detected))'');
    populated_classification_activity_channels_pcnt := AVE(GROUP,IF(h.classification_activity_channels = (TYPEOF(h.classification_activity_channels))'',0,100));
    maxlength_classification_activity_channels := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_channels)));
    avelength_classification_activity_channels := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_channels)),h.classification_activity_channels<>(typeof(h.classification_activity_channels))'');
    populated_classification_activity_category_or_fraudtype_pcnt := AVE(GROUP,IF(h.classification_activity_category_or_fraudtype = (TYPEOF(h.classification_activity_category_or_fraudtype))'',0,100));
    maxlength_classification_activity_category_or_fraudtype := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_category_or_fraudtype)));
    avelength_classification_activity_category_or_fraudtype := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_category_or_fraudtype)),h.classification_activity_category_or_fraudtype<>(typeof(h.classification_activity_category_or_fraudtype))'');
    populated_classification_activity_description_pcnt := AVE(GROUP,IF(h.classification_activity_description = (TYPEOF(h.classification_activity_description))'',0,100));
    maxlength_classification_activity_description := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_description)));
    avelength_classification_activity_description := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_description)),h.classification_activity_description<>(typeof(h.classification_activity_description))'');
    populated_classification_activity_threat_pcnt := AVE(GROUP,IF(h.classification_activity_threat = (TYPEOF(h.classification_activity_threat))'',0,100));
    maxlength_classification_activity_threat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_threat)));
    avelength_classification_activity_threat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_threat)),h.classification_activity_threat<>(typeof(h.classification_activity_threat))'');
    populated_classification_activity_exposure_pcnt := AVE(GROUP,IF(h.classification_activity_exposure = (TYPEOF(h.classification_activity_exposure))'',0,100));
    maxlength_classification_activity_exposure := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_exposure)));
    avelength_classification_activity_exposure := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_exposure)),h.classification_activity_exposure<>(typeof(h.classification_activity_exposure))'');
    populated_classification_activity_write_off_loss_pcnt := AVE(GROUP,IF(h.classification_activity_write_off_loss = (TYPEOF(h.classification_activity_write_off_loss))'',0,100));
    maxlength_classification_activity_write_off_loss := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_write_off_loss)));
    avelength_classification_activity_write_off_loss := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_write_off_loss)),h.classification_activity_write_off_loss<>(typeof(h.classification_activity_write_off_loss))'');
    populated_classification_activity_mitigated_pcnt := AVE(GROUP,IF(h.classification_activity_mitigated = (TYPEOF(h.classification_activity_mitigated))'',0,100));
    maxlength_classification_activity_mitigated := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_mitigated)));
    avelength_classification_activity_mitigated := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_mitigated)),h.classification_activity_mitigated<>(typeof(h.classification_activity_mitigated))'');
    populated_classification_activity_alert_level_pcnt := AVE(GROUP,IF(h.classification_activity_alert_level = (TYPEOF(h.classification_activity_alert_level))'',0,100));
    maxlength_classification_activity_alert_level := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_alert_level)));
    avelength_classification_activity_alert_level := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_activity_alert_level)),h.classification_activity_alert_level<>(typeof(h.classification_activity_alert_level))'');
    populated_classification_entity_entity_type_pcnt := AVE(GROUP,IF(h.classification_entity_entity_type = (TYPEOF(h.classification_entity_entity_type))'',0,100));
    maxlength_classification_entity_entity_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_entity_type)));
    avelength_classification_entity_entity_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_entity_type)),h.classification_entity_entity_type<>(typeof(h.classification_entity_entity_type))'');
    populated_classification_entity_entity_sub_type_pcnt := AVE(GROUP,IF(h.classification_entity_entity_sub_type = (TYPEOF(h.classification_entity_entity_sub_type))'',0,100));
    maxlength_classification_entity_entity_sub_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_entity_sub_type)));
    avelength_classification_entity_entity_sub_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_entity_sub_type)),h.classification_entity_entity_sub_type<>(typeof(h.classification_entity_entity_sub_type))'');
    populated_classification_entity_role_pcnt := AVE(GROUP,IF(h.classification_entity_role = (TYPEOF(h.classification_entity_role))'',0,100));
    maxlength_classification_entity_role := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_role)));
    avelength_classification_entity_role := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_role)),h.classification_entity_role<>(typeof(h.classification_entity_role))'');
    populated_classification_entity_evidence_pcnt := AVE(GROUP,IF(h.classification_entity_evidence = (TYPEOF(h.classification_entity_evidence))'',0,100));
    maxlength_classification_entity_evidence := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_evidence)));
    avelength_classification_entity_evidence := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_evidence)),h.classification_entity_evidence<>(typeof(h.classification_entity_evidence))'');
    populated_classification_entity_investigated_count_pcnt := AVE(GROUP,IF(h.classification_entity_investigated_count = (TYPEOF(h.classification_entity_investigated_count))'',0,100));
    maxlength_classification_entity_investigated_count := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_investigated_count)));
    avelength_classification_entity_investigated_count := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_entity_investigated_count)),h.classification_entity_investigated_count<>(typeof(h.classification_entity_investigated_count))'');
    populated_classification_permissible_use_access_fdn_file_info_id_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_fdn_file_info_id = (TYPEOF(h.classification_permissible_use_access_fdn_file_info_id))'',0,100));
    maxlength_classification_permissible_use_access_fdn_file_info_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_fdn_file_info_id)));
    avelength_classification_permissible_use_access_fdn_file_info_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_fdn_file_info_id)),h.classification_permissible_use_access_fdn_file_info_id<>(typeof(h.classification_permissible_use_access_fdn_file_info_id))'');
    populated_classification_permissible_use_access_fdn_file_code_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_fdn_file_code = (TYPEOF(h.classification_permissible_use_access_fdn_file_code))'',0,100));
    maxlength_classification_permissible_use_access_fdn_file_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_fdn_file_code)));
    avelength_classification_permissible_use_access_fdn_file_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_fdn_file_code)),h.classification_permissible_use_access_fdn_file_code<>(typeof(h.classification_permissible_use_access_fdn_file_code))'');
    populated_classification_permissible_use_access_gc_id_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_gc_id = (TYPEOF(h.classification_permissible_use_access_gc_id))'',0,100));
    maxlength_classification_permissible_use_access_gc_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_gc_id)));
    avelength_classification_permissible_use_access_gc_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_gc_id)),h.classification_permissible_use_access_gc_id<>(typeof(h.classification_permissible_use_access_gc_id))'');
    populated_classification_permissible_use_access_file_type_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_file_type = (TYPEOF(h.classification_permissible_use_access_file_type))'',0,100));
    maxlength_classification_permissible_use_access_file_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_file_type)));
    avelength_classification_permissible_use_access_file_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_file_type)),h.classification_permissible_use_access_file_type<>(typeof(h.classification_permissible_use_access_file_type))'');
    populated_classification_permissible_use_access_description_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_description = (TYPEOF(h.classification_permissible_use_access_description))'',0,100));
    maxlength_classification_permissible_use_access_description := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_description)));
    avelength_classification_permissible_use_access_description := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_description)),h.classification_permissible_use_access_description<>(typeof(h.classification_permissible_use_access_description))'');
    populated_classification_permissible_use_access_primary_source_entity_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_primary_source_entity = (TYPEOF(h.classification_permissible_use_access_primary_source_entity))'',0,100));
    maxlength_classification_permissible_use_access_primary_source_entity := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_primary_source_entity)));
    avelength_classification_permissible_use_access_primary_source_entity := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_primary_source_entity)),h.classification_permissible_use_access_primary_source_entity<>(typeof(h.classification_permissible_use_access_primary_source_entity))'');
    populated_classification_permissible_use_access_ind_type_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_ind_type = (TYPEOF(h.classification_permissible_use_access_ind_type))'',0,100));
    maxlength_classification_permissible_use_access_ind_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_ind_type)));
    avelength_classification_permissible_use_access_ind_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_ind_type)),h.classification_permissible_use_access_ind_type<>(typeof(h.classification_permissible_use_access_ind_type))'');
    populated_classification_permissible_use_access_ind_type_description_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_ind_type_description = (TYPEOF(h.classification_permissible_use_access_ind_type_description))'',0,100));
    maxlength_classification_permissible_use_access_ind_type_description := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_ind_type_description)));
    avelength_classification_permissible_use_access_ind_type_description := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_ind_type_description)),h.classification_permissible_use_access_ind_type_description<>(typeof(h.classification_permissible_use_access_ind_type_description))'');
    populated_classification_permissible_use_access_update_freq_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_update_freq = (TYPEOF(h.classification_permissible_use_access_update_freq))'',0,100));
    maxlength_classification_permissible_use_access_update_freq := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_update_freq)));
    avelength_classification_permissible_use_access_update_freq := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_update_freq)),h.classification_permissible_use_access_update_freq<>(typeof(h.classification_permissible_use_access_update_freq))'');
    populated_classification_permissible_use_access_expiration_days_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_expiration_days = (TYPEOF(h.classification_permissible_use_access_expiration_days))'',0,100));
    maxlength_classification_permissible_use_access_expiration_days := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_expiration_days)));
    avelength_classification_permissible_use_access_expiration_days := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_expiration_days)),h.classification_permissible_use_access_expiration_days<>(typeof(h.classification_permissible_use_access_expiration_days))'');
    populated_classification_permissible_use_access_post_contract_expiration_days_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_post_contract_expiration_days = (TYPEOF(h.classification_permissible_use_access_post_contract_expiration_days))'',0,100));
    maxlength_classification_permissible_use_access_post_contract_expiration_days := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_post_contract_expiration_days)));
    avelength_classification_permissible_use_access_post_contract_expiration_days := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_post_contract_expiration_days)),h.classification_permissible_use_access_post_contract_expiration_days<>(typeof(h.classification_permissible_use_access_post_contract_expiration_days))'');
    populated_classification_permissible_use_access_status_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_status = (TYPEOF(h.classification_permissible_use_access_status))'',0,100));
    maxlength_classification_permissible_use_access_status := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_status)));
    avelength_classification_permissible_use_access_status := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_status)),h.classification_permissible_use_access_status<>(typeof(h.classification_permissible_use_access_status))'');
    populated_classification_permissible_use_access_product_include_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_product_include = (TYPEOF(h.classification_permissible_use_access_product_include))'',0,100));
    maxlength_classification_permissible_use_access_product_include := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_product_include)));
    avelength_classification_permissible_use_access_product_include := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_product_include)),h.classification_permissible_use_access_product_include<>(typeof(h.classification_permissible_use_access_product_include))'');
    populated_classification_permissible_use_access_date_added_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_date_added = (TYPEOF(h.classification_permissible_use_access_date_added))'',0,100));
    maxlength_classification_permissible_use_access_date_added := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_date_added)));
    avelength_classification_permissible_use_access_date_added := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_date_added)),h.classification_permissible_use_access_date_added<>(typeof(h.classification_permissible_use_access_date_added))'');
    populated_classification_permissible_use_access_user_added_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_user_added = (TYPEOF(h.classification_permissible_use_access_user_added))'',0,100));
    maxlength_classification_permissible_use_access_user_added := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_user_added)));
    avelength_classification_permissible_use_access_user_added := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_user_added)),h.classification_permissible_use_access_user_added<>(typeof(h.classification_permissible_use_access_user_added))'');
    populated_classification_permissible_use_access_date_changed_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_date_changed = (TYPEOF(h.classification_permissible_use_access_date_changed))'',0,100));
    maxlength_classification_permissible_use_access_date_changed := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_date_changed)));
    avelength_classification_permissible_use_access_date_changed := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_date_changed)),h.classification_permissible_use_access_date_changed<>(typeof(h.classification_permissible_use_access_date_changed))'');
    populated_classification_permissible_use_access_user_changed_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_user_changed = (TYPEOF(h.classification_permissible_use_access_user_changed))'',0,100));
    maxlength_classification_permissible_use_access_user_changed := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_user_changed)));
    avelength_classification_permissible_use_access_user_changed := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_user_changed)),h.classification_permissible_use_access_user_changed<>(typeof(h.classification_permissible_use_access_user_changed))'');
    populated_classification_permissible_use_access_p_industry_segment_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_p_industry_segment = (TYPEOF(h.classification_permissible_use_access_p_industry_segment))'',0,100));
    maxlength_classification_permissible_use_access_p_industry_segment := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_p_industry_segment)));
    avelength_classification_permissible_use_access_p_industry_segment := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_p_industry_segment)),h.classification_permissible_use_access_p_industry_segment<>(typeof(h.classification_permissible_use_access_p_industry_segment))'');
    populated_classification_permissible_use_access_usage_term_pcnt := AVE(GROUP,IF(h.classification_permissible_use_access_usage_term = (TYPEOF(h.classification_permissible_use_access_usage_term))'',0,100));
    maxlength_classification_permissible_use_access_usage_term := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_usage_term)));
    avelength_classification_permissible_use_access_usage_term := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.classification_permissible_use_access_usage_term)),h.classification_permissible_use_access_usage_term<>(typeof(h.classification_permissible_use_access_usage_term))'');
    populated_cleaned_name_title_pcnt := AVE(GROUP,IF(h.cleaned_name_title = (TYPEOF(h.cleaned_name_title))'',0,100));
    maxlength_cleaned_name_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_title)));
    avelength_cleaned_name_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_title)),h.cleaned_name_title<>(typeof(h.cleaned_name_title))'');
    populated_cleaned_name_fname_pcnt := AVE(GROUP,IF(h.cleaned_name_fname = (TYPEOF(h.cleaned_name_fname))'',0,100));
    maxlength_cleaned_name_fname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_fname)));
    avelength_cleaned_name_fname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_fname)),h.cleaned_name_fname<>(typeof(h.cleaned_name_fname))'');
    populated_cleaned_name_mname_pcnt := AVE(GROUP,IF(h.cleaned_name_mname = (TYPEOF(h.cleaned_name_mname))'',0,100));
    maxlength_cleaned_name_mname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_mname)));
    avelength_cleaned_name_mname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_mname)),h.cleaned_name_mname<>(typeof(h.cleaned_name_mname))'');
    populated_cleaned_name_lname_pcnt := AVE(GROUP,IF(h.cleaned_name_lname = (TYPEOF(h.cleaned_name_lname))'',0,100));
    maxlength_cleaned_name_lname := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_lname)));
    avelength_cleaned_name_lname := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_lname)),h.cleaned_name_lname<>(typeof(h.cleaned_name_lname))'');
    populated_cleaned_name_name_suffix_pcnt := AVE(GROUP,IF(h.cleaned_name_name_suffix = (TYPEOF(h.cleaned_name_name_suffix))'',0,100));
    maxlength_cleaned_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_name_suffix)));
    avelength_cleaned_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_name_suffix)),h.cleaned_name_name_suffix<>(typeof(h.cleaned_name_name_suffix))'');
    populated_cleaned_name_name_score_pcnt := AVE(GROUP,IF(h.cleaned_name_name_score = (TYPEOF(h.cleaned_name_name_score))'',0,100));
    maxlength_cleaned_name_name_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_name_score)));
    avelength_cleaned_name_name_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cleaned_name_name_score)),h.cleaned_name_name_score<>(typeof(h.cleaned_name_name_score))'');
    populated_clean_address_prim_range_pcnt := AVE(GROUP,IF(h.clean_address_prim_range = (TYPEOF(h.clean_address_prim_range))'',0,100));
    maxlength_clean_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_prim_range)));
    avelength_clean_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_prim_range)),h.clean_address_prim_range<>(typeof(h.clean_address_prim_range))'');
    populated_clean_address_predir_pcnt := AVE(GROUP,IF(h.clean_address_predir = (TYPEOF(h.clean_address_predir))'',0,100));
    maxlength_clean_address_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_predir)));
    avelength_clean_address_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_predir)),h.clean_address_predir<>(typeof(h.clean_address_predir))'');
    populated_clean_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_address_prim_name = (TYPEOF(h.clean_address_prim_name))'',0,100));
    maxlength_clean_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_prim_name)));
    avelength_clean_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_prim_name)),h.clean_address_prim_name<>(typeof(h.clean_address_prim_name))'');
    populated_clean_address_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_address_addr_suffix = (TYPEOF(h.clean_address_addr_suffix))'',0,100));
    maxlength_clean_address_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_addr_suffix)));
    avelength_clean_address_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_addr_suffix)),h.clean_address_addr_suffix<>(typeof(h.clean_address_addr_suffix))'');
    populated_clean_address_postdir_pcnt := AVE(GROUP,IF(h.clean_address_postdir = (TYPEOF(h.clean_address_postdir))'',0,100));
    maxlength_clean_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_postdir)));
    avelength_clean_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_postdir)),h.clean_address_postdir<>(typeof(h.clean_address_postdir))'');
    populated_clean_address_unit_desig_pcnt := AVE(GROUP,IF(h.clean_address_unit_desig = (TYPEOF(h.clean_address_unit_desig))'',0,100));
    maxlength_clean_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_unit_desig)));
    avelength_clean_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_unit_desig)),h.clean_address_unit_desig<>(typeof(h.clean_address_unit_desig))'');
    populated_clean_address_sec_range_pcnt := AVE(GROUP,IF(h.clean_address_sec_range = (TYPEOF(h.clean_address_sec_range))'',0,100));
    maxlength_clean_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_sec_range)));
    avelength_clean_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_sec_range)),h.clean_address_sec_range<>(typeof(h.clean_address_sec_range))'');
    populated_clean_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_address_p_city_name = (TYPEOF(h.clean_address_p_city_name))'',0,100));
    maxlength_clean_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_p_city_name)));
    avelength_clean_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_p_city_name)),h.clean_address_p_city_name<>(typeof(h.clean_address_p_city_name))'');
    populated_clean_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_address_v_city_name = (TYPEOF(h.clean_address_v_city_name))'',0,100));
    maxlength_clean_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_v_city_name)));
    avelength_clean_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_v_city_name)),h.clean_address_v_city_name<>(typeof(h.clean_address_v_city_name))'');
    populated_clean_address_st_pcnt := AVE(GROUP,IF(h.clean_address_st = (TYPEOF(h.clean_address_st))'',0,100));
    maxlength_clean_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_st)));
    avelength_clean_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_st)),h.clean_address_st<>(typeof(h.clean_address_st))'');
    populated_clean_address_zip_pcnt := AVE(GROUP,IF(h.clean_address_zip = (TYPEOF(h.clean_address_zip))'',0,100));
    maxlength_clean_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_zip)));
    avelength_clean_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_zip)),h.clean_address_zip<>(typeof(h.clean_address_zip))'');
    populated_clean_address_zip4_pcnt := AVE(GROUP,IF(h.clean_address_zip4 = (TYPEOF(h.clean_address_zip4))'',0,100));
    maxlength_clean_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_zip4)));
    avelength_clean_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_zip4)),h.clean_address_zip4<>(typeof(h.clean_address_zip4))'');
    populated_clean_address_cart_pcnt := AVE(GROUP,IF(h.clean_address_cart = (TYPEOF(h.clean_address_cart))'',0,100));
    maxlength_clean_address_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_cart)));
    avelength_clean_address_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_cart)),h.clean_address_cart<>(typeof(h.clean_address_cart))'');
    populated_clean_address_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_address_cr_sort_sz = (TYPEOF(h.clean_address_cr_sort_sz))'',0,100));
    maxlength_clean_address_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_cr_sort_sz)));
    avelength_clean_address_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_cr_sort_sz)),h.clean_address_cr_sort_sz<>(typeof(h.clean_address_cr_sort_sz))'');
    populated_clean_address_lot_pcnt := AVE(GROUP,IF(h.clean_address_lot = (TYPEOF(h.clean_address_lot))'',0,100));
    maxlength_clean_address_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_lot)));
    avelength_clean_address_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_lot)),h.clean_address_lot<>(typeof(h.clean_address_lot))'');
    populated_clean_address_lot_order_pcnt := AVE(GROUP,IF(h.clean_address_lot_order = (TYPEOF(h.clean_address_lot_order))'',0,100));
    maxlength_clean_address_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_lot_order)));
    avelength_clean_address_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_lot_order)),h.clean_address_lot_order<>(typeof(h.clean_address_lot_order))'');
    populated_clean_address_dbpc_pcnt := AVE(GROUP,IF(h.clean_address_dbpc = (TYPEOF(h.clean_address_dbpc))'',0,100));
    maxlength_clean_address_dbpc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_dbpc)));
    avelength_clean_address_dbpc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_dbpc)),h.clean_address_dbpc<>(typeof(h.clean_address_dbpc))'');
    populated_clean_address_chk_digit_pcnt := AVE(GROUP,IF(h.clean_address_chk_digit = (TYPEOF(h.clean_address_chk_digit))'',0,100));
    maxlength_clean_address_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_chk_digit)));
    avelength_clean_address_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_chk_digit)),h.clean_address_chk_digit<>(typeof(h.clean_address_chk_digit))'');
    populated_clean_address_rec_type_pcnt := AVE(GROUP,IF(h.clean_address_rec_type = (TYPEOF(h.clean_address_rec_type))'',0,100));
    maxlength_clean_address_rec_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_rec_type)));
    avelength_clean_address_rec_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_rec_type)),h.clean_address_rec_type<>(typeof(h.clean_address_rec_type))'');
    populated_clean_address_fips_state_pcnt := AVE(GROUP,IF(h.clean_address_fips_state = (TYPEOF(h.clean_address_fips_state))'',0,100));
    maxlength_clean_address_fips_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_fips_state)));
    avelength_clean_address_fips_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_fips_state)),h.clean_address_fips_state<>(typeof(h.clean_address_fips_state))'');
    populated_clean_address_fips_county_pcnt := AVE(GROUP,IF(h.clean_address_fips_county = (TYPEOF(h.clean_address_fips_county))'',0,100));
    maxlength_clean_address_fips_county := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_fips_county)));
    avelength_clean_address_fips_county := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_fips_county)),h.clean_address_fips_county<>(typeof(h.clean_address_fips_county))'');
    populated_clean_address_geo_lat_pcnt := AVE(GROUP,IF(h.clean_address_geo_lat = (TYPEOF(h.clean_address_geo_lat))'',0,100));
    maxlength_clean_address_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_lat)));
    avelength_clean_address_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_lat)),h.clean_address_geo_lat<>(typeof(h.clean_address_geo_lat))'');
    populated_clean_address_geo_long_pcnt := AVE(GROUP,IF(h.clean_address_geo_long = (TYPEOF(h.clean_address_geo_long))'',0,100));
    maxlength_clean_address_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_long)));
    avelength_clean_address_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_long)),h.clean_address_geo_long<>(typeof(h.clean_address_geo_long))'');
    populated_clean_address_msa_pcnt := AVE(GROUP,IF(h.clean_address_msa = (TYPEOF(h.clean_address_msa))'',0,100));
    maxlength_clean_address_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_msa)));
    avelength_clean_address_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_msa)),h.clean_address_msa<>(typeof(h.clean_address_msa))'');
    populated_clean_address_geo_blk_pcnt := AVE(GROUP,IF(h.clean_address_geo_blk = (TYPEOF(h.clean_address_geo_blk))'',0,100));
    maxlength_clean_address_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_blk)));
    avelength_clean_address_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_blk)),h.clean_address_geo_blk<>(typeof(h.clean_address_geo_blk))'');
    populated_clean_address_geo_match_pcnt := AVE(GROUP,IF(h.clean_address_geo_match = (TYPEOF(h.clean_address_geo_match))'',0,100));
    maxlength_clean_address_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_match)));
    avelength_clean_address_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_geo_match)),h.clean_address_geo_match<>(typeof(h.clean_address_geo_match))'');
    populated_clean_address_err_stat_pcnt := AVE(GROUP,IF(h.clean_address_err_stat = (TYPEOF(h.clean_address_err_stat))'',0,100));
    maxlength_clean_address_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_err_stat)));
    avelength_clean_address_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_address_err_stat)),h.clean_address_err_stat<>(typeof(h.clean_address_err_stat))'');
    populated_clean_phones_phone_number_pcnt := AVE(GROUP,IF(h.clean_phones_phone_number = (TYPEOF(h.clean_phones_phone_number))'',0,100));
    maxlength_clean_phones_phone_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone_number)));
    avelength_clean_phones_phone_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone_number)),h.clean_phones_phone_number<>(typeof(h.clean_phones_phone_number))'');
    populated_clean_phones_cell_phone_pcnt := AVE(GROUP,IF(h.clean_phones_cell_phone = (TYPEOF(h.clean_phones_cell_phone))'',0,100));
    maxlength_clean_phones_cell_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_cell_phone)));
    avelength_clean_phones_cell_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_cell_phone)),h.clean_phones_cell_phone<>(typeof(h.clean_phones_cell_phone))'');
    populated_clean_phones_work_phone_pcnt := AVE(GROUP,IF(h.clean_phones_work_phone = (TYPEOF(h.clean_phones_work_phone))'',0,100));
    maxlength_clean_phones_work_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_work_phone)));
    avelength_clean_phones_work_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_work_phone)),h.clean_phones_work_phone<>(typeof(h.clean_phones_work_phone))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_uid_pcnt := AVE(GROUP,IF(h.uid = (TYPEOF(h.uid))'',0,100));
    maxlength_uid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.uid)));
    avelength_uid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.uid)),h.uid<>(typeof(h.uid))'');
    populated_customer_id_pcnt := AVE(GROUP,IF(h.customer_id = (TYPEOF(h.customer_id))'',0,100));
    maxlength_customer_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_id)));
    avelength_customer_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_id)),h.customer_id<>(typeof(h.customer_id))'');
    populated_sub_customer_id_pcnt := AVE(GROUP,IF(h.sub_customer_id = (TYPEOF(h.sub_customer_id))'',0,100));
    maxlength_sub_customer_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_customer_id)));
    avelength_sub_customer_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_customer_id)),h.sub_customer_id<>(typeof(h.sub_customer_id))'');
    populated_vendor_id_pcnt := AVE(GROUP,IF(h.vendor_id = (TYPEOF(h.vendor_id))'',0,100));
    maxlength_vendor_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.vendor_id)));
    avelength_vendor_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.vendor_id)),h.vendor_id<>(typeof(h.vendor_id))'');
    populated_offender_key_pcnt := AVE(GROUP,IF(h.offender_key = (TYPEOF(h.offender_key))'',0,100));
    maxlength_offender_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.offender_key)));
    avelength_offender_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.offender_key)),h.offender_key<>(typeof(h.offender_key))'');
    populated_sub_sub_customer_id_pcnt := AVE(GROUP,IF(h.sub_sub_customer_id = (TYPEOF(h.sub_sub_customer_id))'',0,100));
    maxlength_sub_sub_customer_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_sub_customer_id)));
    avelength_sub_sub_customer_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_sub_customer_id)),h.sub_sub_customer_id<>(typeof(h.sub_sub_customer_id))'');
    populated_customer_event_id_pcnt := AVE(GROUP,IF(h.customer_event_id = (TYPEOF(h.customer_event_id))'',0,100));
    maxlength_customer_event_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_event_id)));
    avelength_customer_event_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_event_id)),h.customer_event_id<>(typeof(h.customer_event_id))'');
    populated_sub_customer_event_id_pcnt := AVE(GROUP,IF(h.sub_customer_event_id = (TYPEOF(h.sub_customer_event_id))'',0,100));
    maxlength_sub_customer_event_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_customer_event_id)));
    avelength_sub_customer_event_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_customer_event_id)),h.sub_customer_event_id<>(typeof(h.sub_customer_event_id))'');
    populated_sub_sub_customer_event_id_pcnt := AVE(GROUP,IF(h.sub_sub_customer_event_id = (TYPEOF(h.sub_sub_customer_event_id))'',0,100));
    maxlength_sub_sub_customer_event_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_sub_customer_event_id)));
    avelength_sub_sub_customer_event_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sub_sub_customer_event_id)),h.sub_sub_customer_event_id<>(typeof(h.sub_sub_customer_event_id))'');
    populated_ln_product_id_pcnt := AVE(GROUP,IF(h.ln_product_id = (TYPEOF(h.ln_product_id))'',0,100));
    maxlength_ln_product_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_product_id)));
    avelength_ln_product_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_product_id)),h.ln_product_id<>(typeof(h.ln_product_id))'');
    populated_ln_sub_product_id_pcnt := AVE(GROUP,IF(h.ln_sub_product_id = (TYPEOF(h.ln_sub_product_id))'',0,100));
    maxlength_ln_sub_product_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_sub_product_id)));
    avelength_ln_sub_product_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_sub_product_id)),h.ln_sub_product_id<>(typeof(h.ln_sub_product_id))'');
    populated_ln_sub_sub_product_id_pcnt := AVE(GROUP,IF(h.ln_sub_sub_product_id = (TYPEOF(h.ln_sub_sub_product_id))'',0,100));
    maxlength_ln_sub_sub_product_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_sub_sub_product_id)));
    avelength_ln_sub_sub_product_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_sub_sub_product_id)),h.ln_sub_sub_product_id<>(typeof(h.ln_sub_sub_product_id))'');
    populated_ln_product_key_pcnt := AVE(GROUP,IF(h.ln_product_key = (TYPEOF(h.ln_product_key))'',0,100));
    maxlength_ln_product_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_product_key)));
    avelength_ln_product_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_product_key)),h.ln_product_key<>(typeof(h.ln_product_key))'');
    populated_ln_report_date_pcnt := AVE(GROUP,IF(h.ln_report_date = (TYPEOF(h.ln_report_date))'',0,100));
    maxlength_ln_report_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_report_date)));
    avelength_ln_report_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_report_date)),h.ln_report_date<>(typeof(h.ln_report_date))'');
    populated_ln_report_time_pcnt := AVE(GROUP,IF(h.ln_report_time = (TYPEOF(h.ln_report_time))'',0,100));
    maxlength_ln_report_time := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_report_time)));
    avelength_ln_report_time := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_report_time)),h.ln_report_time<>(typeof(h.ln_report_time))'');
    populated_reported_date_pcnt := AVE(GROUP,IF(h.reported_date = (TYPEOF(h.reported_date))'',0,100));
    maxlength_reported_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.reported_date)));
    avelength_reported_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.reported_date)),h.reported_date<>(typeof(h.reported_date))'');
    populated_reported_time_pcnt := AVE(GROUP,IF(h.reported_time = (TYPEOF(h.reported_time))'',0,100));
    maxlength_reported_time := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.reported_time)));
    avelength_reported_time := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.reported_time)),h.reported_time<>(typeof(h.reported_time))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_end_date_pcnt := AVE(GROUP,IF(h.event_end_date = (TYPEOF(h.event_end_date))'',0,100));
    maxlength_event_end_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_end_date)));
    avelength_event_end_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_end_date)),h.event_end_date<>(typeof(h.event_end_date))'');
    populated_event_location_pcnt := AVE(GROUP,IF(h.event_location = (TYPEOF(h.event_location))'',0,100));
    maxlength_event_location := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_location)));
    avelength_event_location := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_location)),h.event_location<>(typeof(h.event_location))'');
    populated_event_type_1_pcnt := AVE(GROUP,IF(h.event_type_1 = (TYPEOF(h.event_type_1))'',0,100));
    maxlength_event_type_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_1)));
    avelength_event_type_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_1)),h.event_type_1<>(typeof(h.event_type_1))'');
    populated_event_type_2_pcnt := AVE(GROUP,IF(h.event_type_2 = (TYPEOF(h.event_type_2))'',0,100));
    maxlength_event_type_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_2)));
    avelength_event_type_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_2)),h.event_type_2<>(typeof(h.event_type_2))'');
    populated_event_type_3_pcnt := AVE(GROUP,IF(h.event_type_3 = (TYPEOF(h.event_type_3))'',0,100));
    maxlength_event_type_3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_3)));
    avelength_event_type_3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.event_type_3)),h.event_type_3<>(typeof(h.event_type_3))'');
    populated_household_id_pcnt := AVE(GROUP,IF(h.household_id = (TYPEOF(h.household_id))'',0,100));
    maxlength_household_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.household_id)));
    avelength_household_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.household_id)),h.household_id<>(typeof(h.household_id))'');
    populated_reason_description_pcnt := AVE(GROUP,IF(h.reason_description = (TYPEOF(h.reason_description))'',0,100));
    maxlength_reason_description := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.reason_description)));
    avelength_reason_description := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.reason_description)),h.reason_description<>(typeof(h.reason_description))'');
    populated_investigation_referral_case_id_pcnt := AVE(GROUP,IF(h.investigation_referral_case_id = (TYPEOF(h.investigation_referral_case_id))'',0,100));
    maxlength_investigation_referral_case_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_case_id)));
    avelength_investigation_referral_case_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_case_id)),h.investigation_referral_case_id<>(typeof(h.investigation_referral_case_id))'');
    populated_investigation_referral_date_opened_pcnt := AVE(GROUP,IF(h.investigation_referral_date_opened = (TYPEOF(h.investigation_referral_date_opened))'',0,100));
    maxlength_investigation_referral_date_opened := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_date_opened)));
    avelength_investigation_referral_date_opened := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_date_opened)),h.investigation_referral_date_opened<>(typeof(h.investigation_referral_date_opened))'');
    populated_investigation_referral_date_closed_pcnt := AVE(GROUP,IF(h.investigation_referral_date_closed = (TYPEOF(h.investigation_referral_date_closed))'',0,100));
    maxlength_investigation_referral_date_closed := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_date_closed)));
    avelength_investigation_referral_date_closed := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.investigation_referral_date_closed)),h.investigation_referral_date_closed<>(typeof(h.investigation_referral_date_closed))'');
    populated_customer_fraud_code_1_pcnt := AVE(GROUP,IF(h.customer_fraud_code_1 = (TYPEOF(h.customer_fraud_code_1))'',0,100));
    maxlength_customer_fraud_code_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_fraud_code_1)));
    avelength_customer_fraud_code_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_fraud_code_1)),h.customer_fraud_code_1<>(typeof(h.customer_fraud_code_1))'');
    populated_customer_fraud_code_2_pcnt := AVE(GROUP,IF(h.customer_fraud_code_2 = (TYPEOF(h.customer_fraud_code_2))'',0,100));
    maxlength_customer_fraud_code_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_fraud_code_2)));
    avelength_customer_fraud_code_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_fraud_code_2)),h.customer_fraud_code_2<>(typeof(h.customer_fraud_code_2))'');
    populated_type_of_referral_pcnt := AVE(GROUP,IF(h.type_of_referral = (TYPEOF(h.type_of_referral))'',0,100));
    maxlength_type_of_referral := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_referral)));
    avelength_type_of_referral := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_referral)),h.type_of_referral<>(typeof(h.type_of_referral))'');
    populated_referral_reason_pcnt := AVE(GROUP,IF(h.referral_reason = (TYPEOF(h.referral_reason))'',0,100));
    maxlength_referral_reason := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.referral_reason)));
    avelength_referral_reason := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.referral_reason)),h.referral_reason<>(typeof(h.referral_reason))'');
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_mitigated_pcnt := AVE(GROUP,IF(h.mitigated = (TYPEOF(h.mitigated))'',0,100));
    maxlength_mitigated := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mitigated)));
    avelength_mitigated := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mitigated)),h.mitigated<>(typeof(h.mitigated))'');
    populated_mitigated_amount_pcnt := AVE(GROUP,IF(h.mitigated_amount = (TYPEOF(h.mitigated_amount))'',0,100));
    maxlength_mitigated_amount := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mitigated_amount)));
    avelength_mitigated_amount := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mitigated_amount)),h.mitigated_amount<>(typeof(h.mitigated_amount))'');
    populated_external_referral_or_casenumber_pcnt := AVE(GROUP,IF(h.external_referral_or_casenumber = (TYPEOF(h.external_referral_or_casenumber))'',0,100));
    maxlength_external_referral_or_casenumber := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.external_referral_or_casenumber)));
    avelength_external_referral_or_casenumber := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.external_referral_or_casenumber)),h.external_referral_or_casenumber<>(typeof(h.external_referral_or_casenumber))'');
    populated_fraud_point_score_pcnt := AVE(GROUP,IF(h.fraud_point_score = (TYPEOF(h.fraud_point_score))'',0,100));
    maxlength_fraud_point_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fraud_point_score)));
    avelength_fraud_point_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fraud_point_score)),h.fraud_point_score<>(typeof(h.fraud_point_score))'');
    populated_customer_person_id_pcnt := AVE(GROUP,IF(h.customer_person_id = (TYPEOF(h.customer_person_id))'',0,100));
    maxlength_customer_person_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_person_id)));
    avelength_customer_person_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.customer_person_id)),h.customer_person_id<>(typeof(h.customer_person_id))'');
    populated_raw_title_pcnt := AVE(GROUP,IF(h.raw_title = (TYPEOF(h.raw_title))'',0,100));
    maxlength_raw_title := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_title)));
    avelength_raw_title := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_title)),h.raw_title<>(typeof(h.raw_title))'');
    populated_raw_first_name_pcnt := AVE(GROUP,IF(h.raw_first_name = (TYPEOF(h.raw_first_name))'',0,100));
    maxlength_raw_first_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_first_name)));
    avelength_raw_first_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_first_name)),h.raw_first_name<>(typeof(h.raw_first_name))'');
    populated_raw_middle_name_pcnt := AVE(GROUP,IF(h.raw_middle_name = (TYPEOF(h.raw_middle_name))'',0,100));
    maxlength_raw_middle_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_middle_name)));
    avelength_raw_middle_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_middle_name)),h.raw_middle_name<>(typeof(h.raw_middle_name))'');
    populated_raw_last_name_pcnt := AVE(GROUP,IF(h.raw_last_name = (TYPEOF(h.raw_last_name))'',0,100));
    maxlength_raw_last_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_last_name)));
    avelength_raw_last_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_last_name)),h.raw_last_name<>(typeof(h.raw_last_name))'');
    populated_raw_orig_suffix_pcnt := AVE(GROUP,IF(h.raw_orig_suffix = (TYPEOF(h.raw_orig_suffix))'',0,100));
    maxlength_raw_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_orig_suffix)));
    avelength_raw_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_orig_suffix)),h.raw_orig_suffix<>(typeof(h.raw_orig_suffix))'');
    populated_raw_full_name_pcnt := AVE(GROUP,IF(h.raw_full_name = (TYPEOF(h.raw_full_name))'',0,100));
    maxlength_raw_full_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_full_name)));
    avelength_raw_full_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.raw_full_name)),h.raw_full_name<>(typeof(h.raw_full_name))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_drivers_license_pcnt := AVE(GROUP,IF(h.drivers_license = (TYPEOF(h.drivers_license))'',0,100));
    maxlength_drivers_license := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.drivers_license)));
    avelength_drivers_license := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.drivers_license)),h.drivers_license<>(typeof(h.drivers_license))'');
    populated_drivers_license_state_pcnt := AVE(GROUP,IF(h.drivers_license_state = (TYPEOF(h.drivers_license_state))'',0,100));
    maxlength_drivers_license_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.drivers_license_state)));
    avelength_drivers_license_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.drivers_license_state)),h.drivers_license_state<>(typeof(h.drivers_license_state))'');
    populated_person_date_pcnt := AVE(GROUP,IF(h.person_date = (TYPEOF(h.person_date))'',0,100));
    maxlength_person_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.person_date)));
    avelength_person_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.person_date)),h.person_date<>(typeof(h.person_date))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_income_pcnt := AVE(GROUP,IF(h.income = (TYPEOF(h.income))'',0,100));
    maxlength_income := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.income)));
    avelength_income := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.income)),h.income<>(typeof(h.income))'');
    populated_own_or_rent_pcnt := AVE(GROUP,IF(h.own_or_rent = (TYPEOF(h.own_or_rent))'',0,100));
    maxlength_own_or_rent := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.own_or_rent)));
    avelength_own_or_rent := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.own_or_rent)),h.own_or_rent<>(typeof(h.own_or_rent))'');
    populated_rawlinkid_pcnt := AVE(GROUP,IF(h.rawlinkid = (TYPEOF(h.rawlinkid))'',0,100));
    maxlength_rawlinkid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawlinkid)));
    avelength_rawlinkid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawlinkid)),h.rawlinkid<>(typeof(h.rawlinkid))'');
    populated_street_1_pcnt := AVE(GROUP,IF(h.street_1 = (TYPEOF(h.street_1))'',0,100));
    maxlength_street_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.street_1)));
    avelength_street_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.street_1)),h.street_1<>(typeof(h.street_1))'');
    populated_street_2_pcnt := AVE(GROUP,IF(h.street_2 = (TYPEOF(h.street_2))'',0,100));
    maxlength_street_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.street_2)));
    avelength_street_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.street_2)),h.street_2<>(typeof(h.street_2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_gps_coordinates_pcnt := AVE(GROUP,IF(h.gps_coordinates = (TYPEOF(h.gps_coordinates))'',0,100));
    maxlength_gps_coordinates := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.gps_coordinates)));
    avelength_gps_coordinates := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.gps_coordinates)),h.gps_coordinates<>(typeof(h.gps_coordinates))'');
    populated_address_date_pcnt := AVE(GROUP,IF(h.address_date = (TYPEOF(h.address_date))'',0,100));
    maxlength_address_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_date)));
    avelength_address_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_date)),h.address_date<>(typeof(h.address_date))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_appended_provider_id_pcnt := AVE(GROUP,IF(h.appended_provider_id = (TYPEOF(h.appended_provider_id))'',0,100));
    maxlength_appended_provider_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.appended_provider_id)));
    avelength_appended_provider_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.appended_provider_id)),h.appended_provider_id<>(typeof(h.appended_provider_id))'');
    populated_lnpid_pcnt := AVE(GROUP,IF(h.lnpid = (TYPEOF(h.lnpid))'',0,100));
    maxlength_lnpid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lnpid)));
    avelength_lnpid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lnpid)),h.lnpid<>(typeof(h.lnpid))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_tin_pcnt := AVE(GROUP,IF(h.tin = (TYPEOF(h.tin))'',0,100));
    maxlength_tin := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.tin)));
    avelength_tin := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.tin)),h.tin<>(typeof(h.tin))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_business_type_1_pcnt := AVE(GROUP,IF(h.business_type_1 = (TYPEOF(h.business_type_1))'',0,100));
    maxlength_business_type_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type_1)));
    avelength_business_type_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type_1)),h.business_type_1<>(typeof(h.business_type_1))'');
    populated_business_type_2_pcnt := AVE(GROUP,IF(h.business_type_2 = (TYPEOF(h.business_type_2))'',0,100));
    maxlength_business_type_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type_2)));
    avelength_business_type_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_type_2)),h.business_type_2<>(typeof(h.business_type_2))'');
    populated_business_date_pcnt := AVE(GROUP,IF(h.business_date = (TYPEOF(h.business_date))'',0,100));
    maxlength_business_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_date)));
    avelength_business_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_date)),h.business_date<>(typeof(h.business_date))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_cell_phone_pcnt := AVE(GROUP,IF(h.cell_phone = (TYPEOF(h.cell_phone))'',0,100));
    maxlength_cell_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cell_phone)));
    avelength_cell_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cell_phone)),h.cell_phone<>(typeof(h.cell_phone))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
    populated_contact_type_pcnt := AVE(GROUP,IF(h.contact_type = (TYPEOF(h.contact_type))'',0,100));
    maxlength_contact_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_type)));
    avelength_contact_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_type)),h.contact_type<>(typeof(h.contact_type))'');
    populated_contact_date_pcnt := AVE(GROUP,IF(h.contact_date = (TYPEOF(h.contact_date))'',0,100));
    maxlength_contact_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_date)));
    avelength_contact_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_date)),h.contact_date<>(typeof(h.contact_date))'');
    populated_carrier_pcnt := AVE(GROUP,IF(h.carrier = (TYPEOF(h.carrier))'',0,100));
    maxlength_carrier := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.carrier)));
    avelength_carrier := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.carrier)),h.carrier<>(typeof(h.carrier))'');
    populated_contact_location_pcnt := AVE(GROUP,IF(h.contact_location = (TYPEOF(h.contact_location))'',0,100));
    maxlength_contact_location := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_location)));
    avelength_contact_location := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact_location)),h.contact_location<>(typeof(h.contact_location))'');
    populated_contact_pcnt := AVE(GROUP,IF(h.contact = (TYPEOF(h.contact))'',0,100));
    maxlength_contact := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact)));
    avelength_contact := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contact)),h.contact<>(typeof(h.contact))'');
    populated_call_records_pcnt := AVE(GROUP,IF(h.call_records = (TYPEOF(h.call_records))'',0,100));
    maxlength_call_records := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.call_records)));
    avelength_call_records := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.call_records)),h.call_records<>(typeof(h.call_records))'');
    populated_in_service_pcnt := AVE(GROUP,IF(h.in_service = (TYPEOF(h.in_service))'',0,100));
    maxlength_in_service := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.in_service)));
    avelength_in_service := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.in_service)),h.in_service<>(typeof(h.in_service))'');
    populated_email_address_pcnt := AVE(GROUP,IF(h.email_address = (TYPEOF(h.email_address))'',0,100));
    maxlength_email_address := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_address)));
    avelength_email_address := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_address)),h.email_address<>(typeof(h.email_address))'');
    populated_email_address_type_pcnt := AVE(GROUP,IF(h.email_address_type = (TYPEOF(h.email_address_type))'',0,100));
    maxlength_email_address_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_address_type)));
    avelength_email_address_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_address_type)),h.email_address_type<>(typeof(h.email_address_type))'');
    populated_email_date_pcnt := AVE(GROUP,IF(h.email_date = (TYPEOF(h.email_date))'',0,100));
    maxlength_email_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_date)));
    avelength_email_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.email_date)),h.email_date<>(typeof(h.email_date))'');
    populated_host_pcnt := AVE(GROUP,IF(h.host = (TYPEOF(h.host))'',0,100));
    maxlength_host := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.host)));
    avelength_host := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.host)),h.host<>(typeof(h.host))'');
    populated_alias_pcnt := AVE(GROUP,IF(h.alias = (TYPEOF(h.alias))'',0,100));
    maxlength_alias := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.alias)));
    avelength_alias := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.alias)),h.alias<>(typeof(h.alias))'');
    populated_location_pcnt := AVE(GROUP,IF(h.location = (TYPEOF(h.location))'',0,100));
    maxlength_location := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.location)));
    avelength_location := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.location)),h.location<>(typeof(h.location))'');
    populated_ip_address_pcnt := AVE(GROUP,IF(h.ip_address = (TYPEOF(h.ip_address))'',0,100));
    maxlength_ip_address := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ip_address)));
    avelength_ip_address := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ip_address)),h.ip_address<>(typeof(h.ip_address))'');
    populated_ip_address_date_pcnt := AVE(GROUP,IF(h.ip_address_date = (TYPEOF(h.ip_address_date))'',0,100));
    maxlength_ip_address_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ip_address_date)));
    avelength_ip_address_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ip_address_date)),h.ip_address_date<>(typeof(h.ip_address_date))'');
    populated_version_pcnt := AVE(GROUP,IF(h.version = (TYPEOF(h.version))'',0,100));
    maxlength_version := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.version)));
    avelength_version := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.version)),h.version<>(typeof(h.version))'');
    populated_class_pcnt := AVE(GROUP,IF(h.class = (TYPEOF(h.class))'',0,100));
    maxlength_class := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.class)));
    avelength_class := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.class)),h.class<>(typeof(h.class))'');
    populated_subnet_mask_pcnt := AVE(GROUP,IF(h.subnet_mask = (TYPEOF(h.subnet_mask))'',0,100));
    maxlength_subnet_mask := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.subnet_mask)));
    avelength_subnet_mask := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.subnet_mask)),h.subnet_mask<>(typeof(h.subnet_mask))'');
    populated_reserved_pcnt := AVE(GROUP,IF(h.reserved = (TYPEOF(h.reserved))'',0,100));
    maxlength_reserved := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.reserved)));
    avelength_reserved := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.reserved)),h.reserved<>(typeof(h.reserved))'');
    populated_isp_pcnt := AVE(GROUP,IF(h.isp = (TYPEOF(h.isp))'',0,100));
    maxlength_isp := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.isp)));
    avelength_isp := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.isp)),h.isp<>(typeof(h.isp))'');
    populated_device_id_pcnt := AVE(GROUP,IF(h.device_id = (TYPEOF(h.device_id))'',0,100));
    maxlength_device_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_id)));
    avelength_device_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_id)),h.device_id<>(typeof(h.device_id))'');
    populated_device_date_pcnt := AVE(GROUP,IF(h.device_date = (TYPEOF(h.device_date))'',0,100));
    maxlength_device_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_date)));
    avelength_device_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_date)),h.device_date<>(typeof(h.device_date))'');
    populated_unique_number_pcnt := AVE(GROUP,IF(h.unique_number = (TYPEOF(h.unique_number))'',0,100));
    maxlength_unique_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.unique_number)));
    avelength_unique_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.unique_number)),h.unique_number<>(typeof(h.unique_number))'');
    populated_mac_address_pcnt := AVE(GROUP,IF(h.mac_address = (TYPEOF(h.mac_address))'',0,100));
    maxlength_mac_address := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mac_address)));
    avelength_mac_address := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mac_address)),h.mac_address<>(typeof(h.mac_address))'');
    populated_serial_number_pcnt := AVE(GROUP,IF(h.serial_number = (TYPEOF(h.serial_number))'',0,100));
    maxlength_serial_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.serial_number)));
    avelength_serial_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.serial_number)),h.serial_number<>(typeof(h.serial_number))'');
    populated_device_type_pcnt := AVE(GROUP,IF(h.device_type = (TYPEOF(h.device_type))'',0,100));
    maxlength_device_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_type)));
    avelength_device_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_type)),h.device_type<>(typeof(h.device_type))'');
    populated_device_identification_provider_pcnt := AVE(GROUP,IF(h.device_identification_provider = (TYPEOF(h.device_identification_provider))'',0,100));
    maxlength_device_identification_provider := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_identification_provider)));
    avelength_device_identification_provider := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.device_identification_provider)),h.device_identification_provider<>(typeof(h.device_identification_provider))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_transaction_type_pcnt := AVE(GROUP,IF(h.transaction_type = (TYPEOF(h.transaction_type))'',0,100));
    maxlength_transaction_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.transaction_type)));
    avelength_transaction_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.transaction_type)),h.transaction_type<>(typeof(h.transaction_type))'');
    populated_amount_of_loss_pcnt := AVE(GROUP,IF(h.amount_of_loss = (TYPEOF(h.amount_of_loss))'',0,100));
    maxlength_amount_of_loss := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.amount_of_loss)));
    avelength_amount_of_loss := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.amount_of_loss)),h.amount_of_loss<>(typeof(h.amount_of_loss))'');
    populated_professional_id_pcnt := AVE(GROUP,IF(h.professional_id = (TYPEOF(h.professional_id))'',0,100));
    maxlength_professional_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.professional_id)));
    avelength_professional_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.professional_id)),h.professional_id<>(typeof(h.professional_id))'');
    populated_profession_type_pcnt := AVE(GROUP,IF(h.profession_type = (TYPEOF(h.profession_type))'',0,100));
    maxlength_profession_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.profession_type)));
    avelength_profession_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.profession_type)),h.profession_type<>(typeof(h.profession_type))'');
    populated_corresponding_professional_ids_pcnt := AVE(GROUP,IF(h.corresponding_professional_ids = (TYPEOF(h.corresponding_professional_ids))'',0,100));
    maxlength_corresponding_professional_ids := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corresponding_professional_ids)));
    avelength_corresponding_professional_ids := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corresponding_professional_ids)),h.corresponding_professional_ids<>(typeof(h.corresponding_professional_ids))'');
    populated_licensed_pr_state_pcnt := AVE(GROUP,IF(h.licensed_pr_state = (TYPEOF(h.licensed_pr_state))'',0,100));
    maxlength_licensed_pr_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.licensed_pr_state)));
    avelength_licensed_pr_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.licensed_pr_state)),h.licensed_pr_state<>(typeof(h.licensed_pr_state))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_name_ind_pcnt := AVE(GROUP,IF(h.name_ind = (TYPEOF(h.name_ind))'',0,100));
    maxlength_name_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_ind)));
    avelength_name_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name_ind)),h.name_ind<>(typeof(h.name_ind))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_aceaid_pcnt := AVE(GROUP,IF(h.aceaid = (TYPEOF(h.aceaid))'',0,100));
    maxlength_aceaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.aceaid)));
    avelength_aceaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.aceaid)),h.aceaid<>(typeof(h.aceaid))'');
    populated_address_ind_pcnt := AVE(GROUP,IF(h.address_ind = (TYPEOF(h.address_ind))'',0,100));
    maxlength_address_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_ind)));
    avelength_address_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.address_ind)),h.address_ind<>(typeof(h.address_ind))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_clean_business_name_pcnt := AVE(GROUP,IF(h.clean_business_name = (TYPEOF(h.clean_business_name))'',0,100));
    maxlength_clean_business_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_business_name)));
    avelength_clean_business_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_business_name)),h.clean_business_name<>(typeof(h.clean_business_name))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated___internal_fpos___pcnt := AVE(GROUP,IF(h.__internal_fpos__ = (TYPEOF(h.__internal_fpos__))'',0,100));
    maxlength___internal_fpos__ := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.__internal_fpos__)));
    avelength___internal_fpos__ := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.__internal_fpos__)),h.__internal_fpos__<>(typeof(h.__internal_fpos__))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_classification_source_source_type_pcnt *   0.00 / 100 + T.Populated_classification_source_primary_source_entity_pcnt *   0.00 / 100 + T.Populated_classification_source_expectation_of_victim_entities_pcnt *   0.00 / 100 + T.Populated_classification_source_industry_segment_pcnt *   0.00 / 100 + T.Populated_classification_activity_suspected_discrepancy_pcnt *   0.00 / 100 + T.Populated_classification_activity_confidence_that_activity_was_deceitful_pcnt *   0.00 / 100 + T.Populated_classification_activity_workflow_stage_committed_pcnt *   0.00 / 100 + T.Populated_classification_activity_workflow_stage_detected_pcnt *   0.00 / 100 + T.Populated_classification_activity_channels_pcnt *   0.00 / 100 + T.Populated_classification_activity_category_or_fraudtype_pcnt *   0.00 / 100 + T.Populated_classification_activity_description_pcnt *   0.00 / 100 + T.Populated_classification_activity_threat_pcnt *   0.00 / 100 + T.Populated_classification_activity_exposure_pcnt *   0.00 / 100 + T.Populated_classification_activity_write_off_loss_pcnt *   0.00 / 100 + T.Populated_classification_activity_mitigated_pcnt *   0.00 / 100 + T.Populated_classification_activity_alert_level_pcnt *   0.00 / 100 + T.Populated_classification_entity_entity_type_pcnt *   0.00 / 100 + T.Populated_classification_entity_entity_sub_type_pcnt *   0.00 / 100 + T.Populated_classification_entity_role_pcnt *   0.00 / 100 + T.Populated_classification_entity_evidence_pcnt *   0.00 / 100 + T.Populated_classification_entity_investigated_count_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_fdn_file_info_id_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_fdn_file_code_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_gc_id_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_file_type_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_description_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_primary_source_entity_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_ind_type_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_ind_type_description_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_update_freq_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_expiration_days_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_post_contract_expiration_days_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_status_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_product_include_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_date_added_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_user_added_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_date_changed_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_user_changed_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_p_industry_segment_pcnt *   0.00 / 100 + T.Populated_classification_permissible_use_access_usage_term_pcnt *   0.00 / 100 + T.Populated_cleaned_name_title_pcnt *   0.00 / 100 + T.Populated_cleaned_name_fname_pcnt *   0.00 / 100 + T.Populated_cleaned_name_mname_pcnt *   0.00 / 100 + T.Populated_cleaned_name_lname_pcnt *   0.00 / 100 + T.Populated_cleaned_name_name_suffix_pcnt *   0.00 / 100 + T.Populated_cleaned_name_name_score_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_address_predir_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_address_postdir_pcnt *   0.00 / 100 + T.Populated_clean_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_address_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_address_zip4_pcnt *   0.00 / 100 + T.Populated_clean_address_cart_pcnt *   0.00 / 100 + T.Populated_clean_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_pcnt *   0.00 / 100 + T.Populated_clean_address_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_address_dbpc_pcnt *   0.00 / 100 + T.Populated_clean_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_address_rec_type_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_state_pcnt *   0.00 / 100 + T.Populated_clean_address_fips_county_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_address_msa_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_address_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_address_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_phones_phone_number_pcnt *   0.00 / 100 + T.Populated_clean_phones_cell_phone_pcnt *   0.00 / 100 + T.Populated_clean_phones_work_phone_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_uid_pcnt *   0.00 / 100 + T.Populated_customer_id_pcnt *   0.00 / 100 + T.Populated_sub_customer_id_pcnt *   0.00 / 100 + T.Populated_vendor_id_pcnt *   0.00 / 100 + T.Populated_offender_key_pcnt *   0.00 / 100 + T.Populated_sub_sub_customer_id_pcnt *   0.00 / 100 + T.Populated_customer_event_id_pcnt *   0.00 / 100 + T.Populated_sub_customer_event_id_pcnt *   0.00 / 100 + T.Populated_sub_sub_customer_event_id_pcnt *   0.00 / 100 + T.Populated_ln_product_id_pcnt *   0.00 / 100 + T.Populated_ln_sub_product_id_pcnt *   0.00 / 100 + T.Populated_ln_sub_sub_product_id_pcnt *   0.00 / 100 + T.Populated_ln_product_key_pcnt *   0.00 / 100 + T.Populated_ln_report_date_pcnt *   0.00 / 100 + T.Populated_ln_report_time_pcnt *   0.00 / 100 + T.Populated_reported_date_pcnt *   0.00 / 100 + T.Populated_reported_time_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_end_date_pcnt *   0.00 / 100 + T.Populated_event_location_pcnt *   0.00 / 100 + T.Populated_event_type_1_pcnt *   0.00 / 100 + T.Populated_event_type_2_pcnt *   0.00 / 100 + T.Populated_event_type_3_pcnt *   0.00 / 100 + T.Populated_household_id_pcnt *   0.00 / 100 + T.Populated_reason_description_pcnt *   0.00 / 100 + T.Populated_investigation_referral_case_id_pcnt *   0.00 / 100 + T.Populated_investigation_referral_date_opened_pcnt *   0.00 / 100 + T.Populated_investigation_referral_date_closed_pcnt *   0.00 / 100 + T.Populated_customer_fraud_code_1_pcnt *   0.00 / 100 + T.Populated_customer_fraud_code_2_pcnt *   0.00 / 100 + T.Populated_type_of_referral_pcnt *   0.00 / 100 + T.Populated_referral_reason_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_mitigated_pcnt *   0.00 / 100 + T.Populated_mitigated_amount_pcnt *   0.00 / 100 + T.Populated_external_referral_or_casenumber_pcnt *   0.00 / 100 + T.Populated_fraud_point_score_pcnt *   0.00 / 100 + T.Populated_customer_person_id_pcnt *   0.00 / 100 + T.Populated_raw_title_pcnt *   0.00 / 100 + T.Populated_raw_first_name_pcnt *   0.00 / 100 + T.Populated_raw_middle_name_pcnt *   0.00 / 100 + T.Populated_raw_last_name_pcnt *   0.00 / 100 + T.Populated_raw_orig_suffix_pcnt *   0.00 / 100 + T.Populated_raw_full_name_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_drivers_license_pcnt *   0.00 / 100 + T.Populated_drivers_license_state_pcnt *   0.00 / 100 + T.Populated_person_date_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_income_pcnt *   0.00 / 100 + T.Populated_own_or_rent_pcnt *   0.00 / 100 + T.Populated_rawlinkid_pcnt *   0.00 / 100 + T.Populated_street_1_pcnt *   0.00 / 100 + T.Populated_street_2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_gps_coordinates_pcnt *   0.00 / 100 + T.Populated_address_date_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_appended_provider_id_pcnt *   0.00 / 100 + T.Populated_lnpid_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_tin_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_npi_pcnt *   0.00 / 100 + T.Populated_business_type_1_pcnt *   0.00 / 100 + T.Populated_business_type_2_pcnt *   0.00 / 100 + T.Populated_business_date_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_cell_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_contact_type_pcnt *   0.00 / 100 + T.Populated_contact_date_pcnt *   0.00 / 100 + T.Populated_carrier_pcnt *   0.00 / 100 + T.Populated_contact_location_pcnt *   0.00 / 100 + T.Populated_contact_pcnt *   0.00 / 100 + T.Populated_call_records_pcnt *   0.00 / 100 + T.Populated_in_service_pcnt *   0.00 / 100 + T.Populated_email_address_pcnt *   0.00 / 100 + T.Populated_email_address_type_pcnt *   0.00 / 100 + T.Populated_email_date_pcnt *   0.00 / 100 + T.Populated_host_pcnt *   0.00 / 100 + T.Populated_alias_pcnt *   0.00 / 100 + T.Populated_location_pcnt *   0.00 / 100 + T.Populated_ip_address_pcnt *   0.00 / 100 + T.Populated_ip_address_date_pcnt *   0.00 / 100 + T.Populated_version_pcnt *   0.00 / 100 + T.Populated_class_pcnt *   0.00 / 100 + T.Populated_subnet_mask_pcnt *   0.00 / 100 + T.Populated_reserved_pcnt *   0.00 / 100 + T.Populated_isp_pcnt *   0.00 / 100 + T.Populated_device_id_pcnt *   0.00 / 100 + T.Populated_device_date_pcnt *   0.00 / 100 + T.Populated_unique_number_pcnt *   0.00 / 100 + T.Populated_mac_address_pcnt *   0.00 / 100 + T.Populated_serial_number_pcnt *   0.00 / 100 + T.Populated_device_type_pcnt *   0.00 / 100 + T.Populated_device_identification_provider_pcnt *   0.00 / 100 + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_transaction_type_pcnt *   0.00 / 100 + T.Populated_amount_of_loss_pcnt *   0.00 / 100 + T.Populated_professional_id_pcnt *   0.00 / 100 + T.Populated_profession_type_pcnt *   0.00 / 100 + T.Populated_corresponding_professional_ids_pcnt *   0.00 / 100 + T.Populated_licensed_pr_state_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_name_ind_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_aceaid_pcnt *   0.00 / 100 + T.Populated_address_ind_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_clean_business_name_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated___internal_fpos___pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'classification_source_source_type','classification_source_primary_source_entity','classification_source_expectation_of_victim_entities','classification_source_industry_segment','classification_activity_suspected_discrepancy','classification_activity_confidence_that_activity_was_deceitful','classification_activity_workflow_stage_committed','classification_activity_workflow_stage_detected','classification_activity_channels','classification_activity_category_or_fraudtype','classification_activity_description','classification_activity_threat','classification_activity_exposure','classification_activity_write_off_loss','classification_activity_mitigated','classification_activity_alert_level','classification_entity_entity_type','classification_entity_entity_sub_type','classification_entity_role','classification_entity_evidence','classification_entity_investigated_count','classification_permissible_use_access_fdn_file_info_id','classification_permissible_use_access_fdn_file_code','classification_permissible_use_access_gc_id','classification_permissible_use_access_file_type','classification_permissible_use_access_description','classification_permissible_use_access_primary_source_entity','classification_permissible_use_access_ind_type','classification_permissible_use_access_ind_type_description','classification_permissible_use_access_update_freq','classification_permissible_use_access_expiration_days','classification_permissible_use_access_post_contract_expiration_days','classification_permissible_use_access_status','classification_permissible_use_access_product_include','classification_permissible_use_access_date_added','classification_permissible_use_access_user_added','classification_permissible_use_access_date_changed','classification_permissible_use_access_user_changed','classification_permissible_use_access_p_industry_segment','classification_permissible_use_access_usage_term','cleaned_name_title','cleaned_name_fname','cleaned_name_mname','cleaned_name_lname','cleaned_name_name_suffix','cleaned_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_phones_phone_number','clean_phones_cell_phone','clean_phones_work_phone','record_id','uid','customer_id','sub_customer_id','vendor_id','offender_key','sub_sub_customer_id','customer_event_id','sub_customer_event_id','sub_sub_customer_event_id','ln_product_id','ln_sub_product_id','ln_sub_sub_product_id','ln_product_key','ln_report_date','ln_report_time','reported_date','reported_time','event_date','event_end_date','event_location','event_type_1','event_type_2','event_type_3','household_id','reason_description','investigation_referral_case_id','investigation_referral_date_opened','investigation_referral_date_closed','customer_fraud_code_1','customer_fraud_code_2','type_of_referral','referral_reason','disposition','mitigated','mitigated_amount','external_referral_or_casenumber','fraud_point_score','customer_person_id','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','raw_full_name','ssn','dob','drivers_license','drivers_license_state','person_date','name_type','income','own_or_rent','rawlinkid','street_1','street_2','city','state','zip','gps_coordinates','address_date','address_type','appended_provider_id','lnpid','business_name','tin','fein','npi','business_type_1','business_type_2','business_date','phone_number','cell_phone','work_phone','contact_type','contact_date','carrier','contact_location','contact','call_records','in_service','email_address','email_address_type','email_date','host','alias','location','ip_address','ip_address_date','version','class','subnet_mask','reserved','isp','device_id','device_date','unique_number','mac_address','serial_number','device_type','device_identification_provider','transaction_id','transaction_type','amount_of_loss','professional_id','profession_type','corresponding_professional_ids','licensed_pr_state','source','process_date','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','source_rec_id','nid','name_ind','address_1','address_2','rawaid','aceaid','address_ind','did','did_score','clean_business_name','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','__internal_fpos__');
  SELF.populated_pcnt := CHOOSE(C,le.populated_classification_source_source_type_pcnt,le.populated_classification_source_primary_source_entity_pcnt,le.populated_classification_source_expectation_of_victim_entities_pcnt,le.populated_classification_source_industry_segment_pcnt,le.populated_classification_activity_suspected_discrepancy_pcnt,le.populated_classification_activity_confidence_that_activity_was_deceitful_pcnt,le.populated_classification_activity_workflow_stage_committed_pcnt,le.populated_classification_activity_workflow_stage_detected_pcnt,le.populated_classification_activity_channels_pcnt,le.populated_classification_activity_category_or_fraudtype_pcnt,le.populated_classification_activity_description_pcnt,le.populated_classification_activity_threat_pcnt,le.populated_classification_activity_exposure_pcnt,le.populated_classification_activity_write_off_loss_pcnt,le.populated_classification_activity_mitigated_pcnt,le.populated_classification_activity_alert_level_pcnt,le.populated_classification_entity_entity_type_pcnt,le.populated_classification_entity_entity_sub_type_pcnt,le.populated_classification_entity_role_pcnt,le.populated_classification_entity_evidence_pcnt,le.populated_classification_entity_investigated_count_pcnt,le.populated_classification_permissible_use_access_fdn_file_info_id_pcnt,le.populated_classification_permissible_use_access_fdn_file_code_pcnt,le.populated_classification_permissible_use_access_gc_id_pcnt,le.populated_classification_permissible_use_access_file_type_pcnt,le.populated_classification_permissible_use_access_description_pcnt,le.populated_classification_permissible_use_access_primary_source_entity_pcnt,le.populated_classification_permissible_use_access_ind_type_pcnt,le.populated_classification_permissible_use_access_ind_type_description_pcnt,le.populated_classification_permissible_use_access_update_freq_pcnt,le.populated_classification_permissible_use_access_expiration_days_pcnt,le.populated_classification_permissible_use_access_post_contract_expiration_days_pcnt,le.populated_classification_permissible_use_access_status_pcnt,le.populated_classification_permissible_use_access_product_include_pcnt,le.populated_classification_permissible_use_access_date_added_pcnt,le.populated_classification_permissible_use_access_user_added_pcnt,le.populated_classification_permissible_use_access_date_changed_pcnt,le.populated_classification_permissible_use_access_user_changed_pcnt,le.populated_classification_permissible_use_access_p_industry_segment_pcnt,le.populated_classification_permissible_use_access_usage_term_pcnt,le.populated_cleaned_name_title_pcnt,le.populated_cleaned_name_fname_pcnt,le.populated_cleaned_name_mname_pcnt,le.populated_cleaned_name_lname_pcnt,le.populated_cleaned_name_name_suffix_pcnt,le.populated_cleaned_name_name_score_pcnt,le.populated_clean_address_prim_range_pcnt,le.populated_clean_address_predir_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_addr_suffix_pcnt,le.populated_clean_address_postdir_pcnt,le.populated_clean_address_unit_desig_pcnt,le.populated_clean_address_sec_range_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt,le.populated_clean_address_zip4_pcnt,le.populated_clean_address_cart_pcnt,le.populated_clean_address_cr_sort_sz_pcnt,le.populated_clean_address_lot_pcnt,le.populated_clean_address_lot_order_pcnt,le.populated_clean_address_dbpc_pcnt,le.populated_clean_address_chk_digit_pcnt,le.populated_clean_address_rec_type_pcnt,le.populated_clean_address_fips_state_pcnt,le.populated_clean_address_fips_county_pcnt,le.populated_clean_address_geo_lat_pcnt,le.populated_clean_address_geo_long_pcnt,le.populated_clean_address_msa_pcnt,le.populated_clean_address_geo_blk_pcnt,le.populated_clean_address_geo_match_pcnt,le.populated_clean_address_err_stat_pcnt,le.populated_clean_phones_phone_number_pcnt,le.populated_clean_phones_cell_phone_pcnt,le.populated_clean_phones_work_phone_pcnt,le.populated_record_id_pcnt,le.populated_uid_pcnt,le.populated_customer_id_pcnt,le.populated_sub_customer_id_pcnt,le.populated_vendor_id_pcnt,le.populated_offender_key_pcnt,le.populated_sub_sub_customer_id_pcnt,le.populated_customer_event_id_pcnt,le.populated_sub_customer_event_id_pcnt,le.populated_sub_sub_customer_event_id_pcnt,le.populated_ln_product_id_pcnt,le.populated_ln_sub_product_id_pcnt,le.populated_ln_sub_sub_product_id_pcnt,le.populated_ln_product_key_pcnt,le.populated_ln_report_date_pcnt,le.populated_ln_report_time_pcnt,le.populated_reported_date_pcnt,le.populated_reported_time_pcnt,le.populated_event_date_pcnt,le.populated_event_end_date_pcnt,le.populated_event_location_pcnt,le.populated_event_type_1_pcnt,le.populated_event_type_2_pcnt,le.populated_event_type_3_pcnt,le.populated_household_id_pcnt,le.populated_reason_description_pcnt,le.populated_investigation_referral_case_id_pcnt,le.populated_investigation_referral_date_opened_pcnt,le.populated_investigation_referral_date_closed_pcnt,le.populated_customer_fraud_code_1_pcnt,le.populated_customer_fraud_code_2_pcnt,le.populated_type_of_referral_pcnt,le.populated_referral_reason_pcnt,le.populated_disposition_pcnt,le.populated_mitigated_pcnt,le.populated_mitigated_amount_pcnt,le.populated_external_referral_or_casenumber_pcnt,le.populated_fraud_point_score_pcnt,le.populated_customer_person_id_pcnt,le.populated_raw_title_pcnt,le.populated_raw_first_name_pcnt,le.populated_raw_middle_name_pcnt,le.populated_raw_last_name_pcnt,le.populated_raw_orig_suffix_pcnt,le.populated_raw_full_name_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_drivers_license_pcnt,le.populated_drivers_license_state_pcnt,le.populated_person_date_pcnt,le.populated_name_type_pcnt,le.populated_income_pcnt,le.populated_own_or_rent_pcnt,le.populated_rawlinkid_pcnt,le.populated_street_1_pcnt,le.populated_street_2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_gps_coordinates_pcnt,le.populated_address_date_pcnt,le.populated_address_type_pcnt,le.populated_appended_provider_id_pcnt,le.populated_lnpid_pcnt,le.populated_business_name_pcnt,le.populated_tin_pcnt,le.populated_fein_pcnt,le.populated_npi_pcnt,le.populated_business_type_1_pcnt,le.populated_business_type_2_pcnt,le.populated_business_date_pcnt,le.populated_phone_number_pcnt,le.populated_cell_phone_pcnt,le.populated_work_phone_pcnt,le.populated_contact_type_pcnt,le.populated_contact_date_pcnt,le.populated_carrier_pcnt,le.populated_contact_location_pcnt,le.populated_contact_pcnt,le.populated_call_records_pcnt,le.populated_in_service_pcnt,le.populated_email_address_pcnt,le.populated_email_address_type_pcnt,le.populated_email_date_pcnt,le.populated_host_pcnt,le.populated_alias_pcnt,le.populated_location_pcnt,le.populated_ip_address_pcnt,le.populated_ip_address_date_pcnt,le.populated_version_pcnt,le.populated_class_pcnt,le.populated_subnet_mask_pcnt,le.populated_reserved_pcnt,le.populated_isp_pcnt,le.populated_device_id_pcnt,le.populated_device_date_pcnt,le.populated_unique_number_pcnt,le.populated_mac_address_pcnt,le.populated_serial_number_pcnt,le.populated_device_type_pcnt,le.populated_device_identification_provider_pcnt,le.populated_transaction_id_pcnt,le.populated_transaction_type_pcnt,le.populated_amount_of_loss_pcnt,le.populated_professional_id_pcnt,le.populated_profession_type_pcnt,le.populated_corresponding_professional_ids_pcnt,le.populated_licensed_pr_state_pcnt,le.populated_source_pcnt,le.populated_process_date_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_source_rec_id_pcnt,le.populated_nid_pcnt,le.populated_name_ind_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_rawaid_pcnt,le.populated_aceaid_pcnt,le.populated_address_ind_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_clean_business_name_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated___internal_fpos___pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_classification_source_source_type,le.maxlength_classification_source_primary_source_entity,le.maxlength_classification_source_expectation_of_victim_entities,le.maxlength_classification_source_industry_segment,le.maxlength_classification_activity_suspected_discrepancy,le.maxlength_classification_activity_confidence_that_activity_was_deceitful,le.maxlength_classification_activity_workflow_stage_committed,le.maxlength_classification_activity_workflow_stage_detected,le.maxlength_classification_activity_channels,le.maxlength_classification_activity_category_or_fraudtype,le.maxlength_classification_activity_description,le.maxlength_classification_activity_threat,le.maxlength_classification_activity_exposure,le.maxlength_classification_activity_write_off_loss,le.maxlength_classification_activity_mitigated,le.maxlength_classification_activity_alert_level,le.maxlength_classification_entity_entity_type,le.maxlength_classification_entity_entity_sub_type,le.maxlength_classification_entity_role,le.maxlength_classification_entity_evidence,le.maxlength_classification_entity_investigated_count,le.maxlength_classification_permissible_use_access_fdn_file_info_id,le.maxlength_classification_permissible_use_access_fdn_file_code,le.maxlength_classification_permissible_use_access_gc_id,le.maxlength_classification_permissible_use_access_file_type,le.maxlength_classification_permissible_use_access_description,le.maxlength_classification_permissible_use_access_primary_source_entity,le.maxlength_classification_permissible_use_access_ind_type,le.maxlength_classification_permissible_use_access_ind_type_description,le.maxlength_classification_permissible_use_access_update_freq,le.maxlength_classification_permissible_use_access_expiration_days,le.maxlength_classification_permissible_use_access_post_contract_expiration_days,le.maxlength_classification_permissible_use_access_status,le.maxlength_classification_permissible_use_access_product_include,le.maxlength_classification_permissible_use_access_date_added,le.maxlength_classification_permissible_use_access_user_added,le.maxlength_classification_permissible_use_access_date_changed,le.maxlength_classification_permissible_use_access_user_changed,le.maxlength_classification_permissible_use_access_p_industry_segment,le.maxlength_classification_permissible_use_access_usage_term,le.maxlength_cleaned_name_title,le.maxlength_cleaned_name_fname,le.maxlength_cleaned_name_mname,le.maxlength_cleaned_name_lname,le.maxlength_cleaned_name_name_suffix,le.maxlength_cleaned_name_name_score,le.maxlength_clean_address_prim_range,le.maxlength_clean_address_predir,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_addr_suffix,le.maxlength_clean_address_postdir,le.maxlength_clean_address_unit_desig,le.maxlength_clean_address_sec_range,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip,le.maxlength_clean_address_zip4,le.maxlength_clean_address_cart,le.maxlength_clean_address_cr_sort_sz,le.maxlength_clean_address_lot,le.maxlength_clean_address_lot_order,le.maxlength_clean_address_dbpc,le.maxlength_clean_address_chk_digit,le.maxlength_clean_address_rec_type,le.maxlength_clean_address_fips_state,le.maxlength_clean_address_fips_county,le.maxlength_clean_address_geo_lat,le.maxlength_clean_address_geo_long,le.maxlength_clean_address_msa,le.maxlength_clean_address_geo_blk,le.maxlength_clean_address_geo_match,le.maxlength_clean_address_err_stat,le.maxlength_clean_phones_phone_number,le.maxlength_clean_phones_cell_phone,le.maxlength_clean_phones_work_phone,le.maxlength_record_id,le.maxlength_uid,le.maxlength_customer_id,le.maxlength_sub_customer_id,le.maxlength_vendor_id,le.maxlength_offender_key,le.maxlength_sub_sub_customer_id,le.maxlength_customer_event_id,le.maxlength_sub_customer_event_id,le.maxlength_sub_sub_customer_event_id,le.maxlength_ln_product_id,le.maxlength_ln_sub_product_id,le.maxlength_ln_sub_sub_product_id,le.maxlength_ln_product_key,le.maxlength_ln_report_date,le.maxlength_ln_report_time,le.maxlength_reported_date,le.maxlength_reported_time,le.maxlength_event_date,le.maxlength_event_end_date,le.maxlength_event_location,le.maxlength_event_type_1,le.maxlength_event_type_2,le.maxlength_event_type_3,le.maxlength_household_id,le.maxlength_reason_description,le.maxlength_investigation_referral_case_id,le.maxlength_investigation_referral_date_opened,le.maxlength_investigation_referral_date_closed,le.maxlength_customer_fraud_code_1,le.maxlength_customer_fraud_code_2,le.maxlength_type_of_referral,le.maxlength_referral_reason,le.maxlength_disposition,le.maxlength_mitigated,le.maxlength_mitigated_amount,le.maxlength_external_referral_or_casenumber,le.maxlength_fraud_point_score,le.maxlength_customer_person_id,le.maxlength_raw_title,le.maxlength_raw_first_name,le.maxlength_raw_middle_name,le.maxlength_raw_last_name,le.maxlength_raw_orig_suffix,le.maxlength_raw_full_name,le.maxlength_ssn,le.maxlength_dob,le.maxlength_drivers_license,le.maxlength_drivers_license_state,le.maxlength_person_date,le.maxlength_name_type,le.maxlength_income,le.maxlength_own_or_rent,le.maxlength_rawlinkid,le.maxlength_street_1,le.maxlength_street_2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_gps_coordinates,le.maxlength_address_date,le.maxlength_address_type,le.maxlength_appended_provider_id,le.maxlength_lnpid,le.maxlength_business_name,le.maxlength_tin,le.maxlength_fein,le.maxlength_npi,le.maxlength_business_type_1,le.maxlength_business_type_2,le.maxlength_business_date,le.maxlength_phone_number,le.maxlength_cell_phone,le.maxlength_work_phone,le.maxlength_contact_type,le.maxlength_contact_date,le.maxlength_carrier,le.maxlength_contact_location,le.maxlength_contact,le.maxlength_call_records,le.maxlength_in_service,le.maxlength_email_address,le.maxlength_email_address_type,le.maxlength_email_date,le.maxlength_host,le.maxlength_alias,le.maxlength_location,le.maxlength_ip_address,le.maxlength_ip_address_date,le.maxlength_version,le.maxlength_class,le.maxlength_subnet_mask,le.maxlength_reserved,le.maxlength_isp,le.maxlength_device_id,le.maxlength_device_date,le.maxlength_unique_number,le.maxlength_mac_address,le.maxlength_serial_number,le.maxlength_device_type,le.maxlength_device_identification_provider,le.maxlength_transaction_id,le.maxlength_transaction_type,le.maxlength_amount_of_loss,le.maxlength_professional_id,le.maxlength_profession_type,le.maxlength_corresponding_professional_ids,le.maxlength_licensed_pr_state,le.maxlength_source,le.maxlength_process_date,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_source_rec_id,le.maxlength_nid,le.maxlength_name_ind,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_rawaid,le.maxlength_aceaid,le.maxlength_address_ind,le.maxlength_did,le.maxlength_did_score,le.maxlength_clean_business_name,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength___internal_fpos__);
  SELF.avelength := CHOOSE(C,le.avelength_classification_source_source_type,le.avelength_classification_source_primary_source_entity,le.avelength_classification_source_expectation_of_victim_entities,le.avelength_classification_source_industry_segment,le.avelength_classification_activity_suspected_discrepancy,le.avelength_classification_activity_confidence_that_activity_was_deceitful,le.avelength_classification_activity_workflow_stage_committed,le.avelength_classification_activity_workflow_stage_detected,le.avelength_classification_activity_channels,le.avelength_classification_activity_category_or_fraudtype,le.avelength_classification_activity_description,le.avelength_classification_activity_threat,le.avelength_classification_activity_exposure,le.avelength_classification_activity_write_off_loss,le.avelength_classification_activity_mitigated,le.avelength_classification_activity_alert_level,le.avelength_classification_entity_entity_type,le.avelength_classification_entity_entity_sub_type,le.avelength_classification_entity_role,le.avelength_classification_entity_evidence,le.avelength_classification_entity_investigated_count,le.avelength_classification_permissible_use_access_fdn_file_info_id,le.avelength_classification_permissible_use_access_fdn_file_code,le.avelength_classification_permissible_use_access_gc_id,le.avelength_classification_permissible_use_access_file_type,le.avelength_classification_permissible_use_access_description,le.avelength_classification_permissible_use_access_primary_source_entity,le.avelength_classification_permissible_use_access_ind_type,le.avelength_classification_permissible_use_access_ind_type_description,le.avelength_classification_permissible_use_access_update_freq,le.avelength_classification_permissible_use_access_expiration_days,le.avelength_classification_permissible_use_access_post_contract_expiration_days,le.avelength_classification_permissible_use_access_status,le.avelength_classification_permissible_use_access_product_include,le.avelength_classification_permissible_use_access_date_added,le.avelength_classification_permissible_use_access_user_added,le.avelength_classification_permissible_use_access_date_changed,le.avelength_classification_permissible_use_access_user_changed,le.avelength_classification_permissible_use_access_p_industry_segment,le.avelength_classification_permissible_use_access_usage_term,le.avelength_cleaned_name_title,le.avelength_cleaned_name_fname,le.avelength_cleaned_name_mname,le.avelength_cleaned_name_lname,le.avelength_cleaned_name_name_suffix,le.avelength_cleaned_name_name_score,le.avelength_clean_address_prim_range,le.avelength_clean_address_predir,le.avelength_clean_address_prim_name,le.avelength_clean_address_addr_suffix,le.avelength_clean_address_postdir,le.avelength_clean_address_unit_desig,le.avelength_clean_address_sec_range,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip,le.avelength_clean_address_zip4,le.avelength_clean_address_cart,le.avelength_clean_address_cr_sort_sz,le.avelength_clean_address_lot,le.avelength_clean_address_lot_order,le.avelength_clean_address_dbpc,le.avelength_clean_address_chk_digit,le.avelength_clean_address_rec_type,le.avelength_clean_address_fips_state,le.avelength_clean_address_fips_county,le.avelength_clean_address_geo_lat,le.avelength_clean_address_geo_long,le.avelength_clean_address_msa,le.avelength_clean_address_geo_blk,le.avelength_clean_address_geo_match,le.avelength_clean_address_err_stat,le.avelength_clean_phones_phone_number,le.avelength_clean_phones_cell_phone,le.avelength_clean_phones_work_phone,le.avelength_record_id,le.avelength_uid,le.avelength_customer_id,le.avelength_sub_customer_id,le.avelength_vendor_id,le.avelength_offender_key,le.avelength_sub_sub_customer_id,le.avelength_customer_event_id,le.avelength_sub_customer_event_id,le.avelength_sub_sub_customer_event_id,le.avelength_ln_product_id,le.avelength_ln_sub_product_id,le.avelength_ln_sub_sub_product_id,le.avelength_ln_product_key,le.avelength_ln_report_date,le.avelength_ln_report_time,le.avelength_reported_date,le.avelength_reported_time,le.avelength_event_date,le.avelength_event_end_date,le.avelength_event_location,le.avelength_event_type_1,le.avelength_event_type_2,le.avelength_event_type_3,le.avelength_household_id,le.avelength_reason_description,le.avelength_investigation_referral_case_id,le.avelength_investigation_referral_date_opened,le.avelength_investigation_referral_date_closed,le.avelength_customer_fraud_code_1,le.avelength_customer_fraud_code_2,le.avelength_type_of_referral,le.avelength_referral_reason,le.avelength_disposition,le.avelength_mitigated,le.avelength_mitigated_amount,le.avelength_external_referral_or_casenumber,le.avelength_fraud_point_score,le.avelength_customer_person_id,le.avelength_raw_title,le.avelength_raw_first_name,le.avelength_raw_middle_name,le.avelength_raw_last_name,le.avelength_raw_orig_suffix,le.avelength_raw_full_name,le.avelength_ssn,le.avelength_dob,le.avelength_drivers_license,le.avelength_drivers_license_state,le.avelength_person_date,le.avelength_name_type,le.avelength_income,le.avelength_own_or_rent,le.avelength_rawlinkid,le.avelength_street_1,le.avelength_street_2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_gps_coordinates,le.avelength_address_date,le.avelength_address_type,le.avelength_appended_provider_id,le.avelength_lnpid,le.avelength_business_name,le.avelength_tin,le.avelength_fein,le.avelength_npi,le.avelength_business_type_1,le.avelength_business_type_2,le.avelength_business_date,le.avelength_phone_number,le.avelength_cell_phone,le.avelength_work_phone,le.avelength_contact_type,le.avelength_contact_date,le.avelength_carrier,le.avelength_contact_location,le.avelength_contact,le.avelength_call_records,le.avelength_in_service,le.avelength_email_address,le.avelength_email_address_type,le.avelength_email_date,le.avelength_host,le.avelength_alias,le.avelength_location,le.avelength_ip_address,le.avelength_ip_address_date,le.avelength_version,le.avelength_class,le.avelength_subnet_mask,le.avelength_reserved,le.avelength_isp,le.avelength_device_id,le.avelength_device_date,le.avelength_unique_number,le.avelength_mac_address,le.avelength_serial_number,le.avelength_device_type,le.avelength_device_identification_provider,le.avelength_transaction_id,le.avelength_transaction_type,le.avelength_amount_of_loss,le.avelength_professional_id,le.avelength_profession_type,le.avelength_corresponding_professional_ids,le.avelength_licensed_pr_state,le.avelength_source,le.avelength_process_date,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_source_rec_id,le.avelength_nid,le.avelength_name_ind,le.avelength_address_1,le.avelength_address_2,le.avelength_rawaid,le.avelength_aceaid,le.avelength_address_ind,le.avelength_did,le.avelength_did_score,le.avelength_clean_business_name,le.avelength_bdid,le.avelength_bdid_score,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength___internal_fpos__);
END;
EXPORT invSummary := NORMALIZE(summary0, 225, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.classification_source_source_type),TRIM((SALT34.StrType)le.classification_source_primary_source_entity),TRIM((SALT34.StrType)le.classification_source_expectation_of_victim_entities),TRIM((SALT34.StrType)le.classification_source_industry_segment),TRIM((SALT34.StrType)le.classification_activity_suspected_discrepancy),TRIM((SALT34.StrType)le.classification_activity_confidence_that_activity_was_deceitful),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_committed),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_detected),TRIM((SALT34.StrType)le.classification_activity_channels),TRIM((SALT34.StrType)le.classification_activity_category_or_fraudtype),TRIM((SALT34.StrType)le.classification_activity_description),TRIM((SALT34.StrType)le.classification_activity_threat),TRIM((SALT34.StrType)le.classification_activity_exposure),TRIM((SALT34.StrType)le.classification_activity_write_off_loss),TRIM((SALT34.StrType)le.classification_activity_mitigated),TRIM((SALT34.StrType)le.classification_activity_alert_level),TRIM((SALT34.StrType)le.classification_entity_entity_type),TRIM((SALT34.StrType)le.classification_entity_entity_sub_type),TRIM((SALT34.StrType)le.classification_entity_role),TRIM((SALT34.StrType)le.classification_entity_evidence),TRIM((SALT34.StrType)le.classification_entity_investigated_count),IF (le.classification_permissible_use_access_fdn_file_info_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_info_id), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_code),IF (le.classification_permissible_use_access_gc_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_gc_id), ''),IF (le.classification_permissible_use_access_file_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_file_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_description),IF (le.classification_permissible_use_access_primary_source_entity <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_primary_source_entity), ''),IF (le.classification_permissible_use_access_ind_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type_description),IF (le.classification_permissible_use_access_update_freq <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_update_freq), ''),IF (le.classification_permissible_use_access_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_expiration_days), ''),IF (le.classification_permissible_use_access_post_contract_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_post_contract_expiration_days), ''),IF (le.classification_permissible_use_access_status <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_status), ''),IF (le.classification_permissible_use_access_product_include <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_product_include), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_p_industry_segment),TRIM((SALT34.StrType)le.classification_permissible_use_access_usage_term),TRIM((SALT34.StrType)le.cleaned_name_title),TRIM((SALT34.StrType)le.cleaned_name_fname),TRIM((SALT34.StrType)le.cleaned_name_mname),TRIM((SALT34.StrType)le.cleaned_name_lname),TRIM((SALT34.StrType)le.cleaned_name_name_suffix),TRIM((SALT34.StrType)le.cleaned_name_name_score),TRIM((SALT34.StrType)le.clean_address_prim_range),TRIM((SALT34.StrType)le.clean_address_predir),TRIM((SALT34.StrType)le.clean_address_prim_name),TRIM((SALT34.StrType)le.clean_address_addr_suffix),TRIM((SALT34.StrType)le.clean_address_postdir),TRIM((SALT34.StrType)le.clean_address_unit_desig),TRIM((SALT34.StrType)le.clean_address_sec_range),TRIM((SALT34.StrType)le.clean_address_p_city_name),TRIM((SALT34.StrType)le.clean_address_v_city_name),TRIM((SALT34.StrType)le.clean_address_st),TRIM((SALT34.StrType)le.clean_address_zip),TRIM((SALT34.StrType)le.clean_address_zip4),TRIM((SALT34.StrType)le.clean_address_cart),TRIM((SALT34.StrType)le.clean_address_cr_sort_sz),TRIM((SALT34.StrType)le.clean_address_lot),TRIM((SALT34.StrType)le.clean_address_lot_order),TRIM((SALT34.StrType)le.clean_address_dbpc),TRIM((SALT34.StrType)le.clean_address_chk_digit),TRIM((SALT34.StrType)le.clean_address_rec_type),TRIM((SALT34.StrType)le.clean_address_fips_state),TRIM((SALT34.StrType)le.clean_address_fips_county),TRIM((SALT34.StrType)le.clean_address_geo_lat),TRIM((SALT34.StrType)le.clean_address_geo_long),TRIM((SALT34.StrType)le.clean_address_msa),TRIM((SALT34.StrType)le.clean_address_geo_blk),TRIM((SALT34.StrType)le.clean_address_geo_match),TRIM((SALT34.StrType)le.clean_address_err_stat),TRIM((SALT34.StrType)le.clean_phones_phone_number),TRIM((SALT34.StrType)le.clean_phones_cell_phone),TRIM((SALT34.StrType)le.clean_phones_work_phone),IF (le.record_id <> 0,TRIM((SALT34.StrType)le.record_id), ''),IF (le.uid <> 0,TRIM((SALT34.StrType)le.uid), ''),TRIM((SALT34.StrType)le.customer_id),TRIM((SALT34.StrType)le.sub_customer_id),TRIM((SALT34.StrType)le.vendor_id),TRIM((SALT34.StrType)le.offender_key),TRIM((SALT34.StrType)le.sub_sub_customer_id),TRIM((SALT34.StrType)le.customer_event_id),TRIM((SALT34.StrType)le.sub_customer_event_id),TRIM((SALT34.StrType)le.sub_sub_customer_event_id),TRIM((SALT34.StrType)le.ln_product_id),TRIM((SALT34.StrType)le.ln_sub_product_id),TRIM((SALT34.StrType)le.ln_sub_sub_product_id),TRIM((SALT34.StrType)le.ln_product_key),TRIM((SALT34.StrType)le.ln_report_date),TRIM((SALT34.StrType)le.ln_report_time),TRIM((SALT34.StrType)le.reported_date),TRIM((SALT34.StrType)le.reported_time),TRIM((SALT34.StrType)le.event_date),TRIM((SALT34.StrType)le.event_end_date),TRIM((SALT34.StrType)le.event_location),TRIM((SALT34.StrType)le.event_type_1),TRIM((SALT34.StrType)le.event_type_2),TRIM((SALT34.StrType)le.event_type_3),IF (le.household_id <> 0,TRIM((SALT34.StrType)le.household_id), ''),TRIM((SALT34.StrType)le.reason_description),TRIM((SALT34.StrType)le.investigation_referral_case_id),TRIM((SALT34.StrType)le.investigation_referral_date_opened),TRIM((SALT34.StrType)le.investigation_referral_date_closed),TRIM((SALT34.StrType)le.customer_fraud_code_1),TRIM((SALT34.StrType)le.customer_fraud_code_2),TRIM((SALT34.StrType)le.type_of_referral),TRIM((SALT34.StrType)le.referral_reason),TRIM((SALT34.StrType)le.disposition),TRIM((SALT34.StrType)le.mitigated),TRIM((SALT34.StrType)le.mitigated_amount),TRIM((SALT34.StrType)le.external_referral_or_casenumber),TRIM((SALT34.StrType)le.fraud_point_score),IF (le.customer_person_id <> 0,TRIM((SALT34.StrType)le.customer_person_id), ''),TRIM((SALT34.StrType)le.raw_title),TRIM((SALT34.StrType)le.raw_first_name),TRIM((SALT34.StrType)le.raw_middle_name),TRIM((SALT34.StrType)le.raw_last_name),TRIM((SALT34.StrType)le.raw_orig_suffix),TRIM((SALT34.StrType)le.raw_full_name),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.drivers_license),TRIM((SALT34.StrType)le.drivers_license_state),TRIM((SALT34.StrType)le.person_date),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.income),TRIM((SALT34.StrType)le.own_or_rent),IF (le.rawlinkid <> 0,TRIM((SALT34.StrType)le.rawlinkid), ''),TRIM((SALT34.StrType)le.street_1),TRIM((SALT34.StrType)le.street_2),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.gps_coordinates),TRIM((SALT34.StrType)le.address_date),TRIM((SALT34.StrType)le.address_type),IF (le.appended_provider_id <> 0,TRIM((SALT34.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT34.StrType)le.lnpid), ''),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.tin),TRIM((SALT34.StrType)le.fein),TRIM((SALT34.StrType)le.npi),TRIM((SALT34.StrType)le.business_type_1),TRIM((SALT34.StrType)le.business_type_2),TRIM((SALT34.StrType)le.business_date),TRIM((SALT34.StrType)le.phone_number),TRIM((SALT34.StrType)le.cell_phone),TRIM((SALT34.StrType)le.work_phone),TRIM((SALT34.StrType)le.contact_type),TRIM((SALT34.StrType)le.contact_date),TRIM((SALT34.StrType)le.carrier),TRIM((SALT34.StrType)le.contact_location),TRIM((SALT34.StrType)le.contact),TRIM((SALT34.StrType)le.call_records),TRIM((SALT34.StrType)le.in_service),TRIM((SALT34.StrType)le.email_address),TRIM((SALT34.StrType)le.email_address_type),TRIM((SALT34.StrType)le.email_date),TRIM((SALT34.StrType)le.host),TRIM((SALT34.StrType)le.alias),TRIM((SALT34.StrType)le.location),TRIM((SALT34.StrType)le.ip_address),TRIM((SALT34.StrType)le.ip_address_date),TRIM((SALT34.StrType)le.version),TRIM((SALT34.StrType)le.class),TRIM((SALT34.StrType)le.subnet_mask),TRIM((SALT34.StrType)le.reserved),TRIM((SALT34.StrType)le.isp),TRIM((SALT34.StrType)le.device_id),TRIM((SALT34.StrType)le.device_date),TRIM((SALT34.StrType)le.unique_number),TRIM((SALT34.StrType)le.mac_address),TRIM((SALT34.StrType)le.serial_number),TRIM((SALT34.StrType)le.device_type),TRIM((SALT34.StrType)le.device_identification_provider),TRIM((SALT34.StrType)le.transaction_id),TRIM((SALT34.StrType)le.transaction_type),TRIM((SALT34.StrType)le.amount_of_loss),TRIM((SALT34.StrType)le.professional_id),TRIM((SALT34.StrType)le.profession_type),TRIM((SALT34.StrType)le.corresponding_professional_ids),TRIM((SALT34.StrType)le.licensed_pr_state),TRIM((SALT34.StrType)le.source),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), ''),IF (le.nid <> 0,TRIM((SALT34.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT34.StrType)le.name_ind), ''),TRIM((SALT34.StrType)le.address_1),TRIM((SALT34.StrType)le.address_2),IF (le.rawaid <> 0,TRIM((SALT34.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT34.StrType)le.aceaid), ''),IF (le.address_ind <> 0,TRIM((SALT34.StrType)le.address_ind), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT34.StrType)le.did_score), ''),TRIM((SALT34.StrType)le.clean_business_name),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT34.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT34.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT34.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT34.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT34.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT34.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT34.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT34.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT34.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT34.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT34.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT34.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT34.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT34.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT34.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT34.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT34.StrType)le.ultweight), ''),IF (le.__internal_fpos__ <> 0,TRIM((SALT34.StrType)le.__internal_fpos__), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,225,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 225);
  SELF.FldNo2 := 1 + (C % 225);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.classification_source_source_type),TRIM((SALT34.StrType)le.classification_source_primary_source_entity),TRIM((SALT34.StrType)le.classification_source_expectation_of_victim_entities),TRIM((SALT34.StrType)le.classification_source_industry_segment),TRIM((SALT34.StrType)le.classification_activity_suspected_discrepancy),TRIM((SALT34.StrType)le.classification_activity_confidence_that_activity_was_deceitful),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_committed),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_detected),TRIM((SALT34.StrType)le.classification_activity_channels),TRIM((SALT34.StrType)le.classification_activity_category_or_fraudtype),TRIM((SALT34.StrType)le.classification_activity_description),TRIM((SALT34.StrType)le.classification_activity_threat),TRIM((SALT34.StrType)le.classification_activity_exposure),TRIM((SALT34.StrType)le.classification_activity_write_off_loss),TRIM((SALT34.StrType)le.classification_activity_mitigated),TRIM((SALT34.StrType)le.classification_activity_alert_level),TRIM((SALT34.StrType)le.classification_entity_entity_type),TRIM((SALT34.StrType)le.classification_entity_entity_sub_type),TRIM((SALT34.StrType)le.classification_entity_role),TRIM((SALT34.StrType)le.classification_entity_evidence),TRIM((SALT34.StrType)le.classification_entity_investigated_count),IF (le.classification_permissible_use_access_fdn_file_info_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_info_id), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_code),IF (le.classification_permissible_use_access_gc_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_gc_id), ''),IF (le.classification_permissible_use_access_file_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_file_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_description),IF (le.classification_permissible_use_access_primary_source_entity <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_primary_source_entity), ''),IF (le.classification_permissible_use_access_ind_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type_description),IF (le.classification_permissible_use_access_update_freq <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_update_freq), ''),IF (le.classification_permissible_use_access_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_expiration_days), ''),IF (le.classification_permissible_use_access_post_contract_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_post_contract_expiration_days), ''),IF (le.classification_permissible_use_access_status <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_status), ''),IF (le.classification_permissible_use_access_product_include <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_product_include), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_p_industry_segment),TRIM((SALT34.StrType)le.classification_permissible_use_access_usage_term),TRIM((SALT34.StrType)le.cleaned_name_title),TRIM((SALT34.StrType)le.cleaned_name_fname),TRIM((SALT34.StrType)le.cleaned_name_mname),TRIM((SALT34.StrType)le.cleaned_name_lname),TRIM((SALT34.StrType)le.cleaned_name_name_suffix),TRIM((SALT34.StrType)le.cleaned_name_name_score),TRIM((SALT34.StrType)le.clean_address_prim_range),TRIM((SALT34.StrType)le.clean_address_predir),TRIM((SALT34.StrType)le.clean_address_prim_name),TRIM((SALT34.StrType)le.clean_address_addr_suffix),TRIM((SALT34.StrType)le.clean_address_postdir),TRIM((SALT34.StrType)le.clean_address_unit_desig),TRIM((SALT34.StrType)le.clean_address_sec_range),TRIM((SALT34.StrType)le.clean_address_p_city_name),TRIM((SALT34.StrType)le.clean_address_v_city_name),TRIM((SALT34.StrType)le.clean_address_st),TRIM((SALT34.StrType)le.clean_address_zip),TRIM((SALT34.StrType)le.clean_address_zip4),TRIM((SALT34.StrType)le.clean_address_cart),TRIM((SALT34.StrType)le.clean_address_cr_sort_sz),TRIM((SALT34.StrType)le.clean_address_lot),TRIM((SALT34.StrType)le.clean_address_lot_order),TRIM((SALT34.StrType)le.clean_address_dbpc),TRIM((SALT34.StrType)le.clean_address_chk_digit),TRIM((SALT34.StrType)le.clean_address_rec_type),TRIM((SALT34.StrType)le.clean_address_fips_state),TRIM((SALT34.StrType)le.clean_address_fips_county),TRIM((SALT34.StrType)le.clean_address_geo_lat),TRIM((SALT34.StrType)le.clean_address_geo_long),TRIM((SALT34.StrType)le.clean_address_msa),TRIM((SALT34.StrType)le.clean_address_geo_blk),TRIM((SALT34.StrType)le.clean_address_geo_match),TRIM((SALT34.StrType)le.clean_address_err_stat),TRIM((SALT34.StrType)le.clean_phones_phone_number),TRIM((SALT34.StrType)le.clean_phones_cell_phone),TRIM((SALT34.StrType)le.clean_phones_work_phone),IF (le.record_id <> 0,TRIM((SALT34.StrType)le.record_id), ''),IF (le.uid <> 0,TRIM((SALT34.StrType)le.uid), ''),TRIM((SALT34.StrType)le.customer_id),TRIM((SALT34.StrType)le.sub_customer_id),TRIM((SALT34.StrType)le.vendor_id),TRIM((SALT34.StrType)le.offender_key),TRIM((SALT34.StrType)le.sub_sub_customer_id),TRIM((SALT34.StrType)le.customer_event_id),TRIM((SALT34.StrType)le.sub_customer_event_id),TRIM((SALT34.StrType)le.sub_sub_customer_event_id),TRIM((SALT34.StrType)le.ln_product_id),TRIM((SALT34.StrType)le.ln_sub_product_id),TRIM((SALT34.StrType)le.ln_sub_sub_product_id),TRIM((SALT34.StrType)le.ln_product_key),TRIM((SALT34.StrType)le.ln_report_date),TRIM((SALT34.StrType)le.ln_report_time),TRIM((SALT34.StrType)le.reported_date),TRIM((SALT34.StrType)le.reported_time),TRIM((SALT34.StrType)le.event_date),TRIM((SALT34.StrType)le.event_end_date),TRIM((SALT34.StrType)le.event_location),TRIM((SALT34.StrType)le.event_type_1),TRIM((SALT34.StrType)le.event_type_2),TRIM((SALT34.StrType)le.event_type_3),IF (le.household_id <> 0,TRIM((SALT34.StrType)le.household_id), ''),TRIM((SALT34.StrType)le.reason_description),TRIM((SALT34.StrType)le.investigation_referral_case_id),TRIM((SALT34.StrType)le.investigation_referral_date_opened),TRIM((SALT34.StrType)le.investigation_referral_date_closed),TRIM((SALT34.StrType)le.customer_fraud_code_1),TRIM((SALT34.StrType)le.customer_fraud_code_2),TRIM((SALT34.StrType)le.type_of_referral),TRIM((SALT34.StrType)le.referral_reason),TRIM((SALT34.StrType)le.disposition),TRIM((SALT34.StrType)le.mitigated),TRIM((SALT34.StrType)le.mitigated_amount),TRIM((SALT34.StrType)le.external_referral_or_casenumber),TRIM((SALT34.StrType)le.fraud_point_score),IF (le.customer_person_id <> 0,TRIM((SALT34.StrType)le.customer_person_id), ''),TRIM((SALT34.StrType)le.raw_title),TRIM((SALT34.StrType)le.raw_first_name),TRIM((SALT34.StrType)le.raw_middle_name),TRIM((SALT34.StrType)le.raw_last_name),TRIM((SALT34.StrType)le.raw_orig_suffix),TRIM((SALT34.StrType)le.raw_full_name),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.drivers_license),TRIM((SALT34.StrType)le.drivers_license_state),TRIM((SALT34.StrType)le.person_date),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.income),TRIM((SALT34.StrType)le.own_or_rent),IF (le.rawlinkid <> 0,TRIM((SALT34.StrType)le.rawlinkid), ''),TRIM((SALT34.StrType)le.street_1),TRIM((SALT34.StrType)le.street_2),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.gps_coordinates),TRIM((SALT34.StrType)le.address_date),TRIM((SALT34.StrType)le.address_type),IF (le.appended_provider_id <> 0,TRIM((SALT34.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT34.StrType)le.lnpid), ''),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.tin),TRIM((SALT34.StrType)le.fein),TRIM((SALT34.StrType)le.npi),TRIM((SALT34.StrType)le.business_type_1),TRIM((SALT34.StrType)le.business_type_2),TRIM((SALT34.StrType)le.business_date),TRIM((SALT34.StrType)le.phone_number),TRIM((SALT34.StrType)le.cell_phone),TRIM((SALT34.StrType)le.work_phone),TRIM((SALT34.StrType)le.contact_type),TRIM((SALT34.StrType)le.contact_date),TRIM((SALT34.StrType)le.carrier),TRIM((SALT34.StrType)le.contact_location),TRIM((SALT34.StrType)le.contact),TRIM((SALT34.StrType)le.call_records),TRIM((SALT34.StrType)le.in_service),TRIM((SALT34.StrType)le.email_address),TRIM((SALT34.StrType)le.email_address_type),TRIM((SALT34.StrType)le.email_date),TRIM((SALT34.StrType)le.host),TRIM((SALT34.StrType)le.alias),TRIM((SALT34.StrType)le.location),TRIM((SALT34.StrType)le.ip_address),TRIM((SALT34.StrType)le.ip_address_date),TRIM((SALT34.StrType)le.version),TRIM((SALT34.StrType)le.class),TRIM((SALT34.StrType)le.subnet_mask),TRIM((SALT34.StrType)le.reserved),TRIM((SALT34.StrType)le.isp),TRIM((SALT34.StrType)le.device_id),TRIM((SALT34.StrType)le.device_date),TRIM((SALT34.StrType)le.unique_number),TRIM((SALT34.StrType)le.mac_address),TRIM((SALT34.StrType)le.serial_number),TRIM((SALT34.StrType)le.device_type),TRIM((SALT34.StrType)le.device_identification_provider),TRIM((SALT34.StrType)le.transaction_id),TRIM((SALT34.StrType)le.transaction_type),TRIM((SALT34.StrType)le.amount_of_loss),TRIM((SALT34.StrType)le.professional_id),TRIM((SALT34.StrType)le.profession_type),TRIM((SALT34.StrType)le.corresponding_professional_ids),TRIM((SALT34.StrType)le.licensed_pr_state),TRIM((SALT34.StrType)le.source),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), ''),IF (le.nid <> 0,TRIM((SALT34.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT34.StrType)le.name_ind), ''),TRIM((SALT34.StrType)le.address_1),TRIM((SALT34.StrType)le.address_2),IF (le.rawaid <> 0,TRIM((SALT34.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT34.StrType)le.aceaid), ''),IF (le.address_ind <> 0,TRIM((SALT34.StrType)le.address_ind), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT34.StrType)le.did_score), ''),TRIM((SALT34.StrType)le.clean_business_name),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT34.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT34.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT34.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT34.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT34.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT34.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT34.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT34.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT34.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT34.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT34.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT34.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT34.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT34.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT34.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT34.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT34.StrType)le.ultweight), ''),IF (le.__internal_fpos__ <> 0,TRIM((SALT34.StrType)le.__internal_fpos__), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.classification_source_source_type),TRIM((SALT34.StrType)le.classification_source_primary_source_entity),TRIM((SALT34.StrType)le.classification_source_expectation_of_victim_entities),TRIM((SALT34.StrType)le.classification_source_industry_segment),TRIM((SALT34.StrType)le.classification_activity_suspected_discrepancy),TRIM((SALT34.StrType)le.classification_activity_confidence_that_activity_was_deceitful),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_committed),TRIM((SALT34.StrType)le.classification_activity_workflow_stage_detected),TRIM((SALT34.StrType)le.classification_activity_channels),TRIM((SALT34.StrType)le.classification_activity_category_or_fraudtype),TRIM((SALT34.StrType)le.classification_activity_description),TRIM((SALT34.StrType)le.classification_activity_threat),TRIM((SALT34.StrType)le.classification_activity_exposure),TRIM((SALT34.StrType)le.classification_activity_write_off_loss),TRIM((SALT34.StrType)le.classification_activity_mitigated),TRIM((SALT34.StrType)le.classification_activity_alert_level),TRIM((SALT34.StrType)le.classification_entity_entity_type),TRIM((SALT34.StrType)le.classification_entity_entity_sub_type),TRIM((SALT34.StrType)le.classification_entity_role),TRIM((SALT34.StrType)le.classification_entity_evidence),TRIM((SALT34.StrType)le.classification_entity_investigated_count),IF (le.classification_permissible_use_access_fdn_file_info_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_info_id), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_fdn_file_code),IF (le.classification_permissible_use_access_gc_id <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_gc_id), ''),IF (le.classification_permissible_use_access_file_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_file_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_description),IF (le.classification_permissible_use_access_primary_source_entity <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_primary_source_entity), ''),IF (le.classification_permissible_use_access_ind_type <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_ind_type_description),IF (le.classification_permissible_use_access_update_freq <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_update_freq), ''),IF (le.classification_permissible_use_access_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_expiration_days), ''),IF (le.classification_permissible_use_access_post_contract_expiration_days <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_post_contract_expiration_days), ''),IF (le.classification_permissible_use_access_status <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_status), ''),IF (le.classification_permissible_use_access_product_include <> 0,TRIM((SALT34.StrType)le.classification_permissible_use_access_product_include), ''),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_added),TRIM((SALT34.StrType)le.classification_permissible_use_access_date_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_user_changed),TRIM((SALT34.StrType)le.classification_permissible_use_access_p_industry_segment),TRIM((SALT34.StrType)le.classification_permissible_use_access_usage_term),TRIM((SALT34.StrType)le.cleaned_name_title),TRIM((SALT34.StrType)le.cleaned_name_fname),TRIM((SALT34.StrType)le.cleaned_name_mname),TRIM((SALT34.StrType)le.cleaned_name_lname),TRIM((SALT34.StrType)le.cleaned_name_name_suffix),TRIM((SALT34.StrType)le.cleaned_name_name_score),TRIM((SALT34.StrType)le.clean_address_prim_range),TRIM((SALT34.StrType)le.clean_address_predir),TRIM((SALT34.StrType)le.clean_address_prim_name),TRIM((SALT34.StrType)le.clean_address_addr_suffix),TRIM((SALT34.StrType)le.clean_address_postdir),TRIM((SALT34.StrType)le.clean_address_unit_desig),TRIM((SALT34.StrType)le.clean_address_sec_range),TRIM((SALT34.StrType)le.clean_address_p_city_name),TRIM((SALT34.StrType)le.clean_address_v_city_name),TRIM((SALT34.StrType)le.clean_address_st),TRIM((SALT34.StrType)le.clean_address_zip),TRIM((SALT34.StrType)le.clean_address_zip4),TRIM((SALT34.StrType)le.clean_address_cart),TRIM((SALT34.StrType)le.clean_address_cr_sort_sz),TRIM((SALT34.StrType)le.clean_address_lot),TRIM((SALT34.StrType)le.clean_address_lot_order),TRIM((SALT34.StrType)le.clean_address_dbpc),TRIM((SALT34.StrType)le.clean_address_chk_digit),TRIM((SALT34.StrType)le.clean_address_rec_type),TRIM((SALT34.StrType)le.clean_address_fips_state),TRIM((SALT34.StrType)le.clean_address_fips_county),TRIM((SALT34.StrType)le.clean_address_geo_lat),TRIM((SALT34.StrType)le.clean_address_geo_long),TRIM((SALT34.StrType)le.clean_address_msa),TRIM((SALT34.StrType)le.clean_address_geo_blk),TRIM((SALT34.StrType)le.clean_address_geo_match),TRIM((SALT34.StrType)le.clean_address_err_stat),TRIM((SALT34.StrType)le.clean_phones_phone_number),TRIM((SALT34.StrType)le.clean_phones_cell_phone),TRIM((SALT34.StrType)le.clean_phones_work_phone),IF (le.record_id <> 0,TRIM((SALT34.StrType)le.record_id), ''),IF (le.uid <> 0,TRIM((SALT34.StrType)le.uid), ''),TRIM((SALT34.StrType)le.customer_id),TRIM((SALT34.StrType)le.sub_customer_id),TRIM((SALT34.StrType)le.vendor_id),TRIM((SALT34.StrType)le.offender_key),TRIM((SALT34.StrType)le.sub_sub_customer_id),TRIM((SALT34.StrType)le.customer_event_id),TRIM((SALT34.StrType)le.sub_customer_event_id),TRIM((SALT34.StrType)le.sub_sub_customer_event_id),TRIM((SALT34.StrType)le.ln_product_id),TRIM((SALT34.StrType)le.ln_sub_product_id),TRIM((SALT34.StrType)le.ln_sub_sub_product_id),TRIM((SALT34.StrType)le.ln_product_key),TRIM((SALT34.StrType)le.ln_report_date),TRIM((SALT34.StrType)le.ln_report_time),TRIM((SALT34.StrType)le.reported_date),TRIM((SALT34.StrType)le.reported_time),TRIM((SALT34.StrType)le.event_date),TRIM((SALT34.StrType)le.event_end_date),TRIM((SALT34.StrType)le.event_location),TRIM((SALT34.StrType)le.event_type_1),TRIM((SALT34.StrType)le.event_type_2),TRIM((SALT34.StrType)le.event_type_3),IF (le.household_id <> 0,TRIM((SALT34.StrType)le.household_id), ''),TRIM((SALT34.StrType)le.reason_description),TRIM((SALT34.StrType)le.investigation_referral_case_id),TRIM((SALT34.StrType)le.investigation_referral_date_opened),TRIM((SALT34.StrType)le.investigation_referral_date_closed),TRIM((SALT34.StrType)le.customer_fraud_code_1),TRIM((SALT34.StrType)le.customer_fraud_code_2),TRIM((SALT34.StrType)le.type_of_referral),TRIM((SALT34.StrType)le.referral_reason),TRIM((SALT34.StrType)le.disposition),TRIM((SALT34.StrType)le.mitigated),TRIM((SALT34.StrType)le.mitigated_amount),TRIM((SALT34.StrType)le.external_referral_or_casenumber),TRIM((SALT34.StrType)le.fraud_point_score),IF (le.customer_person_id <> 0,TRIM((SALT34.StrType)le.customer_person_id), ''),TRIM((SALT34.StrType)le.raw_title),TRIM((SALT34.StrType)le.raw_first_name),TRIM((SALT34.StrType)le.raw_middle_name),TRIM((SALT34.StrType)le.raw_last_name),TRIM((SALT34.StrType)le.raw_orig_suffix),TRIM((SALT34.StrType)le.raw_full_name),TRIM((SALT34.StrType)le.ssn),TRIM((SALT34.StrType)le.dob),TRIM((SALT34.StrType)le.drivers_license),TRIM((SALT34.StrType)le.drivers_license_state),TRIM((SALT34.StrType)le.person_date),TRIM((SALT34.StrType)le.name_type),TRIM((SALT34.StrType)le.income),TRIM((SALT34.StrType)le.own_or_rent),IF (le.rawlinkid <> 0,TRIM((SALT34.StrType)le.rawlinkid), ''),TRIM((SALT34.StrType)le.street_1),TRIM((SALT34.StrType)le.street_2),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.gps_coordinates),TRIM((SALT34.StrType)le.address_date),TRIM((SALT34.StrType)le.address_type),IF (le.appended_provider_id <> 0,TRIM((SALT34.StrType)le.appended_provider_id), ''),IF (le.lnpid <> 0,TRIM((SALT34.StrType)le.lnpid), ''),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.tin),TRIM((SALT34.StrType)le.fein),TRIM((SALT34.StrType)le.npi),TRIM((SALT34.StrType)le.business_type_1),TRIM((SALT34.StrType)le.business_type_2),TRIM((SALT34.StrType)le.business_date),TRIM((SALT34.StrType)le.phone_number),TRIM((SALT34.StrType)le.cell_phone),TRIM((SALT34.StrType)le.work_phone),TRIM((SALT34.StrType)le.contact_type),TRIM((SALT34.StrType)le.contact_date),TRIM((SALT34.StrType)le.carrier),TRIM((SALT34.StrType)le.contact_location),TRIM((SALT34.StrType)le.contact),TRIM((SALT34.StrType)le.call_records),TRIM((SALT34.StrType)le.in_service),TRIM((SALT34.StrType)le.email_address),TRIM((SALT34.StrType)le.email_address_type),TRIM((SALT34.StrType)le.email_date),TRIM((SALT34.StrType)le.host),TRIM((SALT34.StrType)le.alias),TRIM((SALT34.StrType)le.location),TRIM((SALT34.StrType)le.ip_address),TRIM((SALT34.StrType)le.ip_address_date),TRIM((SALT34.StrType)le.version),TRIM((SALT34.StrType)le.class),TRIM((SALT34.StrType)le.subnet_mask),TRIM((SALT34.StrType)le.reserved),TRIM((SALT34.StrType)le.isp),TRIM((SALT34.StrType)le.device_id),TRIM((SALT34.StrType)le.device_date),TRIM((SALT34.StrType)le.unique_number),TRIM((SALT34.StrType)le.mac_address),TRIM((SALT34.StrType)le.serial_number),TRIM((SALT34.StrType)le.device_type),TRIM((SALT34.StrType)le.device_identification_provider),TRIM((SALT34.StrType)le.transaction_id),TRIM((SALT34.StrType)le.transaction_type),TRIM((SALT34.StrType)le.amount_of_loss),TRIM((SALT34.StrType)le.professional_id),TRIM((SALT34.StrType)le.profession_type),TRIM((SALT34.StrType)le.corresponding_professional_ids),TRIM((SALT34.StrType)le.licensed_pr_state),TRIM((SALT34.StrType)le.source),IF (le.process_date <> 0,TRIM((SALT34.StrType)le.process_date), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.source_rec_id <> 0,TRIM((SALT34.StrType)le.source_rec_id), ''),IF (le.nid <> 0,TRIM((SALT34.StrType)le.nid), ''),IF (le.name_ind <> 0,TRIM((SALT34.StrType)le.name_ind), ''),TRIM((SALT34.StrType)le.address_1),TRIM((SALT34.StrType)le.address_2),IF (le.rawaid <> 0,TRIM((SALT34.StrType)le.rawaid), ''),IF (le.aceaid <> 0,TRIM((SALT34.StrType)le.aceaid), ''),IF (le.address_ind <> 0,TRIM((SALT34.StrType)le.address_ind), ''),IF (le.did <> 0,TRIM((SALT34.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT34.StrType)le.did_score), ''),TRIM((SALT34.StrType)le.clean_business_name),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT34.StrType)le.bdid_score), ''),IF (le.dotid <> 0,TRIM((SALT34.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT34.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT34.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT34.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT34.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT34.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT34.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT34.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT34.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT34.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT34.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT34.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT34.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT34.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT34.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT34.StrType)le.ultweight), ''),IF (le.__internal_fpos__ <> 0,TRIM((SALT34.StrType)le.__internal_fpos__), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),225*225,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'classification_source_source_type'}
      ,{2,'classification_source_primary_source_entity'}
      ,{3,'classification_source_expectation_of_victim_entities'}
      ,{4,'classification_source_industry_segment'}
      ,{5,'classification_activity_suspected_discrepancy'}
      ,{6,'classification_activity_confidence_that_activity_was_deceitful'}
      ,{7,'classification_activity_workflow_stage_committed'}
      ,{8,'classification_activity_workflow_stage_detected'}
      ,{9,'classification_activity_channels'}
      ,{10,'classification_activity_category_or_fraudtype'}
      ,{11,'classification_activity_description'}
      ,{12,'classification_activity_threat'}
      ,{13,'classification_activity_exposure'}
      ,{14,'classification_activity_write_off_loss'}
      ,{15,'classification_activity_mitigated'}
      ,{16,'classification_activity_alert_level'}
      ,{17,'classification_entity_entity_type'}
      ,{18,'classification_entity_entity_sub_type'}
      ,{19,'classification_entity_role'}
      ,{20,'classification_entity_evidence'}
      ,{21,'classification_entity_investigated_count'}
      ,{22,'classification_permissible_use_access_fdn_file_info_id'}
      ,{23,'classification_permissible_use_access_fdn_file_code'}
      ,{24,'classification_permissible_use_access_gc_id'}
      ,{25,'classification_permissible_use_access_file_type'}
      ,{26,'classification_permissible_use_access_description'}
      ,{27,'classification_permissible_use_access_primary_source_entity'}
      ,{28,'classification_permissible_use_access_ind_type'}
      ,{29,'classification_permissible_use_access_ind_type_description'}
      ,{30,'classification_permissible_use_access_update_freq'}
      ,{31,'classification_permissible_use_access_expiration_days'}
      ,{32,'classification_permissible_use_access_post_contract_expiration_days'}
      ,{33,'classification_permissible_use_access_status'}
      ,{34,'classification_permissible_use_access_product_include'}
      ,{35,'classification_permissible_use_access_date_added'}
      ,{36,'classification_permissible_use_access_user_added'}
      ,{37,'classification_permissible_use_access_date_changed'}
      ,{38,'classification_permissible_use_access_user_changed'}
      ,{39,'classification_permissible_use_access_p_industry_segment'}
      ,{40,'classification_permissible_use_access_usage_term'}
      ,{41,'cleaned_name_title'}
      ,{42,'cleaned_name_fname'}
      ,{43,'cleaned_name_mname'}
      ,{44,'cleaned_name_lname'}
      ,{45,'cleaned_name_name_suffix'}
      ,{46,'cleaned_name_name_score'}
      ,{47,'clean_address_prim_range'}
      ,{48,'clean_address_predir'}
      ,{49,'clean_address_prim_name'}
      ,{50,'clean_address_addr_suffix'}
      ,{51,'clean_address_postdir'}
      ,{52,'clean_address_unit_desig'}
      ,{53,'clean_address_sec_range'}
      ,{54,'clean_address_p_city_name'}
      ,{55,'clean_address_v_city_name'}
      ,{56,'clean_address_st'}
      ,{57,'clean_address_zip'}
      ,{58,'clean_address_zip4'}
      ,{59,'clean_address_cart'}
      ,{60,'clean_address_cr_sort_sz'}
      ,{61,'clean_address_lot'}
      ,{62,'clean_address_lot_order'}
      ,{63,'clean_address_dbpc'}
      ,{64,'clean_address_chk_digit'}
      ,{65,'clean_address_rec_type'}
      ,{66,'clean_address_fips_state'}
      ,{67,'clean_address_fips_county'}
      ,{68,'clean_address_geo_lat'}
      ,{69,'clean_address_geo_long'}
      ,{70,'clean_address_msa'}
      ,{71,'clean_address_geo_blk'}
      ,{72,'clean_address_geo_match'}
      ,{73,'clean_address_err_stat'}
      ,{74,'clean_phones_phone_number'}
      ,{75,'clean_phones_cell_phone'}
      ,{76,'clean_phones_work_phone'}
      ,{77,'record_id'}
      ,{78,'uid'}
      ,{79,'customer_id'}
      ,{80,'sub_customer_id'}
      ,{81,'vendor_id'}
      ,{82,'offender_key'}
      ,{83,'sub_sub_customer_id'}
      ,{84,'customer_event_id'}
      ,{85,'sub_customer_event_id'}
      ,{86,'sub_sub_customer_event_id'}
      ,{87,'ln_product_id'}
      ,{88,'ln_sub_product_id'}
      ,{89,'ln_sub_sub_product_id'}
      ,{90,'ln_product_key'}
      ,{91,'ln_report_date'}
      ,{92,'ln_report_time'}
      ,{93,'reported_date'}
      ,{94,'reported_time'}
      ,{95,'event_date'}
      ,{96,'event_end_date'}
      ,{97,'event_location'}
      ,{98,'event_type_1'}
      ,{99,'event_type_2'}
      ,{100,'event_type_3'}
      ,{101,'household_id'}
      ,{102,'reason_description'}
      ,{103,'investigation_referral_case_id'}
      ,{104,'investigation_referral_date_opened'}
      ,{105,'investigation_referral_date_closed'}
      ,{106,'customer_fraud_code_1'}
      ,{107,'customer_fraud_code_2'}
      ,{108,'type_of_referral'}
      ,{109,'referral_reason'}
      ,{110,'disposition'}
      ,{111,'mitigated'}
      ,{112,'mitigated_amount'}
      ,{113,'external_referral_or_casenumber'}
      ,{114,'fraud_point_score'}
      ,{115,'customer_person_id'}
      ,{116,'raw_title'}
      ,{117,'raw_first_name'}
      ,{118,'raw_middle_name'}
      ,{119,'raw_last_name'}
      ,{120,'raw_orig_suffix'}
      ,{121,'raw_full_name'}
      ,{122,'ssn'}
      ,{123,'dob'}
      ,{124,'drivers_license'}
      ,{125,'drivers_license_state'}
      ,{126,'person_date'}
      ,{127,'name_type'}
      ,{128,'income'}
      ,{129,'own_or_rent'}
      ,{130,'rawlinkid'}
      ,{131,'street_1'}
      ,{132,'street_2'}
      ,{133,'city'}
      ,{134,'state'}
      ,{135,'zip'}
      ,{136,'gps_coordinates'}
      ,{137,'address_date'}
      ,{138,'address_type'}
      ,{139,'appended_provider_id'}
      ,{140,'lnpid'}
      ,{141,'business_name'}
      ,{142,'tin'}
      ,{143,'fein'}
      ,{144,'npi'}
      ,{145,'business_type_1'}
      ,{146,'business_type_2'}
      ,{147,'business_date'}
      ,{148,'phone_number'}
      ,{149,'cell_phone'}
      ,{150,'work_phone'}
      ,{151,'contact_type'}
      ,{152,'contact_date'}
      ,{153,'carrier'}
      ,{154,'contact_location'}
      ,{155,'contact'}
      ,{156,'call_records'}
      ,{157,'in_service'}
      ,{158,'email_address'}
      ,{159,'email_address_type'}
      ,{160,'email_date'}
      ,{161,'host'}
      ,{162,'alias'}
      ,{163,'location'}
      ,{164,'ip_address'}
      ,{165,'ip_address_date'}
      ,{166,'version'}
      ,{167,'class'}
      ,{168,'subnet_mask'}
      ,{169,'reserved'}
      ,{170,'isp'}
      ,{171,'device_id'}
      ,{172,'device_date'}
      ,{173,'unique_number'}
      ,{174,'mac_address'}
      ,{175,'serial_number'}
      ,{176,'device_type'}
      ,{177,'device_identification_provider'}
      ,{178,'transaction_id'}
      ,{179,'transaction_type'}
      ,{180,'amount_of_loss'}
      ,{181,'professional_id'}
      ,{182,'profession_type'}
      ,{183,'corresponding_professional_ids'}
      ,{184,'licensed_pr_state'}
      ,{185,'source'}
      ,{186,'process_date'}
      ,{187,'dt_first_seen'}
      ,{188,'dt_last_seen'}
      ,{189,'dt_vendor_last_reported'}
      ,{190,'dt_vendor_first_reported'}
      ,{191,'source_rec_id'}
      ,{192,'nid'}
      ,{193,'name_ind'}
      ,{194,'address_1'}
      ,{195,'address_2'}
      ,{196,'rawaid'}
      ,{197,'aceaid'}
      ,{198,'address_ind'}
      ,{199,'did'}
      ,{200,'did_score'}
      ,{201,'clean_business_name'}
      ,{202,'bdid'}
      ,{203,'bdid_score'}
      ,{204,'dotid'}
      ,{205,'dotscore'}
      ,{206,'dotweight'}
      ,{207,'empid'}
      ,{208,'empscore'}
      ,{209,'empweight'}
      ,{210,'powid'}
      ,{211,'powscore'}
      ,{212,'powweight'}
      ,{213,'proxid'}
      ,{214,'proxscore'}
      ,{215,'proxweight'}
      ,{216,'seleid'}
      ,{217,'selescore'}
      ,{218,'seleweight'}
      ,{219,'orgid'}
      ,{220,'orgscore'}
      ,{221,'orgweight'}
      ,{222,'ultid'}
      ,{223,'ultscore'}
      ,{224,'ultweight'}
      ,{225,'__internal_fpos__'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_classification_source_source_type((SALT34.StrType)le.classification_source_source_type),
    Fields.InValid_classification_source_primary_source_entity((SALT34.StrType)le.classification_source_primary_source_entity),
    Fields.InValid_classification_source_expectation_of_victim_entities((SALT34.StrType)le.classification_source_expectation_of_victim_entities),
    Fields.InValid_classification_source_industry_segment((SALT34.StrType)le.classification_source_industry_segment),
    Fields.InValid_classification_activity_suspected_discrepancy((SALT34.StrType)le.classification_activity_suspected_discrepancy),
    Fields.InValid_classification_activity_confidence_that_activity_was_deceitful((SALT34.StrType)le.classification_activity_confidence_that_activity_was_deceitful),
    Fields.InValid_classification_activity_workflow_stage_committed((SALT34.StrType)le.classification_activity_workflow_stage_committed),
    Fields.InValid_classification_activity_workflow_stage_detected((SALT34.StrType)le.classification_activity_workflow_stage_detected),
    Fields.InValid_classification_activity_channels((SALT34.StrType)le.classification_activity_channels),
    Fields.InValid_classification_activity_category_or_fraudtype((SALT34.StrType)le.classification_activity_category_or_fraudtype),
    Fields.InValid_classification_activity_description((SALT34.StrType)le.classification_activity_description),
    Fields.InValid_classification_activity_threat((SALT34.StrType)le.classification_activity_threat),
    Fields.InValid_classification_activity_exposure((SALT34.StrType)le.classification_activity_exposure),
    Fields.InValid_classification_activity_write_off_loss((SALT34.StrType)le.classification_activity_write_off_loss),
    Fields.InValid_classification_activity_mitigated((SALT34.StrType)le.classification_activity_mitigated),
    Fields.InValid_classification_activity_alert_level((SALT34.StrType)le.classification_activity_alert_level),
    Fields.InValid_classification_entity_entity_type((SALT34.StrType)le.classification_entity_entity_type),
    Fields.InValid_classification_entity_entity_sub_type((SALT34.StrType)le.classification_entity_entity_sub_type),
    Fields.InValid_classification_entity_role((SALT34.StrType)le.classification_entity_role),
    Fields.InValid_classification_entity_evidence((SALT34.StrType)le.classification_entity_evidence),
    Fields.InValid_classification_entity_investigated_count((SALT34.StrType)le.classification_entity_investigated_count),
    Fields.InValid_classification_permissible_use_access_fdn_file_info_id((SALT34.StrType)le.classification_permissible_use_access_fdn_file_info_id),
    Fields.InValid_classification_permissible_use_access_fdn_file_code((SALT34.StrType)le.classification_permissible_use_access_fdn_file_code),
    Fields.InValid_classification_permissible_use_access_gc_id((SALT34.StrType)le.classification_permissible_use_access_gc_id),
    Fields.InValid_classification_permissible_use_access_file_type((SALT34.StrType)le.classification_permissible_use_access_file_type),
    Fields.InValid_classification_permissible_use_access_description((SALT34.StrType)le.classification_permissible_use_access_description),
    Fields.InValid_classification_permissible_use_access_primary_source_entity((SALT34.StrType)le.classification_permissible_use_access_primary_source_entity),
    Fields.InValid_classification_permissible_use_access_ind_type((SALT34.StrType)le.classification_permissible_use_access_ind_type),
    Fields.InValid_classification_permissible_use_access_ind_type_description((SALT34.StrType)le.classification_permissible_use_access_ind_type_description),
    Fields.InValid_classification_permissible_use_access_update_freq((SALT34.StrType)le.classification_permissible_use_access_update_freq),
    Fields.InValid_classification_permissible_use_access_expiration_days((SALT34.StrType)le.classification_permissible_use_access_expiration_days),
    Fields.InValid_classification_permissible_use_access_post_contract_expiration_days((SALT34.StrType)le.classification_permissible_use_access_post_contract_expiration_days),
    Fields.InValid_classification_permissible_use_access_status((SALT34.StrType)le.classification_permissible_use_access_status),
    Fields.InValid_classification_permissible_use_access_product_include((SALT34.StrType)le.classification_permissible_use_access_product_include),
    Fields.InValid_classification_permissible_use_access_date_added((SALT34.StrType)le.classification_permissible_use_access_date_added),
    Fields.InValid_classification_permissible_use_access_user_added((SALT34.StrType)le.classification_permissible_use_access_user_added),
    Fields.InValid_classification_permissible_use_access_date_changed((SALT34.StrType)le.classification_permissible_use_access_date_changed),
    Fields.InValid_classification_permissible_use_access_user_changed((SALT34.StrType)le.classification_permissible_use_access_user_changed),
    Fields.InValid_classification_permissible_use_access_p_industry_segment((SALT34.StrType)le.classification_permissible_use_access_p_industry_segment),
    Fields.InValid_classification_permissible_use_access_usage_term((SALT34.StrType)le.classification_permissible_use_access_usage_term),
    Fields.InValid_cleaned_name_title((SALT34.StrType)le.cleaned_name_title),
    Fields.InValid_cleaned_name_fname((SALT34.StrType)le.cleaned_name_fname),
    Fields.InValid_cleaned_name_mname((SALT34.StrType)le.cleaned_name_mname),
    Fields.InValid_cleaned_name_lname((SALT34.StrType)le.cleaned_name_lname),
    Fields.InValid_cleaned_name_name_suffix((SALT34.StrType)le.cleaned_name_name_suffix),
    Fields.InValid_cleaned_name_name_score((SALT34.StrType)le.cleaned_name_name_score),
    Fields.InValid_clean_address_prim_range((SALT34.StrType)le.clean_address_prim_range),
    Fields.InValid_clean_address_predir((SALT34.StrType)le.clean_address_predir),
    Fields.InValid_clean_address_prim_name((SALT34.StrType)le.clean_address_prim_name),
    Fields.InValid_clean_address_addr_suffix((SALT34.StrType)le.clean_address_addr_suffix),
    Fields.InValid_clean_address_postdir((SALT34.StrType)le.clean_address_postdir),
    Fields.InValid_clean_address_unit_desig((SALT34.StrType)le.clean_address_unit_desig),
    Fields.InValid_clean_address_sec_range((SALT34.StrType)le.clean_address_sec_range),
    Fields.InValid_clean_address_p_city_name((SALT34.StrType)le.clean_address_p_city_name),
    Fields.InValid_clean_address_v_city_name((SALT34.StrType)le.clean_address_v_city_name),
    Fields.InValid_clean_address_st((SALT34.StrType)le.clean_address_st),
    Fields.InValid_clean_address_zip((SALT34.StrType)le.clean_address_zip),
    Fields.InValid_clean_address_zip4((SALT34.StrType)le.clean_address_zip4),
    Fields.InValid_clean_address_cart((SALT34.StrType)le.clean_address_cart),
    Fields.InValid_clean_address_cr_sort_sz((SALT34.StrType)le.clean_address_cr_sort_sz),
    Fields.InValid_clean_address_lot((SALT34.StrType)le.clean_address_lot),
    Fields.InValid_clean_address_lot_order((SALT34.StrType)le.clean_address_lot_order),
    Fields.InValid_clean_address_dbpc((SALT34.StrType)le.clean_address_dbpc),
    Fields.InValid_clean_address_chk_digit((SALT34.StrType)le.clean_address_chk_digit),
    Fields.InValid_clean_address_rec_type((SALT34.StrType)le.clean_address_rec_type),
    Fields.InValid_clean_address_fips_state((SALT34.StrType)le.clean_address_fips_state),
    Fields.InValid_clean_address_fips_county((SALT34.StrType)le.clean_address_fips_county),
    Fields.InValid_clean_address_geo_lat((SALT34.StrType)le.clean_address_geo_lat),
    Fields.InValid_clean_address_geo_long((SALT34.StrType)le.clean_address_geo_long),
    Fields.InValid_clean_address_msa((SALT34.StrType)le.clean_address_msa),
    Fields.InValid_clean_address_geo_blk((SALT34.StrType)le.clean_address_geo_blk),
    Fields.InValid_clean_address_geo_match((SALT34.StrType)le.clean_address_geo_match),
    Fields.InValid_clean_address_err_stat((SALT34.StrType)le.clean_address_err_stat),
    Fields.InValid_clean_phones_phone_number((SALT34.StrType)le.clean_phones_phone_number),
    Fields.InValid_clean_phones_cell_phone((SALT34.StrType)le.clean_phones_cell_phone),
    Fields.InValid_clean_phones_work_phone((SALT34.StrType)le.clean_phones_work_phone),
    Fields.InValid_record_id((SALT34.StrType)le.record_id),
    Fields.InValid_uid((SALT34.StrType)le.uid),
    Fields.InValid_customer_id((SALT34.StrType)le.customer_id),
    Fields.InValid_sub_customer_id((SALT34.StrType)le.sub_customer_id),
    Fields.InValid_vendor_id((SALT34.StrType)le.vendor_id),
    Fields.InValid_offender_key((SALT34.StrType)le.offender_key),
    Fields.InValid_sub_sub_customer_id((SALT34.StrType)le.sub_sub_customer_id),
    Fields.InValid_customer_event_id((SALT34.StrType)le.customer_event_id),
    Fields.InValid_sub_customer_event_id((SALT34.StrType)le.sub_customer_event_id),
    Fields.InValid_sub_sub_customer_event_id((SALT34.StrType)le.sub_sub_customer_event_id),
    Fields.InValid_ln_product_id((SALT34.StrType)le.ln_product_id),
    Fields.InValid_ln_sub_product_id((SALT34.StrType)le.ln_sub_product_id),
    Fields.InValid_ln_sub_sub_product_id((SALT34.StrType)le.ln_sub_sub_product_id),
    Fields.InValid_ln_product_key((SALT34.StrType)le.ln_product_key),
    Fields.InValid_ln_report_date((SALT34.StrType)le.ln_report_date),
    Fields.InValid_ln_report_time((SALT34.StrType)le.ln_report_time),
    Fields.InValid_reported_date((SALT34.StrType)le.reported_date),
    Fields.InValid_reported_time((SALT34.StrType)le.reported_time),
    Fields.InValid_event_date((SALT34.StrType)le.event_date),
    Fields.InValid_event_end_date((SALT34.StrType)le.event_end_date),
    Fields.InValid_event_location((SALT34.StrType)le.event_location),
    Fields.InValid_event_type_1((SALT34.StrType)le.event_type_1),
    Fields.InValid_event_type_2((SALT34.StrType)le.event_type_2),
    Fields.InValid_event_type_3((SALT34.StrType)le.event_type_3),
    Fields.InValid_household_id((SALT34.StrType)le.household_id),
    Fields.InValid_reason_description((SALT34.StrType)le.reason_description),
    Fields.InValid_investigation_referral_case_id((SALT34.StrType)le.investigation_referral_case_id),
    Fields.InValid_investigation_referral_date_opened((SALT34.StrType)le.investigation_referral_date_opened),
    Fields.InValid_investigation_referral_date_closed((SALT34.StrType)le.investigation_referral_date_closed),
    Fields.InValid_customer_fraud_code_1((SALT34.StrType)le.customer_fraud_code_1),
    Fields.InValid_customer_fraud_code_2((SALT34.StrType)le.customer_fraud_code_2),
    Fields.InValid_type_of_referral((SALT34.StrType)le.type_of_referral),
    Fields.InValid_referral_reason((SALT34.StrType)le.referral_reason),
    Fields.InValid_disposition((SALT34.StrType)le.disposition),
    Fields.InValid_mitigated((SALT34.StrType)le.mitigated),
    Fields.InValid_mitigated_amount((SALT34.StrType)le.mitigated_amount),
    Fields.InValid_external_referral_or_casenumber((SALT34.StrType)le.external_referral_or_casenumber),
    Fields.InValid_fraud_point_score((SALT34.StrType)le.fraud_point_score),
    Fields.InValid_customer_person_id((SALT34.StrType)le.customer_person_id),
    Fields.InValid_raw_title((SALT34.StrType)le.raw_title),
    Fields.InValid_raw_first_name((SALT34.StrType)le.raw_first_name),
    Fields.InValid_raw_middle_name((SALT34.StrType)le.raw_middle_name),
    Fields.InValid_raw_last_name((SALT34.StrType)le.raw_last_name),
    Fields.InValid_raw_orig_suffix((SALT34.StrType)le.raw_orig_suffix),
    Fields.InValid_raw_full_name((SALT34.StrType)le.raw_full_name),
    Fields.InValid_ssn((SALT34.StrType)le.ssn),
    Fields.InValid_dob((SALT34.StrType)le.dob),
    Fields.InValid_drivers_license((SALT34.StrType)le.drivers_license),
    Fields.InValid_drivers_license_state((SALT34.StrType)le.drivers_license_state),
    Fields.InValid_person_date((SALT34.StrType)le.person_date),
    Fields.InValid_name_type((SALT34.StrType)le.name_type),
    Fields.InValid_income((SALT34.StrType)le.income),
    Fields.InValid_own_or_rent((SALT34.StrType)le.own_or_rent),
    Fields.InValid_rawlinkid((SALT34.StrType)le.rawlinkid),
    Fields.InValid_street_1((SALT34.StrType)le.street_1),
    Fields.InValid_street_2((SALT34.StrType)le.street_2),
    Fields.InValid_city((SALT34.StrType)le.city),
    Fields.InValid_state((SALT34.StrType)le.state),
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_gps_coordinates((SALT34.StrType)le.gps_coordinates),
    Fields.InValid_address_date((SALT34.StrType)le.address_date),
    Fields.InValid_address_type((SALT34.StrType)le.address_type),
    Fields.InValid_appended_provider_id((SALT34.StrType)le.appended_provider_id),
    Fields.InValid_lnpid((SALT34.StrType)le.lnpid),
    Fields.InValid_business_name((SALT34.StrType)le.business_name),
    Fields.InValid_tin((SALT34.StrType)le.tin),
    Fields.InValid_fein((SALT34.StrType)le.fein),
    Fields.InValid_npi((SALT34.StrType)le.npi),
    Fields.InValid_business_type_1((SALT34.StrType)le.business_type_1),
    Fields.InValid_business_type_2((SALT34.StrType)le.business_type_2),
    Fields.InValid_business_date((SALT34.StrType)le.business_date),
    Fields.InValid_phone_number((SALT34.StrType)le.phone_number),
    Fields.InValid_cell_phone((SALT34.StrType)le.cell_phone),
    Fields.InValid_work_phone((SALT34.StrType)le.work_phone),
    Fields.InValid_contact_type((SALT34.StrType)le.contact_type),
    Fields.InValid_contact_date((SALT34.StrType)le.contact_date),
    Fields.InValid_carrier((SALT34.StrType)le.carrier),
    Fields.InValid_contact_location((SALT34.StrType)le.contact_location),
    Fields.InValid_contact((SALT34.StrType)le.contact),
    Fields.InValid_call_records((SALT34.StrType)le.call_records),
    Fields.InValid_in_service((SALT34.StrType)le.in_service),
    Fields.InValid_email_address((SALT34.StrType)le.email_address),
    Fields.InValid_email_address_type((SALT34.StrType)le.email_address_type),
    Fields.InValid_email_date((SALT34.StrType)le.email_date),
    Fields.InValid_host((SALT34.StrType)le.host),
    Fields.InValid_alias((SALT34.StrType)le.alias),
    Fields.InValid_location((SALT34.StrType)le.location),
    Fields.InValid_ip_address((SALT34.StrType)le.ip_address),
    Fields.InValid_ip_address_date((SALT34.StrType)le.ip_address_date),
    Fields.InValid_version((SALT34.StrType)le.version),
    Fields.InValid_class((SALT34.StrType)le.class),
    Fields.InValid_subnet_mask((SALT34.StrType)le.subnet_mask),
    Fields.InValid_reserved((SALT34.StrType)le.reserved),
    Fields.InValid_isp((SALT34.StrType)le.isp),
    Fields.InValid_device_id((SALT34.StrType)le.device_id),
    Fields.InValid_device_date((SALT34.StrType)le.device_date),
    Fields.InValid_unique_number((SALT34.StrType)le.unique_number),
    Fields.InValid_mac_address((SALT34.StrType)le.mac_address),
    Fields.InValid_serial_number((SALT34.StrType)le.serial_number),
    Fields.InValid_device_type((SALT34.StrType)le.device_type),
    Fields.InValid_device_identification_provider((SALT34.StrType)le.device_identification_provider),
    Fields.InValid_transaction_id((SALT34.StrType)le.transaction_id),
    Fields.InValid_transaction_type((SALT34.StrType)le.transaction_type),
    Fields.InValid_amount_of_loss((SALT34.StrType)le.amount_of_loss),
    Fields.InValid_professional_id((SALT34.StrType)le.professional_id),
    Fields.InValid_profession_type((SALT34.StrType)le.profession_type),
    Fields.InValid_corresponding_professional_ids((SALT34.StrType)le.corresponding_professional_ids),
    Fields.InValid_licensed_pr_state((SALT34.StrType)le.licensed_pr_state),
    Fields.InValid_source((SALT34.StrType)le.source),
    Fields.InValid_process_date((SALT34.StrType)le.process_date),
    Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Fields.InValid_source_rec_id((SALT34.StrType)le.source_rec_id),
    Fields.InValid_nid((SALT34.StrType)le.nid),
    Fields.InValid_name_ind((SALT34.StrType)le.name_ind),
    Fields.InValid_address_1((SALT34.StrType)le.address_1),
    Fields.InValid_address_2((SALT34.StrType)le.address_2),
    Fields.InValid_rawaid((SALT34.StrType)le.rawaid),
    Fields.InValid_aceaid((SALT34.StrType)le.aceaid),
    Fields.InValid_address_ind((SALT34.StrType)le.address_ind),
    Fields.InValid_did((SALT34.StrType)le.did),
    Fields.InValid_did_score((SALT34.StrType)le.did_score),
    Fields.InValid_clean_business_name((SALT34.StrType)le.clean_business_name),
    Fields.InValid_bdid((SALT34.StrType)le.bdid),
    Fields.InValid_bdid_score((SALT34.StrType)le.bdid_score),
    Fields.InValid_dotid((SALT34.StrType)le.dotid),
    Fields.InValid_dotscore((SALT34.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT34.StrType)le.dotweight),
    Fields.InValid_empid((SALT34.StrType)le.empid),
    Fields.InValid_empscore((SALT34.StrType)le.empscore),
    Fields.InValid_empweight((SALT34.StrType)le.empweight),
    Fields.InValid_powid((SALT34.StrType)le.powid),
    Fields.InValid_powscore((SALT34.StrType)le.powscore),
    Fields.InValid_powweight((SALT34.StrType)le.powweight),
    Fields.InValid_proxid((SALT34.StrType)le.proxid),
    Fields.InValid_proxscore((SALT34.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT34.StrType)le.proxweight),
    Fields.InValid_seleid((SALT34.StrType)le.seleid),
    Fields.InValid_selescore((SALT34.StrType)le.selescore),
    Fields.InValid_seleweight((SALT34.StrType)le.seleweight),
    Fields.InValid_orgid((SALT34.StrType)le.orgid),
    Fields.InValid_orgscore((SALT34.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT34.StrType)le.orgweight),
    Fields.InValid_ultid((SALT34.StrType)le.ultid),
    Fields.InValid_ultscore((SALT34.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT34.StrType)le.ultweight),
    Fields.InValid___internal_fpos__((SALT34.StrType)le.__internal_fpos__),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,225,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_classification_source_source_type(TotalErrors.ErrorNum),Fields.InValidMessage_classification_source_primary_source_entity(TotalErrors.ErrorNum),Fields.InValidMessage_classification_source_expectation_of_victim_entities(TotalErrors.ErrorNum),Fields.InValidMessage_classification_source_industry_segment(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_suspected_discrepancy(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_confidence_that_activity_was_deceitful(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_workflow_stage_committed(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_workflow_stage_detected(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_channels(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_category_or_fraudtype(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_description(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_threat(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_exposure(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_write_off_loss(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_mitigated(TotalErrors.ErrorNum),Fields.InValidMessage_classification_activity_alert_level(TotalErrors.ErrorNum),Fields.InValidMessage_classification_entity_entity_type(TotalErrors.ErrorNum),Fields.InValidMessage_classification_entity_entity_sub_type(TotalErrors.ErrorNum),Fields.InValidMessage_classification_entity_role(TotalErrors.ErrorNum),Fields.InValidMessage_classification_entity_evidence(TotalErrors.ErrorNum),Fields.InValidMessage_classification_entity_investigated_count(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_fdn_file_info_id(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_fdn_file_code(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_gc_id(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_file_type(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_description(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_primary_source_entity(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_ind_type(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_ind_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_update_freq(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_expiration_days(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_post_contract_expiration_days(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_status(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_product_include(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_user_added(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_date_changed(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_user_changed(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_p_industry_segment(TotalErrors.ErrorNum),Fields.InValidMessage_classification_permissible_use_access_usage_term(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_title(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_fname(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_mname(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_lname(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cleaned_name_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_address_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phones_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phones_cell_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phones_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_uid(TotalErrors.ErrorNum),Fields.InValidMessage_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_sub_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Fields.InValidMessage_offender_key(TotalErrors.ErrorNum),Fields.InValidMessage_sub_sub_customer_id(TotalErrors.ErrorNum),Fields.InValidMessage_customer_event_id(TotalErrors.ErrorNum),Fields.InValidMessage_sub_customer_event_id(TotalErrors.ErrorNum),Fields.InValidMessage_sub_sub_customer_event_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_sub_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_sub_sub_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_product_key(TotalErrors.ErrorNum),Fields.InValidMessage_ln_report_date(TotalErrors.ErrorNum),Fields.InValidMessage_ln_report_time(TotalErrors.ErrorNum),Fields.InValidMessage_reported_date(TotalErrors.ErrorNum),Fields.InValidMessage_reported_time(TotalErrors.ErrorNum),Fields.InValidMessage_event_date(TotalErrors.ErrorNum),Fields.InValidMessage_event_end_date(TotalErrors.ErrorNum),Fields.InValidMessage_event_location(TotalErrors.ErrorNum),Fields.InValidMessage_event_type_1(TotalErrors.ErrorNum),Fields.InValidMessage_event_type_2(TotalErrors.ErrorNum),Fields.InValidMessage_event_type_3(TotalErrors.ErrorNum),Fields.InValidMessage_household_id(TotalErrors.ErrorNum),Fields.InValidMessage_reason_description(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_referral_case_id(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_referral_date_opened(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_referral_date_closed(TotalErrors.ErrorNum),Fields.InValidMessage_customer_fraud_code_1(TotalErrors.ErrorNum),Fields.InValidMessage_customer_fraud_code_2(TotalErrors.ErrorNum),Fields.InValidMessage_type_of_referral(TotalErrors.ErrorNum),Fields.InValidMessage_referral_reason(TotalErrors.ErrorNum),Fields.InValidMessage_disposition(TotalErrors.ErrorNum),Fields.InValidMessage_mitigated(TotalErrors.ErrorNum),Fields.InValidMessage_mitigated_amount(TotalErrors.ErrorNum),Fields.InValidMessage_external_referral_or_casenumber(TotalErrors.ErrorNum),Fields.InValidMessage_fraud_point_score(TotalErrors.ErrorNum),Fields.InValidMessage_customer_person_id(TotalErrors.ErrorNum),Fields.InValidMessage_raw_title(TotalErrors.ErrorNum),Fields.InValidMessage_raw_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_raw_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_raw_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_raw_orig_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_raw_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_state(TotalErrors.ErrorNum),Fields.InValidMessage_person_date(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_income(TotalErrors.ErrorNum),Fields.InValidMessage_own_or_rent(TotalErrors.ErrorNum),Fields.InValidMessage_rawlinkid(TotalErrors.ErrorNum),Fields.InValidMessage_street_1(TotalErrors.ErrorNum),Fields.InValidMessage_street_2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_gps_coordinates(TotalErrors.ErrorNum),Fields.InValidMessage_address_date(TotalErrors.ErrorNum),Fields.InValidMessage_address_type(TotalErrors.ErrorNum),Fields.InValidMessage_appended_provider_id(TotalErrors.ErrorNum),Fields.InValidMessage_lnpid(TotalErrors.ErrorNum),Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_tin(TotalErrors.ErrorNum),Fields.InValidMessage_fein(TotalErrors.ErrorNum),Fields.InValidMessage_npi(TotalErrors.ErrorNum),Fields.InValidMessage_business_type_1(TotalErrors.ErrorNum),Fields.InValidMessage_business_type_2(TotalErrors.ErrorNum),Fields.InValidMessage_business_date(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_cell_phone(TotalErrors.ErrorNum),Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),Fields.InValidMessage_contact_type(TotalErrors.ErrorNum),Fields.InValidMessage_contact_date(TotalErrors.ErrorNum),Fields.InValidMessage_carrier(TotalErrors.ErrorNum),Fields.InValidMessage_contact_location(TotalErrors.ErrorNum),Fields.InValidMessage_contact(TotalErrors.ErrorNum),Fields.InValidMessage_call_records(TotalErrors.ErrorNum),Fields.InValidMessage_in_service(TotalErrors.ErrorNum),Fields.InValidMessage_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_email_address_type(TotalErrors.ErrorNum),Fields.InValidMessage_email_date(TotalErrors.ErrorNum),Fields.InValidMessage_host(TotalErrors.ErrorNum),Fields.InValidMessage_alias(TotalErrors.ErrorNum),Fields.InValidMessage_location(TotalErrors.ErrorNum),Fields.InValidMessage_ip_address(TotalErrors.ErrorNum),Fields.InValidMessage_ip_address_date(TotalErrors.ErrorNum),Fields.InValidMessage_version(TotalErrors.ErrorNum),Fields.InValidMessage_class(TotalErrors.ErrorNum),Fields.InValidMessage_subnet_mask(TotalErrors.ErrorNum),Fields.InValidMessage_reserved(TotalErrors.ErrorNum),Fields.InValidMessage_isp(TotalErrors.ErrorNum),Fields.InValidMessage_device_id(TotalErrors.ErrorNum),Fields.InValidMessage_device_date(TotalErrors.ErrorNum),Fields.InValidMessage_unique_number(TotalErrors.ErrorNum),Fields.InValidMessage_mac_address(TotalErrors.ErrorNum),Fields.InValidMessage_serial_number(TotalErrors.ErrorNum),Fields.InValidMessage_device_type(TotalErrors.ErrorNum),Fields.InValidMessage_device_identification_provider(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_type(TotalErrors.ErrorNum),Fields.InValidMessage_amount_of_loss(TotalErrors.ErrorNum),Fields.InValidMessage_professional_id(TotalErrors.ErrorNum),Fields.InValidMessage_profession_type(TotalErrors.ErrorNum),Fields.InValidMessage_corresponding_professional_ids(TotalErrors.ErrorNum),Fields.InValidMessage_licensed_pr_state(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Fields.InValidMessage_nid(TotalErrors.ErrorNum),Fields.InValidMessage_name_ind(TotalErrors.ErrorNum),Fields.InValidMessage_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_address_ind(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_business_name(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage___internal_fpos__(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
