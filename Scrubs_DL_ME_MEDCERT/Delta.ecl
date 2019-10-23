IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_In_ME_MEDCERT)old_s, DATASET(Layout_In_ME_MEDCERT) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['append_process_date','orig_dob','orig_credential_type','orig_id_terminal_date','orig_lname','orig_fname','orig_mi','orig_namesuf','orig_street','orig_city','orig_state','orig_zip','orig_drivered','orig_sex','orig_height','orig_height2','orig_weight','orig_hair','orig_eyes','orig_dlexpiredate','orig_dlstat','orig_dlissuedate','orig_originalissuedate','orig_regstatfr','orig_regstatcr','orig_dlclass','orig_historynum','orig_disabledvet','orig_photo','orig_habitualoffender','orig_restrictions','orig_endorsements','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_endorsements6','orig_endorsements7','orig_endorsements8','orig_endorsements9','orig_endorsements10','orig_endorsements11_20','orig_comm_driv_status','orig_disabled_vet_type','orig_organ_donor','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_ME_MEDCERT, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_ME_MEDCERT, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_ME_MEDCERT, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
