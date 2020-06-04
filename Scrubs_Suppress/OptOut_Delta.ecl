IMPORT SALT311,STD;
EXPORT OptOut_Delta(DATASET(OptOut_Layout_Suppress)old_s, DATASET(OptOut_Layout_Suppress) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['entry_type','lexid','prof_data','state_act','date_of_request'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := OptOut_hygiene(old_s).Summary('Old') + OptOut_hygiene(new_s).Summary('New') + OptOut_hygiene(PROJECT(Differences(deleted), TRANSFORM(OptOut_Layout_Suppress, SELF := LEFT.old_rec))).Summary('Deletions') + OptOut_hygiene(PROJECT(Differences(added), TRANSFORM(OptOut_Layout_Suppress, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Suppress, OptOut_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
