IMPORT SALT311,STD;
EXPORT Identities_Delta(DATASET(Identities_Layout_PhoneFinder)old_s, DATASET(Identities_Layout_PhoneFinder) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['transaction_id','sequence_number','lexid','full_name','full_address','city','state','zip','verified_carrier','date_added','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Identities_hygiene(old_s).Summary('Old') + Identities_hygiene(new_s).Summary('New') + Identities_hygiene(PROJECT(Differences(deleted), TRANSFORM(Identities_Layout_PhoneFinder, SELF := LEFT.old_rec))).Summary('Deletions') + Identities_hygiene(PROJECT(Differences(added), TRANSFORM(Identities_Layout_PhoneFinder, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Identities_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
