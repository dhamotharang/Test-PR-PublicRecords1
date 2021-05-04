IMPORT SALT311,STD;
EXPORT DeactRaw2_Delta(DATASET(DeactRaw2_Layout_PhonesInfo)old_s, DATASET(DeactRaw2_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['msisdn','timestamp','changeid','operatorid','msisdneid','msisdnnew','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DeactRaw2_hygiene(old_s).Summary('Old') + DeactRaw2_hygiene(new_s).Summary('New') + DeactRaw2_hygiene(PROJECT(Differences(deleted), TRANSFORM(DeactRaw2_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + DeactRaw2_hygiene(PROJECT(Differences(added), TRANSFORM(DeactRaw2_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, DeactRaw2_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
