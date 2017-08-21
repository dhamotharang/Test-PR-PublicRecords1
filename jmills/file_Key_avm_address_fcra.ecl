import avm_v2;

/*EXPORT integer8 avm_v2__layouts__max_history := 10;

layout_history_slim := RECORD
   string8 history_date;
   string1 land_use;
   string8 recording_date;
   string4 assessed_value_year;
   string11 sales_price;
   string11 assessed_total_value;
   string11 market_total_value;
   integer8 tax_assessment_valuation;
   integer8 price_index_valuation;
   integer8 hedonic_valuation;
   integer8 automated_valuation;
   integer8 confidence_score;
  END;

RECORD
  string28 prim_name;
  string2 st;
  string5 zip;
  string10 prim_range;
  string8 sec_range;
  string8 history_date;
  string12 ln_fares_id_ta;
  string12 ln_fares_id_pi;
  string45 unformatted_apn;
  string2 predir;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string4 zip4;
  string10 lat;
  string11 long;
  string7 geo_blk;
  string5 fips_code;
  string1 land_use;
  string8 recording_date;
  string4 assessed_value_year;
  string11 sales_price;
  string11 assessed_total_value;
  string11 market_total_value;
  integer8 tax_assessment_valuation;
  integer8 price_index_valuation;
  integer8 hedonic_valuation;
  integer8 automated_valuation;
  integer8 confidence_score;
  string12 comp1;
  string12 comp2;
  string12 comp3;
  string12 comp4;
  string12 comp5;
  string12 nearby1;
  string12 nearby2;
  string12 nearby3;
  string12 nearby4;
  string12 nearby5;
  DATASET(layout_history_slim) history{maxcount(avm_v2__layouts__max_history)};
  unsigned8 __internal_fpos__;
 END;*/
 
 layout_key_out := RECORD
  string28 prim_name;
  string2 st;
  string5 zip;
  string10 prim_range;
  string8 sec_range;
  string8 history_date;
  string12 ln_fares_id_ta;
  string12 ln_fares_id_pi;
  string45 unformatted_apn;
  string2 predir;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string4 zip4;
  string10 lat;
  string11 long;
  string7 geo_blk;
  string5 fips_code;
  string1 land_use;
  string8 recording_date;
  string4 assessed_value_year;
  string11 sales_price;
  string11 assessed_total_value;
  string11 market_total_value;
  integer8 tax_assessment_valuation;
  integer8 price_index_valuation;
  integer8 hedonic_valuation;
  integer8 automated_valuation;
  integer8 confidence_score;
  string12 comp1;
  string12 comp2;
  string12 comp3;
  string12 comp4;
  string12 comp5;
  string12 nearby1;
  string12 nearby2;
  string12 nearby3;
  string12 nearby4;
  string12 nearby5;
  //DATASET(layout_history_slim) history{maxcount(avm_v2__layouts__max_history)}; 
	 string8 history_history_date;
   string1 history_land_use;
   string8 history_recording_date;
   string4 history_assessed_value_year;
   string11 history_sales_price;
   string11 history_assessed_total_value;
   string11 history_market_total_value;
   string50 history_tax_assessment_valuation;
   string50 history_price_index_valuation;
   string50 history_hedonic_valuation;
   string50 history_automated_valuation;
   string50 history_confidence_score;
 //unsigned8 __internal_fpos__;
  END;

 key_in := avm_v2.key_avm_address_fcra;

 //transform statement
layout_key_out makerecord (key_in L) := transform
self.prim_name := L.prim_name;
self.st := L.st;
self.zip := L.zip;
self.prim_range := L.prim_range;
self.sec_range := L.sec_range;
self.history_date := L.history_date;
self.ln_fares_id_ta := L.ln_fares_id_ta;
self.ln_fares_id_pi := L.ln_fares_id_pi;
self.unformatted_apn := L.unformatted_apn;
self.predir := L.predir;
self.suffix := L.suffix;
self.postdir := L.postdir;
self.unit_desig := L.unit_desig;
self.p_city_name := L.p_city_name;
self.zip4 := L.zip4;
self.lat := L.lat;
self.long := L.long;
self.geo_blk := L.geo_blk;
self.fips_code := L.fips_code;
self.land_use := L.land_use;
self.recording_date := L.recording_date;
self.assessed_value_year := L.assessed_value_year;
self.sales_price := L.sales_price;
self.assessed_total_value := L.assessed_total_value;
self.market_total_value := L.market_total_value;
self.tax_assessment_valuation := L.tax_assessment_valuation;
self.price_index_valuation := L.price_index_valuation;
self.hedonic_valuation := L.hedonic_valuation;
self.automated_valuation := L.automated_valuation;
self.confidence_score := L.confidence_score;
self.comp1 := L.comp1;
self.comp2 := L.comp2;
self.comp3 := L.comp3;
self.comp4 := L.comp4;
self.comp5 := L.comp5;
self.nearby1 := L.nearby1;
self.nearby2 := L.nearby2;
self.nearby3 := L.nearby3;
self.nearby4 := L.nearby4;
self.nearby5 := L.nearby5;
//DATASET(layout_history_slim)history{maxcount(avm_v2__layouts__max_history)};
self.history_history_date := 'HISTORY DATE';
self.history_land_use := 'LAND USE';
self.history_recording_date := 'RECORDING DATE';
self.history_assessed_value_year := 'ASSESSED VALUE YEAR';
self.history_sales_price := 'SALES PRICE';
self.history_assessed_total_value := 'ASSESSED TOTAL VALUE';
self.history_market_total_value := 'MARKET TOTAL VALUE';
self.history_tax_assessment_valuation := 'TAX ASSESSMENT VALUATION';
self.history_price_index_valuation := 'PRICE INDEX VALUATION';
self.history_hedonic_valuation := 'HEDONIC VALUATION';
self.history_automated_valuation := 'AUTOMATED VALUATION';
self.history_confidence_score := 'CONFIDENCE SCORE';
//unsigned8__internal_fpos__  
END;




EXPORT file_Key_avm_address_fcra := project(key_in,makerecord(left));

	
