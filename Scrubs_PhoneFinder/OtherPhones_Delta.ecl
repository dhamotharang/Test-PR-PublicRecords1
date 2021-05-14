IMPORT SALT311,STD;
EXPORT OtherPhones_Delta(DATASET(OtherPhones_Layout_PhoneFinder)old_s, DATASET(OtherPhones_Layout_PhoneFinder) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['transaction_id','sequence_number','phone_id','phonenumber','risk_indicator','phone_type','phone_status','listing_name','porting_code','phone_forwarded','verified_carrier','date_added','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := OtherPhones_hygiene(old_s).Summary('Old') + OtherPhones_hygiene(new_s).Summary('New') + OtherPhones_hygiene(PROJECT(Differences(deleted), TRANSFORM(OtherPhones_Layout_PhoneFinder, SELF := LEFT.old_rec))).Summary('Deletions') + OtherPhones_hygiene(PROJECT(Differences(added), TRANSFORM(OtherPhones_Layout_PhoneFinder, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, OtherPhones_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
