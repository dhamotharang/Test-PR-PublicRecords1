IMPORT SALT39,STD;
EXPORT MBS_Delta(DATASET(MBS_Layout_MBS)old_s, DATASET(MBS_Layout_MBS) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fdn_file_info_id','fdn_file_code','gc_id','file_type','description','primary_source_entity','ind_type','update_freq','expiration_days','post_contract_expiration_days','status','product_include','expectation_of_victim_entities','suspected_discrepancy','confidence_that_activity_was_deceitful','workflow_stage_committed','workflow_stage_detected','channels','threat','alert_level','entity_type','entity_sub_type','role','evidence','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := MBS_hygiene(old_s).Summary('Old') + MBS_hygiene(new_s).Summary('New') + MBS_hygiene(PROJECT(Differences(deleted), TRANSFORM(MBS_Layout_MBS, SELF := LEFT.old_rec))).Summary('Deletions') + MBS_hygiene(PROJECT(Differences(added), TRANSFORM(MBS_Layout_MBS, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MBS_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
