IMPORT SALT311,STD;
EXPORT Input_FL_Event_Delta(DATASET(Input_FL_Event_Layout_FBNV2)old_s, DATASET(Input_FL_Event_Layout_FBNV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['EVENT_DOC_NUMBER','EVENT_ORIG_DOC_NUMBER','EVENT_DATE','ACTION_OWN_NAME','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_FL_Event_hygiene(old_s).Summary('Old') + Input_FL_Event_hygiene(new_s).Summary('New') + Input_FL_Event_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_FL_Event_Layout_FBNV2, SELF := LEFT.old_rec))).Summary('Deletions') + Input_FL_Event_hygiene(PROJECT(Differences(added), TRANSFORM(Input_FL_Event_Layout_FBNV2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_FL_Event_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
