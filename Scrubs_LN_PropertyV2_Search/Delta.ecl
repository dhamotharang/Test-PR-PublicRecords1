IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_LN_PropertyV2_Search)old_s, DATASET(Layout_LN_PropertyV2_Search) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','vendor_source_flag','ln_fares_id','process_date','source_code','which_orig','conjunctive_name_seq','title','fname','mname','lname','name_suffix','cname','nameasis','append_prepaddr1','append_prepaddr2','append_rawaid','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone_number','name_type','prop_addr_propagated_ind','did','bdid','app_ssn','app_tax_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','ln_party_status','ln_percentage_ownership','ln_entity_type','ln_estate_trust_date','ln_goverment_type','xadl2_weight','addr_ind','best_addr_ind','addr_tx_id','best_addr_tx_id','location_id','best_locid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_LN_PropertyV2_Search, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_LN_PropertyV2_Search, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LN_PropertyV2_Search, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
