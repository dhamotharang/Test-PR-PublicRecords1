IMPORT SALT39,STD;
EXPORT InquiryLogs_Delta(DATASET(InquiryLogs_Layout_InquiryLogs)old_s, DATASET(InquiryLogs_Layout_InquiryLogs) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['transaction_id','datetime','full_name','title','fname','mname','lname','name_suffix','ssn','appended_ssn','address','city','state','zip','fips_county','personal_phone','dob','email_address','dl_st','dl','ipaddr','geo_lat','geo_long','Source'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := InquiryLogs_hygiene(old_s).Summary('Old') + InquiryLogs_hygiene(new_s).Summary('New') + InquiryLogs_hygiene(PROJECT(Differences(deleted), TRANSFORM(InquiryLogs_Layout_InquiryLogs, SELF := LEFT.old_rec))).Summary('Deletions') + InquiryLogs_hygiene(PROJECT(Differences(added), TRANSFORM(InquiryLogs_Layout_InquiryLogs, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, InquiryLogs_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
