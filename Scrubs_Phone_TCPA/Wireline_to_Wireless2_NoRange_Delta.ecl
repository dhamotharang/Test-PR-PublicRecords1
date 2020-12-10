IMPORT SALT311,STD;
EXPORT Wireline_to_Wireless2_NoRange_Delta(DATASET(Wireline_to_Wireless2_NoRange_Layout_Phone_TCPA)old_s, DATASET(Wireline_to_Wireless2_NoRange_Layout_Phone_TCPA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['cellphone','lf','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Wireline_to_Wireless2_NoRange_hygiene(old_s).Summary('Old') + Wireline_to_Wireless2_NoRange_hygiene(new_s).Summary('New') + Wireline_to_Wireless2_NoRange_hygiene(PROJECT(Differences(deleted), TRANSFORM(Wireline_to_Wireless2_NoRange_Layout_Phone_TCPA, SELF := LEFT.old_rec))).Summary('Deletions') + Wireline_to_Wireless2_NoRange_hygiene(PROJECT(Differences(added), TRANSFORM(Wireline_to_Wireless2_NoRange_Layout_Phone_TCPA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phone_TCPA, Wireline_to_Wireless2_NoRange_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
