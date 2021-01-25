IMPORT SALT311,STD;
EXPORT RawInput_Delta(DATASET(RawInput_Layout_IDA)old_s, DATASET(RawInput_Layout_IDA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['firstname','middlename','lastname','suffix','addressline1','addressline2','city','state','zip','dob','ssn','dl','dlstate','phone','clientassigneduniquerecordid','emailaddress','ipaddress'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := RawInput_hygiene(old_s).Summary('Old') + RawInput_hygiene(new_s).Summary('New') + RawInput_hygiene(PROJECT(Differences(deleted), TRANSFORM(RawInput_Layout_IDA, SELF := LEFT.old_rec))).Summary('Deletions') + RawInput_hygiene(PROJECT(Differences(added), TRANSFORM(RawInput_Layout_IDA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IDA, RawInput_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
