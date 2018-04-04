IMPORT SALT39,STD;
EXPORT MBS_hygiene(dataset(MBS_layout_MBS) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fdn_file_info_id_cnt := COUNT(GROUP,h.fdn_file_info_id <> (TYPEOF(h.fdn_file_info_id))'');
    populated_fdn_file_info_id_pcnt := AVE(GROUP,IF(h.fdn_file_info_id = (TYPEOF(h.fdn_file_info_id))'',0,100));
    maxlength_fdn_file_info_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_info_id)));
    avelength_fdn_file_info_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_info_id)),h.fdn_file_info_id<>(typeof(h.fdn_file_info_id))'');
    populated_fdn_file_code_cnt := COUNT(GROUP,h.fdn_file_code <> (TYPEOF(h.fdn_file_code))'');
    populated_fdn_file_code_pcnt := AVE(GROUP,IF(h.fdn_file_code = (TYPEOF(h.fdn_file_code))'',0,100));
    maxlength_fdn_file_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_code)));
    avelength_fdn_file_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_code)),h.fdn_file_code<>(typeof(h.fdn_file_code))'');
    populated_gc_id_cnt := COUNT(GROUP,h.gc_id <> (TYPEOF(h.gc_id))'');
    populated_gc_id_pcnt := AVE(GROUP,IF(h.gc_id = (TYPEOF(h.gc_id))'',0,100));
    maxlength_gc_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)));
    avelength_gc_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)),h.gc_id<>(typeof(h.gc_id))'');
    populated_file_type_cnt := COUNT(GROUP,h.file_type <> (TYPEOF(h.file_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_description_cnt := COUNT(GROUP,h.description <> (TYPEOF(h.description))'');
    populated_description_pcnt := AVE(GROUP,IF(h.description = (TYPEOF(h.description))'',0,100));
    maxlength_description := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.description)));
    avelength_description := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.description)),h.description<>(typeof(h.description))'');
    populated_primary_source_entity_cnt := COUNT(GROUP,h.primary_source_entity <> (TYPEOF(h.primary_source_entity))'');
    populated_primary_source_entity_pcnt := AVE(GROUP,IF(h.primary_source_entity = (TYPEOF(h.primary_source_entity))'',0,100));
    maxlength_primary_source_entity := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary_source_entity)));
    avelength_primary_source_entity := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.primary_source_entity)),h.primary_source_entity<>(typeof(h.primary_source_entity))'');
    populated_ind_type_cnt := COUNT(GROUP,h.ind_type <> (TYPEOF(h.ind_type))'');
    populated_ind_type_pcnt := AVE(GROUP,IF(h.ind_type = (TYPEOF(h.ind_type))'',0,100));
    maxlength_ind_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ind_type)));
    avelength_ind_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ind_type)),h.ind_type<>(typeof(h.ind_type))'');
    populated_update_freq_cnt := COUNT(GROUP,h.update_freq <> (TYPEOF(h.update_freq))'');
    populated_update_freq_pcnt := AVE(GROUP,IF(h.update_freq = (TYPEOF(h.update_freq))'',0,100));
    maxlength_update_freq := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.update_freq)));
    avelength_update_freq := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.update_freq)),h.update_freq<>(typeof(h.update_freq))'');
    populated_expiration_days_cnt := COUNT(GROUP,h.expiration_days <> (TYPEOF(h.expiration_days))'');
    populated_expiration_days_pcnt := AVE(GROUP,IF(h.expiration_days = (TYPEOF(h.expiration_days))'',0,100));
    maxlength_expiration_days := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.expiration_days)));
    avelength_expiration_days := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.expiration_days)),h.expiration_days<>(typeof(h.expiration_days))'');
    populated_post_contract_expiration_days_cnt := COUNT(GROUP,h.post_contract_expiration_days <> (TYPEOF(h.post_contract_expiration_days))'');
    populated_post_contract_expiration_days_pcnt := AVE(GROUP,IF(h.post_contract_expiration_days = (TYPEOF(h.post_contract_expiration_days))'',0,100));
    maxlength_post_contract_expiration_days := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.post_contract_expiration_days)));
    avelength_post_contract_expiration_days := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.post_contract_expiration_days)),h.post_contract_expiration_days<>(typeof(h.post_contract_expiration_days))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_product_include_cnt := COUNT(GROUP,h.product_include <> (TYPEOF(h.product_include))'');
    populated_product_include_pcnt := AVE(GROUP,IF(h.product_include = (TYPEOF(h.product_include))'',0,100));
    maxlength_product_include := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.product_include)));
    avelength_product_include := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.product_include)),h.product_include<>(typeof(h.product_include))'');
    populated_expectation_of_victim_entities_cnt := COUNT(GROUP,h.expectation_of_victim_entities <> (TYPEOF(h.expectation_of_victim_entities))'');
    populated_expectation_of_victim_entities_pcnt := AVE(GROUP,IF(h.expectation_of_victim_entities = (TYPEOF(h.expectation_of_victim_entities))'',0,100));
    maxlength_expectation_of_victim_entities := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.expectation_of_victim_entities)));
    avelength_expectation_of_victim_entities := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.expectation_of_victim_entities)),h.expectation_of_victim_entities<>(typeof(h.expectation_of_victim_entities))'');
    populated_suspected_discrepancy_cnt := COUNT(GROUP,h.suspected_discrepancy <> (TYPEOF(h.suspected_discrepancy))'');
    populated_suspected_discrepancy_pcnt := AVE(GROUP,IF(h.suspected_discrepancy = (TYPEOF(h.suspected_discrepancy))'',0,100));
    maxlength_suspected_discrepancy := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.suspected_discrepancy)));
    avelength_suspected_discrepancy := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.suspected_discrepancy)),h.suspected_discrepancy<>(typeof(h.suspected_discrepancy))'');
    populated_confidence_that_activity_was_deceitful_cnt := COUNT(GROUP,h.confidence_that_activity_was_deceitful <> (TYPEOF(h.confidence_that_activity_was_deceitful))'');
    populated_confidence_that_activity_was_deceitful_pcnt := AVE(GROUP,IF(h.confidence_that_activity_was_deceitful = (TYPEOF(h.confidence_that_activity_was_deceitful))'',0,100));
    maxlength_confidence_that_activity_was_deceitful := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.confidence_that_activity_was_deceitful)));
    avelength_confidence_that_activity_was_deceitful := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.confidence_that_activity_was_deceitful)),h.confidence_that_activity_was_deceitful<>(typeof(h.confidence_that_activity_was_deceitful))'');
    populated_workflow_stage_committed_cnt := COUNT(GROUP,h.workflow_stage_committed <> (TYPEOF(h.workflow_stage_committed))'');
    populated_workflow_stage_committed_pcnt := AVE(GROUP,IF(h.workflow_stage_committed = (TYPEOF(h.workflow_stage_committed))'',0,100));
    maxlength_workflow_stage_committed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.workflow_stage_committed)));
    avelength_workflow_stage_committed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.workflow_stage_committed)),h.workflow_stage_committed<>(typeof(h.workflow_stage_committed))'');
    populated_workflow_stage_detected_cnt := COUNT(GROUP,h.workflow_stage_detected <> (TYPEOF(h.workflow_stage_detected))'');
    populated_workflow_stage_detected_pcnt := AVE(GROUP,IF(h.workflow_stage_detected = (TYPEOF(h.workflow_stage_detected))'',0,100));
    maxlength_workflow_stage_detected := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.workflow_stage_detected)));
    avelength_workflow_stage_detected := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.workflow_stage_detected)),h.workflow_stage_detected<>(typeof(h.workflow_stage_detected))'');
    populated_channels_cnt := COUNT(GROUP,h.channels <> (TYPEOF(h.channels))'');
    populated_channels_pcnt := AVE(GROUP,IF(h.channels = (TYPEOF(h.channels))'',0,100));
    maxlength_channels := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.channels)));
    avelength_channels := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.channels)),h.channels<>(typeof(h.channels))'');
    populated_threat_cnt := COUNT(GROUP,h.threat <> (TYPEOF(h.threat))'');
    populated_threat_pcnt := AVE(GROUP,IF(h.threat = (TYPEOF(h.threat))'',0,100));
    maxlength_threat := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.threat)));
    avelength_threat := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.threat)),h.threat<>(typeof(h.threat))'');
    populated_alert_level_cnt := COUNT(GROUP,h.alert_level <> (TYPEOF(h.alert_level))'');
    populated_alert_level_pcnt := AVE(GROUP,IF(h.alert_level = (TYPEOF(h.alert_level))'',0,100));
    maxlength_alert_level := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.alert_level)));
    avelength_alert_level := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.alert_level)),h.alert_level<>(typeof(h.alert_level))'');
    populated_entity_type_cnt := COUNT(GROUP,h.entity_type <> (TYPEOF(h.entity_type))'');
    populated_entity_type_pcnt := AVE(GROUP,IF(h.entity_type = (TYPEOF(h.entity_type))'',0,100));
    maxlength_entity_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type)));
    avelength_entity_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_type)),h.entity_type<>(typeof(h.entity_type))'');
    populated_entity_sub_type_cnt := COUNT(GROUP,h.entity_sub_type <> (TYPEOF(h.entity_sub_type))'');
    populated_entity_sub_type_pcnt := AVE(GROUP,IF(h.entity_sub_type = (TYPEOF(h.entity_sub_type))'',0,100));
    maxlength_entity_sub_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_sub_type)));
    avelength_entity_sub_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.entity_sub_type)),h.entity_sub_type<>(typeof(h.entity_sub_type))'');
    populated_role_cnt := COUNT(GROUP,h.role <> (TYPEOF(h.role))'');
    populated_role_pcnt := AVE(GROUP,IF(h.role = (TYPEOF(h.role))'',0,100));
    maxlength_role := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.role)));
    avelength_role := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.role)),h.role<>(typeof(h.role))'');
    populated_evidence_cnt := COUNT(GROUP,h.evidence <> (TYPEOF(h.evidence))'');
    populated_evidence_pcnt := AVE(GROUP,IF(h.evidence = (TYPEOF(h.evidence))'',0,100));
    maxlength_evidence := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.evidence)));
    avelength_evidence := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.evidence)),h.evidence<>(typeof(h.evidence))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_user_added_cnt := COUNT(GROUP,h.user_added <> (TYPEOF(h.user_added))'');
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
    populated_date_changed_cnt := COUNT(GROUP,h.date_changed <> (TYPEOF(h.date_changed))'');
    populated_date_changed_pcnt := AVE(GROUP,IF(h.date_changed = (TYPEOF(h.date_changed))'',0,100));
    maxlength_date_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)));
    avelength_date_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)),h.date_changed<>(typeof(h.date_changed))'');
    populated_user_changed_cnt := COUNT(GROUP,h.user_changed <> (TYPEOF(h.user_changed))'');
    populated_user_changed_pcnt := AVE(GROUP,IF(h.user_changed = (TYPEOF(h.user_changed))'',0,100));
    maxlength_user_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)));
    avelength_user_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)),h.user_changed<>(typeof(h.user_changed))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fdn_file_info_id_pcnt *   0.00 / 100 + T.Populated_fdn_file_code_pcnt *   0.00 / 100 + T.Populated_gc_id_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100 + T.Populated_primary_source_entity_pcnt *   0.00 / 100 + T.Populated_ind_type_pcnt *   0.00 / 100 + T.Populated_update_freq_pcnt *   0.00 / 100 + T.Populated_expiration_days_pcnt *   0.00 / 100 + T.Populated_post_contract_expiration_days_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_product_include_pcnt *   0.00 / 100 + T.Populated_expectation_of_victim_entities_pcnt *   0.00 / 100 + T.Populated_suspected_discrepancy_pcnt *   0.00 / 100 + T.Populated_confidence_that_activity_was_deceitful_pcnt *   0.00 / 100 + T.Populated_workflow_stage_committed_pcnt *   0.00 / 100 + T.Populated_workflow_stage_detected_pcnt *   0.00 / 100 + T.Populated_channels_pcnt *   0.00 / 100 + T.Populated_threat_pcnt *   0.00 / 100 + T.Populated_alert_level_pcnt *   0.00 / 100 + T.Populated_entity_type_pcnt *   0.00 / 100 + T.Populated_entity_sub_type_pcnt *   0.00 / 100 + T.Populated_role_pcnt *   0.00 / 100 + T.Populated_evidence_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100 + T.Populated_date_changed_pcnt *   0.00 / 100 + T.Populated_user_changed_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'fdn_file_info_id','fdn_file_code','gc_id','file_type','description','primary_source_entity','ind_type','update_freq','expiration_days','post_contract_expiration_days','status','product_include','expectation_of_victim_entities','suspected_discrepancy','confidence_that_activity_was_deceitful','workflow_stage_committed','workflow_stage_detected','channels','threat','alert_level','entity_type','entity_sub_type','role','evidence','date_added','user_added','date_changed','user_changed');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fdn_file_info_id_pcnt,le.populated_fdn_file_code_pcnt,le.populated_gc_id_pcnt,le.populated_file_type_pcnt,le.populated_description_pcnt,le.populated_primary_source_entity_pcnt,le.populated_ind_type_pcnt,le.populated_update_freq_pcnt,le.populated_expiration_days_pcnt,le.populated_post_contract_expiration_days_pcnt,le.populated_status_pcnt,le.populated_product_include_pcnt,le.populated_expectation_of_victim_entities_pcnt,le.populated_suspected_discrepancy_pcnt,le.populated_confidence_that_activity_was_deceitful_pcnt,le.populated_workflow_stage_committed_pcnt,le.populated_workflow_stage_detected_pcnt,le.populated_channels_pcnt,le.populated_threat_pcnt,le.populated_alert_level_pcnt,le.populated_entity_type_pcnt,le.populated_entity_sub_type_pcnt,le.populated_role_pcnt,le.populated_evidence_pcnt,le.populated_date_added_pcnt,le.populated_user_added_pcnt,le.populated_date_changed_pcnt,le.populated_user_changed_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fdn_file_info_id,le.maxlength_fdn_file_code,le.maxlength_gc_id,le.maxlength_file_type,le.maxlength_description,le.maxlength_primary_source_entity,le.maxlength_ind_type,le.maxlength_update_freq,le.maxlength_expiration_days,le.maxlength_post_contract_expiration_days,le.maxlength_status,le.maxlength_product_include,le.maxlength_expectation_of_victim_entities,le.maxlength_suspected_discrepancy,le.maxlength_confidence_that_activity_was_deceitful,le.maxlength_workflow_stage_committed,le.maxlength_workflow_stage_detected,le.maxlength_channels,le.maxlength_threat,le.maxlength_alert_level,le.maxlength_entity_type,le.maxlength_entity_sub_type,le.maxlength_role,le.maxlength_evidence,le.maxlength_date_added,le.maxlength_user_added,le.maxlength_date_changed,le.maxlength_user_changed);
  SELF.avelength := CHOOSE(C,le.avelength_fdn_file_info_id,le.avelength_fdn_file_code,le.avelength_gc_id,le.avelength_file_type,le.avelength_description,le.avelength_primary_source_entity,le.avelength_ind_type,le.avelength_update_freq,le.avelength_expiration_days,le.avelength_post_contract_expiration_days,le.avelength_status,le.avelength_product_include,le.avelength_expectation_of_victim_entities,le.avelength_suspected_discrepancy,le.avelength_confidence_that_activity_was_deceitful,le.avelength_workflow_stage_committed,le.avelength_workflow_stage_detected,le.avelength_channels,le.avelength_threat,le.avelength_alert_level,le.avelength_entity_type,le.avelength_entity_sub_type,le.avelength_role,le.avelength_evidence,le.avelength_date_added,le.avelength_user_added,le.avelength_date_changed,le.avelength_user_changed);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),TRIM((SALT39.StrType)le.fdn_file_code),IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.file_type <> 0,TRIM((SALT39.StrType)le.file_type), ''),TRIM((SALT39.StrType)le.description),IF (le.primary_source_entity <> 0,TRIM((SALT39.StrType)le.primary_source_entity), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.update_freq <> 0,TRIM((SALT39.StrType)le.update_freq), ''),IF (le.expiration_days <> 0,TRIM((SALT39.StrType)le.expiration_days), ''),IF (le.post_contract_expiration_days <> 0,TRIM((SALT39.StrType)le.post_contract_expiration_days), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),IF (le.product_include <> 0,TRIM((SALT39.StrType)le.product_include), ''),IF (le.expectation_of_victim_entities <> 0,TRIM((SALT39.StrType)le.expectation_of_victim_entities), ''),IF (le.suspected_discrepancy <> 0,TRIM((SALT39.StrType)le.suspected_discrepancy), ''),IF (le.confidence_that_activity_was_deceitful <> 0,TRIM((SALT39.StrType)le.confidence_that_activity_was_deceitful), ''),IF (le.workflow_stage_committed <> 0,TRIM((SALT39.StrType)le.workflow_stage_committed), ''),IF (le.workflow_stage_detected <> 0,TRIM((SALT39.StrType)le.workflow_stage_detected), ''),IF (le.channels <> 0,TRIM((SALT39.StrType)le.channels), ''),IF (le.threat <> 0,TRIM((SALT39.StrType)le.threat), ''),IF (le.alert_level <> 0,TRIM((SALT39.StrType)le.alert_level), ''),IF (le.entity_type <> 0,TRIM((SALT39.StrType)le.entity_type), ''),IF (le.entity_sub_type <> 0,TRIM((SALT39.StrType)le.entity_sub_type), ''),IF (le.role <> 0,TRIM((SALT39.StrType)le.role), ''),IF (le.evidence <> 0,TRIM((SALT39.StrType)le.evidence), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),TRIM((SALT39.StrType)le.fdn_file_code),IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.file_type <> 0,TRIM((SALT39.StrType)le.file_type), ''),TRIM((SALT39.StrType)le.description),IF (le.primary_source_entity <> 0,TRIM((SALT39.StrType)le.primary_source_entity), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.update_freq <> 0,TRIM((SALT39.StrType)le.update_freq), ''),IF (le.expiration_days <> 0,TRIM((SALT39.StrType)le.expiration_days), ''),IF (le.post_contract_expiration_days <> 0,TRIM((SALT39.StrType)le.post_contract_expiration_days), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),IF (le.product_include <> 0,TRIM((SALT39.StrType)le.product_include), ''),IF (le.expectation_of_victim_entities <> 0,TRIM((SALT39.StrType)le.expectation_of_victim_entities), ''),IF (le.suspected_discrepancy <> 0,TRIM((SALT39.StrType)le.suspected_discrepancy), ''),IF (le.confidence_that_activity_was_deceitful <> 0,TRIM((SALT39.StrType)le.confidence_that_activity_was_deceitful), ''),IF (le.workflow_stage_committed <> 0,TRIM((SALT39.StrType)le.workflow_stage_committed), ''),IF (le.workflow_stage_detected <> 0,TRIM((SALT39.StrType)le.workflow_stage_detected), ''),IF (le.channels <> 0,TRIM((SALT39.StrType)le.channels), ''),IF (le.threat <> 0,TRIM((SALT39.StrType)le.threat), ''),IF (le.alert_level <> 0,TRIM((SALT39.StrType)le.alert_level), ''),IF (le.entity_type <> 0,TRIM((SALT39.StrType)le.entity_type), ''),IF (le.entity_sub_type <> 0,TRIM((SALT39.StrType)le.entity_sub_type), ''),IF (le.role <> 0,TRIM((SALT39.StrType)le.role), ''),IF (le.evidence <> 0,TRIM((SALT39.StrType)le.evidence), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),TRIM((SALT39.StrType)le.fdn_file_code),IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.file_type <> 0,TRIM((SALT39.StrType)le.file_type), ''),TRIM((SALT39.StrType)le.description),IF (le.primary_source_entity <> 0,TRIM((SALT39.StrType)le.primary_source_entity), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.update_freq <> 0,TRIM((SALT39.StrType)le.update_freq), ''),IF (le.expiration_days <> 0,TRIM((SALT39.StrType)le.expiration_days), ''),IF (le.post_contract_expiration_days <> 0,TRIM((SALT39.StrType)le.post_contract_expiration_days), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),IF (le.product_include <> 0,TRIM((SALT39.StrType)le.product_include), ''),IF (le.expectation_of_victim_entities <> 0,TRIM((SALT39.StrType)le.expectation_of_victim_entities), ''),IF (le.suspected_discrepancy <> 0,TRIM((SALT39.StrType)le.suspected_discrepancy), ''),IF (le.confidence_that_activity_was_deceitful <> 0,TRIM((SALT39.StrType)le.confidence_that_activity_was_deceitful), ''),IF (le.workflow_stage_committed <> 0,TRIM((SALT39.StrType)le.workflow_stage_committed), ''),IF (le.workflow_stage_detected <> 0,TRIM((SALT39.StrType)le.workflow_stage_detected), ''),IF (le.channels <> 0,TRIM((SALT39.StrType)le.channels), ''),IF (le.threat <> 0,TRIM((SALT39.StrType)le.threat), ''),IF (le.alert_level <> 0,TRIM((SALT39.StrType)le.alert_level), ''),IF (le.entity_type <> 0,TRIM((SALT39.StrType)le.entity_type), ''),IF (le.entity_sub_type <> 0,TRIM((SALT39.StrType)le.entity_sub_type), ''),IF (le.role <> 0,TRIM((SALT39.StrType)le.role), ''),IF (le.evidence <> 0,TRIM((SALT39.StrType)le.evidence), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fdn_file_info_id'}
      ,{2,'fdn_file_code'}
      ,{3,'gc_id'}
      ,{4,'file_type'}
      ,{5,'description'}
      ,{6,'primary_source_entity'}
      ,{7,'ind_type'}
      ,{8,'update_freq'}
      ,{9,'expiration_days'}
      ,{10,'post_contract_expiration_days'}
      ,{11,'status'}
      ,{12,'product_include'}
      ,{13,'expectation_of_victim_entities'}
      ,{14,'suspected_discrepancy'}
      ,{15,'confidence_that_activity_was_deceitful'}
      ,{16,'workflow_stage_committed'}
      ,{17,'workflow_stage_detected'}
      ,{18,'channels'}
      ,{19,'threat'}
      ,{20,'alert_level'}
      ,{21,'entity_type'}
      ,{22,'entity_sub_type'}
      ,{23,'role'}
      ,{24,'evidence'}
      ,{25,'date_added'}
      ,{26,'user_added'}
      ,{27,'date_changed'}
      ,{28,'user_changed'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    MBS_Fields.InValid_fdn_file_info_id((SALT39.StrType)le.fdn_file_info_id),
    MBS_Fields.InValid_fdn_file_code((SALT39.StrType)le.fdn_file_code),
    MBS_Fields.InValid_gc_id((SALT39.StrType)le.gc_id),
    MBS_Fields.InValid_file_type((SALT39.StrType)le.file_type),
    MBS_Fields.InValid_description((SALT39.StrType)le.description),
    MBS_Fields.InValid_primary_source_entity((SALT39.StrType)le.primary_source_entity),
    MBS_Fields.InValid_ind_type((SALT39.StrType)le.ind_type),
    MBS_Fields.InValid_update_freq((SALT39.StrType)le.update_freq),
    MBS_Fields.InValid_expiration_days((SALT39.StrType)le.expiration_days),
    MBS_Fields.InValid_post_contract_expiration_days((SALT39.StrType)le.post_contract_expiration_days),
    MBS_Fields.InValid_status((SALT39.StrType)le.status),
    MBS_Fields.InValid_product_include((SALT39.StrType)le.product_include),
    MBS_Fields.InValid_expectation_of_victim_entities((SALT39.StrType)le.expectation_of_victim_entities),
    MBS_Fields.InValid_suspected_discrepancy((SALT39.StrType)le.suspected_discrepancy),
    MBS_Fields.InValid_confidence_that_activity_was_deceitful((SALT39.StrType)le.confidence_that_activity_was_deceitful),
    MBS_Fields.InValid_workflow_stage_committed((SALT39.StrType)le.workflow_stage_committed),
    MBS_Fields.InValid_workflow_stage_detected((SALT39.StrType)le.workflow_stage_detected),
    MBS_Fields.InValid_channels((SALT39.StrType)le.channels),
    MBS_Fields.InValid_threat((SALT39.StrType)le.threat),
    MBS_Fields.InValid_alert_level((SALT39.StrType)le.alert_level),
    MBS_Fields.InValid_entity_type((SALT39.StrType)le.entity_type),
    MBS_Fields.InValid_entity_sub_type((SALT39.StrType)le.entity_sub_type),
    MBS_Fields.InValid_role((SALT39.StrType)le.role),
    MBS_Fields.InValid_evidence((SALT39.StrType)le.evidence),
    MBS_Fields.InValid_date_added((SALT39.StrType)le.date_added),
    MBS_Fields.InValid_user_added((SALT39.StrType)le.user_added),
    MBS_Fields.InValid_date_changed((SALT39.StrType)le.date_changed),
    MBS_Fields.InValid_user_changed((SALT39.StrType)le.user_changed),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := MBS_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,MBS_Fields.InValidMessage_fdn_file_info_id(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_fdn_file_code(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_gc_id(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_file_type(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_description(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_primary_source_entity(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_ind_type(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_update_freq(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_expiration_days(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_post_contract_expiration_days(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_status(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_product_include(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_expectation_of_victim_entities(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_suspected_discrepancy(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_confidence_that_activity_was_deceitful(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_workflow_stage_committed(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_workflow_stage_detected(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_channels(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_threat(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_alert_level(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_entity_type(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_entity_sub_type(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_role(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_evidence(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_user_added(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_date_changed(TotalErrors.ErrorNum),MBS_Fields.InValidMessage_user_changed(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MBS_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
