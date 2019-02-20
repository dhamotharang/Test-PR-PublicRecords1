IMPORT SALT311,STD;
EXPORT Base_Verified_Delta(DATASET(Base_Verified_Layout_SKA)old_s, DATASET(Base_Verified_Layout_SKA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['id_ska','bdid','ttl','first_name','middle','last_name','t1','do','deptcode','dept_expl','key_file','company1','address1','city','state','zip','address2','city2','state2','zip2','fips','phone','spec','spec_expl','spec2','spec2_expl','spec3','spec3_expl','persid','owner','emailavail','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','alt_prim_range','alt_predir','alt_prim_name','alt_addr_suffix','alt_postdir','alt_unit_desig','alt_sec_range','alt_p_city_name','alt_v_city_name','alt_st','alt_zip','alt_zip4','alt_cart','alt_cr_sort_sz','alt_lot','alt_lot_order','alt_dbpc','alt_chk_digit','alt_rec_type','alt_ace_fips_state','alt_county','alt_geo_lat','alt_geo_long','alt_msa','alt_geo_blk','alt_geo_match','alt_err_stat','lf','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_Verified_hygiene(old_s).Summary('Old') + Base_Verified_hygiene(new_s).Summary('New') + Base_Verified_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Verified_Layout_SKA, SELF := LEFT.old_rec))).Summary('Deletions') + Base_Verified_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Verified_Layout_SKA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SKA, Base_Verified_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
