IMPORT SALT38,STD;
EXPORT Airmen_Delta(DATASET(Airmen_Layout_FAA)old_s, DATASET(Airmen_Layout_FAA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['d_score','best_ssn','did_out','date_first_seen','date_last_seen','current_flag','record_type','letter_code','unique_id','orig_rec_type','orig_fname','orig_lname','street1','street2','city','state','zip_code','country','region','med_class','med_date','med_exp_date','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','oer','source'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Airmen_hygiene(old_s).Summary('Old') + Airmen_hygiene(new_s).Summary('New') + Airmen_hygiene(PROJECT(Differences(deleted), TRANSFORM(Airmen_Layout_FAA, SELF := LEFT.old_rec))).Summary('Deletions') + Airmen_hygiene(PROJECT(Differences(added), TRANSFORM(Airmen_Layout_FAA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Airmen_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
