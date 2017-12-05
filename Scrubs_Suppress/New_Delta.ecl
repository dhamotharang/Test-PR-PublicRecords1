IMPORT SALT38,STD;
EXPORT New_Delta(DATASET(New_Layout_Suppress)old_s, DATASET(New_Layout_Suppress) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['product','linking_type','linking_id','document_type','document_id','date_added','user','compliance_id','comment'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := New_hygiene(old_s).Summary('Old') + New_hygiene(new_s).Summary('New') + New_hygiene(PROJECT(Differences(deleted), TRANSFORM(New_Layout_Suppress, SELF := LEFT.old_rec))).Summary('Deletions') + New_hygiene(PROJECT(Differences(added), TRANSFORM(New_Layout_Suppress, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Suppress, New_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
