IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Patriot)old_s, DATASET(Layout_Patriot) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','global_sid','record_sid','did','aid_prim_range','aid_predir','aid_prim_name','aid_addr_suffix','aid_postdir','aid_unit_desig','aid_sec_range','aid_p_city_name','aid_v_city_name','aid_st','aid_zip','aid_zip4','aid_cart','aid_cr_sort_sz','aid_lot','aid_lot_order','aid_dpbc','aid_chk_digit','aid_record_type','aid_fips_st','aid_county','aid_geo_lat','aid_geo_long','aid_msa','aid_geo_blk','aid_geo_match','aid_err_stat','append_rawaid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Patriot, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Patriot, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Patriot, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
