IMPORT SALT311,STD;
EXPORT CC_Delta(DATASET(CC_Layout_Debt_Settlement)old_s, DATASET(CC_Layout_Debt_Settlement) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['idnum','businessname','dba','orgid','address1','address2','city','state','zip','zip4','phone','fax','email','url','status','licensedatefrom','licensedateto','orgtype','source'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := CC_hygiene(old_s).Summary('Old') + CC_hygiene(new_s).Summary('New') + CC_hygiene(PROJECT(Differences(deleted), TRANSFORM(CC_Layout_Debt_Settlement, SELF := LEFT.old_rec))).Summary('Deletions') + CC_hygiene(PROJECT(Differences(added), TRANSFORM(CC_Layout_Debt_Settlement, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Debt_Settlement, CC_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
