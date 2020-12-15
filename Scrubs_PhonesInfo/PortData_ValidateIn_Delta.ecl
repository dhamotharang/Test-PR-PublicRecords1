IMPORT SALT311,STD;
EXPORT PortData_ValidateIn_Delta(DATASET(PortData_ValidateIn_Layout_PhonesInfo)old_s, DATASET(PortData_ValidateIn_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['tid','action','actts','digits','spid','altspid','laltspid','linetype'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := PortData_ValidateIn_hygiene(old_s).Summary('Old') + PortData_ValidateIn_hygiene(new_s).Summary('New') + PortData_ValidateIn_hygiene(PROJECT(Differences(deleted), TRANSFORM(PortData_ValidateIn_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + PortData_ValidateIn_hygiene(PROJECT(Differences(added), TRANSFORM(PortData_ValidateIn_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PortData_ValidateIn_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
