IMPORT SALT311,STD;
EXPORT Base_2020_Delta(DATASET(Base_2020_Layout_EBR)old_s, DATASET(Base_2020_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','trend_mm','trend_yy','dbt','acct_bal_mask','acct_bal','current_balance_pct','dbt_01_30_pct','dbt_31_60_pct','dbt_61_90_pct','dbt_91_plus_pct'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_2020_hygiene(old_s).Summary('Old') + Base_2020_hygiene(new_s).Summary('New') + Base_2020_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_2020_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_2020_hygiene(PROJECT(Differences(added), TRANSFORM(Base_2020_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2020_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
