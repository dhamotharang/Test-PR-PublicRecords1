IMPORT SALT39,STD;
EXPORT NAC_Delta(DATASET(NAC_Layout_NAC)old_s, DATASET(NAC_Layout_NAC) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['SearchAddress1StreetAddress1','SearchAddress1StreetAddress2','SearchAddress1City','SearchAddress1State','SearchAddress1Zip','SearchAddress2StreetAddress1','SearchAddress2StreetAddress2','SearchAddress2City','SearchAddress2State','SearchAddress2Zip','SearchCaseId','enduserip','CaseID','ClientFirstName','ClientMiddleName','ClientLastName','ClientPhone','ClientEmail'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := NAC_hygiene(old_s).Summary('Old') + NAC_hygiene(new_s).Summary('New') + NAC_hygiene(PROJECT(Differences(deleted), TRANSFORM(NAC_Layout_NAC, SELF := LEFT.old_rec))).Summary('Deletions') + NAC_hygiene(PROJECT(Differences(added), TRANSFORM(NAC_Layout_NAC, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, NAC_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
