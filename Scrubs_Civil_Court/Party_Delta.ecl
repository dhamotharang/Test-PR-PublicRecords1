﻿IMPORT SALT39,STD;
EXPORT Party_Delta(DATASET(Party_Layout_Civil_Court)old_s, DATASET(Party_Layout_Civil_Court) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','ruled_for_against_code','ruled_for_against','entity_1','entity_nm_format_1','entity_type_code_1_orig','entity_type_description_1_orig','entity_type_code_1_master','entity_seq_num_1','atty_seq_num_1','entity_1_address_1','entity_1_address_2','entity_1_address_3','entity_1_address_4','entity_1_dob','primary_entity_2','entity_nm_format_2','entity_type_code_2_orig','entity_type_description_2_orig','entity_type_code_2_master','entity_seq_num_2','atty_seq_num_2','entity_2_address_1','entity_2_address_2','entity_2_address_3','entity_2_address_4','entity_2_dob','prim_range1','predir1','prim_name1','addr_suffix1','postdir1','unit_desig1','sec_range1','p_city_name1','v_city_name1','st1','zip1','zip41','cart1','cr_sort_sz1','lot1','lot_order1','dpbc1','chk_digit1','rec_type1','ace_fips_st1','ace_fips_county1','geo_lat1','geo_long1','msa1','geo_blk1','geo_match1','err_stat1','prim_range2','predir2','prim_name2','addr_suffix2','postdir2','unit_desig2','sec_range2','p_city_name2','v_city_name2','st2','zip2','zip42','cart2','cr_sort_sz2','lot2','lot_order2','dpbc2','chk_digit2','rec_type2','ace_fips_st2','ace_fips_county2','geo_lat2','geo_long2','msa2','geo_blk2','geo_match2','err_stat2','e1_title1','e1_fname1','e1_mname1','e1_lname1','e1_suffix1','e1_pname1_score','e1_cname1','e1_title2','e1_fname2','e1_mname2','e1_lname2','e1_suffix2','e1_pname2_score','e1_cname2','e1_title3','e1_fname3','e1_mname3','e1_lname3','e1_suffix3','e1_pname3_score','e1_cname3','e1_title4','e1_fname4','e1_mname4','e1_lname4','e1_suffix4','e1_pname4_score','e1_cname4','e1_title5','e1_fname5','e1_mname5','e1_lname5','e1_suffix5','e1_pname5_score','e1_cname5','e2_title1','e2_fname1','e2_mname1','e2_lname1','e2_suffix1','e2_pname1_score','e2_cname1','e2_title2','e2_fname2','e2_mname2','e2_lname2','e2_suffix2','e2_pname2_score','e2_cname2','e2_title3','e2_fname3','e2_mname3','e2_lname3','e2_suffix3','e2_pname3_score','e2_cname3','e2_title4','e2_fname4','e2_mname4','e2_lname4','e2_suffix4','e2_pname4_score','e2_cname4','e2_title5','e2_fname5','e2_mname5','e2_lname5','e2_suffix5','e2_pname5_score','e2_cname5','v1_title1','v1_fname1','v1_mname1','v1_lname1','v1_suffix1','v1_pname1_score','v1_cname1','v1_title2','v1_fname2','v1_mname2','v1_lname2','v1_suffix2','v1_pname2_score','v1_cname2','v1_title3','v1_fname3','v1_mname3','v1_lname3','v1_suffix3','v1_pname3_score','v1_cname3','v1_title4','v1_fname4','v1_mname4','v1_lname4','v1_suffix4','v1_pname4_score','v1_cname4','v1_title5','v1_fname5','v1_mname5','v1_lname5','v1_suffix5','v1_pname5_score','v1_cname5','v2_title1','v2_fname1','v2_mname1','v2_lname1','v2_suffix1','v2_pname1_score','v2_cname1','v2_title2','v2_fname2','v2_mname2','v2_lname2','v2_suffix2','v2_pname2_score','v2_cname2','v2_title3','v2_fname3','v2_mname3','v2_lname3','v2_suffix3','v2_pname3_score','v2_cname3','v2_title4','v2_fname4','v2_mname4','v2_lname4','v2_suffix4','v2_pname4_score','v2_cname4','v2_title5','v2_fname5','v2_mname5','v2_lname5','v2_suffix5','v2_pname5_score','v2_cname5'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Party_hygiene(old_s).Summary('Old') + Party_hygiene(new_s).Summary('New') + Party_hygiene(PROJECT(Differences(deleted), TRANSFORM(Party_Layout_Civil_Court, SELF := LEFT.old_rec))).Summary('Deletions') + Party_hygiene(PROJECT(Differences(added), TRANSFORM(Party_Layout_Civil_Court, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Party_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
