IMPORT SALT311,STD;
EXPORT Base_Delta(DATASET(Base_Layout_OneKey)old_s, DATASET(Base_Layout_OneKey) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['source','bdid','bdid_score','source_rec_id','dt_vendor_first_reported','dt_vendor_last_reported','record_type','hcp_hce_id','ok_indv_id','ska_uid','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','sec_spcl_cd','sec_spcl_desc','tert_spcl_cd','tert_spcl_desc','sub_spcl_cd','sub_spcl_desc','titl_typ_id','titl_typ_desc','hco_hce_id','ok_wkp_id','ska_id','bus_nm','dba_nm','addr_id','str_front_id','addr_ln_1_txt','addr_ln_2_txt','city_nm','st_cd','zip5_cd','zip4_cd','fips_cnty_cd','fips_cnty_desc','telephn_nbr','cot_id','cot_clas_id','cot_clas_desc','cot_fclt_typ_id','cot_fclt_typ_desc','cot_spcl_id','cot_spcl_desc','email_ind_flag','ims_id','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','cleaned_deactv_dt','xref_hce_id','title','fname','mname','lname','name_suffix','name_score','prep_addr_line1','prep_addr_line_last','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_OneKey, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_OneKey, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
