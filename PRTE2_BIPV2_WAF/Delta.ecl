IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_BizHead)old_s, DATASET(Layout_BizHead) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['parent_proxid','ultimate_proxid','has_lgid','empid','powid','source','source_record_id','cnp_number','cnp_btype','cnp_lowv','cnp_name','company_phone','company_fein','company_sic_code1','prim_range','prim_name','sec_range','p_city_name','st','zip','company_url','isContact','title','fname','mname','lname','name_suffix','contact_email'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, rcid);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_BizHead, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_BizHead, SELF := LEFT.new_rec))).Summary('Additions',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_BizHead, SELF := LEFT.new_rec))).Summary('Updates_NewFile',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_BizHead, SELF := LEFT.old_rec))).Summary('Updates_OldFile',Glob);
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges(BOOLEAN Glob = TRUE) := IF(Glob, SALT38.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList), SALT38.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList, SOURCE));
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE, BOOLEAN doFieldDiffsPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(PRTE2_BIPV2_WAF, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    fieldDiffsOverall := DifferencesFieldChanges(TRUE);
    fieldDiffsPerSrc := DifferencesFieldChanges(FALSE);
    SALT38.mod_StandardStatsTransforms.mac_deltaDifferencesFieldChanges('RECORDOF(fieldDiffsOverall)', inFieldList, myTimeStamp, TRUE);
    fieldDiffsOverall_Standard := IF(doFieldDiffsGlobal, NORMALIZE(fieldDiffsOverall, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
    fieldDiffsPerSrc_Standard := IF(doFieldDiffsPerSrc, NORMALIZE(fieldDiffsPerSrc, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard & fieldDiffsOverall_Standard & fieldDiffsPerSrc_Standard;
  END;
END;
