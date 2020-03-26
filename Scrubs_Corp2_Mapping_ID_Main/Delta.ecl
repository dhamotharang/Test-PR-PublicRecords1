IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_in_file)old_s, DATASET(Layout_in_file) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_status_date','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_forgn_date','corp_term_exist_cd','corp_term_exist_desc','corp_orig_org_structure_desc','corp_for_profit_ind','corp_name_reservation_expiration_date','corp_orig_bus_type_desc','corp_management_desc','corp_fiscal_year_month','corp_agent_county','InternalField1','InternalField2','InternalField3','recordorigin'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_in_file, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_in_file, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_ID_Main, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
