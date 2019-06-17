IMPORT SALT311,STD;
EXPORT raw_NonMember_Delta(DATASET(raw_NonMember_Layout_BBB2)old_s, DATASET(raw_NonMember_Layout_BBB2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','non_member_title','non_member_category'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := raw_NonMember_hygiene(old_s).Summary('Old') + raw_NonMember_hygiene(new_s).Summary('New') + raw_NonMember_hygiene(PROJECT(Differences(deleted), TRANSFORM(raw_NonMember_Layout_BBB2, SELF := LEFT.old_rec))).Summary('Deletions') + raw_NonMember_hygiene(PROJECT(Differences(added), TRANSFORM(raw_NonMember_Layout_BBB2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BBB2, raw_NonMember_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
