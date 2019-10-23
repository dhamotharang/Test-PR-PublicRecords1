IMPORT SALT39;
EXPORT MBS_Fields := MODULE
 
EXPORT NumFields := 28;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_date','invalid_numeric');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_date' => 3,'invalid_numeric' => 4,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -:'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' -:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -:'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -:'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fdn_file_info_id','fdn_file_code','gc_id','file_type','description','primary_source_entity','ind_type','update_freq','expiration_days','post_contract_expiration_days','status','product_include','expectation_of_victim_entities','suspected_discrepancy','confidence_that_activity_was_deceitful','workflow_stage_committed','workflow_stage_detected','channels','threat','alert_level','entity_type','entity_sub_type','role','evidence','date_added','user_added','date_changed','user_changed');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'fdn_file_info_id','fdn_file_code','gc_id','file_type','description','primary_source_entity','ind_type','update_freq','expiration_days','post_contract_expiration_days','status','product_include','expectation_of_victim_entities','suspected_discrepancy','confidence_that_activity_was_deceitful','workflow_stage_committed','workflow_stage_detected','channels','threat','alert_level','entity_type','entity_sub_type','role','evidence','date_added','user_added','date_changed','user_changed');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'fdn_file_info_id' => 0,'fdn_file_code' => 1,'gc_id' => 2,'file_type' => 3,'description' => 4,'primary_source_entity' => 5,'ind_type' => 6,'update_freq' => 7,'expiration_days' => 8,'post_contract_expiration_days' => 9,'status' => 10,'product_include' => 11,'expectation_of_victim_entities' => 12,'suspected_discrepancy' => 13,'confidence_that_activity_was_deceitful' => 14,'workflow_stage_committed' => 15,'workflow_stage_detected' => 16,'channels' => 17,'threat' => 18,'alert_level' => 19,'entity_type' => 20,'entity_sub_type' => 21,'role' => 22,'evidence' => 23,'date_added' => 24,'user_added' => 25,'date_changed' => 26,'user_changed' => 27,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_fdn_file_info_id(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fdn_file_info_id(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fdn_file_info_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fdn_file_code(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_fdn_file_code(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_fdn_file_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_gc_id(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_gc_id(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_gc_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_file_type(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_file_type(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_description(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_description(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_description(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_primary_source_entity(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_primary_source_entity(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_primary_source_entity(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ind_type(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ind_type(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ind_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_update_freq(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_update_freq(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_update_freq(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_expiration_days(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_expiration_days(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_expiration_days(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_post_contract_expiration_days(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_post_contract_expiration_days(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_post_contract_expiration_days(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_status(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_status(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_product_include(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_product_include(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_product_include(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_expectation_of_victim_entities(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_expectation_of_victim_entities(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_expectation_of_victim_entities(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_suspected_discrepancy(SALT39.StrType s0) := s0;
EXPORT InValid_suspected_discrepancy(SALT39.StrType s) := 0;
EXPORT InValidMessage_suspected_discrepancy(UNSIGNED1 wh) := '';
 
EXPORT Make_confidence_that_activity_was_deceitful(SALT39.StrType s0) := s0;
EXPORT InValid_confidence_that_activity_was_deceitful(SALT39.StrType s) := 0;
EXPORT InValidMessage_confidence_that_activity_was_deceitful(UNSIGNED1 wh) := '';
 
EXPORT Make_workflow_stage_committed(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_workflow_stage_committed(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_workflow_stage_committed(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_workflow_stage_detected(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_workflow_stage_detected(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_workflow_stage_detected(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_channels(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_channels(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_channels(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_threat(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_threat(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_threat(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_alert_level(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_alert_level(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_alert_level(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_entity_type(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_entity_type(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_entity_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_entity_sub_type(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_entity_sub_type(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_entity_sub_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_role(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_role(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_role(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_evidence(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_evidence(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_evidence(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_added(SALT39.StrType s0) := s0;
EXPORT InValid_date_added(SALT39.StrType s) := 0;
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := '';
 
EXPORT Make_user_added(SALT39.StrType s0) := s0;
EXPORT InValid_user_added(SALT39.StrType s) := 0;
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := '';
 
EXPORT Make_date_changed(SALT39.StrType s0) := s0;
EXPORT InValid_date_changed(SALT39.StrType s) := 0;
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_user_changed(SALT39.StrType s0) := s0;
EXPORT InValid_user_changed(SALT39.StrType s) := 0;
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_MBS;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_fdn_file_info_id;
    BOOLEAN Diff_fdn_file_code;
    BOOLEAN Diff_gc_id;
    BOOLEAN Diff_file_type;
    BOOLEAN Diff_description;
    BOOLEAN Diff_primary_source_entity;
    BOOLEAN Diff_ind_type;
    BOOLEAN Diff_update_freq;
    BOOLEAN Diff_expiration_days;
    BOOLEAN Diff_post_contract_expiration_days;
    BOOLEAN Diff_status;
    BOOLEAN Diff_product_include;
    BOOLEAN Diff_expectation_of_victim_entities;
    BOOLEAN Diff_suspected_discrepancy;
    BOOLEAN Diff_confidence_that_activity_was_deceitful;
    BOOLEAN Diff_workflow_stage_committed;
    BOOLEAN Diff_workflow_stage_detected;
    BOOLEAN Diff_channels;
    BOOLEAN Diff_threat;
    BOOLEAN Diff_alert_level;
    BOOLEAN Diff_entity_type;
    BOOLEAN Diff_entity_sub_type;
    BOOLEAN Diff_role;
    BOOLEAN Diff_evidence;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user_added;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_user_changed;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fdn_file_info_id := le.fdn_file_info_id <> ri.fdn_file_info_id;
    SELF.Diff_fdn_file_code := le.fdn_file_code <> ri.fdn_file_code;
    SELF.Diff_gc_id := le.gc_id <> ri.gc_id;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Diff_description := le.description <> ri.description;
    SELF.Diff_primary_source_entity := le.primary_source_entity <> ri.primary_source_entity;
    SELF.Diff_ind_type := le.ind_type <> ri.ind_type;
    SELF.Diff_update_freq := le.update_freq <> ri.update_freq;
    SELF.Diff_expiration_days := le.expiration_days <> ri.expiration_days;
    SELF.Diff_post_contract_expiration_days := le.post_contract_expiration_days <> ri.post_contract_expiration_days;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_product_include := le.product_include <> ri.product_include;
    SELF.Diff_expectation_of_victim_entities := le.expectation_of_victim_entities <> ri.expectation_of_victim_entities;
    SELF.Diff_suspected_discrepancy := le.suspected_discrepancy <> ri.suspected_discrepancy;
    SELF.Diff_confidence_that_activity_was_deceitful := le.confidence_that_activity_was_deceitful <> ri.confidence_that_activity_was_deceitful;
    SELF.Diff_workflow_stage_committed := le.workflow_stage_committed <> ri.workflow_stage_committed;
    SELF.Diff_workflow_stage_detected := le.workflow_stage_detected <> ri.workflow_stage_detected;
    SELF.Diff_channels := le.channels <> ri.channels;
    SELF.Diff_threat := le.threat <> ri.threat;
    SELF.Diff_alert_level := le.alert_level <> ri.alert_level;
    SELF.Diff_entity_type := le.entity_type <> ri.entity_type;
    SELF.Diff_entity_sub_type := le.entity_sub_type <> ri.entity_sub_type;
    SELF.Diff_role := le.role <> ri.role;
    SELF.Diff_evidence := le.evidence <> ri.evidence;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fdn_file_info_id,1,0)+ IF( SELF.Diff_fdn_file_code,1,0)+ IF( SELF.Diff_gc_id,1,0)+ IF( SELF.Diff_file_type,1,0)+ IF( SELF.Diff_description,1,0)+ IF( SELF.Diff_primary_source_entity,1,0)+ IF( SELF.Diff_ind_type,1,0)+ IF( SELF.Diff_update_freq,1,0)+ IF( SELF.Diff_expiration_days,1,0)+ IF( SELF.Diff_post_contract_expiration_days,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_product_include,1,0)+ IF( SELF.Diff_expectation_of_victim_entities,1,0)+ IF( SELF.Diff_suspected_discrepancy,1,0)+ IF( SELF.Diff_confidence_that_activity_was_deceitful,1,0)+ IF( SELF.Diff_workflow_stage_committed,1,0)+ IF( SELF.Diff_workflow_stage_detected,1,0)+ IF( SELF.Diff_channels,1,0)+ IF( SELF.Diff_threat,1,0)+ IF( SELF.Diff_alert_level,1,0)+ IF( SELF.Diff_entity_type,1,0)+ IF( SELF.Diff_entity_sub_type,1,0)+ IF( SELF.Diff_role,1,0)+ IF( SELF.Diff_evidence,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user_added,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_user_changed,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_fdn_file_info_id := COUNT(GROUP,%Closest%.Diff_fdn_file_info_id);
    Count_Diff_fdn_file_code := COUNT(GROUP,%Closest%.Diff_fdn_file_code);
    Count_Diff_gc_id := COUNT(GROUP,%Closest%.Diff_gc_id);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
    Count_Diff_description := COUNT(GROUP,%Closest%.Diff_description);
    Count_Diff_primary_source_entity := COUNT(GROUP,%Closest%.Diff_primary_source_entity);
    Count_Diff_ind_type := COUNT(GROUP,%Closest%.Diff_ind_type);
    Count_Diff_update_freq := COUNT(GROUP,%Closest%.Diff_update_freq);
    Count_Diff_expiration_days := COUNT(GROUP,%Closest%.Diff_expiration_days);
    Count_Diff_post_contract_expiration_days := COUNT(GROUP,%Closest%.Diff_post_contract_expiration_days);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_product_include := COUNT(GROUP,%Closest%.Diff_product_include);
    Count_Diff_expectation_of_victim_entities := COUNT(GROUP,%Closest%.Diff_expectation_of_victim_entities);
    Count_Diff_suspected_discrepancy := COUNT(GROUP,%Closest%.Diff_suspected_discrepancy);
    Count_Diff_confidence_that_activity_was_deceitful := COUNT(GROUP,%Closest%.Diff_confidence_that_activity_was_deceitful);
    Count_Diff_workflow_stage_committed := COUNT(GROUP,%Closest%.Diff_workflow_stage_committed);
    Count_Diff_workflow_stage_detected := COUNT(GROUP,%Closest%.Diff_workflow_stage_detected);
    Count_Diff_channels := COUNT(GROUP,%Closest%.Diff_channels);
    Count_Diff_threat := COUNT(GROUP,%Closest%.Diff_threat);
    Count_Diff_alert_level := COUNT(GROUP,%Closest%.Diff_alert_level);
    Count_Diff_entity_type := COUNT(GROUP,%Closest%.Diff_entity_type);
    Count_Diff_entity_sub_type := COUNT(GROUP,%Closest%.Diff_entity_sub_type);
    Count_Diff_role := COUNT(GROUP,%Closest%.Diff_role);
    Count_Diff_evidence := COUNT(GROUP,%Closest%.Diff_evidence);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
