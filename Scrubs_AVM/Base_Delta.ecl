IMPORT SALT38,STD;
EXPORT Base_Delta(DATASET(Base_Layout_AVM)old_s, DATASET(Base_Layout_AVM) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['history_date','ln_fares_id_ta','ln_fares_id_pi','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use','recording_date','assessed_value_year','sales_price','assessed_total_value','market_total_value','tax_assessment_valuation','price_index_valuation','hedonic_valuation','automated_valuation','confidence_score','comp1','comp2','comp3','comp4','comp5','nearby1','nearby2','nearby3','nearby4','nearby5','history_history_date','history_land_use','history_recording_date','history_assessed_value_year','history_sales_price','history_assessed_total_value','history_market_total_value','history_tax_assessment_valuation','history_price_index_valuation','history_hedonic_valuation','history_automated_valuation','history_confidence_score'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_AVM, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_AVM, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
