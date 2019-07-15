IMPORT SALT38,STD;
EXPORT CodesV3_Delta(DATASET(CodesV3_Layout_Codes)old_s, DATASET(CodesV3_Layout_Codes) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['file_name','field_name','field_name2','code','long_flag','long_desc'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := CodesV3_hygiene(old_s).Summary('Old') + CodesV3_hygiene(new_s).Summary('New') + CodesV3_hygiene(PROJECT(Differences(deleted), TRANSFORM(CodesV3_Layout_Codes, SELF := LEFT.old_rec))).Summary('Deletions') + CodesV3_hygiene(PROJECT(Differences(added), TRANSFORM(CodesV3_Layout_Codes, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Codes, CodesV3_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
