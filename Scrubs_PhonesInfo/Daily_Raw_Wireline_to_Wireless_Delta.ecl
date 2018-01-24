﻿IMPORT SALT38,STD;
EXPORT Daily_Raw_Wireline_to_Wireless_Delta(DATASET(Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo)old_s, DATASET(Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['phone','lf','filename'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Daily_Raw_Wireline_to_Wireless_hygiene(old_s).Summary('Old') + Daily_Raw_Wireline_to_Wireless_hygiene(new_s).Summary('New') + Daily_Raw_Wireline_to_Wireless_hygiene(PROJECT(Differences(deleted), TRANSFORM(Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + Daily_Raw_Wireline_to_Wireless_hygiene(PROJECT(Differences(added), TRANSFORM(Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, Daily_Raw_Wireline_to_Wireless_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
