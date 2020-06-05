IMPORT SALT311,STD;
EXPORT InputB_Delta(DATASET(InputB_Layout_OneKey)old_s, DATASET(InputB_Layout_OneKey) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['hcp_hce_id','ok_indv_id','ska_uid','ims_id','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','xref_hce_id','city_nm','st_cd','zip5_cd'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := InputB_hygiene(old_s).Summary('Old') + InputB_hygiene(new_s).Summary('New') + InputB_hygiene(PROJECT(Differences(deleted), TRANSFORM(InputB_Layout_OneKey, SELF := LEFT.old_rec))).Summary('Deletions') + InputB_hygiene(PROJECT(Differences(added), TRANSFORM(InputB_Layout_OneKey, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, InputB_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
