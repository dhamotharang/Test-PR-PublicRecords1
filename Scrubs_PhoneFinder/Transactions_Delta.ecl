IMPORT SALT311,STD;
EXPORT Transactions_Delta(DATASET(Transactions_Layout_PhoneFinder)old_s, DATASET(Transactions_Layout_PhoneFinder) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['transaction_id','transaction_date','user_id','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','reference_code','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','submitted_streetaddress1','submitted_city','submitted_state','submitted_zip','phonenumber','data_source','royalty_used','carrier','risk_indicator','phone_type','phone_status','ported_count','last_ported_date','otp_count','last_otp_date','spoof_count','last_spoof_date','phone_forwarded','date_added','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Transactions_hygiene(old_s).Summary('Old') + Transactions_hygiene(new_s).Summary('New') + Transactions_hygiene(PROJECT(Differences(deleted), TRANSFORM(Transactions_Layout_PhoneFinder, SELF := LEFT.old_rec))).Summary('Deletions') + Transactions_hygiene(PROJECT(Differences(added), TRANSFORM(Transactions_Layout_PhoneFinder, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Transactions_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
