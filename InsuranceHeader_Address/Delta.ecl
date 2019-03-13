IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Address_Link)old_s, DATASET(Layout_Address_Link) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['DID','src','dt_first_seen','dt_last_seen','prim_range','prim_range_alpha','prim_range_num','prim_range_fract','predir','prim_name','prim_name_num','prim_name_alpha','addr_suffix','addr_ind','postdir','unit_desig','sec_range','sec_range_alpha','sec_range_num','city','st','zip','rec_cnt','src_cnt'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, RID);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Address_Link, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Address_Link, SELF := LEFT.new_rec))).Summary('Additions') + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_Address_Link, SELF := LEFT.new_rec))).Summary('Updates_NewFile') + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_Address_Link, SELF := LEFT.old_rec))).Summary('Updates_OldFile');
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges := SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(InsuranceHeader_Address, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    fieldDiffsOverall := DifferencesFieldChanges;
    SALT311.mod_StandardStatsTransforms.mac_deltaDifferencesFieldChanges('RECORDOF(fieldDiffsOverall)', inFieldList, myTimeStamp, FALSE);
    fieldDiffsOverall_Standard := IF(doFieldDiffsGlobal, NORMALIZE(fieldDiffsOverall, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
 
    RETURN hygieneDiffOverall_Standard & fieldDiffsOverall_Standard;
  END;
END;
