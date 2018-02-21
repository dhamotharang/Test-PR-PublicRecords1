IMPORT SALT39,STD;
EXPORT In_Port_Daily_Delta(DATASET(In_Port_Daily_Layout_PhonesInfo)old_s, DATASET(In_Port_Daily_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := In_Port_Daily_hygiene(old_s).Summary('Old') + In_Port_Daily_hygiene(new_s).Summary('New') + In_Port_Daily_hygiene(PROJECT(Differences(deleted), TRANSFORM(In_Port_Daily_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + In_Port_Daily_hygiene(PROJECT(Differences(added), TRANSFORM(In_Port_Daily_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, In_Port_Daily_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
