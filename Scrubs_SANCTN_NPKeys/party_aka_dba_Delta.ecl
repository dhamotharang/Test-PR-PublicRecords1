IMPORT SALT311,STD;
EXPORT party_aka_dba_Delta(DATASET(party_aka_dba_Layout_SANCTN_NPKeys)old_s, DATASET(party_aka_dba_Layout_SANCTN_NPKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch','dbcode','incident_num','party_num','name_type','first_name','middle_name','last_name','aka_dba_text','party_key'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := party_aka_dba_hygiene(old_s).Summary('Old',Glob) + party_aka_dba_hygiene(new_s).Summary('New',Glob) + party_aka_dba_hygiene(PROJECT(Differences(deleted), TRANSFORM(party_aka_dba_Layout_SANCTN_NPKeys, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + party_aka_dba_hygiene(PROJECT(Differences(added), TRANSFORM(party_aka_dba_Layout_SANCTN_NPKeys, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTN_NPKeys, party_aka_dba_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
