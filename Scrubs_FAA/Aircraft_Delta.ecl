IMPORT SALT38,STD;
EXPORT Aircraft_Delta(DATASET(Aircraft_Layout_FAA)old_s, DATASET(Aircraft_Layout_FAA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['d_score','best_ssn','did_out','bdid_out','date_first_seen','date_last_seen','current_flag','n_number','serial_number','mfr_mdl_code','eng_mfr_mdl','year_mfr','type_registrant','name','street','street2','city','state','zip_code','region','orig_county','country','last_action_date','cert_issue_date','certification','type_aircraft','type_engine','status_code','mode_s_code','fract_owner','aircraft_mfr_name','model_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','z4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','compname','lf','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Aircraft_hygiene(old_s).Summary('Old') + Aircraft_hygiene(new_s).Summary('New') + Aircraft_hygiene(PROJECT(Differences(deleted), TRANSFORM(Aircraft_Layout_FAA, SELF := LEFT.old_rec))).Summary('Deletions') + Aircraft_hygiene(PROJECT(Differences(added), TRANSFORM(Aircraft_Layout_FAA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Aircraft_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
