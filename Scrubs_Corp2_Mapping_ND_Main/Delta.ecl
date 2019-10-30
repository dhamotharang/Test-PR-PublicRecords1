IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_In_ND)old_s, DATASET(Layout_In_ND) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_trademark_filing_date','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_filing_date','corp_status_date','corp_status_desc','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_forgn_date','corp_for_profit_ind','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_delayed_effective_date','corp_term_exist_exp','corp_trademark_expiration_date','recordorigin'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_ND, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_ND, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_ND_Main, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
