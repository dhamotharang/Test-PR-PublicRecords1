 
EXPORT MBS_MAC_PopulationStatistics(infile,Ref='',Input_fdn_file_info_id = '',Input_fdn_file_code = '',Input_gc_id = '',Input_file_type = '',Input_description = '',Input_primary_source_entity = '',Input_ind_type = '',Input_update_freq = '',Input_expiration_days = '',Input_post_contract_expiration_days = '',Input_status = '',Input_product_include = '',Input_expectation_of_victim_entities = '',Input_suspected_discrepancy = '',Input_confidence_that_activity_was_deceitful = '',Input_workflow_stage_committed = '',Input_workflow_stage_detected = '',Input_channels = '',Input_threat = '',Input_alert_level = '',Input_entity_type = '',Input_entity_sub_type = '',Input_role = '',Input_evidence = '',Input_date_added = '',Input_user_added = '',Input_date_changed = '',Input_user_changed = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_fdn_file_info_id)='' )
      '' 
    #ELSE
        IF( le.Input_fdn_file_info_id = (TYPEOF(le.Input_fdn_file_info_id))'','',':fdn_file_info_id')
    #END
 
+    #IF( #TEXT(Input_fdn_file_code)='' )
      '' 
    #ELSE
        IF( le.Input_fdn_file_code = (TYPEOF(le.Input_fdn_file_code))'','',':fdn_file_code')
    #END
 
+    #IF( #TEXT(Input_gc_id)='' )
      '' 
    #ELSE
        IF( le.Input_gc_id = (TYPEOF(le.Input_gc_id))'','',':gc_id')
    #END
 
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
    #END
 
+    #IF( #TEXT(Input_description)='' )
      '' 
    #ELSE
        IF( le.Input_description = (TYPEOF(le.Input_description))'','',':description')
    #END
 
+    #IF( #TEXT(Input_primary_source_entity)='' )
      '' 
    #ELSE
        IF( le.Input_primary_source_entity = (TYPEOF(le.Input_primary_source_entity))'','',':primary_source_entity')
    #END
 
+    #IF( #TEXT(Input_ind_type)='' )
      '' 
    #ELSE
        IF( le.Input_ind_type = (TYPEOF(le.Input_ind_type))'','',':ind_type')
    #END
 
+    #IF( #TEXT(Input_update_freq)='' )
      '' 
    #ELSE
        IF( le.Input_update_freq = (TYPEOF(le.Input_update_freq))'','',':update_freq')
    #END
 
+    #IF( #TEXT(Input_expiration_days)='' )
      '' 
    #ELSE
        IF( le.Input_expiration_days = (TYPEOF(le.Input_expiration_days))'','',':expiration_days')
    #END
 
+    #IF( #TEXT(Input_post_contract_expiration_days)='' )
      '' 
    #ELSE
        IF( le.Input_post_contract_expiration_days = (TYPEOF(le.Input_post_contract_expiration_days))'','',':post_contract_expiration_days')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_product_include)='' )
      '' 
    #ELSE
        IF( le.Input_product_include = (TYPEOF(le.Input_product_include))'','',':product_include')
    #END
 
+    #IF( #TEXT(Input_expectation_of_victim_entities)='' )
      '' 
    #ELSE
        IF( le.Input_expectation_of_victim_entities = (TYPEOF(le.Input_expectation_of_victim_entities))'','',':expectation_of_victim_entities')
    #END
 
+    #IF( #TEXT(Input_suspected_discrepancy)='' )
      '' 
    #ELSE
        IF( le.Input_suspected_discrepancy = (TYPEOF(le.Input_suspected_discrepancy))'','',':suspected_discrepancy')
    #END
 
+    #IF( #TEXT(Input_confidence_that_activity_was_deceitful)='' )
      '' 
    #ELSE
        IF( le.Input_confidence_that_activity_was_deceitful = (TYPEOF(le.Input_confidence_that_activity_was_deceitful))'','',':confidence_that_activity_was_deceitful')
    #END
 
+    #IF( #TEXT(Input_workflow_stage_committed)='' )
      '' 
    #ELSE
        IF( le.Input_workflow_stage_committed = (TYPEOF(le.Input_workflow_stage_committed))'','',':workflow_stage_committed')
    #END
 
+    #IF( #TEXT(Input_workflow_stage_detected)='' )
      '' 
    #ELSE
        IF( le.Input_workflow_stage_detected = (TYPEOF(le.Input_workflow_stage_detected))'','',':workflow_stage_detected')
    #END
 
+    #IF( #TEXT(Input_channels)='' )
      '' 
    #ELSE
        IF( le.Input_channels = (TYPEOF(le.Input_channels))'','',':channels')
    #END
 
+    #IF( #TEXT(Input_threat)='' )
      '' 
    #ELSE
        IF( le.Input_threat = (TYPEOF(le.Input_threat))'','',':threat')
    #END
 
+    #IF( #TEXT(Input_alert_level)='' )
      '' 
    #ELSE
        IF( le.Input_alert_level = (TYPEOF(le.Input_alert_level))'','',':alert_level')
    #END
 
+    #IF( #TEXT(Input_entity_type)='' )
      '' 
    #ELSE
        IF( le.Input_entity_type = (TYPEOF(le.Input_entity_type))'','',':entity_type')
    #END
 
+    #IF( #TEXT(Input_entity_sub_type)='' )
      '' 
    #ELSE
        IF( le.Input_entity_sub_type = (TYPEOF(le.Input_entity_sub_type))'','',':entity_sub_type')
    #END
 
+    #IF( #TEXT(Input_role)='' )
      '' 
    #ELSE
        IF( le.Input_role = (TYPEOF(le.Input_role))'','',':role')
    #END
 
+    #IF( #TEXT(Input_evidence)='' )
      '' 
    #ELSE
        IF( le.Input_evidence = (TYPEOF(le.Input_evidence))'','',':evidence')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_user_added)='' )
      '' 
    #ELSE
        IF( le.Input_user_added = (TYPEOF(le.Input_user_added))'','',':user_added')
    #END
 
+    #IF( #TEXT(Input_date_changed)='' )
      '' 
    #ELSE
        IF( le.Input_date_changed = (TYPEOF(le.Input_date_changed))'','',':date_changed')
    #END
 
+    #IF( #TEXT(Input_user_changed)='' )
      '' 
    #ELSE
        IF( le.Input_user_changed = (TYPEOF(le.Input_user_changed))'','',':user_changed')
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
