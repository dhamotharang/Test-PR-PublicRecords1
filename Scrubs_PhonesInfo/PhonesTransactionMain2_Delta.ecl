IMPORT SALT311,STD;
EXPORT PhonesTransactionMain2_Delta(DATASET(PhonesTransactionMain2_Layout_PhonesInfo)old_s, DATASET(PhonesTransactionMain2_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['phone','source','transaction_code','transaction_start_dt','transaction_start_time','transaction_end_dt','transaction_end_time','transaction_count','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','country_code','country_abbr','routing_code','dial_type','spid','carrier_name','phone_swap','ocn','alt_spid','lalt_spid','global_sid','record_sid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := PhonesTransactionMain2_hygiene(old_s).Summary('Old') + PhonesTransactionMain2_hygiene(new_s).Summary('New') + PhonesTransactionMain2_hygiene(PROJECT(Differences(deleted), TRANSFORM(PhonesTransactionMain2_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + PhonesTransactionMain2_hygiene(PROJECT(Differences(added), TRANSFORM(PhonesTransactionMain2_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PhonesTransactionMain2_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
