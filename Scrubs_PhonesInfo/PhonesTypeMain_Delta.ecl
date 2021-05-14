IMPORT SALT311,STD;
EXPORT PhonesTypeMain_Delta(DATASET(PhonesTypeMain_Layout_PhonesInfo)old_s, DATASET(PhonesTypeMain_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['phone','source','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','reference_id','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','high_risk_indicator','prepaid','global_sid','record_sid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := PhonesTypeMain_hygiene(old_s).Summary('Old') + PhonesTypeMain_hygiene(new_s).Summary('New') + PhonesTypeMain_hygiene(PROJECT(Differences(deleted), TRANSFORM(PhonesTypeMain_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + PhonesTypeMain_hygiene(PROJECT(Differences(added), TRANSFORM(PhonesTypeMain_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PhonesTypeMain_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
