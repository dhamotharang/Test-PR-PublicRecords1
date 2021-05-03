IMPORT SALT311,STD;
EXPORT charge_Delta(DATASET(charge_Layout_crim)old_s, DATASET(charge_Layout_crim) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['recordid','statecode','caseid','warrantnumber','warrantdate','warrantdesc','warrantissuedate','warrantissuingagency','warrantstatus','citationnumber','bookingnumber','arrestdate','arrestingagency','bookingdate','custodydate','custodylocation','initialcharge','initialchargedate','initialchargecancelleddate','chargedisposed','chargedisposeddate','chargeseverity','chargedisposition','amendedcharge','amendedchargedate','bondsman','bondamount','bondtype','sourcename','sourceid','vendor'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := charge_hygiene(old_s).Summary('Old',Glob) + charge_hygiene(new_s).Summary('New',Glob) + charge_hygiene(PROJECT(Differences(deleted), TRANSFORM(charge_Layout_crim, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + charge_hygiene(PROJECT(Differences(added), TRANSFORM(charge_Layout_crim, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, charge_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
