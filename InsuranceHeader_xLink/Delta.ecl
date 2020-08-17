IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_InsuranceHeader)old_s, DATASET(Layout_InsuranceHeader) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['SNAME','FNAME','MNAME','LNAME','DERIVED_GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','ST','ZIP','SSN5','SSN4','DOB','PHONE','DL_STATE','DL_NBR','SRC','SOURCE_RID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_EFFECTIVE_FIRST','DT_EFFECTIVE_LAST'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, RID);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_InsuranceHeader, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_InsuranceHeader, SELF := LEFT.new_rec))).Summary('Additions',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_InsuranceHeader, SELF := LEFT.new_rec))).Summary('Updates_NewFile',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_InsuranceHeader, SELF := LEFT.old_rec))).Summary('Updates_OldFile',Glob);
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges(BOOLEAN Glob = TRUE) := IF(Glob, SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList), SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList, SRC));
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE, BOOLEAN doFieldDiffsPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(InsuranceHeader_xLink, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
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
