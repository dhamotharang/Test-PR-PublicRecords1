IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_File)old_s, DATASET(Layout_File) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inquiry_History, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
