IMPORT SALT311,STD,Corp2_Mapping;
EXPORT Delta(DATASET(Corp2_Mapping.LayoutsCommon.AR)old_s, DATASET(Corp2_Mapping.LayoutsCommon.AR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_mailed_dt','ar_due_dt','ar_filed_dt','ar_report_dt','ar_report_nbr','ar_franchise_tax_paid_dt','ar_delinquent_dt','ar_tax_factor','ar_tax_amount_paid','ar_annual_report_cap','ar_illinois_capital','ar_roll','ar_frame','ar_extension','ar_microfilm_nbr','ar_comment','ar_type','ar_exempt','ar_license_tax_amount','ar_status','ar_paid_date','ar_prev_paid_date','ar_prev_tax_factor','ar_extension_date','ar_report_mail_date','ar_deliquent_report_mail_date','ar_report_filed_date','ar_year_and_month_due'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Corp2_Mapping.LayoutsCommon.AR, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Corp2_Mapping.LayoutsCommon.AR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MI_AR, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;