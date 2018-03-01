IMPORT SALT39,STD;
EXPORT LIDBReceived_Delta(DATASET(LIDBReceived_Layout_PhonesInfo)old_s, DATASET(LIDBReceived_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['reference_id','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := LIDBReceived_hygiene(old_s).Summary('Old') + LIDBReceived_hygiene(new_s).Summary('New') + LIDBReceived_hygiene(PROJECT(Differences(deleted), TRANSFORM(LIDBReceived_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + LIDBReceived_hygiene(PROJECT(Differences(added), TRANSFORM(LIDBReceived_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, LIDBReceived_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
