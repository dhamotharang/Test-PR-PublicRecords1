IMPORT SALT311,STD;
EXPORT BaseFile_Delta(DATASET(BaseFile_Layout_Phone_TCPA)old_s, DATASET(BaseFile_Layout_Phone_TCPA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['num','phone','end_range','expand_end_range','expand_range_max_count','expand_phone','is_current','dt_first_seen','dt_last_seen','phone_type'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := BaseFile_hygiene(old_s).Summary('Old') + BaseFile_hygiene(new_s).Summary('New') + BaseFile_hygiene(PROJECT(Differences(deleted), TRANSFORM(BaseFile_Layout_Phone_TCPA, SELF := LEFT.old_rec))).Summary('Deletions') + BaseFile_hygiene(PROJECT(Differences(added), TRANSFORM(BaseFile_Layout_Phone_TCPA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phone_TCPA, BaseFile_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
