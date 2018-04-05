IMPORT SALT39,STD;
EXPORT MasterIdIndTypeIncl_Delta(DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl)old_s, DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := MasterIdIndTypeIncl_hygiene(old_s).Summary('Old') + MasterIdIndTypeIncl_hygiene(new_s).Summary('New') + MasterIdIndTypeIncl_hygiene(PROJECT(Differences(deleted), TRANSFORM(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl, SELF := LEFT.old_rec))).Summary('Deletions') + MasterIdIndTypeIncl_hygiene(PROJECT(Differences(added), TRANSFORM(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MasterIdIndTypeIncl_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
