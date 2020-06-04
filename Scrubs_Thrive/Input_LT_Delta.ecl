IMPORT SALT311,STD;
EXPORT Input_LT_Delta(DATASET(Input_LT_Layout_Thrive)old_s, DATASET(Input_LT_Layout_Thrive) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_fname','orig_lname','orig_addr','orig_city','orig_zip4','orig_state','orig_zip5','email','phone','employer','dt'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_LT_hygiene(old_s).Summary('Old') + Input_LT_hygiene(new_s).Summary('New') + Input_LT_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_LT_Layout_Thrive, SELF := LEFT.old_rec))).Summary('Deletions') + Input_LT_hygiene(PROJECT(Differences(added), TRANSFORM(Input_LT_Layout_Thrive, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Thrive, Input_LT_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
