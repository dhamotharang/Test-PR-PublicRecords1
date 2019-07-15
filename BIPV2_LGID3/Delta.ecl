IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_LGID3)old_s, DATASET(Layout_LGID3) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['sbfe_id','nodes_below_st','Lgid3IfHrchy','OriginalSeleId','OriginalOrgId','company_name','cnp_number','active_duns_number','duns_number','company_fein','company_inc_state','company_charter_number','cnp_btype','company_name_type_derived','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','cnp_name','cnp_hasNumber','cnp_lowv','cnp_translated','cnp_classid','prim_range','prim_name','sec_range','v_city_name','st','zip','has_lgid','is_sele_level','is_org_level','is_ult_level','parent_proxid','sele_proxid','org_proxid','ultimate_proxid','levels_from_top','nodes_total','dt_first_seen','dt_last_seen'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, rcid);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_LGID3, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_LGID3, SELF := LEFT.new_rec))).Summary('Additions',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_LGID3, SELF := LEFT.new_rec))).Summary('Updates_NewFile',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_LGID3, SELF := LEFT.old_rec))).Summary('Updates_OldFile',Glob);
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges(BOOLEAN Glob = TRUE) := IF(Glob, SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList), SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList, source));
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE, BOOLEAN doFieldDiffsPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(BIPV2_LGID3, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    fieldDiffsOverall := DifferencesFieldChanges(TRUE);
    fieldDiffsPerSrc := DifferencesFieldChanges(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_deltaDifferencesFieldChanges('RECORDOF(fieldDiffsOverall)', inFieldList, myTimeStamp, TRUE);
    fieldDiffsOverall_Standard := IF(doFieldDiffsGlobal, NORMALIZE(fieldDiffsOverall, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
    fieldDiffsPerSrc_Standard := IF(doFieldDiffsPerSrc, NORMALIZE(fieldDiffsPerSrc, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard & fieldDiffsOverall_Standard & fieldDiffsPerSrc_Standard;
  END;
END;
