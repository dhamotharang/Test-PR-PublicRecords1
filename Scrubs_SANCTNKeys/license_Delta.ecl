IMPORT SALT38,STD;
EXPORT license_Delta(DATASET(license_Layout_SANCTNKeys)old_s, DATASET(license_Layout_SANCTNKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch_number','incident_number','party_number','record_type','order_number','license_number','license_type','license_state','cln_license_number','std_type_desc'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := license_hygiene(old_s).Summary('Old') + license_hygiene(new_s).Summary('New') + license_hygiene(PROJECT(Differences(deleted), TRANSFORM(license_Layout_SANCTNKeys, SELF := LEFT.old_rec))).Summary('Deletions') + license_hygiene(PROJECT(Differences(added), TRANSFORM(license_Layout_SANCTNKeys, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, license_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
