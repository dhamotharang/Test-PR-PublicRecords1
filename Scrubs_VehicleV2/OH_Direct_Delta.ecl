IMPORT SALT311,STD;
EXPORT OH_Direct_Delta(DATASET(OH_Direct_Layout_VehicleV2)old_s, DATASET(OH_Direct_Layout_VehicleV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['categorycode','vin','modelyr','titlenum','ownercode','grossweight','ownername','ownerstreetaddress','ownercity','ownerstate','ownerzip','countynumber','vehiclepurchasedt','vehicletaxweight','vehicletaxcode','vehicleunladdenweight','additionalownername','registrationissuedt','vehiclemake','vehicletype','vehicleexpdt','previousplatenum','platenum','processdate','source_code','state_origin','append_ownernametypeind','append_addlownernametypeind'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := OH_Direct_hygiene(old_s).Summary('Old',Glob) + OH_Direct_hygiene(new_s).Summary('New',Glob) + OH_Direct_hygiene(PROJECT(Differences(deleted), TRANSFORM(OH_Direct_Layout_VehicleV2, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + OH_Direct_hygiene(PROJECT(Differences(added), TRANSFORM(OH_Direct_Layout_VehicleV2, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VehicleV2, OH_Direct_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));


    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
