IMPORT SALT311,STD;
EXPORT alias_counties_Delta(DATASET(alias_counties_Layout_crim)old_s, DATASET(alias_counties_Layout_crim) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akasuffix','akadob','sourcename','vendor'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := alias_counties_hygiene(old_s).Summary('Old',Glob) + alias_counties_hygiene(new_s).Summary('New',Glob) + alias_counties_hygiene(PROJECT(Differences(deleted), TRANSFORM(alias_counties_Layout_crim, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + alias_counties_hygiene(PROJECT(Differences(added), TRANSFORM(alias_counties_Layout_crim, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, alias_counties_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
