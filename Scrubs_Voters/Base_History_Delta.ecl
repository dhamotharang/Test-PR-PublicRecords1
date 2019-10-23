IMPORT SALT39,STD;
EXPORT Base_History_Delta(DATASET(Base_History_Layout_Voters)old_s, DATASET(Base_History_Layout_Voters) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['vtid','voted_year','primary','special_1','other','special_2','general','pres','vote_date'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_History_hygiene(old_s).Summary('Old') + Base_History_hygiene(new_s).Summary('New') + Base_History_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_History_Layout_Voters, SELF := LEFT.old_rec))).Summary('Deletions') + Base_History_hygiene(PROJECT(Differences(added), TRANSFORM(Base_History_Layout_Voters, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Voters, Base_History_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
