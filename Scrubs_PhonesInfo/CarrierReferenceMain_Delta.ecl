IMPORT SALT311,STD;
EXPORT CarrierReferenceMain_Delta(DATASET(CarrierReferenceMain_Layout_PhonesInfo)old_s, DATASET(CarrierReferenceMain_Layout_PhonesInfo) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','dt_start','dt_end','ocn','carrier_name','serv','line','prepaid','high_risk_indicator','activation_dt','number_in_service','spid','operator_full_name','is_current','override_file','data_type','ocn_state','overall_ocn','target_ocn','overall_target_ocn','ocn_abbr_name','rural_lec_indicator','small_ilec_indicator','category','carrier_address1','carrier_address2','carrier_floor','carrier_room','carrier_city','carrier_state','carrier_zip','carrier_phone','affiliated_to','overall_company','contact_function','contact_name','contact_title','contact_address1','contact_address2','contact_city','contact_state','contact_zip','contact_phone','contact_fax','contact_email','contact_information','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','address_type','privacy_indicator'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := CarrierReferenceMain_hygiene(old_s).Summary('Old') + CarrierReferenceMain_hygiene(new_s).Summary('New') + CarrierReferenceMain_hygiene(PROJECT(Differences(deleted), TRANSFORM(CarrierReferenceMain_Layout_PhonesInfo, SELF := LEFT.old_rec))).Summary('Deletions') + CarrierReferenceMain_hygiene(PROJECT(Differences(added), TRANSFORM(CarrierReferenceMain_Layout_PhonesInfo, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, CarrierReferenceMain_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
