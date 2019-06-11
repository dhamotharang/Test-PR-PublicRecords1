IMPORT SALT311,STD;
EXPORT CourtLocator_Delta(DATASET(CourtLocator_Layout_Vendor_Src)old_s, DATASET(CourtLocator_Layout_Vendor_Src) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := CourtLocator_hygiene(old_s).Summary('Old') + CourtLocator_hygiene(new_s).Summary('New') + CourtLocator_hygiene(PROJECT(Differences(deleted), TRANSFORM(CourtLocator_Layout_Vendor_Src, SELF := LEFT.old_rec))).Summary('Deletions') + CourtLocator_hygiene(PROJECT(Differences(added), TRANSFORM(CourtLocator_Layout_Vendor_Src, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Vendor_Src, CourtLocator_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
