IMPORT SALT311,STD;
EXPORT Base_2025_Delta(DATASET(Base_2025_Layout_EBR)old_s, DATASET(Base_2025_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','quarter','quarter_yy','debt','account_balance_mask','account_balance','current_balance_percent','debt_01_30_percent','debt_31_60_percent','debt_61_90_percent','debt_91_plus_percent'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_2025_hygiene(old_s).Summary('Old') + Base_2025_hygiene(new_s).Summary('New') + Base_2025_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_2025_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_2025_hygiene(PROJECT(Differences(added), TRANSFORM(Base_2025_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_2025_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
