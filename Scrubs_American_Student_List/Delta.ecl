IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_American_Student_List)old_s, DATASET(Layout_American_Student_List) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['key','ssn','did','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','historical_flag','full_name','first_name','last_name','address_1','address_2','city','state','zip','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type_code','address_type','county_number','county_name','gender_code','gender','age','birth_date','dob_formatted','telephone','class','college_class','college_name','ln_college_name','college_major','new_college_major','college_code','college_code_exploded','college_type','college_type_exploded','head_of_household_first_name','head_of_household_gender_code','head_of_household_gender','income_level_code','income_level','new_income_level_code','new_income_level','file_type','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','tier2','source'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_American_Student_List, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_American_Student_List, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_American_Student_List, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
