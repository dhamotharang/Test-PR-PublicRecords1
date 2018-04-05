IMPORT SALT39,STD;
EXPORT iConectivMain_Delta(DATASET(iConectivMain_Layout_PhonesInfo)old_s, DATASET(iConectivMain_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['country_code','phone','dial_type','spid','service_provider','service_type','routing_code','porting_dt','country_abbr','filename','file_dt_time','vendor_first_reported_dt','vendor_last_reported_dt','port_start_dt','port_end_dt','remove_port_dt','is_ported'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := iConectivMain_hygiene(old_s).Summary('Old') + iConectivMain_hygiene(new_s).Summary('New') + iConectivMain_hygiene(PROJECT(Differences(deleted), TRANSFORM(iConectivMain_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + iConectivMain_hygiene(PROJECT(Differences(added), TRANSFORM(iConectivMain_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, iConectivMain_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
