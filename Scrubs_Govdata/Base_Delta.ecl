IMPORT SALT311,STD;
EXPORT Base_Delta(DATASET(Base_Layout_SEC_BrokerDealer)old_s, DATASET(Base_Layout_SEC_BrokerDealer) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','cik_number','company_name','reporting_file_number','address1','address2','city','state_code','zip_code','irs_taxpayer_id','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','is_company_flag','cname','lf'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_SEC_BrokerDealer, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_SEC_BrokerDealer, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Govdata, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
