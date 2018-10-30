IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_In_MO_MEDCERT)old_s, DATASET(Layout_In_MO_MEDCERT) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','unique_key','license_number','last_name','first_name','middle_name','suffix','date_of_birth','gender','address','city','state','zip5','zip4','mailing_address1','mailing_address2','mailing_city','mailing_state','mailing_zip','height','eye_color','operator_status','commercial_status','sch_bus_status','pending_act_code','must_test_ind','deceased_ind','prev_cdl_class','cdl_ptr','pdps_ptr','mvr_privacy_code','brc_status_code','brc_status_date','lic_iss_code','license_class','lic_exp_date','lic_seq_number','lic_surrender_to','new_out_of_st_dl_num','license_endorsements','license_restrictions','license_trans_type','lic_print_date','permit_iss_code','permit_class','permit_exp_date','permit_seq_number','permit_endorse_codes','permit_restric_codes','permit_trans_type','permit_print_date','non_driver_code','non_driver_exp_date','non_driver_seq_num','non_driver_trans_type','non_driver_print_date','action_surrender_date','action_counts','driv_priv_counts','conv_counts','accidents_counts','aka_counts','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','previous_dl_number','previous_st','old_dl_number'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_MO_MEDCERT, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_MO_MEDCERT, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MO_MEDCERT, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
