IMPORT SALT311,STD;
EXPORT Violation_Raw_Delta(DATASET(Violation_Raw_Layout)old_s, DATASET(Violation_Raw_Layout) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['activity_nr','citation_id','delete_flag','viol_type','issuance_date','abate_date','current_penalty','initial_penalty','contest_date','final_order_date','nr_instances','nr_exposed','rec','gravity','emphasis','hazcat','fta_insp_nr','fta_issuance_date','fta_penalty','fta_contest_date','fta_final_order_date','hazsub1','hazsub2','hazsub3','hazsub4','hazsub5'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Violation_Raw_hygiene(old_s).Summary('Old') + Violation_Raw_hygiene(new_s).Summary('New') + Violation_Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Violation_Raw_Layout, SELF := LEFT.old_rec))).Summary('Deletions') + Violation_Raw_hygiene(PROJECT(Differences(added), TRANSFORM(Violation_Raw_Layout, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, Violation_Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
