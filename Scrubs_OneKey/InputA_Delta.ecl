IMPORT SALT311,STD;
EXPORT InputA_Delta(DATASET(InputA_Layout_OneKey)old_s, DATASET(InputA_Layout_OneKey) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','hcp_affil_xid','delta_cd'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := InputA_hygiene(old_s).Summary('Old') + InputA_hygiene(new_s).Summary('New') + InputA_hygiene(PROJECT(Differences(deleted), TRANSFORM(InputA_Layout_OneKey, SELF := LEFT.old_rec))).Summary('Deletions') + InputA_hygiene(PROJECT(Differences(added), TRANSFORM(InputA_Layout_OneKey, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, InputA_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
