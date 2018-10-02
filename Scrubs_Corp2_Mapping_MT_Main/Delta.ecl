IMPORT SALT38,STD,corp2_mapping;
EXPORT Delta(DATASET(corp2_mapping.LayoutsCommon.Main)old_s, DATASET(corp2_mapping.LayoutsCommon.Main) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_ln_name_type_cd','corp_filing_date','corp_inc_date','corp_forgn_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_term_exist_cd','corp_term_exist_exp','corp_status_desc','corp_status_comment','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_renewal_date','cont_title1_desc','recordorigin'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(corp2_mapping.LayoutsCommon.Main, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(corp2_mapping.LayoutsCommon.Main, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MT_Main, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;

