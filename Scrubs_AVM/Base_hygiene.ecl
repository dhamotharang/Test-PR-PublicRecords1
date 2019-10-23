IMPORT SALT38,STD;
EXPORT Base_hygiene(dataset(Base_layout_AVM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_history_date_cnt := COUNT(GROUP,h.history_date <> (TYPEOF(h.history_date))'');
    populated_history_date_pcnt := AVE(GROUP,IF(h.history_date = (TYPEOF(h.history_date))'',0,100));
    maxlength_history_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_date)));
    avelength_history_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_date)),h.history_date<>(typeof(h.history_date))'');
    populated_ln_fares_id_ta_cnt := COUNT(GROUP,h.ln_fares_id_ta <> (TYPEOF(h.ln_fares_id_ta))'');
    populated_ln_fares_id_ta_pcnt := AVE(GROUP,IF(h.ln_fares_id_ta = (TYPEOF(h.ln_fares_id_ta))'',0,100));
    maxlength_ln_fares_id_ta := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id_ta)));
    avelength_ln_fares_id_ta := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id_ta)),h.ln_fares_id_ta<>(typeof(h.ln_fares_id_ta))'');
    populated_ln_fares_id_pi_cnt := COUNT(GROUP,h.ln_fares_id_pi <> (TYPEOF(h.ln_fares_id_pi))'');
    populated_ln_fares_id_pi_pcnt := AVE(GROUP,IF(h.ln_fares_id_pi = (TYPEOF(h.ln_fares_id_pi))'',0,100));
    maxlength_ln_fares_id_pi := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id_pi)));
    avelength_ln_fares_id_pi := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id_pi)),h.ln_fares_id_pi<>(typeof(h.ln_fares_id_pi))'');
    populated_unformatted_apn_cnt := COUNT(GROUP,h.unformatted_apn <> (TYPEOF(h.unformatted_apn))'');
    populated_unformatted_apn_pcnt := AVE(GROUP,IF(h.unformatted_apn = (TYPEOF(h.unformatted_apn))'',0,100));
    maxlength_unformatted_apn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unformatted_apn)));
    avelength_unformatted_apn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unformatted_apn)),h.unformatted_apn<>(typeof(h.unformatted_apn))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_lat_cnt := COUNT(GROUP,h.lat <> (TYPEOF(h.lat))'');
    populated_lat_pcnt := AVE(GROUP,IF(h.lat = (TYPEOF(h.lat))'',0,100));
    maxlength_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lat)));
    avelength_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lat)),h.lat<>(typeof(h.lat))'');
    populated_long_cnt := COUNT(GROUP,h.long <> (TYPEOF(h.long))'');
    populated_long_pcnt := AVE(GROUP,IF(h.long = (TYPEOF(h.long))'',0,100));
    maxlength_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.long)));
    avelength_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.long)),h.long<>(typeof(h.long))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_fips_code_cnt := COUNT(GROUP,h.fips_code <> (TYPEOF(h.fips_code))'');
    populated_fips_code_pcnt := AVE(GROUP,IF(h.fips_code = (TYPEOF(h.fips_code))'',0,100));
    maxlength_fips_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_code)));
    avelength_fips_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_code)),h.fips_code<>(typeof(h.fips_code))'');
    populated_land_use_cnt := COUNT(GROUP,h.land_use <> (TYPEOF(h.land_use))'');
    populated_land_use_pcnt := AVE(GROUP,IF(h.land_use = (TYPEOF(h.land_use))'',0,100));
    maxlength_land_use := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.land_use)));
    avelength_land_use := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.land_use)),h.land_use<>(typeof(h.land_use))'');
    populated_recording_date_cnt := COUNT(GROUP,h.recording_date <> (TYPEOF(h.recording_date))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_assessed_value_year_cnt := COUNT(GROUP,h.assessed_value_year <> (TYPEOF(h.assessed_value_year))'');
    populated_assessed_value_year_pcnt := AVE(GROUP,IF(h.assessed_value_year = (TYPEOF(h.assessed_value_year))'',0,100));
    maxlength_assessed_value_year := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_value_year)));
    avelength_assessed_value_year := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_value_year)),h.assessed_value_year<>(typeof(h.assessed_value_year))'');
    populated_sales_price_cnt := COUNT(GROUP,h.sales_price <> (TYPEOF(h.sales_price))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_assessed_total_value_cnt := COUNT(GROUP,h.assessed_total_value <> (TYPEOF(h.assessed_total_value))'');
    populated_assessed_total_value_pcnt := AVE(GROUP,IF(h.assessed_total_value = (TYPEOF(h.assessed_total_value))'',0,100));
    maxlength_assessed_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_total_value)));
    avelength_assessed_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_total_value)),h.assessed_total_value<>(typeof(h.assessed_total_value))'');
    populated_market_total_value_cnt := COUNT(GROUP,h.market_total_value <> (TYPEOF(h.market_total_value))'');
    populated_market_total_value_pcnt := AVE(GROUP,IF(h.market_total_value = (TYPEOF(h.market_total_value))'',0,100));
    maxlength_market_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.market_total_value)));
    avelength_market_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.market_total_value)),h.market_total_value<>(typeof(h.market_total_value))'');
    populated_tax_assessment_valuation_cnt := COUNT(GROUP,h.tax_assessment_valuation <> (TYPEOF(h.tax_assessment_valuation))'');
    populated_tax_assessment_valuation_pcnt := AVE(GROUP,IF(h.tax_assessment_valuation = (TYPEOF(h.tax_assessment_valuation))'',0,100));
    maxlength_tax_assessment_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.tax_assessment_valuation)));
    avelength_tax_assessment_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.tax_assessment_valuation)),h.tax_assessment_valuation<>(typeof(h.tax_assessment_valuation))'');
    populated_price_index_valuation_cnt := COUNT(GROUP,h.price_index_valuation <> (TYPEOF(h.price_index_valuation))'');
    populated_price_index_valuation_pcnt := AVE(GROUP,IF(h.price_index_valuation = (TYPEOF(h.price_index_valuation))'',0,100));
    maxlength_price_index_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.price_index_valuation)));
    avelength_price_index_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.price_index_valuation)),h.price_index_valuation<>(typeof(h.price_index_valuation))'');
    populated_hedonic_valuation_cnt := COUNT(GROUP,h.hedonic_valuation <> (TYPEOF(h.hedonic_valuation))'');
    populated_hedonic_valuation_pcnt := AVE(GROUP,IF(h.hedonic_valuation = (TYPEOF(h.hedonic_valuation))'',0,100));
    maxlength_hedonic_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.hedonic_valuation)));
    avelength_hedonic_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.hedonic_valuation)),h.hedonic_valuation<>(typeof(h.hedonic_valuation))'');
    populated_automated_valuation_cnt := COUNT(GROUP,h.automated_valuation <> (TYPEOF(h.automated_valuation))'');
    populated_automated_valuation_pcnt := AVE(GROUP,IF(h.automated_valuation = (TYPEOF(h.automated_valuation))'',0,100));
    maxlength_automated_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.automated_valuation)));
    avelength_automated_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.automated_valuation)),h.automated_valuation<>(typeof(h.automated_valuation))'');
    populated_confidence_score_cnt := COUNT(GROUP,h.confidence_score <> (TYPEOF(h.confidence_score))'');
    populated_confidence_score_pcnt := AVE(GROUP,IF(h.confidence_score = (TYPEOF(h.confidence_score))'',0,100));
    maxlength_confidence_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.confidence_score)));
    avelength_confidence_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.confidence_score)),h.confidence_score<>(typeof(h.confidence_score))'');
    populated_comp1_cnt := COUNT(GROUP,h.comp1 <> (TYPEOF(h.comp1))'');
    populated_comp1_pcnt := AVE(GROUP,IF(h.comp1 = (TYPEOF(h.comp1))'',0,100));
    maxlength_comp1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp1)));
    avelength_comp1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp1)),h.comp1<>(typeof(h.comp1))'');
    populated_comp2_cnt := COUNT(GROUP,h.comp2 <> (TYPEOF(h.comp2))'');
    populated_comp2_pcnt := AVE(GROUP,IF(h.comp2 = (TYPEOF(h.comp2))'',0,100));
    maxlength_comp2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp2)));
    avelength_comp2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp2)),h.comp2<>(typeof(h.comp2))'');
    populated_comp3_cnt := COUNT(GROUP,h.comp3 <> (TYPEOF(h.comp3))'');
    populated_comp3_pcnt := AVE(GROUP,IF(h.comp3 = (TYPEOF(h.comp3))'',0,100));
    maxlength_comp3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp3)));
    avelength_comp3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp3)),h.comp3<>(typeof(h.comp3))'');
    populated_comp4_cnt := COUNT(GROUP,h.comp4 <> (TYPEOF(h.comp4))'');
    populated_comp4_pcnt := AVE(GROUP,IF(h.comp4 = (TYPEOF(h.comp4))'',0,100));
    maxlength_comp4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp4)));
    avelength_comp4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp4)),h.comp4<>(typeof(h.comp4))'');
    populated_comp5_cnt := COUNT(GROUP,h.comp5 <> (TYPEOF(h.comp5))'');
    populated_comp5_pcnt := AVE(GROUP,IF(h.comp5 = (TYPEOF(h.comp5))'',0,100));
    maxlength_comp5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp5)));
    avelength_comp5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.comp5)),h.comp5<>(typeof(h.comp5))'');
    populated_nearby1_cnt := COUNT(GROUP,h.nearby1 <> (TYPEOF(h.nearby1))'');
    populated_nearby1_pcnt := AVE(GROUP,IF(h.nearby1 = (TYPEOF(h.nearby1))'',0,100));
    maxlength_nearby1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby1)));
    avelength_nearby1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby1)),h.nearby1<>(typeof(h.nearby1))'');
    populated_nearby2_cnt := COUNT(GROUP,h.nearby2 <> (TYPEOF(h.nearby2))'');
    populated_nearby2_pcnt := AVE(GROUP,IF(h.nearby2 = (TYPEOF(h.nearby2))'',0,100));
    maxlength_nearby2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby2)));
    avelength_nearby2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby2)),h.nearby2<>(typeof(h.nearby2))'');
    populated_nearby3_cnt := COUNT(GROUP,h.nearby3 <> (TYPEOF(h.nearby3))'');
    populated_nearby3_pcnt := AVE(GROUP,IF(h.nearby3 = (TYPEOF(h.nearby3))'',0,100));
    maxlength_nearby3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby3)));
    avelength_nearby3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby3)),h.nearby3<>(typeof(h.nearby3))'');
    populated_nearby4_cnt := COUNT(GROUP,h.nearby4 <> (TYPEOF(h.nearby4))'');
    populated_nearby4_pcnt := AVE(GROUP,IF(h.nearby4 = (TYPEOF(h.nearby4))'',0,100));
    maxlength_nearby4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby4)));
    avelength_nearby4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby4)),h.nearby4<>(typeof(h.nearby4))'');
    populated_nearby5_cnt := COUNT(GROUP,h.nearby5 <> (TYPEOF(h.nearby5))'');
    populated_nearby5_pcnt := AVE(GROUP,IF(h.nearby5 = (TYPEOF(h.nearby5))'',0,100));
    maxlength_nearby5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby5)));
    avelength_nearby5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.nearby5)),h.nearby5<>(typeof(h.nearby5))'');
    populated_history_history_date_cnt := COUNT(GROUP,h.history_history_date <> (TYPEOF(h.history_history_date))'');
    populated_history_history_date_pcnt := AVE(GROUP,IF(h.history_history_date = (TYPEOF(h.history_history_date))'',0,100));
    maxlength_history_history_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_history_date)));
    avelength_history_history_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_history_date)),h.history_history_date<>(typeof(h.history_history_date))'');
    populated_history_land_use_cnt := COUNT(GROUP,h.history_land_use <> (TYPEOF(h.history_land_use))'');
    populated_history_land_use_pcnt := AVE(GROUP,IF(h.history_land_use = (TYPEOF(h.history_land_use))'',0,100));
    maxlength_history_land_use := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_land_use)));
    avelength_history_land_use := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_land_use)),h.history_land_use<>(typeof(h.history_land_use))'');
    populated_history_recording_date_cnt := COUNT(GROUP,h.history_recording_date <> (TYPEOF(h.history_recording_date))'');
    populated_history_recording_date_pcnt := AVE(GROUP,IF(h.history_recording_date = (TYPEOF(h.history_recording_date))'',0,100));
    maxlength_history_recording_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_recording_date)));
    avelength_history_recording_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_recording_date)),h.history_recording_date<>(typeof(h.history_recording_date))'');
    populated_history_assessed_value_year_cnt := COUNT(GROUP,h.history_assessed_value_year <> (TYPEOF(h.history_assessed_value_year))'');
    populated_history_assessed_value_year_pcnt := AVE(GROUP,IF(h.history_assessed_value_year = (TYPEOF(h.history_assessed_value_year))'',0,100));
    maxlength_history_assessed_value_year := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_assessed_value_year)));
    avelength_history_assessed_value_year := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_assessed_value_year)),h.history_assessed_value_year<>(typeof(h.history_assessed_value_year))'');
    populated_history_sales_price_cnt := COUNT(GROUP,h.history_sales_price <> (TYPEOF(h.history_sales_price))'');
    populated_history_sales_price_pcnt := AVE(GROUP,IF(h.history_sales_price = (TYPEOF(h.history_sales_price))'',0,100));
    maxlength_history_sales_price := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_sales_price)));
    avelength_history_sales_price := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_sales_price)),h.history_sales_price<>(typeof(h.history_sales_price))'');
    populated_history_assessed_total_value_cnt := COUNT(GROUP,h.history_assessed_total_value <> (TYPEOF(h.history_assessed_total_value))'');
    populated_history_assessed_total_value_pcnt := AVE(GROUP,IF(h.history_assessed_total_value = (TYPEOF(h.history_assessed_total_value))'',0,100));
    maxlength_history_assessed_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_assessed_total_value)));
    avelength_history_assessed_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_assessed_total_value)),h.history_assessed_total_value<>(typeof(h.history_assessed_total_value))'');
    populated_history_market_total_value_cnt := COUNT(GROUP,h.history_market_total_value <> (TYPEOF(h.history_market_total_value))'');
    populated_history_market_total_value_pcnt := AVE(GROUP,IF(h.history_market_total_value = (TYPEOF(h.history_market_total_value))'',0,100));
    maxlength_history_market_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_market_total_value)));
    avelength_history_market_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_market_total_value)),h.history_market_total_value<>(typeof(h.history_market_total_value))'');
    populated_history_tax_assessment_valuation_cnt := COUNT(GROUP,h.history_tax_assessment_valuation <> (TYPEOF(h.history_tax_assessment_valuation))'');
    populated_history_tax_assessment_valuation_pcnt := AVE(GROUP,IF(h.history_tax_assessment_valuation = (TYPEOF(h.history_tax_assessment_valuation))'',0,100));
    maxlength_history_tax_assessment_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_tax_assessment_valuation)));
    avelength_history_tax_assessment_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_tax_assessment_valuation)),h.history_tax_assessment_valuation<>(typeof(h.history_tax_assessment_valuation))'');
    populated_history_price_index_valuation_cnt := COUNT(GROUP,h.history_price_index_valuation <> (TYPEOF(h.history_price_index_valuation))'');
    populated_history_price_index_valuation_pcnt := AVE(GROUP,IF(h.history_price_index_valuation = (TYPEOF(h.history_price_index_valuation))'',0,100));
    maxlength_history_price_index_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_price_index_valuation)));
    avelength_history_price_index_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_price_index_valuation)),h.history_price_index_valuation<>(typeof(h.history_price_index_valuation))'');
    populated_history_hedonic_valuation_cnt := COUNT(GROUP,h.history_hedonic_valuation <> (TYPEOF(h.history_hedonic_valuation))'');
    populated_history_hedonic_valuation_pcnt := AVE(GROUP,IF(h.history_hedonic_valuation = (TYPEOF(h.history_hedonic_valuation))'',0,100));
    maxlength_history_hedonic_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_hedonic_valuation)));
    avelength_history_hedonic_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_hedonic_valuation)),h.history_hedonic_valuation<>(typeof(h.history_hedonic_valuation))'');
    populated_history_automated_valuation_cnt := COUNT(GROUP,h.history_automated_valuation <> (TYPEOF(h.history_automated_valuation))'');
    populated_history_automated_valuation_pcnt := AVE(GROUP,IF(h.history_automated_valuation = (TYPEOF(h.history_automated_valuation))'',0,100));
    maxlength_history_automated_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_automated_valuation)));
    avelength_history_automated_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_automated_valuation)),h.history_automated_valuation<>(typeof(h.history_automated_valuation))'');
    populated_history_confidence_score_cnt := COUNT(GROUP,h.history_confidence_score <> (TYPEOF(h.history_confidence_score))'');
    populated_history_confidence_score_pcnt := AVE(GROUP,IF(h.history_confidence_score = (TYPEOF(h.history_confidence_score))'',0,100));
    maxlength_history_confidence_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_confidence_score)));
    avelength_history_confidence_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_confidence_score)),h.history_confidence_score<>(typeof(h.history_confidence_score))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_history_date_pcnt *   0.00 / 100 + T.Populated_ln_fares_id_ta_pcnt *   0.00 / 100 + T.Populated_ln_fares_id_pi_pcnt *   0.00 / 100 + T.Populated_unformatted_apn_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_lat_pcnt *   0.00 / 100 + T.Populated_long_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_fips_code_pcnt *   0.00 / 100 + T.Populated_land_use_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_assessed_value_year_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_assessed_total_value_pcnt *   0.00 / 100 + T.Populated_market_total_value_pcnt *   0.00 / 100 + T.Populated_tax_assessment_valuation_pcnt *   0.00 / 100 + T.Populated_price_index_valuation_pcnt *   0.00 / 100 + T.Populated_hedonic_valuation_pcnt *   0.00 / 100 + T.Populated_automated_valuation_pcnt *   0.00 / 100 + T.Populated_confidence_score_pcnt *   0.00 / 100 + T.Populated_comp1_pcnt *   0.00 / 100 + T.Populated_comp2_pcnt *   0.00 / 100 + T.Populated_comp3_pcnt *   0.00 / 100 + T.Populated_comp4_pcnt *   0.00 / 100 + T.Populated_comp5_pcnt *   0.00 / 100 + T.Populated_nearby1_pcnt *   0.00 / 100 + T.Populated_nearby2_pcnt *   0.00 / 100 + T.Populated_nearby3_pcnt *   0.00 / 100 + T.Populated_nearby4_pcnt *   0.00 / 100 + T.Populated_nearby5_pcnt *   0.00 / 100 + T.Populated_history_history_date_pcnt *   0.00 / 100 + T.Populated_history_land_use_pcnt *   0.00 / 100 + T.Populated_history_recording_date_pcnt *   0.00 / 100 + T.Populated_history_assessed_value_year_pcnt *   0.00 / 100 + T.Populated_history_sales_price_pcnt *   0.00 / 100 + T.Populated_history_assessed_total_value_pcnt *   0.00 / 100 + T.Populated_history_market_total_value_pcnt *   0.00 / 100 + T.Populated_history_tax_assessment_valuation_pcnt *   0.00 / 100 + T.Populated_history_price_index_valuation_pcnt *   0.00 / 100 + T.Populated_history_hedonic_valuation_pcnt *   0.00 / 100 + T.Populated_history_automated_valuation_pcnt *   0.00 / 100 + T.Populated_history_confidence_score_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'history_date','ln_fares_id_ta','ln_fares_id_pi','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use','recording_date','assessed_value_year','sales_price','assessed_total_value','market_total_value','tax_assessment_valuation','price_index_valuation','hedonic_valuation','automated_valuation','confidence_score','comp1','comp2','comp3','comp4','comp5','nearby1','nearby2','nearby3','nearby4','nearby5','history_history_date','history_land_use','history_recording_date','history_assessed_value_year','history_sales_price','history_assessed_total_value','history_market_total_value','history_tax_assessment_valuation','history_price_index_valuation','history_hedonic_valuation','history_automated_valuation','history_confidence_score');
  SELF.populated_pcnt := CHOOSE(C,le.populated_history_date_pcnt,le.populated_ln_fares_id_ta_pcnt,le.populated_ln_fares_id_pi_pcnt,le.populated_unformatted_apn_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_lat_pcnt,le.populated_long_pcnt,le.populated_geo_blk_pcnt,le.populated_fips_code_pcnt,le.populated_land_use_pcnt,le.populated_recording_date_pcnt,le.populated_assessed_value_year_pcnt,le.populated_sales_price_pcnt,le.populated_assessed_total_value_pcnt,le.populated_market_total_value_pcnt,le.populated_tax_assessment_valuation_pcnt,le.populated_price_index_valuation_pcnt,le.populated_hedonic_valuation_pcnt,le.populated_automated_valuation_pcnt,le.populated_confidence_score_pcnt,le.populated_comp1_pcnt,le.populated_comp2_pcnt,le.populated_comp3_pcnt,le.populated_comp4_pcnt,le.populated_comp5_pcnt,le.populated_nearby1_pcnt,le.populated_nearby2_pcnt,le.populated_nearby3_pcnt,le.populated_nearby4_pcnt,le.populated_nearby5_pcnt,le.populated_history_history_date_pcnt,le.populated_history_land_use_pcnt,le.populated_history_recording_date_pcnt,le.populated_history_assessed_value_year_pcnt,le.populated_history_sales_price_pcnt,le.populated_history_assessed_total_value_pcnt,le.populated_history_market_total_value_pcnt,le.populated_history_tax_assessment_valuation_pcnt,le.populated_history_price_index_valuation_pcnt,le.populated_history_hedonic_valuation_pcnt,le.populated_history_automated_valuation_pcnt,le.populated_history_confidence_score_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_history_date,le.maxlength_ln_fares_id_ta,le.maxlength_ln_fares_id_pi,le.maxlength_unformatted_apn,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_lat,le.maxlength_long,le.maxlength_geo_blk,le.maxlength_fips_code,le.maxlength_land_use,le.maxlength_recording_date,le.maxlength_assessed_value_year,le.maxlength_sales_price,le.maxlength_assessed_total_value,le.maxlength_market_total_value,le.maxlength_tax_assessment_valuation,le.maxlength_price_index_valuation,le.maxlength_hedonic_valuation,le.maxlength_automated_valuation,le.maxlength_confidence_score,le.maxlength_comp1,le.maxlength_comp2,le.maxlength_comp3,le.maxlength_comp4,le.maxlength_comp5,le.maxlength_nearby1,le.maxlength_nearby2,le.maxlength_nearby3,le.maxlength_nearby4,le.maxlength_nearby5,le.maxlength_history_history_date,le.maxlength_history_land_use,le.maxlength_history_recording_date,le.maxlength_history_assessed_value_year,le.maxlength_history_sales_price,le.maxlength_history_assessed_total_value,le.maxlength_history_market_total_value,le.maxlength_history_tax_assessment_valuation,le.maxlength_history_price_index_valuation,le.maxlength_history_hedonic_valuation,le.maxlength_history_automated_valuation,le.maxlength_history_confidence_score);
  SELF.avelength := CHOOSE(C,le.avelength_history_date,le.avelength_ln_fares_id_ta,le.avelength_ln_fares_id_pi,le.avelength_unformatted_apn,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_lat,le.avelength_long,le.avelength_geo_blk,le.avelength_fips_code,le.avelength_land_use,le.avelength_recording_date,le.avelength_assessed_value_year,le.avelength_sales_price,le.avelength_assessed_total_value,le.avelength_market_total_value,le.avelength_tax_assessment_valuation,le.avelength_price_index_valuation,le.avelength_hedonic_valuation,le.avelength_automated_valuation,le.avelength_confidence_score,le.avelength_comp1,le.avelength_comp2,le.avelength_comp3,le.avelength_comp4,le.avelength_comp5,le.avelength_nearby1,le.avelength_nearby2,le.avelength_nearby3,le.avelength_nearby4,le.avelength_nearby5,le.avelength_history_history_date,le.avelength_history_land_use,le.avelength_history_recording_date,le.avelength_history_assessed_value_year,le.avelength_history_sales_price,le.avelength_history_assessed_total_value,le.avelength_history_market_total_value,le.avelength_history_tax_assessment_valuation,le.avelength_history_price_index_valuation,le.avelength_history_hedonic_valuation,le.avelength_history_automated_valuation,le.avelength_history_confidence_score);
END;
EXPORT invSummary := NORMALIZE(summary0, 52, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.ln_fares_id_ta),TRIM((SALT38.StrType)le.ln_fares_id_pi),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),IF (le.tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.tax_assessment_valuation), ''),IF (le.price_index_valuation <> 0,TRIM((SALT38.StrType)le.price_index_valuation), ''),IF (le.hedonic_valuation <> 0,TRIM((SALT38.StrType)le.hedonic_valuation), ''),IF (le.automated_valuation <> 0,TRIM((SALT38.StrType)le.automated_valuation), ''),IF (le.confidence_score <> 0,TRIM((SALT38.StrType)le.confidence_score), ''),TRIM((SALT38.StrType)le.comp1),TRIM((SALT38.StrType)le.comp2),TRIM((SALT38.StrType)le.comp3),TRIM((SALT38.StrType)le.comp4),TRIM((SALT38.StrType)le.comp5),TRIM((SALT38.StrType)le.nearby1),TRIM((SALT38.StrType)le.nearby2),TRIM((SALT38.StrType)le.nearby3),TRIM((SALT38.StrType)le.nearby4),TRIM((SALT38.StrType)le.nearby5),TRIM((SALT38.StrType)le.history_history_date),TRIM((SALT38.StrType)le.history_land_use),TRIM((SALT38.StrType)le.history_recording_date),TRIM((SALT38.StrType)le.history_assessed_value_year),TRIM((SALT38.StrType)le.history_sales_price),TRIM((SALT38.StrType)le.history_assessed_total_value),TRIM((SALT38.StrType)le.history_market_total_value),IF (le.history_tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.history_tax_assessment_valuation), ''),IF (le.history_price_index_valuation <> 0,TRIM((SALT38.StrType)le.history_price_index_valuation), ''),IF (le.history_hedonic_valuation <> 0,TRIM((SALT38.StrType)le.history_hedonic_valuation), ''),IF (le.history_automated_valuation <> 0,TRIM((SALT38.StrType)le.history_automated_valuation), ''),IF (le.history_confidence_score <> 0,TRIM((SALT38.StrType)le.history_confidence_score), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,52,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 52);
  SELF.FldNo2 := 1 + (C % 52);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.ln_fares_id_ta),TRIM((SALT38.StrType)le.ln_fares_id_pi),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),IF (le.tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.tax_assessment_valuation), ''),IF (le.price_index_valuation <> 0,TRIM((SALT38.StrType)le.price_index_valuation), ''),IF (le.hedonic_valuation <> 0,TRIM((SALT38.StrType)le.hedonic_valuation), ''),IF (le.automated_valuation <> 0,TRIM((SALT38.StrType)le.automated_valuation), ''),IF (le.confidence_score <> 0,TRIM((SALT38.StrType)le.confidence_score), ''),TRIM((SALT38.StrType)le.comp1),TRIM((SALT38.StrType)le.comp2),TRIM((SALT38.StrType)le.comp3),TRIM((SALT38.StrType)le.comp4),TRIM((SALT38.StrType)le.comp5),TRIM((SALT38.StrType)le.nearby1),TRIM((SALT38.StrType)le.nearby2),TRIM((SALT38.StrType)le.nearby3),TRIM((SALT38.StrType)le.nearby4),TRIM((SALT38.StrType)le.nearby5),TRIM((SALT38.StrType)le.history_history_date),TRIM((SALT38.StrType)le.history_land_use),TRIM((SALT38.StrType)le.history_recording_date),TRIM((SALT38.StrType)le.history_assessed_value_year),TRIM((SALT38.StrType)le.history_sales_price),TRIM((SALT38.StrType)le.history_assessed_total_value),TRIM((SALT38.StrType)le.history_market_total_value),IF (le.history_tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.history_tax_assessment_valuation), ''),IF (le.history_price_index_valuation <> 0,TRIM((SALT38.StrType)le.history_price_index_valuation), ''),IF (le.history_hedonic_valuation <> 0,TRIM((SALT38.StrType)le.history_hedonic_valuation), ''),IF (le.history_automated_valuation <> 0,TRIM((SALT38.StrType)le.history_automated_valuation), ''),IF (le.history_confidence_score <> 0,TRIM((SALT38.StrType)le.history_confidence_score), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.ln_fares_id_ta),TRIM((SALT38.StrType)le.ln_fares_id_pi),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),IF (le.tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.tax_assessment_valuation), ''),IF (le.price_index_valuation <> 0,TRIM((SALT38.StrType)le.price_index_valuation), ''),IF (le.hedonic_valuation <> 0,TRIM((SALT38.StrType)le.hedonic_valuation), ''),IF (le.automated_valuation <> 0,TRIM((SALT38.StrType)le.automated_valuation), ''),IF (le.confidence_score <> 0,TRIM((SALT38.StrType)le.confidence_score), ''),TRIM((SALT38.StrType)le.comp1),TRIM((SALT38.StrType)le.comp2),TRIM((SALT38.StrType)le.comp3),TRIM((SALT38.StrType)le.comp4),TRIM((SALT38.StrType)le.comp5),TRIM((SALT38.StrType)le.nearby1),TRIM((SALT38.StrType)le.nearby2),TRIM((SALT38.StrType)le.nearby3),TRIM((SALT38.StrType)le.nearby4),TRIM((SALT38.StrType)le.nearby5),TRIM((SALT38.StrType)le.history_history_date),TRIM((SALT38.StrType)le.history_land_use),TRIM((SALT38.StrType)le.history_recording_date),TRIM((SALT38.StrType)le.history_assessed_value_year),TRIM((SALT38.StrType)le.history_sales_price),TRIM((SALT38.StrType)le.history_assessed_total_value),TRIM((SALT38.StrType)le.history_market_total_value),IF (le.history_tax_assessment_valuation <> 0,TRIM((SALT38.StrType)le.history_tax_assessment_valuation), ''),IF (le.history_price_index_valuation <> 0,TRIM((SALT38.StrType)le.history_price_index_valuation), ''),IF (le.history_hedonic_valuation <> 0,TRIM((SALT38.StrType)le.history_hedonic_valuation), ''),IF (le.history_automated_valuation <> 0,TRIM((SALT38.StrType)le.history_automated_valuation), ''),IF (le.history_confidence_score <> 0,TRIM((SALT38.StrType)le.history_confidence_score), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),52*52,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'history_date'}
      ,{2,'ln_fares_id_ta'}
      ,{3,'ln_fares_id_pi'}
      ,{4,'unformatted_apn'}
      ,{5,'prim_range'}
      ,{6,'predir'}
      ,{7,'prim_name'}
      ,{8,'suffix'}
      ,{9,'postdir'}
      ,{10,'unit_desig'}
      ,{11,'sec_range'}
      ,{12,'p_city_name'}
      ,{13,'st'}
      ,{14,'zip'}
      ,{15,'zip4'}
      ,{16,'lat'}
      ,{17,'long'}
      ,{18,'geo_blk'}
      ,{19,'fips_code'}
      ,{20,'land_use'}
      ,{21,'recording_date'}
      ,{22,'assessed_value_year'}
      ,{23,'sales_price'}
      ,{24,'assessed_total_value'}
      ,{25,'market_total_value'}
      ,{26,'tax_assessment_valuation'}
      ,{27,'price_index_valuation'}
      ,{28,'hedonic_valuation'}
      ,{29,'automated_valuation'}
      ,{30,'confidence_score'}
      ,{31,'comp1'}
      ,{32,'comp2'}
      ,{33,'comp3'}
      ,{34,'comp4'}
      ,{35,'comp5'}
      ,{36,'nearby1'}
      ,{37,'nearby2'}
      ,{38,'nearby3'}
      ,{39,'nearby4'}
      ,{40,'nearby5'}
      ,{41,'history_history_date'}
      ,{42,'history_land_use'}
      ,{43,'history_recording_date'}
      ,{44,'history_assessed_value_year'}
      ,{45,'history_sales_price'}
      ,{46,'history_assessed_total_value'}
      ,{47,'history_market_total_value'}
      ,{48,'history_tax_assessment_valuation'}
      ,{49,'history_price_index_valuation'}
      ,{50,'history_hedonic_valuation'}
      ,{51,'history_automated_valuation'}
      ,{52,'history_confidence_score'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_history_date((SALT38.StrType)le.history_date),
    Base_Fields.InValid_ln_fares_id_ta((SALT38.StrType)le.ln_fares_id_ta),
    Base_Fields.InValid_ln_fares_id_pi((SALT38.StrType)le.ln_fares_id_pi),
    Base_Fields.InValid_unformatted_apn((SALT38.StrType)le.unformatted_apn),
    Base_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT38.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Base_Fields.InValid_suffix((SALT38.StrType)le.suffix),
    Base_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Base_Fields.InValid_st((SALT38.StrType)le.st),
    Base_Fields.InValid_zip((SALT38.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Base_Fields.InValid_lat((SALT38.StrType)le.lat),
    Base_Fields.InValid_long((SALT38.StrType)le.long),
    Base_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Base_Fields.InValid_fips_code((SALT38.StrType)le.fips_code),
    Base_Fields.InValid_land_use((SALT38.StrType)le.land_use),
    Base_Fields.InValid_recording_date((SALT38.StrType)le.recording_date),
    Base_Fields.InValid_assessed_value_year((SALT38.StrType)le.assessed_value_year),
    Base_Fields.InValid_sales_price((SALT38.StrType)le.sales_price),
    Base_Fields.InValid_assessed_total_value((SALT38.StrType)le.assessed_total_value),
    Base_Fields.InValid_market_total_value((SALT38.StrType)le.market_total_value),
    Base_Fields.InValid_tax_assessment_valuation((SALT38.StrType)le.tax_assessment_valuation),
    Base_Fields.InValid_price_index_valuation((SALT38.StrType)le.price_index_valuation),
    Base_Fields.InValid_hedonic_valuation((SALT38.StrType)le.hedonic_valuation),
    Base_Fields.InValid_automated_valuation((SALT38.StrType)le.automated_valuation),
    Base_Fields.InValid_confidence_score((SALT38.StrType)le.confidence_score),
    Base_Fields.InValid_comp1((SALT38.StrType)le.comp1),
    Base_Fields.InValid_comp2((SALT38.StrType)le.comp2),
    Base_Fields.InValid_comp3((SALT38.StrType)le.comp3),
    Base_Fields.InValid_comp4((SALT38.StrType)le.comp4),
    Base_Fields.InValid_comp5((SALT38.StrType)le.comp5),
    Base_Fields.InValid_nearby1((SALT38.StrType)le.nearby1),
    Base_Fields.InValid_nearby2((SALT38.StrType)le.nearby2),
    Base_Fields.InValid_nearby3((SALT38.StrType)le.nearby3),
    Base_Fields.InValid_nearby4((SALT38.StrType)le.nearby4),
    Base_Fields.InValid_nearby5((SALT38.StrType)le.nearby5),
    Base_Fields.InValid_history_history_date((SALT38.StrType)le.history_history_date),
    Base_Fields.InValid_history_land_use((SALT38.StrType)le.history_land_use),
    Base_Fields.InValid_history_recording_date((SALT38.StrType)le.history_recording_date),
    Base_Fields.InValid_history_assessed_value_year((SALT38.StrType)le.history_assessed_value_year),
    Base_Fields.InValid_history_sales_price((SALT38.StrType)le.history_sales_price),
    Base_Fields.InValid_history_assessed_total_value((SALT38.StrType)le.history_assessed_total_value),
    Base_Fields.InValid_history_market_total_value((SALT38.StrType)le.history_market_total_value),
    Base_Fields.InValid_history_tax_assessment_valuation((SALT38.StrType)le.history_tax_assessment_valuation),
    Base_Fields.InValid_history_price_index_valuation((SALT38.StrType)le.history_price_index_valuation),
    Base_Fields.InValid_history_hedonic_valuation((SALT38.StrType)le.history_hedonic_valuation),
    Base_Fields.InValid_history_automated_valuation((SALT38.StrType)le.history_automated_valuation),
    Base_Fields.InValid_history_confidence_score((SALT38.StrType)le.history_confidence_score),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,52,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Comps','Invalid_Comps','Invalid_Comps','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Alpha','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Invalid_Num','Unknown','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Date','Unknown','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_history_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ln_fares_id_ta(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ln_fares_id_pi(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unformatted_apn(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_land_use(TotalErrors.ErrorNum),Base_Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_assessed_value_year(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Base_Fields.InValidMessage_assessed_total_value(TotalErrors.ErrorNum),Base_Fields.InValidMessage_market_total_value(TotalErrors.ErrorNum),Base_Fields.InValidMessage_tax_assessment_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_price_index_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_hedonic_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_automated_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_confidence_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_comp1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_comp2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_comp3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_comp4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_comp5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nearby1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nearby2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nearby3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nearby4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_nearby5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_history_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_land_use(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_recording_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_assessed_value_year(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_sales_price(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_assessed_total_value(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_market_total_value(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_tax_assessment_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_price_index_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_hedonic_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_automated_valuation(TotalErrors.ErrorNum),Base_Fields.InValidMessage_history_confidence_score(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
