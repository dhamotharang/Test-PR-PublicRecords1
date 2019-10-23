IMPORT SALT311,STD;
EXPORT raw_Member_Delta(DATASET(raw_Member_Layout_BBB2)old_s, DATASET(raw_Member_Layout_BBB2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','member_title','member_attr_name1','member_attr1','member_attr_name2','member_attr2'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := raw_Member_hygiene(old_s).Summary('Old') + raw_Member_hygiene(new_s).Summary('New') + raw_Member_hygiene(PROJECT(Differences(deleted), TRANSFORM(raw_Member_Layout_BBB2, SELF := LEFT.old_rec))).Summary('Deletions') + raw_Member_hygiene(PROJECT(Differences(added), TRANSFORM(raw_Member_Layout_BBB2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BBB2, raw_Member_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
