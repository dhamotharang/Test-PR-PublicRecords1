IMPORT SALT311,STD;
EXPORT sentence_counties_Delta(DATASET(sentence_counties_Layout_crim)old_s, DATASET(sentence_counties_Layout_crim) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['recordid','statecode','caseid','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus','sourcename','vendor'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := sentence_counties_hygiene(old_s).Summary('Old',Glob) + sentence_counties_hygiene(new_s).Summary('New',Glob) + sentence_counties_hygiene(PROJECT(Differences(deleted), TRANSFORM(sentence_counties_Layout_crim, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + sentence_counties_hygiene(PROJECT(Differences(added), TRANSFORM(sentence_counties_Layout_crim, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, sentence_counties_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
