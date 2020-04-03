IMPORT SALT311,STD;
EXPORT Lerg1ConRaw_Delta(DATASET(Lerg1ConRaw_Layout_PhonesInfo)old_s, DATASET(Lerg1ConRaw_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ocn','ocn_name','ocn_state','contact_function','contact_phone','contact_information','filler','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Lerg1ConRaw_hygiene(old_s).Summary('Old') + Lerg1ConRaw_hygiene(new_s).Summary('New') + Lerg1ConRaw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Lerg1ConRaw_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + Lerg1ConRaw_hygiene(PROJECT(Differences(added), TRANSFORM(Lerg1ConRaw_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, Lerg1ConRaw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
