﻿IMPORT SALT311,STD;
EXPORT Companies_Delta(DATASET(Companies_Layout_Sheila_Greco)old_s, DATASET(Companies_Layout_Sheila_Greco) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincompanyid','rawfields_companyname','rawfields_ticker','rawfields_fortunerank','rawfields_primaryindustry','rawfields_address1','rawfields_address2','rawfields_city','rawfields_state','rawfields_zip','rawfields_country','rawfields_region','rawfields_phone','rawfields_extension','rawfields_weburl','rawfields_sales','rawfields_employees','rawfields_competitors','rawfields_divisionname','rawfields_siccode','rawfields_auditor','rawfields_entrydate','rawfields_lastupdate','rawfields_entrystaffid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_phone','global_sid','record_sid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Companies_hygiene(old_s).Summary('Old') + Companies_hygiene(new_s).Summary('New') + Companies_hygiene(PROJECT(Differences(deleted), TRANSFORM(Companies_Layout_Sheila_Greco, SELF := LEFT.old_rec))).Summary('Deletions') + Companies_hygiene(PROJECT(Differences(added), TRANSFORM(Companies_Layout_Sheila_Greco, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Sheila_Greco, Companies_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
