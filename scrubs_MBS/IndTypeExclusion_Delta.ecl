IMPORT SALT39,STD;
EXPORT IndTypeExclusion_Delta(DATASET(IndTypeExclusion_Layout_IndTypeExclusion)old_s, DATASET(IndTypeExclusion_Layout_IndTypeExclusion) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fdn_file_ind_type_exclusion_id','fdn_file_info_id','ind_type','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := IndTypeExclusion_hygiene(old_s).Summary('Old') + IndTypeExclusion_hygiene(new_s).Summary('New') + IndTypeExclusion_hygiene(PROJECT(Differences(deleted), TRANSFORM(IndTypeExclusion_Layout_IndTypeExclusion, SELF := LEFT.old_rec))).Summary('Deletions') + IndTypeExclusion_hygiene(PROJECT(Differences(added), TRANSFORM(IndTypeExclusion_Layout_IndTypeExclusion, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, IndTypeExclusion_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
