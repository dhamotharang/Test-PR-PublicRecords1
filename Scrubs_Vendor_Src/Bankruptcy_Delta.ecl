IMPORT SALT311,STD;
EXPORT Bankruptcy_Delta(DATASET(Bankruptcy_Layout_Vendor_Src)old_s, DATASET(Bankruptcy_Layout_Vendor_Src) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['lncourtcode','court_code','court_name','address1','address2','city','state','zip','phone'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Bankruptcy_hygiene(old_s).Summary('Old') + Bankruptcy_hygiene(new_s).Summary('New') + Bankruptcy_hygiene(PROJECT(Differences(deleted), TRANSFORM(Bankruptcy_Layout_Vendor_Src, SELF := LEFT.old_rec))).Summary('Deletions') + Bankruptcy_hygiene(PROJECT(Differences(added), TRANSFORM(Bankruptcy_Layout_Vendor_Src, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Vendor_Src, Bankruptcy_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
