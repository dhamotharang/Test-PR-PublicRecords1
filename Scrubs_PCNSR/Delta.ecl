IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_PCNSR)old_s, DATASET(Layout_PCNSR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['title','fname','mname','lname','name_suffix','name_score','fname_orig','mname_orig','lname_orig','name_suffix_orig','title_orig','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','hhid','did','did_score','phone_fordid','gender','date_of_birth','address_type','demographic_level_indicator','length_of_residence','location_type','dqi2_occupancy_count','delivery_unit_size','household_arrival_date','area_code','phone_number','telephone_number_type','phone2_number','telephone2_number_type','time_zone','refresh_date','name_address_verification_source','drop_indicator','do_not_mail_flag','do_not_call_flag','business_file_hit_flag','spouse_title','spouse_fname','spouse_mname','spouse_lname','spouse_name_suffix','spouse_fname_orig','spouse_mname_orig','spouse_lname_orig','spouse_name_suffix_orig','spouse_title_orig','spouse_gender','spouse_date_of_birth','spouse_indicator','household_income','find_income_in_1000s','phhincomeunder25k','phhincome50kplus','phhincome200kplus','medianhhincome','own_rent','homeowner_source_code','telephone_acquisition_date','recency_date','source'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_PCNSR, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_PCNSR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PCNSR, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
