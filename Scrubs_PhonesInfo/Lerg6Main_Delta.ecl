IMPORT SALT311,STD;
EXPORT Lerg6Main_Delta(DATASET(Lerg6Main_Layout_Phonesinfo)old_s, DATASET(Lerg6Main_Layout_Phonesinfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','dt_start','dt_end','source','lata','lata_name','status','eff_date','eff_time','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','test_line_exp_time','blk_1000_pool','rc_lata','filler4','creation_date','creation_time','filler5','e_status_date','e_status_time','filler6','last_modified_date','last_modified_time','filler7','is_current','os1','os2','os3','os4','os5','os6','os7','os8','os9','os10','os11','os12','os13','os14','os15','os16','os17','os18','os19','os20','os21','os22','os23','os24','os25','notes','global_sid','record_sid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Lerg6Main_hygiene(old_s).Summary('Old') + Lerg6Main_hygiene(new_s).Summary('New') + Lerg6Main_hygiene(PROJECT(Differences(deleted), TRANSFORM(Lerg6Main_Layout_Phonesinfo, SELF := LEFT.old_rec))).Summary('Deletions') + Lerg6Main_hygiene(PROJECT(Differences(added), TRANSFORM(Lerg6Main_Layout_Phonesinfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, Lerg6Main_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
