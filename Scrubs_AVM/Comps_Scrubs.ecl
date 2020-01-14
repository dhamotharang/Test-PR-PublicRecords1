IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Comps_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 21;
  EXPORT NumRulesFromFieldType := 21;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 21;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Comps_Layout_AVM)
    UNSIGNED1 seq_Invalid;
    UNSIGNED1 ln_fares_id_Invalid;
    UNSIGNED1 unformatted_apn_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 fips_code_Invalid;
    UNSIGNED1 land_use_code_Invalid;
    UNSIGNED1 sales_price_Invalid;
    UNSIGNED1 sales_price_code_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 assessed_value_year_Invalid;
    UNSIGNED1 assessed_total_value_Invalid;
    UNSIGNED1 market_total_value_Invalid;
    UNSIGNED1 lot_size_Invalid;
    UNSIGNED1 building_area_Invalid;
    UNSIGNED1 year_built_Invalid;
    UNSIGNED1 no_of_stories_Invalid;
    UNSIGNED1 no_of_rooms_Invalid;
    UNSIGNED1 no_of_bedrooms_Invalid;
    UNSIGNED1 no_of_baths_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Comps_Layout_AVM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Comps_Layout_AVM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.seq_Invalid := Comps_Fields.InValid_seq((SALT38.StrType)le.seq);
    SELF.ln_fares_id_Invalid := Comps_Fields.InValid_ln_fares_id((SALT38.StrType)le.ln_fares_id);
    SELF.unformatted_apn_Invalid := Comps_Fields.InValid_unformatted_apn((SALT38.StrType)le.unformatted_apn);
    SELF.st_Invalid := Comps_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Comps_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := Comps_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.fips_code_Invalid := Comps_Fields.InValid_fips_code((SALT38.StrType)le.fips_code);
    SELF.land_use_code_Invalid := Comps_Fields.InValid_land_use_code((SALT38.StrType)le.land_use_code);
    SELF.sales_price_Invalid := Comps_Fields.InValid_sales_price((SALT38.StrType)le.sales_price);
    SELF.sales_price_code_Invalid := Comps_Fields.InValid_sales_price_code((SALT38.StrType)le.sales_price_code);
    SELF.recording_date_Invalid := Comps_Fields.InValid_recording_date((SALT38.StrType)le.recording_date);
    SELF.assessed_value_year_Invalid := Comps_Fields.InValid_assessed_value_year((SALT38.StrType)le.assessed_value_year);
    SELF.assessed_total_value_Invalid := Comps_Fields.InValid_assessed_total_value((SALT38.StrType)le.assessed_total_value);
    SELF.market_total_value_Invalid := Comps_Fields.InValid_market_total_value((SALT38.StrType)le.market_total_value);
    SELF.lot_size_Invalid := Comps_Fields.InValid_lot_size((SALT38.StrType)le.lot_size);
    SELF.building_area_Invalid := Comps_Fields.InValid_building_area((SALT38.StrType)le.building_area);
    SELF.year_built_Invalid := Comps_Fields.InValid_year_built((SALT38.StrType)le.year_built);
    SELF.no_of_stories_Invalid := Comps_Fields.InValid_no_of_stories((SALT38.StrType)le.no_of_stories);
    SELF.no_of_rooms_Invalid := Comps_Fields.InValid_no_of_rooms((SALT38.StrType)le.no_of_rooms);
    SELF.no_of_bedrooms_Invalid := Comps_Fields.InValid_no_of_bedrooms((SALT38.StrType)le.no_of_bedrooms);
    SELF.no_of_baths_Invalid := Comps_Fields.InValid_no_of_baths((SALT38.StrType)le.no_of_baths);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Comps_Layout_AVM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.seq_Invalid << 0 ) + ( le.ln_fares_id_Invalid << 1 ) + ( le.unformatted_apn_Invalid << 2 ) + ( le.st_Invalid << 3 ) + ( le.zip_Invalid << 4 ) + ( le.zip4_Invalid << 5 ) + ( le.fips_code_Invalid << 6 ) + ( le.land_use_code_Invalid << 7 ) + ( le.sales_price_Invalid << 8 ) + ( le.sales_price_code_Invalid << 9 ) + ( le.recording_date_Invalid << 10 ) + ( le.assessed_value_year_Invalid << 11 ) + ( le.assessed_total_value_Invalid << 12 ) + ( le.market_total_value_Invalid << 13 ) + ( le.lot_size_Invalid << 14 ) + ( le.building_area_Invalid << 15 ) + ( le.year_built_Invalid << 16 ) + ( le.no_of_stories_Invalid << 17 ) + ( le.no_of_rooms_Invalid << 18 ) + ( le.no_of_bedrooms_Invalid << 19 ) + ( le.no_of_baths_Invalid << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Comps_Layout_AVM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.seq_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ln_fares_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.unformatted_apn_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fips_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.land_use_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sales_price_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sales_price_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.assessed_value_year_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.assessed_total_value_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.market_total_value_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.lot_size_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.building_area_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.year_built_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.no_of_stories_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.no_of_rooms_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.no_of_bedrooms_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.no_of_baths_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    seq_ALLOW_ErrorCount := COUNT(GROUP,h.seq_Invalid=1);
    ln_fares_id_ALLOW_ErrorCount := COUNT(GROUP,h.ln_fares_id_Invalid=1);
    unformatted_apn_ALLOW_ErrorCount := COUNT(GROUP,h.unformatted_apn_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    land_use_code_ENUM_ErrorCount := COUNT(GROUP,h.land_use_code_Invalid=1);
    sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.sales_price_Invalid=1);
    sales_price_code_ENUM_ErrorCount := COUNT(GROUP,h.sales_price_code_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    assessed_value_year_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_value_year_Invalid=1);
    assessed_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_total_value_Invalid=1);
    market_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_total_value_Invalid=1);
    lot_size_ALLOW_ErrorCount := COUNT(GROUP,h.lot_size_Invalid=1);
    building_area_ALLOW_ErrorCount := COUNT(GROUP,h.building_area_Invalid=1);
    year_built_ALLOW_ErrorCount := COUNT(GROUP,h.year_built_Invalid=1);
    no_of_stories_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=1);
    no_of_rooms_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_rooms_Invalid=1);
    no_of_bedrooms_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_bedrooms_Invalid=1);
    no_of_baths_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_baths_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.seq_Invalid > 0 OR h.ln_fares_id_Invalid > 0 OR h.unformatted_apn_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.fips_code_Invalid > 0 OR h.land_use_code_Invalid > 0 OR h.sales_price_Invalid > 0 OR h.sales_price_code_Invalid > 0 OR h.recording_date_Invalid > 0 OR h.assessed_value_year_Invalid > 0 OR h.assessed_total_value_Invalid > 0 OR h.market_total_value_Invalid > 0 OR h.lot_size_Invalid > 0 OR h.building_area_Invalid > 0 OR h.year_built_Invalid > 0 OR h.no_of_stories_Invalid > 0 OR h.no_of_rooms_Invalid > 0 OR h.no_of_bedrooms_Invalid > 0 OR h.no_of_baths_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.seq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.land_use_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_area_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_built_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_rooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_bedrooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_baths_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.seq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.land_use_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_area_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_built_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_rooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_bedrooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.no_of_baths_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.seq_Invalid,le.ln_fares_id_Invalid,le.unformatted_apn_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.fips_code_Invalid,le.land_use_code_Invalid,le.sales_price_Invalid,le.sales_price_code_Invalid,le.recording_date_Invalid,le.assessed_value_year_Invalid,le.assessed_total_value_Invalid,le.market_total_value_Invalid,le.lot_size_Invalid,le.building_area_Invalid,le.year_built_Invalid,le.no_of_stories_Invalid,le.no_of_rooms_Invalid,le.no_of_bedrooms_Invalid,le.no_of_baths_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Comps_Fields.InvalidMessage_seq(le.seq_Invalid),Comps_Fields.InvalidMessage_ln_fares_id(le.ln_fares_id_Invalid),Comps_Fields.InvalidMessage_unformatted_apn(le.unformatted_apn_Invalid),Comps_Fields.InvalidMessage_st(le.st_Invalid),Comps_Fields.InvalidMessage_zip(le.zip_Invalid),Comps_Fields.InvalidMessage_zip4(le.zip4_Invalid),Comps_Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Comps_Fields.InvalidMessage_land_use_code(le.land_use_code_Invalid),Comps_Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Comps_Fields.InvalidMessage_sales_price_code(le.sales_price_code_Invalid),Comps_Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Comps_Fields.InvalidMessage_assessed_value_year(le.assessed_value_year_Invalid),Comps_Fields.InvalidMessage_assessed_total_value(le.assessed_total_value_Invalid),Comps_Fields.InvalidMessage_market_total_value(le.market_total_value_Invalid),Comps_Fields.InvalidMessage_lot_size(le.lot_size_Invalid),Comps_Fields.InvalidMessage_building_area(le.building_area_Invalid),Comps_Fields.InvalidMessage_year_built(le.year_built_Invalid),Comps_Fields.InvalidMessage_no_of_stories(le.no_of_stories_Invalid),Comps_Fields.InvalidMessage_no_of_rooms(le.no_of_rooms_Invalid),Comps_Fields.InvalidMessage_no_of_bedrooms(le.no_of_bedrooms_Invalid),Comps_Fields.InvalidMessage_no_of_baths(le.no_of_baths_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.seq_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ln_fares_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unformatted_apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.land_use_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessed_value_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessed_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_size_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.building_area_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_built_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.no_of_stories_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.no_of_rooms_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.no_of_bedrooms_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.no_of_baths_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'seq','ln_fares_id','unformatted_apn','st','zip','zip4','fips_code','land_use_code','sales_price','sales_price_code','recording_date','assessed_value_year','assessed_total_value','market_total_value','lot_size','building_area','year_built','no_of_stories','no_of_rooms','no_of_bedrooms','no_of_baths','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Comps','Invalid_AlphaNum','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_LandUseCode','Invalid_Num','Invalid_SalesPriceCode','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Chars','Invalid_Num','Invalid_Num','Invalid_Chars','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.seq,(SALT38.StrType)le.ln_fares_id,(SALT38.StrType)le.unformatted_apn,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.fips_code,(SALT38.StrType)le.land_use_code,(SALT38.StrType)le.sales_price,(SALT38.StrType)le.sales_price_code,(SALT38.StrType)le.recording_date,(SALT38.StrType)le.assessed_value_year,(SALT38.StrType)le.assessed_total_value,(SALT38.StrType)le.market_total_value,(SALT38.StrType)le.lot_size,(SALT38.StrType)le.building_area,(SALT38.StrType)le.year_built,(SALT38.StrType)le.no_of_stories,(SALT38.StrType)le.no_of_rooms,(SALT38.StrType)le.no_of_bedrooms,(SALT38.StrType)le.no_of_baths,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Comps_Layout_AVM) prevDS = DATASET([], Comps_Layout_AVM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'seq:Invalid_Num:ALLOW'
          ,'ln_fares_id:Invalid_Comps:ALLOW'
          ,'unformatted_apn:Invalid_AlphaNum:ALLOW'
          ,'st:Invalid_Alpha:ALLOW'
          ,'zip:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'fips_code:Invalid_Num:ALLOW'
          ,'land_use_code:Invalid_LandUseCode:ENUM'
          ,'sales_price:Invalid_Num:ALLOW'
          ,'sales_price_code:Invalid_SalesPriceCode:ENUM'
          ,'recording_date:Invalid_Date:CUSTOM'
          ,'assessed_value_year:Invalid_Num:ALLOW'
          ,'assessed_total_value:Invalid_Num:ALLOW'
          ,'market_total_value:Invalid_Num:ALLOW'
          ,'lot_size:Invalid_Chars:ALLOW'
          ,'building_area:Invalid_Num:ALLOW'
          ,'year_built:Invalid_Num:ALLOW'
          ,'no_of_stories:Invalid_Chars:ALLOW'
          ,'no_of_rooms:Invalid_Num:ALLOW'
          ,'no_of_bedrooms:Invalid_Num:ALLOW'
          ,'no_of_baths:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Comps_Fields.InvalidMessage_seq(1)
          ,Comps_Fields.InvalidMessage_ln_fares_id(1)
          ,Comps_Fields.InvalidMessage_unformatted_apn(1)
          ,Comps_Fields.InvalidMessage_st(1)
          ,Comps_Fields.InvalidMessage_zip(1)
          ,Comps_Fields.InvalidMessage_zip4(1)
          ,Comps_Fields.InvalidMessage_fips_code(1)
          ,Comps_Fields.InvalidMessage_land_use_code(1)
          ,Comps_Fields.InvalidMessage_sales_price(1)
          ,Comps_Fields.InvalidMessage_sales_price_code(1)
          ,Comps_Fields.InvalidMessage_recording_date(1)
          ,Comps_Fields.InvalidMessage_assessed_value_year(1)
          ,Comps_Fields.InvalidMessage_assessed_total_value(1)
          ,Comps_Fields.InvalidMessage_market_total_value(1)
          ,Comps_Fields.InvalidMessage_lot_size(1)
          ,Comps_Fields.InvalidMessage_building_area(1)
          ,Comps_Fields.InvalidMessage_year_built(1)
          ,Comps_Fields.InvalidMessage_no_of_stories(1)
          ,Comps_Fields.InvalidMessage_no_of_rooms(1)
          ,Comps_Fields.InvalidMessage_no_of_bedrooms(1)
          ,Comps_Fields.InvalidMessage_no_of_baths(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.seq_ALLOW_ErrorCount
          ,le.ln_fares_id_ALLOW_ErrorCount
          ,le.unformatted_apn_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount
          ,le.land_use_code_ENUM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_ENUM_ErrorCount
          ,le.recording_date_CUSTOM_ErrorCount
          ,le.assessed_value_year_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.lot_size_ALLOW_ErrorCount
          ,le.building_area_ALLOW_ErrorCount
          ,le.year_built_ALLOW_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount
          ,le.no_of_rooms_ALLOW_ErrorCount
          ,le.no_of_bedrooms_ALLOW_ErrorCount
          ,le.no_of_baths_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.seq_ALLOW_ErrorCount
          ,le.ln_fares_id_ALLOW_ErrorCount
          ,le.unformatted_apn_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount
          ,le.land_use_code_ENUM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_ENUM_ErrorCount
          ,le.recording_date_CUSTOM_ErrorCount
          ,le.assessed_value_year_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.lot_size_ALLOW_ErrorCount
          ,le.building_area_ALLOW_ErrorCount
          ,le.year_built_ALLOW_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount
          ,le.no_of_rooms_ALLOW_ErrorCount
          ,le.no_of_bedrooms_ALLOW_ErrorCount
          ,le.no_of_baths_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Comps_hygiene(PROJECT(h, Comps_Layout_AVM));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'seq:' + getFieldTypeText(h.seq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_fares_id:' + getFieldTypeText(h.ln_fares_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unformatted_apn:' + getFieldTypeText(h.unformatted_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lat:' + getFieldTypeText(h.lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'long:' + getFieldTypeText(h.long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_code:' + getFieldTypeText(h.fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_use_code:' + getFieldTypeText(h.land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price:' + getFieldTypeText(h.sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price_code:' + getFieldTypeText(h.sales_price_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_date:' + getFieldTypeText(h.recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_value_year:' + getFieldTypeText(h.assessed_value_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_total_value:' + getFieldTypeText(h.assessed_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_total_value:' + getFieldTypeText(h.market_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size:' + getFieldTypeText(h.lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_area:' + getFieldTypeText(h.building_area) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_built:' + getFieldTypeText(h.year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_stories:' + getFieldTypeText(h.no_of_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_rooms:' + getFieldTypeText(h.no_of_rooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_bedrooms:' + getFieldTypeText(h.no_of_bedrooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_baths:' + getFieldTypeText(h.no_of_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_seq_cnt
          ,le.populated_ln_fares_id_cnt
          ,le.populated_unformatted_apn_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_lat_cnt
          ,le.populated_long_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_fips_code_cnt
          ,le.populated_land_use_code_cnt
          ,le.populated_sales_price_cnt
          ,le.populated_sales_price_code_cnt
          ,le.populated_recording_date_cnt
          ,le.populated_assessed_value_year_cnt
          ,le.populated_assessed_total_value_cnt
          ,le.populated_market_total_value_cnt
          ,le.populated_lot_size_cnt
          ,le.populated_building_area_cnt
          ,le.populated_year_built_cnt
          ,le.populated_no_of_stories_cnt
          ,le.populated_no_of_rooms_cnt
          ,le.populated_no_of_bedrooms_cnt
          ,le.populated_no_of_baths_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_seq_pcnt
          ,le.populated_ln_fares_id_pcnt
          ,le.populated_unformatted_apn_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_lat_pcnt
          ,le.populated_long_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_fips_code_pcnt
          ,le.populated_land_use_code_pcnt
          ,le.populated_sales_price_pcnt
          ,le.populated_sales_price_code_pcnt
          ,le.populated_recording_date_pcnt
          ,le.populated_assessed_value_year_pcnt
          ,le.populated_assessed_total_value_pcnt
          ,le.populated_market_total_value_pcnt
          ,le.populated_lot_size_pcnt
          ,le.populated_building_area_pcnt
          ,le.populated_year_built_pcnt
          ,le.populated_no_of_stories_pcnt
          ,le.populated_no_of_rooms_pcnt
          ,le.populated_no_of_bedrooms_pcnt
          ,le.populated_no_of_baths_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,32,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Comps_Delta(prevDS, PROJECT(h, Comps_Layout_AVM));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),32,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Comps_Layout_AVM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_AVM, Comps_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
