IMPORT SALT44,STD;
EXPORT Delta(DATASET(Layout_BizHead)old_s, DATASET(Layout_BizHead) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['parent_proxid','sele_proxid','org_proxid','ultimate_proxid','has_lgid','empid','source','source_record_id','source_docid','company_name','company_name_prefix','cnp_name','cnp_number','cnp_btype','cnp_lowv','company_phone','company_phone_3','company_phone_3_ex','company_phone_7','company_fein','company_sic_code1','active_duns_number','prim_range','prim_name','sec_range','city','city_clean','st','zip','company_url','isContact','contact_did','title','fname','fname_preferred','mname','lname','name_suffix','contact_ssn','contact_email','sele_flag','org_flag','ult_flag','fallback_value'];
  EXPORT Differences := SALT44.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, rcid);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_BizHead, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_BizHead, SELF := LEFT.new_rec))).Summary('Additions') + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_BizHead, SELF := LEFT.new_rec))).Summary('Updates_NewFile') + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_BizHead, SELF := LEFT.old_rec))).Summary('Updates_OldFile');
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges := SALT44.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT44.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT44.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(BizLinkFull, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    fieldDiffsOverall := DifferencesFieldChanges;
    SALT44.mod_StandardStatsTransforms.mac_deltaDifferencesFieldChanges('RECORDOF(fieldDiffsOverall)', inFieldList, myTimeStamp, FALSE);
    fieldDiffsOverall_Standard := IF(doFieldDiffsGlobal, NORMALIZE(fieldDiffsOverall, COUNT(inFieldList) * 3, xByRIDFieldChanges(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
    RETURN hygieneDiffOverall_Standard & fieldDiffsOverall_Standard;
  END;
END;
