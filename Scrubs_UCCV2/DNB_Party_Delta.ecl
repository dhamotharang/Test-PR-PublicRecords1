IMPORT SALT39,STD;
EXPORT DNB_Party_Delta(DATASET(DNB_Party_Layout_UCCV2)old_s, DATASET(DNB_Party_Layout_UCCV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['tmsid','rmsid','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','duns_number','hq_duns_number','ssn','fein','incorp_state','corp_number','corp_type','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_country','orig_province','orig_postal_code','foreign_indc','party_type','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','process_date','title','fname','mname','lname','name_suffix','name_score','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','county','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','bdid','did','did_score','bdid_score','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','prep_addr_line1','prep_addr_last_line','rawaid','aceaid','persistent_record_id'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DNB_Party_hygiene(old_s).Summary('Old') + DNB_Party_hygiene(new_s).Summary('New') + DNB_Party_hygiene(PROJECT(Differences(deleted), TRANSFORM(DNB_Party_Layout_UCCV2, SELF := LEFT.old_rec))).Summary('Deletions') + DNB_Party_hygiene(PROJECT(Differences(added), TRANSFORM(DNB_Party_Layout_UCCV2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_UCCV2, DNB_Party_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
