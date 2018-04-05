IMPORT SALT39,STD;
EXPORT Activity_Delta(DATASET(Activity_Layout_Civil_Court)old_s, DATASET(Activity_Layout_Civil_Court) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','court_code','court','case_number','event_date','event_type_code','event_type_description_1','event_type_description_2'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Activity_hygiene(old_s).Summary('Old') + Activity_hygiene(new_s).Summary('New') + Activity_hygiene(PROJECT(Differences(deleted), TRANSFORM(Activity_Layout_Civil_Court, SELF := LEFT.old_rec))).Summary('Deletions') + Activity_hygiene(PROJECT(Differences(added), TRANSFORM(Activity_Layout_Civil_Court, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Activity_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
