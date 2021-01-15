IMPORT SALT311,STD;
EXPORT DEDI_Delta(DATASET(DEDI_Layout_DEDI)old_s, DATASET(DEDI_Layout_DEDI) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['domain','dispsblemail'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DEDI_hygiene(old_s).Summary('Old') + DEDI_hygiene(new_s).Summary('New') + DEDI_hygiene(PROJECT(Differences(deleted), TRANSFORM(DEDI_Layout_DEDI, SELF := LEFT.old_rec))).Summary('Deletions') + DEDI_hygiene(PROJECT(Differences(added), TRANSFORM(DEDI_Layout_DEDI, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, DEDI_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    RETURN hygieneDiffOverall_Standard;
  END;
END;
