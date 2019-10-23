IMPORT SALT39,STD;
EXPORT NewGcIdExcl_Delta(DATASET(NewGcIdExcl_Layout_NewGcIdExcl)old_s, DATASET(NewGcIdExcl_Layout_NewGcIdExcl) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fdn_file_gc_exclusion_id','fdn_file_info_id','exclusion_id','exclusion_id_type','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := NewGcIdExcl_hygiene(old_s).Summary('Old') + NewGcIdExcl_hygiene(new_s).Summary('New') + NewGcIdExcl_hygiene(PROJECT(Differences(deleted), TRANSFORM(NewGcIdExcl_Layout_NewGcIdExcl, SELF := LEFT.old_rec))).Summary('Deletions') + NewGcIdExcl_hygiene(PROJECT(Differences(added), TRANSFORM(NewGcIdExcl_Layout_NewGcIdExcl, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, NewGcIdExcl_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
