IMPORT SALT311,STD;
EXPORT Base_1000_Delta(DATASET(Base_1000_Layout_EBR)old_s, DATASET(Base_1000_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','current_dbt','predicted_dbt','orig_predicted_dbt_date_mmddyy','average_industry_dbt','average_all_industries_dbt','low_balance','high_balance','current_account_balance','high_credit_extended','median_credit_extended','payment_performance','payment_trend','industry_description','predicted_dbt_date'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_1000_hygiene(old_s).Summary('Old') + Base_1000_hygiene(new_s).Summary('New') + Base_1000_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_1000_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_1000_hygiene(PROJECT(Differences(added), TRANSFORM(Base_1000_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_1000_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
