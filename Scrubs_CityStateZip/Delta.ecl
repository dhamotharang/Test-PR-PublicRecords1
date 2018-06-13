IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_CityStateZip)old_s, DATASET(Layout_CityStateZip) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['zip5','zipclass','city','state','county','prefctystname'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_CityStateZip, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_CityStateZip, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CityStateZip, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
