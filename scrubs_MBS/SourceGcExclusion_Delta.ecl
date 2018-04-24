IMPORT SALT39,STD;
EXPORT SourceGcExclusion_Delta(DATASET(SourceGcExclusion_Layout_SourceGcExclusion)old_s, DATASET(SourceGcExclusion_Layout_SourceGcExclusion) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['gc_id','product_id','company_id','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := SourceGcExclusion_hygiene(old_s).Summary('Old') + SourceGcExclusion_hygiene(new_s).Summary('New') + SourceGcExclusion_hygiene(PROJECT(Differences(deleted), TRANSFORM(SourceGcExclusion_Layout_SourceGcExclusion, SELF := LEFT.old_rec))).Summary('Deletions') + SourceGcExclusion_hygiene(PROJECT(Differences(added), TRANSFORM(SourceGcExclusion_Layout_SourceGcExclusion, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, SourceGcExclusion_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
