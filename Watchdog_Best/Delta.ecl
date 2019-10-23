IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Hdr)old_s, DATASET(Layout_Hdr) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','address_ind','name_ind','persistent_record_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, inFieldList, rid);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Hdr, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Hdr, SELF := LEFT.new_rec))).Summary('Additions',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_Hdr, SELF := LEFT.new_rec))).Summary('Updates_NewFile',Glob) + hygiene(PROJECT(Differences(changed), TRANSFORM(Layout_Hdr, SELF := LEFT.old_rec))).Summary('Updates_OldFile',Glob);
  diffChanged := Differences(Changed);
  EXPORT DifferencesFieldChanges(BOOLEAN Glob = TRUE) := IF(Glob, SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList), SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, inFieldList, src));
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE, BOOLEAN doFieldDiffsGlobal = TRUE, BOOLEAN doFieldDiffsPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Watchdog_best, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
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
