IMPORT SALT311,STD;
EXPORT raw_Delta(DATASET(raw_Layout_OPM)old_s, DATASET(raw_Layout_OPM) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['employee_name','duty_station','country','state','city','county','agency','agency_sub_element','computation_date','occupational_series','file_date'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := raw_hygiene(old_s).Summary('Old') + raw_hygiene(new_s).Summary('New') + raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(raw_Layout_OPM, SELF := LEFT.old_rec))).Summary('Deletions') + raw_hygiene(PROJECT(Differences(added), TRANSFORM(raw_Layout_OPM, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OPM, raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
