IMPORT SALT311,STD;
EXPORT Moxie_DOC_Offenses_Dev_Delta(DATASET(Moxie_DOC_Offenses_Dev_Layout_crim)old_s, DATASET(Moxie_DOC_Offenses_Dev_Layout_crim) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','offender_key','vendor','county_of_origin','source_file','data_type','record_type','orig_state','offense_key','off_date','arr_date','case_num','total_num_of_offenses','num_of_counts','off_code','chg','chg_typ_flg','off_of_record','off_desc_1','off_desc_2','add_off_cd','add_off_desc','off_typ','off_lev','arr_disp_date','arr_disp_cd','arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','court_cd','court_desc','ct_dist','ct_fnl_plea_cd','ct_fnl_plea','ct_off_code','ct_chg','ct_chg_typ_flg','ct_off_desc_1','ct_off_desc_2','ct_addl_desc_cd','ct_off_lev','ct_disp_dt','ct_disp_cd','ct_disp_desc_1','ct_disp_desc_2','cty_conv_cd','cty_conv','adj_wthd','stc_dt','stc_cd','stc_comp','stc_desc_1','stc_desc_2','stc_desc_3','stc_desc_4','stc_lgth','stc_lgth_desc','inc_adm_dt','min_term','min_term_desc','max_term','max_term_desc','parole','probation','offensetown','convict_dt','court_county','fcra_offense_key','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id','offense_category','hyg_classification_code','old_ln_offense_score'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := Moxie_DOC_Offenses_Dev_hygiene(old_s).Summary('Old',Glob) + Moxie_DOC_Offenses_Dev_hygiene(new_s).Summary('New',Glob) + Moxie_DOC_Offenses_Dev_hygiene(PROJECT(Differences(deleted), TRANSFORM(Moxie_DOC_Offenses_Dev_Layout_crim, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + Moxie_DOC_Offenses_Dev_hygiene(PROJECT(Differences(added), TRANSFORM(Moxie_DOC_Offenses_Dev_Layout_crim, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, Moxie_DOC_Offenses_Dev_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
