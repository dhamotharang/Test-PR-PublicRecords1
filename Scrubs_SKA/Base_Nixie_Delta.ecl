IMPORT SALT311,STD;
EXPORT Base_Nixie_Delta(DATASET(Base_Nixie_Layout_SKA)old_s, DATASET(Base_Nixie_Layout_SKA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['id_ska','bdid','ttl','first_name','middle','last_name','t1','dept_code','dept_expl','spec','spec_expl','dept_file','company1','address1','city','state','zip','area_code','number','persid','nixie_date','title','fname','mname','lname','name_suffix','name_score','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dbpc','mail_chk_digit','mail_rec_type','mail_ace_fips_state','mail_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_Nixie_hygiene(old_s).Summary('Old') + Base_Nixie_hygiene(new_s).Summary('New') + Base_Nixie_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Nixie_Layout_SKA, SELF := LEFT.old_rec))).Summary('Deletions') + Base_Nixie_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Nixie_Layout_SKA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SKA, Base_Nixie_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
