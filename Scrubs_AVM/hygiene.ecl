IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_AVM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_seq_cnt := COUNT(GROUP,h.seq <> (TYPEOF(h.seq))'');
    populated_seq_pcnt := AVE(GROUP,IF(h.seq = (TYPEOF(h.seq))'',0,100));
    maxlength_seq := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seq)));
    avelength_seq := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seq)),h.seq<>(typeof(h.seq))'');
    populated_ln_fares_id_cnt := COUNT(GROUP,h.ln_fares_id <> (TYPEOF(h.ln_fares_id))'');
    populated_ln_fares_id_pcnt := AVE(GROUP,IF(h.ln_fares_id = (TYPEOF(h.ln_fares_id))'',0,100));
    maxlength_ln_fares_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id)));
    avelength_ln_fares_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ln_fares_id)),h.ln_fares_id<>(typeof(h.ln_fares_id))'');
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
    populated_land_use_code_cnt := COUNT(GROUP,h.land_use_code <> (TYPEOF(h.land_use_code))'');
    populated_land_use_code_pcnt := AVE(GROUP,IF(h.land_use_code = (TYPEOF(h.land_use_code))'',0,100));
    maxlength_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.land_use_code)));
    avelength_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.land_use_code)),h.land_use_code<>(typeof(h.land_use_code))'');
    populated_sales_price_cnt := COUNT(GROUP,h.sales_price <> (TYPEOF(h.sales_price))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_sales_price_code_cnt := COUNT(GROUP,h.sales_price_code <> (TYPEOF(h.sales_price_code))'');
    populated_sales_price_code_pcnt := AVE(GROUP,IF(h.sales_price_code = (TYPEOF(h.sales_price_code))'',0,100));
    maxlength_sales_price_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price_code)));
    avelength_sales_price_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sales_price_code)),h.sales_price_code<>(typeof(h.sales_price_code))'');
    populated_recording_date_cnt := COUNT(GROUP,h.recording_date <> (TYPEOF(h.recording_date))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_assessed_value_year_cnt := COUNT(GROUP,h.assessed_value_year <> (TYPEOF(h.assessed_value_year))'');
    populated_assessed_value_year_pcnt := AVE(GROUP,IF(h.assessed_value_year = (TYPEOF(h.assessed_value_year))'',0,100));
    maxlength_assessed_value_year := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_value_year)));
    avelength_assessed_value_year := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_value_year)),h.assessed_value_year<>(typeof(h.assessed_value_year))'');
    populated_assessed_total_value_cnt := COUNT(GROUP,h.assessed_total_value <> (TYPEOF(h.assessed_total_value))'');
    populated_assessed_total_value_pcnt := AVE(GROUP,IF(h.assessed_total_value = (TYPEOF(h.assessed_total_value))'',0,100));
    maxlength_assessed_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_total_value)));
    avelength_assessed_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.assessed_total_value)),h.assessed_total_value<>(typeof(h.assessed_total_value))'');
    populated_market_total_value_cnt := COUNT(GROUP,h.market_total_value <> (TYPEOF(h.market_total_value))'');
    populated_market_total_value_pcnt := AVE(GROUP,IF(h.market_total_value = (TYPEOF(h.market_total_value))'',0,100));
    maxlength_market_total_value := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.market_total_value)));
    avelength_market_total_value := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.market_total_value)),h.market_total_value<>(typeof(h.market_total_value))'');
    populated_lot_size_cnt := COUNT(GROUP,h.lot_size <> (TYPEOF(h.lot_size))'');
    populated_lot_size_pcnt := AVE(GROUP,IF(h.lot_size = (TYPEOF(h.lot_size))'',0,100));
    maxlength_lot_size := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_size)));
    avelength_lot_size := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_size)),h.lot_size<>(typeof(h.lot_size))'');
    populated_building_area_cnt := COUNT(GROUP,h.building_area <> (TYPEOF(h.building_area))'');
    populated_building_area_pcnt := AVE(GROUP,IF(h.building_area = (TYPEOF(h.building_area))'',0,100));
    maxlength_building_area := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.building_area)));
    avelength_building_area := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.building_area)),h.building_area<>(typeof(h.building_area))'');
    populated_year_built_cnt := COUNT(GROUP,h.year_built <> (TYPEOF(h.year_built))'');
    populated_year_built_pcnt := AVE(GROUP,IF(h.year_built = (TYPEOF(h.year_built))'',0,100));
    maxlength_year_built := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_built)));
    avelength_year_built := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.year_built)),h.year_built<>(typeof(h.year_built))'');
    populated_no_of_stories_cnt := COUNT(GROUP,h.no_of_stories <> (TYPEOF(h.no_of_stories))'');
    populated_no_of_stories_pcnt := AVE(GROUP,IF(h.no_of_stories = (TYPEOF(h.no_of_stories))'',0,100));
    maxlength_no_of_stories := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_stories)));
    avelength_no_of_stories := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_stories)),h.no_of_stories<>(typeof(h.no_of_stories))'');
    populated_no_of_rooms_cnt := COUNT(GROUP,h.no_of_rooms <> (TYPEOF(h.no_of_rooms))'');
    populated_no_of_rooms_pcnt := AVE(GROUP,IF(h.no_of_rooms = (TYPEOF(h.no_of_rooms))'',0,100));
    maxlength_no_of_rooms := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_rooms)));
    avelength_no_of_rooms := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_rooms)),h.no_of_rooms<>(typeof(h.no_of_rooms))'');
    populated_no_of_bedrooms_cnt := COUNT(GROUP,h.no_of_bedrooms <> (TYPEOF(h.no_of_bedrooms))'');
    populated_no_of_bedrooms_pcnt := AVE(GROUP,IF(h.no_of_bedrooms = (TYPEOF(h.no_of_bedrooms))'',0,100));
    maxlength_no_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_bedrooms)));
    avelength_no_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_bedrooms)),h.no_of_bedrooms<>(typeof(h.no_of_bedrooms))'');
    populated_no_of_baths_cnt := COUNT(GROUP,h.no_of_baths <> (TYPEOF(h.no_of_baths))'');
    populated_no_of_baths_pcnt := AVE(GROUP,IF(h.no_of_baths = (TYPEOF(h.no_of_baths))'',0,100));
    maxlength_no_of_baths := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_baths)));
    avelength_no_of_baths := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.no_of_baths)),h.no_of_baths<>(typeof(h.no_of_baths))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_seq_pcnt *   0.00 / 100 + T.Populated_ln_fares_id_pcnt *   0.00 / 100 + T.Populated_unformatted_apn_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_lat_pcnt *   0.00 / 100 + T.Populated_long_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_fips_code_pcnt *   0.00 / 100 + T.Populated_land_use_code_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_sales_price_code_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_assessed_value_year_pcnt *   0.00 / 100 + T.Populated_assessed_total_value_pcnt *   0.00 / 100 + T.Populated_market_total_value_pcnt *   0.00 / 100 + T.Populated_lot_size_pcnt *   0.00 / 100 + T.Populated_building_area_pcnt *   0.00 / 100 + T.Populated_year_built_pcnt *   0.00 / 100 + T.Populated_no_of_stories_pcnt *   0.00 / 100 + T.Populated_no_of_rooms_pcnt *   0.00 / 100 + T.Populated_no_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_no_of_baths_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'seq','ln_fares_id','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use_code','sales_price','sales_price_code','recording_date','assessed_value_year','assessed_total_value','market_total_value','lot_size','building_area','year_built','no_of_stories','no_of_rooms','no_of_bedrooms','no_of_baths');
  SELF.populated_pcnt := CHOOSE(C,le.populated_seq_pcnt,le.populated_ln_fares_id_pcnt,le.populated_unformatted_apn_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_lat_pcnt,le.populated_long_pcnt,le.populated_geo_blk_pcnt,le.populated_fips_code_pcnt,le.populated_land_use_code_pcnt,le.populated_sales_price_pcnt,le.populated_sales_price_code_pcnt,le.populated_recording_date_pcnt,le.populated_assessed_value_year_pcnt,le.populated_assessed_total_value_pcnt,le.populated_market_total_value_pcnt,le.populated_lot_size_pcnt,le.populated_building_area_pcnt,le.populated_year_built_pcnt,le.populated_no_of_stories_pcnt,le.populated_no_of_rooms_pcnt,le.populated_no_of_bedrooms_pcnt,le.populated_no_of_baths_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_seq,le.maxlength_ln_fares_id,le.maxlength_unformatted_apn,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_lat,le.maxlength_long,le.maxlength_geo_blk,le.maxlength_fips_code,le.maxlength_land_use_code,le.maxlength_sales_price,le.maxlength_sales_price_code,le.maxlength_recording_date,le.maxlength_assessed_value_year,le.maxlength_assessed_total_value,le.maxlength_market_total_value,le.maxlength_lot_size,le.maxlength_building_area,le.maxlength_year_built,le.maxlength_no_of_stories,le.maxlength_no_of_rooms,le.maxlength_no_of_bedrooms,le.maxlength_no_of_baths);
  SELF.avelength := CHOOSE(C,le.avelength_seq,le.avelength_ln_fares_id,le.avelength_unformatted_apn,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_lat,le.avelength_long,le.avelength_geo_blk,le.avelength_fips_code,le.avelength_land_use_code,le.avelength_sales_price,le.avelength_sales_price_code,le.avelength_recording_date,le.avelength_assessed_value_year,le.avelength_assessed_total_value,le.avelength_market_total_value,le.avelength_lot_size,le.avelength_building_area,le.avelength_year_built,le.avelength_no_of_stories,le.avelength_no_of_rooms,le.avelength_no_of_bedrooms,le.avelength_no_of_baths);
END;
EXPORT invSummary := NORMALIZE(summary0, 32, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.seq <> 0,TRIM((SALT38.StrType)le.seq), ''),TRIM((SALT38.StrType)le.ln_fares_id),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use_code),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.sales_price_code),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),TRIM((SALT38.StrType)le.lot_size),TRIM((SALT38.StrType)le.building_area),TRIM((SALT38.StrType)le.year_built),TRIM((SALT38.StrType)le.no_of_stories),TRIM((SALT38.StrType)le.no_of_rooms),TRIM((SALT38.StrType)le.no_of_bedrooms),TRIM((SALT38.StrType)le.no_of_baths)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 32);
  SELF.FldNo2 := 1 + (C % 32);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.seq <> 0,TRIM((SALT38.StrType)le.seq), ''),TRIM((SALT38.StrType)le.ln_fares_id),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use_code),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.sales_price_code),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),TRIM((SALT38.StrType)le.lot_size),TRIM((SALT38.StrType)le.building_area),TRIM((SALT38.StrType)le.year_built),TRIM((SALT38.StrType)le.no_of_stories),TRIM((SALT38.StrType)le.no_of_rooms),TRIM((SALT38.StrType)le.no_of_bedrooms),TRIM((SALT38.StrType)le.no_of_baths)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.seq <> 0,TRIM((SALT38.StrType)le.seq), ''),TRIM((SALT38.StrType)le.ln_fares_id),TRIM((SALT38.StrType)le.unformatted_apn),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.lat),TRIM((SALT38.StrType)le.long),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.fips_code),TRIM((SALT38.StrType)le.land_use_code),TRIM((SALT38.StrType)le.sales_price),TRIM((SALT38.StrType)le.sales_price_code),TRIM((SALT38.StrType)le.recording_date),TRIM((SALT38.StrType)le.assessed_value_year),TRIM((SALT38.StrType)le.assessed_total_value),TRIM((SALT38.StrType)le.market_total_value),TRIM((SALT38.StrType)le.lot_size),TRIM((SALT38.StrType)le.building_area),TRIM((SALT38.StrType)le.year_built),TRIM((SALT38.StrType)le.no_of_stories),TRIM((SALT38.StrType)le.no_of_rooms),TRIM((SALT38.StrType)le.no_of_bedrooms),TRIM((SALT38.StrType)le.no_of_baths)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),32*32,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'seq'}
      ,{2,'ln_fares_id'}
      ,{3,'unformatted_apn'}
      ,{4,'prim_range'}
      ,{5,'predir'}
      ,{6,'prim_name'}
      ,{7,'suffix'}
      ,{8,'postdir'}
      ,{9,'unit_desig'}
      ,{10,'sec_range'}
      ,{11,'p_city_name'}
      ,{12,'st'}
      ,{13,'zip'}
      ,{14,'zip4'}
      ,{15,'lat'}
      ,{16,'long'}
      ,{17,'geo_blk'}
      ,{18,'fips_code'}
      ,{19,'land_use_code'}
      ,{20,'sales_price'}
      ,{21,'sales_price_code'}
      ,{22,'recording_date'}
      ,{23,'assessed_value_year'}
      ,{24,'assessed_total_value'}
      ,{25,'market_total_value'}
      ,{26,'lot_size'}
      ,{27,'building_area'}
      ,{28,'year_built'}
      ,{29,'no_of_stories'}
      ,{30,'no_of_rooms'}
      ,{31,'no_of_bedrooms'}
      ,{32,'no_of_baths'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_seq((SALT38.StrType)le.seq),
    Fields.InValid_ln_fares_id((SALT38.StrType)le.ln_fares_id),
    Fields.InValid_unformatted_apn((SALT38.StrType)le.unformatted_apn),
    Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Fields.InValid_predir((SALT38.StrType)le.predir),
    Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Fields.InValid_suffix((SALT38.StrType)le.suffix),
    Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Fields.InValid_st((SALT38.StrType)le.st),
    Fields.InValid_zip((SALT38.StrType)le.zip),
    Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Fields.InValid_lat((SALT38.StrType)le.lat),
    Fields.InValid_long((SALT38.StrType)le.long),
    Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Fields.InValid_fips_code((SALT38.StrType)le.fips_code),
    Fields.InValid_land_use_code((SALT38.StrType)le.land_use_code),
    Fields.InValid_sales_price((SALT38.StrType)le.sales_price),
    Fields.InValid_sales_price_code((SALT38.StrType)le.sales_price_code),
    Fields.InValid_recording_date((SALT38.StrType)le.recording_date),
    Fields.InValid_assessed_value_year((SALT38.StrType)le.assessed_value_year),
    Fields.InValid_assessed_total_value((SALT38.StrType)le.assessed_total_value),
    Fields.InValid_market_total_value((SALT38.StrType)le.market_total_value),
    Fields.InValid_lot_size((SALT38.StrType)le.lot_size),
    Fields.InValid_building_area((SALT38.StrType)le.building_area),
    Fields.InValid_year_built((SALT38.StrType)le.year_built),
    Fields.InValid_no_of_stories((SALT38.StrType)le.no_of_stories),
    Fields.InValid_no_of_rooms((SALT38.StrType)le.no_of_rooms),
    Fields.InValid_no_of_bedrooms((SALT38.StrType)le.no_of_bedrooms),
    Fields.InValid_no_of_baths((SALT38.StrType)le.no_of_baths),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Comps','Invalid_AlphaNum','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Alpha','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Invalid_Num','Invalid_LandUseCode','Invalid_Num','Invalid_SalesPriceCode','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Chars','Invalid_Num','Invalid_Num','Invalid_Chars','Invalid_Num','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_seq(TotalErrors.ErrorNum),Fields.InValidMessage_ln_fares_id(TotalErrors.ErrorNum),Fields.InValidMessage_unformatted_apn(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_lat(TotalErrors.ErrorNum),Fields.InValidMessage_long(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price_code(TotalErrors.ErrorNum),Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_value_year(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_total_value(TotalErrors.ErrorNum),Fields.InValidMessage_market_total_value(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_building_area(TotalErrors.ErrorNum),Fields.InValidMessage_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_stories(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_rooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_baths(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
