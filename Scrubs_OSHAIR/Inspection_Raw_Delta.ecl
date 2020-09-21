IMPORT SALT311,STD;
EXPORT Inspection_Raw_Delta(DATASET(Inspection_Raw_Layout)old_s, DATASET(Inspection_Raw_Layout) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['activity_nr','reporting_id','state_flag','site_state','site_zip','owner_type','owner_code','adv_notice','safety_hlth','sic_code','naics_code','insp_type','insp_scope','why_no_insp','union_status','safety_manuf','safety_const','safety_marit','health_manuf','health_const','health_marit','migrant','mail_state','mail_zip','host_est_key','nr_in_estab','open_date','case_mod_date','close_conf_date','close_case_date','open_year','case_mod_year','close_conf_year','close_case_year','estab_name'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Inspection_Raw_hygiene(old_s).Summary('Old') + Inspection_Raw_hygiene(new_s).Summary('New') + Inspection_Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Inspection_Raw_Layout, SELF := LEFT.old_rec))).Summary('Deletions') + Inspection_Raw_hygiene(PROJECT(Differences(added), TRANSFORM(Inspection_Raw_Layout, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, Inspection_Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
