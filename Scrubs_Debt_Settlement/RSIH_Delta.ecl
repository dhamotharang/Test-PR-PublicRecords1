IMPORT SALT311,STD;
EXPORT RSIH_Delta(DATASET(RSIH_Layout_Debt_Settlement)old_s, DATASET(RSIH_Layout_Debt_Settlement) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['avdanumber','attorneyname','businessname','address1','address2','phone','email','primary_range_cln','primary_name_cln','sec_range_cln','zip_cln','did_header_addr_count','did_header_phone_count','did_phoneplus_gongphone_count'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := RSIH_hygiene(old_s).Summary('Old') + RSIH_hygiene(new_s).Summary('New') + RSIH_hygiene(PROJECT(Differences(deleted), TRANSFORM(RSIH_Layout_Debt_Settlement, SELF := LEFT.old_rec))).Summary('Deletions') + RSIH_hygiene(PROJECT(Differences(added), TRANSFORM(RSIH_Layout_Debt_Settlement, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Debt_Settlement, RSIH_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
