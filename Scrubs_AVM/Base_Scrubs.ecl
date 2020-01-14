IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 39;
  EXPORT NumRulesFromFieldType := 39;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 39;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_AVM)
    UNSIGNED1 history_date_Invalid;
    UNSIGNED1 ln_fares_id_ta_Invalid;
    UNSIGNED1 ln_fares_id_pi_Invalid;
    UNSIGNED1 unformatted_apn_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 fips_code_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 assessed_value_year_Invalid;
    UNSIGNED1 sales_price_Invalid;
    UNSIGNED1 assessed_total_value_Invalid;
    UNSIGNED1 market_total_value_Invalid;
    UNSIGNED1 tax_assessment_valuation_Invalid;
    UNSIGNED1 price_index_valuation_Invalid;
    UNSIGNED1 hedonic_valuation_Invalid;
    UNSIGNED1 automated_valuation_Invalid;
    UNSIGNED1 confidence_score_Invalid;
    UNSIGNED1 comp1_Invalid;
    UNSIGNED1 comp2_Invalid;
    UNSIGNED1 comp3_Invalid;
    UNSIGNED1 comp4_Invalid;
    UNSIGNED1 comp5_Invalid;
    UNSIGNED1 nearby1_Invalid;
    UNSIGNED1 nearby2_Invalid;
    UNSIGNED1 nearby3_Invalid;
    UNSIGNED1 nearby4_Invalid;
    UNSIGNED1 nearby5_Invalid;
    UNSIGNED1 history_history_date_Invalid;
    UNSIGNED1 history_recording_date_Invalid;
    UNSIGNED1 history_assessed_value_year_Invalid;
    UNSIGNED1 history_sales_price_Invalid;
    UNSIGNED1 history_assessed_total_value_Invalid;
    UNSIGNED1 history_market_total_value_Invalid;
    UNSIGNED1 history_tax_assessment_valuation_Invalid;
    UNSIGNED1 history_price_index_valuation_Invalid;
    UNSIGNED1 history_hedonic_valuation_Invalid;
    UNSIGNED1 history_automated_valuation_Invalid;
    UNSIGNED1 history_confidence_score_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_AVM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_AVM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.history_date_Invalid := Base_Fields.InValid_history_date((SALT38.StrType)le.history_date);
    SELF.ln_fares_id_ta_Invalid := Base_Fields.InValid_ln_fares_id_ta((SALT38.StrType)le.ln_fares_id_ta);
    SELF.ln_fares_id_pi_Invalid := Base_Fields.InValid_ln_fares_id_pi((SALT38.StrType)le.ln_fares_id_pi);
    SELF.unformatted_apn_Invalid := Base_Fields.InValid_unformatted_apn((SALT38.StrType)le.unformatted_apn);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.fips_code_Invalid := Base_Fields.InValid_fips_code((SALT38.StrType)le.fips_code);
    SELF.recording_date_Invalid := Base_Fields.InValid_recording_date((SALT38.StrType)le.recording_date);
    SELF.assessed_value_year_Invalid := Base_Fields.InValid_assessed_value_year((SALT38.StrType)le.assessed_value_year);
    SELF.sales_price_Invalid := Base_Fields.InValid_sales_price((SALT38.StrType)le.sales_price);
    SELF.assessed_total_value_Invalid := Base_Fields.InValid_assessed_total_value((SALT38.StrType)le.assessed_total_value);
    SELF.market_total_value_Invalid := Base_Fields.InValid_market_total_value((SALT38.StrType)le.market_total_value);
    SELF.tax_assessment_valuation_Invalid := Base_Fields.InValid_tax_assessment_valuation((SALT38.StrType)le.tax_assessment_valuation);
    SELF.price_index_valuation_Invalid := Base_Fields.InValid_price_index_valuation((SALT38.StrType)le.price_index_valuation);
    SELF.hedonic_valuation_Invalid := Base_Fields.InValid_hedonic_valuation((SALT38.StrType)le.hedonic_valuation);
    SELF.automated_valuation_Invalid := Base_Fields.InValid_automated_valuation((SALT38.StrType)le.automated_valuation);
    SELF.confidence_score_Invalid := Base_Fields.InValid_confidence_score((SALT38.StrType)le.confidence_score);
    SELF.comp1_Invalid := Base_Fields.InValid_comp1((SALT38.StrType)le.comp1);
    SELF.comp2_Invalid := Base_Fields.InValid_comp2((SALT38.StrType)le.comp2);
    SELF.comp3_Invalid := Base_Fields.InValid_comp3((SALT38.StrType)le.comp3);
    SELF.comp4_Invalid := Base_Fields.InValid_comp4((SALT38.StrType)le.comp4);
    SELF.comp5_Invalid := Base_Fields.InValid_comp5((SALT38.StrType)le.comp5);
    SELF.nearby1_Invalid := Base_Fields.InValid_nearby1((SALT38.StrType)le.nearby1);
    SELF.nearby2_Invalid := Base_Fields.InValid_nearby2((SALT38.StrType)le.nearby2);
    SELF.nearby3_Invalid := Base_Fields.InValid_nearby3((SALT38.StrType)le.nearby3);
    SELF.nearby4_Invalid := Base_Fields.InValid_nearby4((SALT38.StrType)le.nearby4);
    SELF.nearby5_Invalid := Base_Fields.InValid_nearby5((SALT38.StrType)le.nearby5);
    SELF.history_history_date_Invalid := Base_Fields.InValid_history_history_date((SALT38.StrType)le.history_history_date);
    SELF.history_recording_date_Invalid := Base_Fields.InValid_history_recording_date((SALT38.StrType)le.history_recording_date);
    SELF.history_assessed_value_year_Invalid := Base_Fields.InValid_history_assessed_value_year((SALT38.StrType)le.history_assessed_value_year);
    SELF.history_sales_price_Invalid := Base_Fields.InValid_history_sales_price((SALT38.StrType)le.history_sales_price);
    SELF.history_assessed_total_value_Invalid := Base_Fields.InValid_history_assessed_total_value((SALT38.StrType)le.history_assessed_total_value);
    SELF.history_market_total_value_Invalid := Base_Fields.InValid_history_market_total_value((SALT38.StrType)le.history_market_total_value);
    SELF.history_tax_assessment_valuation_Invalid := Base_Fields.InValid_history_tax_assessment_valuation((SALT38.StrType)le.history_tax_assessment_valuation);
    SELF.history_price_index_valuation_Invalid := Base_Fields.InValid_history_price_index_valuation((SALT38.StrType)le.history_price_index_valuation);
    SELF.history_hedonic_valuation_Invalid := Base_Fields.InValid_history_hedonic_valuation((SALT38.StrType)le.history_hedonic_valuation);
    SELF.history_automated_valuation_Invalid := Base_Fields.InValid_history_automated_valuation((SALT38.StrType)le.history_automated_valuation);
    SELF.history_confidence_score_Invalid := Base_Fields.InValid_history_confidence_score((SALT38.StrType)le.history_confidence_score);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_AVM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.history_date_Invalid << 0 ) + ( le.ln_fares_id_ta_Invalid << 1 ) + ( le.ln_fares_id_pi_Invalid << 2 ) + ( le.unformatted_apn_Invalid << 3 ) + ( le.st_Invalid << 4 ) + ( le.zip_Invalid << 5 ) + ( le.zip4_Invalid << 6 ) + ( le.fips_code_Invalid << 7 ) + ( le.recording_date_Invalid << 8 ) + ( le.assessed_value_year_Invalid << 9 ) + ( le.sales_price_Invalid << 10 ) + ( le.assessed_total_value_Invalid << 11 ) + ( le.market_total_value_Invalid << 12 ) + ( le.tax_assessment_valuation_Invalid << 13 ) + ( le.price_index_valuation_Invalid << 14 ) + ( le.hedonic_valuation_Invalid << 15 ) + ( le.automated_valuation_Invalid << 16 ) + ( le.confidence_score_Invalid << 17 ) + ( le.comp1_Invalid << 18 ) + ( le.comp2_Invalid << 19 ) + ( le.comp3_Invalid << 20 ) + ( le.comp4_Invalid << 21 ) + ( le.comp5_Invalid << 22 ) + ( le.nearby1_Invalid << 23 ) + ( le.nearby2_Invalid << 24 ) + ( le.nearby3_Invalid << 25 ) + ( le.nearby4_Invalid << 26 ) + ( le.nearby5_Invalid << 27 ) + ( le.history_history_date_Invalid << 28 ) + ( le.history_recording_date_Invalid << 29 ) + ( le.history_assessed_value_year_Invalid << 30 ) + ( le.history_sales_price_Invalid << 31 ) + ( le.history_assessed_total_value_Invalid << 32 ) + ( le.history_market_total_value_Invalid << 33 ) + ( le.history_tax_assessment_valuation_Invalid << 34 ) + ( le.history_price_index_valuation_Invalid << 35 ) + ( le.history_hedonic_valuation_Invalid << 36 ) + ( le.history_automated_valuation_Invalid << 37 ) + ( le.history_confidence_score_Invalid << 38 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_AVM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.history_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ln_fares_id_ta_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.ln_fares_id_pi_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.unformatted_apn_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.fips_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.assessed_value_year_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.sales_price_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.assessed_total_value_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.market_total_value_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.tax_assessment_valuation_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.price_index_valuation_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.hedonic_valuation_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.automated_valuation_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.confidence_score_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.comp1_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.comp2_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.comp3_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.comp4_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.comp5_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.nearby1_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.nearby2_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.nearby3_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.nearby4_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.nearby5_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.history_history_date_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.history_recording_date_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.history_assessed_value_year_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.history_sales_price_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.history_assessed_total_value_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.history_market_total_value_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.history_tax_assessment_valuation_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.history_price_index_valuation_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.history_hedonic_valuation_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.history_automated_valuation_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.history_confidence_score_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    history_date_CUSTOM_ErrorCount := COUNT(GROUP,h.history_date_Invalid=1);
    ln_fares_id_ta_ALLOW_ErrorCount := COUNT(GROUP,h.ln_fares_id_ta_Invalid=1);
    ln_fares_id_pi_ALLOW_ErrorCount := COUNT(GROUP,h.ln_fares_id_pi_Invalid=1);
    unformatted_apn_ALLOW_ErrorCount := COUNT(GROUP,h.unformatted_apn_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    assessed_value_year_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_value_year_Invalid=1);
    sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.sales_price_Invalid=1);
    assessed_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_total_value_Invalid=1);
    market_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_total_value_Invalid=1);
    tax_assessment_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.tax_assessment_valuation_Invalid=1);
    price_index_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.price_index_valuation_Invalid=1);
    hedonic_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.hedonic_valuation_Invalid=1);
    automated_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.automated_valuation_Invalid=1);
    confidence_score_ALLOW_ErrorCount := COUNT(GROUP,h.confidence_score_Invalid=1);
    comp1_ALLOW_ErrorCount := COUNT(GROUP,h.comp1_Invalid=1);
    comp2_ALLOW_ErrorCount := COUNT(GROUP,h.comp2_Invalid=1);
    comp3_ALLOW_ErrorCount := COUNT(GROUP,h.comp3_Invalid=1);
    comp4_ALLOW_ErrorCount := COUNT(GROUP,h.comp4_Invalid=1);
    comp5_ALLOW_ErrorCount := COUNT(GROUP,h.comp5_Invalid=1);
    nearby1_ALLOW_ErrorCount := COUNT(GROUP,h.nearby1_Invalid=1);
    nearby2_ALLOW_ErrorCount := COUNT(GROUP,h.nearby2_Invalid=1);
    nearby3_ALLOW_ErrorCount := COUNT(GROUP,h.nearby3_Invalid=1);
    nearby4_ALLOW_ErrorCount := COUNT(GROUP,h.nearby4_Invalid=1);
    nearby5_ALLOW_ErrorCount := COUNT(GROUP,h.nearby5_Invalid=1);
    history_history_date_CUSTOM_ErrorCount := COUNT(GROUP,h.history_history_date_Invalid=1);
    history_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.history_recording_date_Invalid=1);
    history_assessed_value_year_ALLOW_ErrorCount := COUNT(GROUP,h.history_assessed_value_year_Invalid=1);
    history_sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.history_sales_price_Invalid=1);
    history_assessed_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.history_assessed_total_value_Invalid=1);
    history_market_total_value_ALLOW_ErrorCount := COUNT(GROUP,h.history_market_total_value_Invalid=1);
    history_tax_assessment_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.history_tax_assessment_valuation_Invalid=1);
    history_price_index_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.history_price_index_valuation_Invalid=1);
    history_hedonic_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.history_hedonic_valuation_Invalid=1);
    history_automated_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.history_automated_valuation_Invalid=1);
    history_confidence_score_ALLOW_ErrorCount := COUNT(GROUP,h.history_confidence_score_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.history_date_Invalid > 0 OR h.ln_fares_id_ta_Invalid > 0 OR h.ln_fares_id_pi_Invalid > 0 OR h.unformatted_apn_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.fips_code_Invalid > 0 OR h.recording_date_Invalid > 0 OR h.assessed_value_year_Invalid > 0 OR h.sales_price_Invalid > 0 OR h.assessed_total_value_Invalid > 0 OR h.market_total_value_Invalid > 0 OR h.tax_assessment_valuation_Invalid > 0 OR h.price_index_valuation_Invalid > 0 OR h.hedonic_valuation_Invalid > 0 OR h.automated_valuation_Invalid > 0 OR h.confidence_score_Invalid > 0 OR h.comp1_Invalid > 0 OR h.comp2_Invalid > 0 OR h.comp3_Invalid > 0 OR h.comp4_Invalid > 0 OR h.comp5_Invalid > 0 OR h.nearby1_Invalid > 0 OR h.nearby2_Invalid > 0 OR h.nearby3_Invalid > 0 OR h.nearby4_Invalid > 0 OR h.nearby5_Invalid > 0 OR h.history_history_date_Invalid > 0 OR h.history_recording_date_Invalid > 0 OR h.history_assessed_value_year_Invalid > 0 OR h.history_sales_price_Invalid > 0 OR h.history_assessed_total_value_Invalid > 0 OR h.history_market_total_value_Invalid > 0 OR h.history_tax_assessment_valuation_Invalid > 0 OR h.history_price_index_valuation_Invalid > 0 OR h.history_hedonic_valuation_Invalid > 0 OR h.history_automated_valuation_Invalid > 0 OR h.history_confidence_score_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ta_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_pi_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tax_assessment_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.price_index_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hedonic_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.automated_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.confidence_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_tax_assessment_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_price_index_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_hedonic_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_automated_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_confidence_score_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ta_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_pi_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tax_assessment_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.price_index_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hedonic_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.automated_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.confidence_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.comp5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nearby5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_assessed_value_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_assessed_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_market_total_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_tax_assessment_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_price_index_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_hedonic_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_automated_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_confidence_score_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.history_date_Invalid,le.ln_fares_id_ta_Invalid,le.ln_fares_id_pi_Invalid,le.unformatted_apn_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.fips_code_Invalid,le.recording_date_Invalid,le.assessed_value_year_Invalid,le.sales_price_Invalid,le.assessed_total_value_Invalid,le.market_total_value_Invalid,le.tax_assessment_valuation_Invalid,le.price_index_valuation_Invalid,le.hedonic_valuation_Invalid,le.automated_valuation_Invalid,le.confidence_score_Invalid,le.comp1_Invalid,le.comp2_Invalid,le.comp3_Invalid,le.comp4_Invalid,le.comp5_Invalid,le.nearby1_Invalid,le.nearby2_Invalid,le.nearby3_Invalid,le.nearby4_Invalid,le.nearby5_Invalid,le.history_history_date_Invalid,le.history_recording_date_Invalid,le.history_assessed_value_year_Invalid,le.history_sales_price_Invalid,le.history_assessed_total_value_Invalid,le.history_market_total_value_Invalid,le.history_tax_assessment_valuation_Invalid,le.history_price_index_valuation_Invalid,le.history_hedonic_valuation_Invalid,le.history_automated_valuation_Invalid,le.history_confidence_score_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_history_date(le.history_date_Invalid),Base_Fields.InvalidMessage_ln_fares_id_ta(le.ln_fares_id_ta_Invalid),Base_Fields.InvalidMessage_ln_fares_id_pi(le.ln_fares_id_pi_Invalid),Base_Fields.InvalidMessage_unformatted_apn(le.unformatted_apn_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Base_Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Base_Fields.InvalidMessage_assessed_value_year(le.assessed_value_year_Invalid),Base_Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Base_Fields.InvalidMessage_assessed_total_value(le.assessed_total_value_Invalid),Base_Fields.InvalidMessage_market_total_value(le.market_total_value_Invalid),Base_Fields.InvalidMessage_tax_assessment_valuation(le.tax_assessment_valuation_Invalid),Base_Fields.InvalidMessage_price_index_valuation(le.price_index_valuation_Invalid),Base_Fields.InvalidMessage_hedonic_valuation(le.hedonic_valuation_Invalid),Base_Fields.InvalidMessage_automated_valuation(le.automated_valuation_Invalid),Base_Fields.InvalidMessage_confidence_score(le.confidence_score_Invalid),Base_Fields.InvalidMessage_comp1(le.comp1_Invalid),Base_Fields.InvalidMessage_comp2(le.comp2_Invalid),Base_Fields.InvalidMessage_comp3(le.comp3_Invalid),Base_Fields.InvalidMessage_comp4(le.comp4_Invalid),Base_Fields.InvalidMessage_comp5(le.comp5_Invalid),Base_Fields.InvalidMessage_nearby1(le.nearby1_Invalid),Base_Fields.InvalidMessage_nearby2(le.nearby2_Invalid),Base_Fields.InvalidMessage_nearby3(le.nearby3_Invalid),Base_Fields.InvalidMessage_nearby4(le.nearby4_Invalid),Base_Fields.InvalidMessage_nearby5(le.nearby5_Invalid),Base_Fields.InvalidMessage_history_history_date(le.history_history_date_Invalid),Base_Fields.InvalidMessage_history_recording_date(le.history_recording_date_Invalid),Base_Fields.InvalidMessage_history_assessed_value_year(le.history_assessed_value_year_Invalid),Base_Fields.InvalidMessage_history_sales_price(le.history_sales_price_Invalid),Base_Fields.InvalidMessage_history_assessed_total_value(le.history_assessed_total_value_Invalid),Base_Fields.InvalidMessage_history_market_total_value(le.history_market_total_value_Invalid),Base_Fields.InvalidMessage_history_tax_assessment_valuation(le.history_tax_assessment_valuation_Invalid),Base_Fields.InvalidMessage_history_price_index_valuation(le.history_price_index_valuation_Invalid),Base_Fields.InvalidMessage_history_hedonic_valuation(le.history_hedonic_valuation_Invalid),Base_Fields.InvalidMessage_history_automated_valuation(le.history_automated_valuation_Invalid),Base_Fields.InvalidMessage_history_confidence_score(le.history_confidence_score_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.history_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ln_fares_id_ta_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ln_fares_id_pi_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unformatted_apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessed_value_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assessed_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tax_assessment_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.price_index_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hedonic_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.automated_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.confidence_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comp1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comp2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comp3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comp4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.comp5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nearby1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nearby2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nearby3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nearby4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nearby5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_history_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.history_recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.history_assessed_value_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_assessed_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_market_total_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_tax_assessment_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_price_index_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_hedonic_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_automated_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_confidence_score_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'history_date','ln_fares_id_ta','ln_fares_id_pi','unformatted_apn','st','zip','zip4','fips_code','recording_date','assessed_value_year','sales_price','assessed_total_value','market_total_value','tax_assessment_valuation','price_index_valuation','hedonic_valuation','automated_valuation','confidence_score','comp1','comp2','comp3','comp4','comp5','nearby1','nearby2','nearby3','nearby4','nearby5','history_history_date','history_recording_date','history_assessed_value_year','history_sales_price','history_assessed_total_value','history_market_total_value','history_tax_assessment_valuation','history_price_index_valuation','history_hedonic_valuation','history_automated_valuation','history_confidence_score','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Alpha','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Comps','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.history_date,(SALT38.StrType)le.ln_fares_id_ta,(SALT38.StrType)le.ln_fares_id_pi,(SALT38.StrType)le.unformatted_apn,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.fips_code,(SALT38.StrType)le.recording_date,(SALT38.StrType)le.assessed_value_year,(SALT38.StrType)le.sales_price,(SALT38.StrType)le.assessed_total_value,(SALT38.StrType)le.market_total_value,(SALT38.StrType)le.tax_assessment_valuation,(SALT38.StrType)le.price_index_valuation,(SALT38.StrType)le.hedonic_valuation,(SALT38.StrType)le.automated_valuation,(SALT38.StrType)le.confidence_score,(SALT38.StrType)le.comp1,(SALT38.StrType)le.comp2,(SALT38.StrType)le.comp3,(SALT38.StrType)le.comp4,(SALT38.StrType)le.comp5,(SALT38.StrType)le.nearby1,(SALT38.StrType)le.nearby2,(SALT38.StrType)le.nearby3,(SALT38.StrType)le.nearby4,(SALT38.StrType)le.nearby5,(SALT38.StrType)le.history_history_date,(SALT38.StrType)le.history_recording_date,(SALT38.StrType)le.history_assessed_value_year,(SALT38.StrType)le.history_sales_price,(SALT38.StrType)le.history_assessed_total_value,(SALT38.StrType)le.history_market_total_value,(SALT38.StrType)le.history_tax_assessment_valuation,(SALT38.StrType)le.history_price_index_valuation,(SALT38.StrType)le.history_hedonic_valuation,(SALT38.StrType)le.history_automated_valuation,(SALT38.StrType)le.history_confidence_score,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,39,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_AVM) prevDS = DATASET([], Base_Layout_AVM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'history_date:Invalid_Date:CUSTOM'
          ,'ln_fares_id_ta:Invalid_Comps:ALLOW'
          ,'ln_fares_id_pi:Invalid_Comps:ALLOW'
          ,'unformatted_apn:Invalid_Comps:ALLOW'
          ,'st:Invalid_Alpha:ALLOW'
          ,'zip:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'fips_code:Invalid_Num:ALLOW'
          ,'recording_date:Invalid_Date:CUSTOM'
          ,'assessed_value_year:Invalid_Num:ALLOW'
          ,'sales_price:Invalid_Num:ALLOW'
          ,'assessed_total_value:Invalid_Num:ALLOW'
          ,'market_total_value:Invalid_Num:ALLOW'
          ,'tax_assessment_valuation:Invalid_Num:ALLOW'
          ,'price_index_valuation:Invalid_Num:ALLOW'
          ,'hedonic_valuation:Invalid_Num:ALLOW'
          ,'automated_valuation:Invalid_Num:ALLOW'
          ,'confidence_score:Invalid_Num:ALLOW'
          ,'comp1:Invalid_Comps:ALLOW'
          ,'comp2:Invalid_Comps:ALLOW'
          ,'comp3:Invalid_Comps:ALLOW'
          ,'comp4:Invalid_Comps:ALLOW'
          ,'comp5:Invalid_Comps:ALLOW'
          ,'nearby1:Invalid_Comps:ALLOW'
          ,'nearby2:Invalid_Comps:ALLOW'
          ,'nearby3:Invalid_Comps:ALLOW'
          ,'nearby4:Invalid_Comps:ALLOW'
          ,'nearby5:Invalid_Comps:ALLOW'
          ,'history_history_date:Invalid_Date:CUSTOM'
          ,'history_recording_date:Invalid_Date:CUSTOM'
          ,'history_assessed_value_year:Invalid_Num:ALLOW'
          ,'history_sales_price:Invalid_Num:ALLOW'
          ,'history_assessed_total_value:Invalid_Num:ALLOW'
          ,'history_market_total_value:Invalid_Num:ALLOW'
          ,'history_tax_assessment_valuation:Invalid_Num:ALLOW'
          ,'history_price_index_valuation:Invalid_Num:ALLOW'
          ,'history_hedonic_valuation:Invalid_Num:ALLOW'
          ,'history_automated_valuation:Invalid_Num:ALLOW'
          ,'history_confidence_score:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_history_date(1)
          ,Base_Fields.InvalidMessage_ln_fares_id_ta(1)
          ,Base_Fields.InvalidMessage_ln_fares_id_pi(1)
          ,Base_Fields.InvalidMessage_unformatted_apn(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_fips_code(1)
          ,Base_Fields.InvalidMessage_recording_date(1)
          ,Base_Fields.InvalidMessage_assessed_value_year(1)
          ,Base_Fields.InvalidMessage_sales_price(1)
          ,Base_Fields.InvalidMessage_assessed_total_value(1)
          ,Base_Fields.InvalidMessage_market_total_value(1)
          ,Base_Fields.InvalidMessage_tax_assessment_valuation(1)
          ,Base_Fields.InvalidMessage_price_index_valuation(1)
          ,Base_Fields.InvalidMessage_hedonic_valuation(1)
          ,Base_Fields.InvalidMessage_automated_valuation(1)
          ,Base_Fields.InvalidMessage_confidence_score(1)
          ,Base_Fields.InvalidMessage_comp1(1)
          ,Base_Fields.InvalidMessage_comp2(1)
          ,Base_Fields.InvalidMessage_comp3(1)
          ,Base_Fields.InvalidMessage_comp4(1)
          ,Base_Fields.InvalidMessage_comp5(1)
          ,Base_Fields.InvalidMessage_nearby1(1)
          ,Base_Fields.InvalidMessage_nearby2(1)
          ,Base_Fields.InvalidMessage_nearby3(1)
          ,Base_Fields.InvalidMessage_nearby4(1)
          ,Base_Fields.InvalidMessage_nearby5(1)
          ,Base_Fields.InvalidMessage_history_history_date(1)
          ,Base_Fields.InvalidMessage_history_recording_date(1)
          ,Base_Fields.InvalidMessage_history_assessed_value_year(1)
          ,Base_Fields.InvalidMessage_history_sales_price(1)
          ,Base_Fields.InvalidMessage_history_assessed_total_value(1)
          ,Base_Fields.InvalidMessage_history_market_total_value(1)
          ,Base_Fields.InvalidMessage_history_tax_assessment_valuation(1)
          ,Base_Fields.InvalidMessage_history_price_index_valuation(1)
          ,Base_Fields.InvalidMessage_history_hedonic_valuation(1)
          ,Base_Fields.InvalidMessage_history_automated_valuation(1)
          ,Base_Fields.InvalidMessage_history_confidence_score(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.history_date_CUSTOM_ErrorCount
          ,le.ln_fares_id_ta_ALLOW_ErrorCount
          ,le.ln_fares_id_pi_ALLOW_ErrorCount
          ,le.unformatted_apn_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount
          ,le.recording_date_CUSTOM_ErrorCount
          ,le.assessed_value_year_ALLOW_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.tax_assessment_valuation_ALLOW_ErrorCount
          ,le.price_index_valuation_ALLOW_ErrorCount
          ,le.hedonic_valuation_ALLOW_ErrorCount
          ,le.automated_valuation_ALLOW_ErrorCount
          ,le.confidence_score_ALLOW_ErrorCount
          ,le.comp1_ALLOW_ErrorCount
          ,le.comp2_ALLOW_ErrorCount
          ,le.comp3_ALLOW_ErrorCount
          ,le.comp4_ALLOW_ErrorCount
          ,le.comp5_ALLOW_ErrorCount
          ,le.nearby1_ALLOW_ErrorCount
          ,le.nearby2_ALLOW_ErrorCount
          ,le.nearby3_ALLOW_ErrorCount
          ,le.nearby4_ALLOW_ErrorCount
          ,le.nearby5_ALLOW_ErrorCount
          ,le.history_history_date_CUSTOM_ErrorCount
          ,le.history_recording_date_CUSTOM_ErrorCount
          ,le.history_assessed_value_year_ALLOW_ErrorCount
          ,le.history_sales_price_ALLOW_ErrorCount
          ,le.history_assessed_total_value_ALLOW_ErrorCount
          ,le.history_market_total_value_ALLOW_ErrorCount
          ,le.history_tax_assessment_valuation_ALLOW_ErrorCount
          ,le.history_price_index_valuation_ALLOW_ErrorCount
          ,le.history_hedonic_valuation_ALLOW_ErrorCount
          ,le.history_automated_valuation_ALLOW_ErrorCount
          ,le.history_confidence_score_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.history_date_CUSTOM_ErrorCount
          ,le.ln_fares_id_ta_ALLOW_ErrorCount
          ,le.ln_fares_id_pi_ALLOW_ErrorCount
          ,le.unformatted_apn_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount
          ,le.recording_date_CUSTOM_ErrorCount
          ,le.assessed_value_year_ALLOW_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.assessed_total_value_ALLOW_ErrorCount
          ,le.market_total_value_ALLOW_ErrorCount
          ,le.tax_assessment_valuation_ALLOW_ErrorCount
          ,le.price_index_valuation_ALLOW_ErrorCount
          ,le.hedonic_valuation_ALLOW_ErrorCount
          ,le.automated_valuation_ALLOW_ErrorCount
          ,le.confidence_score_ALLOW_ErrorCount
          ,le.comp1_ALLOW_ErrorCount
          ,le.comp2_ALLOW_ErrorCount
          ,le.comp3_ALLOW_ErrorCount
          ,le.comp4_ALLOW_ErrorCount
          ,le.comp5_ALLOW_ErrorCount
          ,le.nearby1_ALLOW_ErrorCount
          ,le.nearby2_ALLOW_ErrorCount
          ,le.nearby3_ALLOW_ErrorCount
          ,le.nearby4_ALLOW_ErrorCount
          ,le.nearby5_ALLOW_ErrorCount
          ,le.history_history_date_CUSTOM_ErrorCount
          ,le.history_recording_date_CUSTOM_ErrorCount
          ,le.history_assessed_value_year_ALLOW_ErrorCount
          ,le.history_sales_price_ALLOW_ErrorCount
          ,le.history_assessed_total_value_ALLOW_ErrorCount
          ,le.history_market_total_value_ALLOW_ErrorCount
          ,le.history_tax_assessment_valuation_ALLOW_ErrorCount
          ,le.history_price_index_valuation_ALLOW_ErrorCount
          ,le.history_hedonic_valuation_ALLOW_ErrorCount
          ,le.history_automated_valuation_ALLOW_ErrorCount
          ,le.history_confidence_score_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_AVM));
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
          ,'history_date:' + getFieldTypeText(h.history_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_fares_id_ta:' + getFieldTypeText(h.ln_fares_id_ta) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_fares_id_pi:' + getFieldTypeText(h.ln_fares_id_pi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'land_use:' + getFieldTypeText(h.land_use) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_date:' + getFieldTypeText(h.recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_value_year:' + getFieldTypeText(h.assessed_value_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price:' + getFieldTypeText(h.sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_total_value:' + getFieldTypeText(h.assessed_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_total_value:' + getFieldTypeText(h.market_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_assessment_valuation:' + getFieldTypeText(h.tax_assessment_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'price_index_valuation:' + getFieldTypeText(h.price_index_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hedonic_valuation:' + getFieldTypeText(h.hedonic_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'automated_valuation:' + getFieldTypeText(h.automated_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'confidence_score:' + getFieldTypeText(h.confidence_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comp1:' + getFieldTypeText(h.comp1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comp2:' + getFieldTypeText(h.comp2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comp3:' + getFieldTypeText(h.comp3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comp4:' + getFieldTypeText(h.comp4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comp5:' + getFieldTypeText(h.comp5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nearby1:' + getFieldTypeText(h.nearby1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nearby2:' + getFieldTypeText(h.nearby2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nearby3:' + getFieldTypeText(h.nearby3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nearby4:' + getFieldTypeText(h.nearby4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nearby5:' + getFieldTypeText(h.nearby5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_history_date:' + getFieldTypeText(h.history_history_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_land_use:' + getFieldTypeText(h.history_land_use) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_recording_date:' + getFieldTypeText(h.history_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_assessed_value_year:' + getFieldTypeText(h.history_assessed_value_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_sales_price:' + getFieldTypeText(h.history_sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_assessed_total_value:' + getFieldTypeText(h.history_assessed_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_market_total_value:' + getFieldTypeText(h.history_market_total_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_tax_assessment_valuation:' + getFieldTypeText(h.history_tax_assessment_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_price_index_valuation:' + getFieldTypeText(h.history_price_index_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_hedonic_valuation:' + getFieldTypeText(h.history_hedonic_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_automated_valuation:' + getFieldTypeText(h.history_automated_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_confidence_score:' + getFieldTypeText(h.history_confidence_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_history_date_cnt
          ,le.populated_ln_fares_id_ta_cnt
          ,le.populated_ln_fares_id_pi_cnt
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
          ,le.populated_land_use_cnt
          ,le.populated_recording_date_cnt
          ,le.populated_assessed_value_year_cnt
          ,le.populated_sales_price_cnt
          ,le.populated_assessed_total_value_cnt
          ,le.populated_market_total_value_cnt
          ,le.populated_tax_assessment_valuation_cnt
          ,le.populated_price_index_valuation_cnt
          ,le.populated_hedonic_valuation_cnt
          ,le.populated_automated_valuation_cnt
          ,le.populated_confidence_score_cnt
          ,le.populated_comp1_cnt
          ,le.populated_comp2_cnt
          ,le.populated_comp3_cnt
          ,le.populated_comp4_cnt
          ,le.populated_comp5_cnt
          ,le.populated_nearby1_cnt
          ,le.populated_nearby2_cnt
          ,le.populated_nearby3_cnt
          ,le.populated_nearby4_cnt
          ,le.populated_nearby5_cnt
          ,le.populated_history_history_date_cnt
          ,le.populated_history_land_use_cnt
          ,le.populated_history_recording_date_cnt
          ,le.populated_history_assessed_value_year_cnt
          ,le.populated_history_sales_price_cnt
          ,le.populated_history_assessed_total_value_cnt
          ,le.populated_history_market_total_value_cnt
          ,le.populated_history_tax_assessment_valuation_cnt
          ,le.populated_history_price_index_valuation_cnt
          ,le.populated_history_hedonic_valuation_cnt
          ,le.populated_history_automated_valuation_cnt
          ,le.populated_history_confidence_score_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_history_date_pcnt
          ,le.populated_ln_fares_id_ta_pcnt
          ,le.populated_ln_fares_id_pi_pcnt
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
          ,le.populated_land_use_pcnt
          ,le.populated_recording_date_pcnt
          ,le.populated_assessed_value_year_pcnt
          ,le.populated_sales_price_pcnt
          ,le.populated_assessed_total_value_pcnt
          ,le.populated_market_total_value_pcnt
          ,le.populated_tax_assessment_valuation_pcnt
          ,le.populated_price_index_valuation_pcnt
          ,le.populated_hedonic_valuation_pcnt
          ,le.populated_automated_valuation_pcnt
          ,le.populated_confidence_score_pcnt
          ,le.populated_comp1_pcnt
          ,le.populated_comp2_pcnt
          ,le.populated_comp3_pcnt
          ,le.populated_comp4_pcnt
          ,le.populated_comp5_pcnt
          ,le.populated_nearby1_pcnt
          ,le.populated_nearby2_pcnt
          ,le.populated_nearby3_pcnt
          ,le.populated_nearby4_pcnt
          ,le.populated_nearby5_pcnt
          ,le.populated_history_history_date_pcnt
          ,le.populated_history_land_use_pcnt
          ,le.populated_history_recording_date_pcnt
          ,le.populated_history_assessed_value_year_pcnt
          ,le.populated_history_sales_price_pcnt
          ,le.populated_history_assessed_total_value_pcnt
          ,le.populated_history_market_total_value_pcnt
          ,le.populated_history_tax_assessment_valuation_pcnt
          ,le.populated_history_price_index_valuation_pcnt
          ,le.populated_history_hedonic_valuation_pcnt
          ,le.populated_history_automated_valuation_pcnt
          ,le.populated_history_confidence_score_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,52,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_AVM));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),52,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_AVM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_AVM, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
