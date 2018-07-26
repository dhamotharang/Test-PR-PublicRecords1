IMPORT SALT39,STD;
EXPORT LIDBProcessed_Delta(DATASET(LIDBProcessed_Layout_PhonesInfo)old_s, DATASET(LIDBProcessed_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['reference_id','dt_first_reported','dt_last_reported','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','activation_dt','number_in_service','high_risk_indicator','prepaid'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := LIDBProcessed_hygiene(old_s).Summary('Old') + LIDBProcessed_hygiene(new_s).Summary('New') + LIDBProcessed_hygiene(PROJECT(Differences(deleted), TRANSFORM(LIDBProcessed_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + LIDBProcessed_hygiene(PROJECT(Differences(added), TRANSFORM(LIDBProcessed_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, LIDBProcessed_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
