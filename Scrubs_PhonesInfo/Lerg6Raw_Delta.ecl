IMPORT SALT311,STD;
EXPORT Lerg6Raw_Delta(DATASET(Lerg6Raw_Layout_Phonesinfo)old_s, DATASET(Lerg6Raw_Layout_Phonesinfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['lata','lata_name','status','eff_date','npa','nxx','block_id','filler1','coc_type','ssc','dind','td_eo','td_at','portable','aocn','filler2','ocn','loc_name','loc','loc_state','rc_abbre','rc_ty','line_fr','line_to','switch','sha_indicator','filler3','test_line_num','test_line_response','test_line_exp_date','blk_1000_pool','rc_lata','filler4','creation_date','filler5','e_status_date','filler6','last_modified_date','filler7','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Lerg6Raw_hygiene(old_s).Summary('Old') + Lerg6Raw_hygiene(new_s).Summary('New') + Lerg6Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Lerg6Raw_Layout_Phonesinfo, SELF := LEFT.old_rec))).Summary('Deletions') + Lerg6Raw_hygiene(PROJECT(Differences(added), TRANSFORM(Lerg6Raw_Layout_Phonesinfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, Lerg6Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
