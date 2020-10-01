IMPORT SALT311,STD;
EXPORT Sources_Delta(DATASET(Sources_Layout_PhoneFinder)old_s, DATASET(Sources_Layout_PhoneFinder) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['auto_id','transaction_id','phonenumber','lexid','phone_id','identity_id','sequence_number','totalsourcecount','date_added','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Sources_hygiene(old_s).Summary('Old') + Sources_hygiene(new_s).Summary('New') + Sources_hygiene(PROJECT(Differences(deleted), TRANSFORM(Sources_Layout_PhoneFinder, SELF := LEFT.old_rec))).Summary('Deletions') + Sources_hygiene(PROJECT(Differences(added), TRANSFORM(Sources_Layout_PhoneFinder, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Sources_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
