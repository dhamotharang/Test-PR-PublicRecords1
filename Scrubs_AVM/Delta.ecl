IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_AVM)old_s, DATASET(Layout_AVM) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['seq','ln_fares_id','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use_code','sales_price','sales_price_code','recording_date','assessed_value_year','assessed_total_value','market_total_value','lot_size','building_area','year_built','no_of_stories','no_of_rooms','no_of_bedrooms','no_of_baths'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_AVM, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_AVM, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
