IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 52;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Num','Invalid_Comps');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_AlphaNum' => 2,'Invalid_Alpha' => 3,'Invalid_Num' => 4,'Invalid_Comps' => 5,0);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Comps(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789OAD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Comps(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789OAD'))));
EXPORT InValidMessageFT_Invalid_Comps(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789OAD'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'history_date','ln_fares_id_ta','ln_fares_id_pi','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use','recording_date','assessed_value_year','sales_price','assessed_total_value','market_total_value','tax_assessment_valuation','price_index_valuation','hedonic_valuation','automated_valuation','confidence_score','comp1','comp2','comp3','comp4','comp5','nearby1','nearby2','nearby3','nearby4','nearby5','history_history_date','history_land_use','history_recording_date','history_assessed_value_year','history_sales_price','history_assessed_total_value','history_market_total_value','history_tax_assessment_valuation','history_price_index_valuation','history_hedonic_valuation','history_automated_valuation','history_confidence_score');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'history_date','ln_fares_id_ta','ln_fares_id_pi','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use','recording_date','assessed_value_year','sales_price','assessed_total_value','market_total_value','tax_assessment_valuation','price_index_valuation','hedonic_valuation','automated_valuation','confidence_score','comp1','comp2','comp3','comp4','comp5','nearby1','nearby2','nearby3','nearby4','nearby5','history_history_date','history_land_use','history_recording_date','history_assessed_value_year','history_sales_price','history_assessed_total_value','history_market_total_value','history_tax_assessment_valuation','history_price_index_valuation','history_hedonic_valuation','history_automated_valuation','history_confidence_score');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'history_date' => 0,'ln_fares_id_ta' => 1,'ln_fares_id_pi' => 2,'unformatted_apn' => 3,'prim_range' => 4,'predir' => 5,'prim_name' => 6,'suffix' => 7,'postdir' => 8,'unit_desig' => 9,'sec_range' => 10,'p_city_name' => 11,'st' => 12,'zip' => 13,'zip4' => 14,'lat' => 15,'long' => 16,'geo_blk' => 17,'fips_code' => 18,'land_use' => 19,'recording_date' => 20,'assessed_value_year' => 21,'sales_price' => 22,'assessed_total_value' => 23,'market_total_value' => 24,'tax_assessment_valuation' => 25,'price_index_valuation' => 26,'hedonic_valuation' => 27,'automated_valuation' => 28,'confidence_score' => 29,'comp1' => 30,'comp2' => 31,'comp3' => 32,'comp4' => 33,'comp5' => 34,'nearby1' => 35,'nearby2' => 36,'nearby3' => 37,'nearby4' => 38,'nearby5' => 39,'history_history_date' => 40,'history_land_use' => 41,'history_recording_date' => 42,'history_assessed_value_year' => 43,'history_sales_price' => 44,'history_assessed_total_value' => 45,'history_market_total_value' => 46,'history_tax_assessment_valuation' => 47,'history_price_index_valuation' => 48,'history_hedonic_valuation' => 49,'history_automated_valuation' => 50,'history_confidence_score' => 51,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_history_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_history_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_history_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ln_fares_id_ta(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_ln_fares_id_ta(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_ln_fares_id_ta(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_ln_fares_id_pi(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_ln_fares_id_pi(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_ln_fares_id_pi(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_unformatted_apn(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_unformatted_apn(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_unformatted_apn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := s0;
EXPORT InValid_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := s0;
EXPORT InValid_prim_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := s0;
EXPORT InValid_postdir(SALT38.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lat(SALT38.StrType s0) := s0;
EXPORT InValid_lat(SALT38.StrType s) := 0;
EXPORT InValidMessage_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_long(SALT38.StrType s0) := s0;
EXPORT InValid_long(SALT38.StrType s) := 0;
EXPORT InValidMessage_long(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_code(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_code(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_land_use(SALT38.StrType s0) := s0;
EXPORT InValid_land_use(SALT38.StrType s) := 0;
EXPORT InValidMessage_land_use(UNSIGNED1 wh) := '';
 
EXPORT Make_recording_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_recording_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_assessed_value_year(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_assessed_value_year(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_assessed_value_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_sales_price(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sales_price(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_assessed_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_assessed_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_assessed_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_market_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_market_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_market_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_tax_assessment_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_tax_assessment_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_tax_assessment_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_price_index_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_price_index_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_price_index_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_hedonic_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_hedonic_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_hedonic_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_automated_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_automated_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_automated_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_confidence_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_confidence_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_confidence_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_comp1(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_comp1(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_comp1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_comp2(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_comp2(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_comp2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_comp3(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_comp3(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_comp3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_comp4(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_comp4(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_comp4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_comp5(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_comp5(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_comp5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_nearby1(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_nearby1(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_nearby1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_nearby2(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_nearby2(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_nearby2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_nearby3(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_nearby3(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_nearby3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_nearby4(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_nearby4(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_nearby4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_nearby5(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_nearby5(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_nearby5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_history_history_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_history_history_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_history_history_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_history_land_use(SALT38.StrType s0) := s0;
EXPORT InValid_history_land_use(SALT38.StrType s) := 0;
EXPORT InValidMessage_history_land_use(UNSIGNED1 wh) := '';
 
EXPORT Make_history_recording_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_history_recording_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_history_recording_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_history_assessed_value_year(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_assessed_value_year(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_assessed_value_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_sales_price(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_sales_price(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_sales_price(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_assessed_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_assessed_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_assessed_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_market_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_market_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_market_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_tax_assessment_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_tax_assessment_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_tax_assessment_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_price_index_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_price_index_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_price_index_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_hedonic_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_hedonic_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_hedonic_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_automated_valuation(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_automated_valuation(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_automated_valuation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_history_confidence_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_history_confidence_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_history_confidence_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_AVM;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_history_date;
    BOOLEAN Diff_ln_fares_id_ta;
    BOOLEAN Diff_ln_fares_id_pi;
    BOOLEAN Diff_unformatted_apn;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_lat;
    BOOLEAN Diff_long;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_fips_code;
    BOOLEAN Diff_land_use;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_assessed_value_year;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_assessed_total_value;
    BOOLEAN Diff_market_total_value;
    BOOLEAN Diff_tax_assessment_valuation;
    BOOLEAN Diff_price_index_valuation;
    BOOLEAN Diff_hedonic_valuation;
    BOOLEAN Diff_automated_valuation;
    BOOLEAN Diff_confidence_score;
    BOOLEAN Diff_comp1;
    BOOLEAN Diff_comp2;
    BOOLEAN Diff_comp3;
    BOOLEAN Diff_comp4;
    BOOLEAN Diff_comp5;
    BOOLEAN Diff_nearby1;
    BOOLEAN Diff_nearby2;
    BOOLEAN Diff_nearby3;
    BOOLEAN Diff_nearby4;
    BOOLEAN Diff_nearby5;
    BOOLEAN Diff_history_history_date;
    BOOLEAN Diff_history_land_use;
    BOOLEAN Diff_history_recording_date;
    BOOLEAN Diff_history_assessed_value_year;
    BOOLEAN Diff_history_sales_price;
    BOOLEAN Diff_history_assessed_total_value;
    BOOLEAN Diff_history_market_total_value;
    BOOLEAN Diff_history_tax_assessment_valuation;
    BOOLEAN Diff_history_price_index_valuation;
    BOOLEAN Diff_history_hedonic_valuation;
    BOOLEAN Diff_history_automated_valuation;
    BOOLEAN Diff_history_confidence_score;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_history_date := le.history_date <> ri.history_date;
    SELF.Diff_ln_fares_id_ta := le.ln_fares_id_ta <> ri.ln_fares_id_ta;
    SELF.Diff_ln_fares_id_pi := le.ln_fares_id_pi <> ri.ln_fares_id_pi;
    SELF.Diff_unformatted_apn := le.unformatted_apn <> ri.unformatted_apn;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_lat := le.lat <> ri.lat;
    SELF.Diff_long := le.long <> ri.long;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_fips_code := le.fips_code <> ri.fips_code;
    SELF.Diff_land_use := le.land_use <> ri.land_use;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_assessed_value_year := le.assessed_value_year <> ri.assessed_value_year;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_assessed_total_value := le.assessed_total_value <> ri.assessed_total_value;
    SELF.Diff_market_total_value := le.market_total_value <> ri.market_total_value;
    SELF.Diff_tax_assessment_valuation := le.tax_assessment_valuation <> ri.tax_assessment_valuation;
    SELF.Diff_price_index_valuation := le.price_index_valuation <> ri.price_index_valuation;
    SELF.Diff_hedonic_valuation := le.hedonic_valuation <> ri.hedonic_valuation;
    SELF.Diff_automated_valuation := le.automated_valuation <> ri.automated_valuation;
    SELF.Diff_confidence_score := le.confidence_score <> ri.confidence_score;
    SELF.Diff_comp1 := le.comp1 <> ri.comp1;
    SELF.Diff_comp2 := le.comp2 <> ri.comp2;
    SELF.Diff_comp3 := le.comp3 <> ri.comp3;
    SELF.Diff_comp4 := le.comp4 <> ri.comp4;
    SELF.Diff_comp5 := le.comp5 <> ri.comp5;
    SELF.Diff_nearby1 := le.nearby1 <> ri.nearby1;
    SELF.Diff_nearby2 := le.nearby2 <> ri.nearby2;
    SELF.Diff_nearby3 := le.nearby3 <> ri.nearby3;
    SELF.Diff_nearby4 := le.nearby4 <> ri.nearby4;
    SELF.Diff_nearby5 := le.nearby5 <> ri.nearby5;
    SELF.Diff_history_history_date := le.history_history_date <> ri.history_history_date;
    SELF.Diff_history_land_use := le.history_land_use <> ri.history_land_use;
    SELF.Diff_history_recording_date := le.history_recording_date <> ri.history_recording_date;
    SELF.Diff_history_assessed_value_year := le.history_assessed_value_year <> ri.history_assessed_value_year;
    SELF.Diff_history_sales_price := le.history_sales_price <> ri.history_sales_price;
    SELF.Diff_history_assessed_total_value := le.history_assessed_total_value <> ri.history_assessed_total_value;
    SELF.Diff_history_market_total_value := le.history_market_total_value <> ri.history_market_total_value;
    SELF.Diff_history_tax_assessment_valuation := le.history_tax_assessment_valuation <> ri.history_tax_assessment_valuation;
    SELF.Diff_history_price_index_valuation := le.history_price_index_valuation <> ri.history_price_index_valuation;
    SELF.Diff_history_hedonic_valuation := le.history_hedonic_valuation <> ri.history_hedonic_valuation;
    SELF.Diff_history_automated_valuation := le.history_automated_valuation <> ri.history_automated_valuation;
    SELF.Diff_history_confidence_score := le.history_confidence_score <> ri.history_confidence_score;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_history_date,1,0)+ IF( SELF.Diff_ln_fares_id_ta,1,0)+ IF( SELF.Diff_ln_fares_id_pi,1,0)+ IF( SELF.Diff_unformatted_apn,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_lat,1,0)+ IF( SELF.Diff_long,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_land_use,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_assessed_value_year,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_assessed_total_value,1,0)+ IF( SELF.Diff_market_total_value,1,0)+ IF( SELF.Diff_tax_assessment_valuation,1,0)+ IF( SELF.Diff_price_index_valuation,1,0)+ IF( SELF.Diff_hedonic_valuation,1,0)+ IF( SELF.Diff_automated_valuation,1,0)+ IF( SELF.Diff_confidence_score,1,0)+ IF( SELF.Diff_comp1,1,0)+ IF( SELF.Diff_comp2,1,0)+ IF( SELF.Diff_comp3,1,0)+ IF( SELF.Diff_comp4,1,0)+ IF( SELF.Diff_comp5,1,0)+ IF( SELF.Diff_nearby1,1,0)+ IF( SELF.Diff_nearby2,1,0)+ IF( SELF.Diff_nearby3,1,0)+ IF( SELF.Diff_nearby4,1,0)+ IF( SELF.Diff_nearby5,1,0)+ IF( SELF.Diff_history_history_date,1,0)+ IF( SELF.Diff_history_land_use,1,0)+ IF( SELF.Diff_history_recording_date,1,0)+ IF( SELF.Diff_history_assessed_value_year,1,0)+ IF( SELF.Diff_history_sales_price,1,0)+ IF( SELF.Diff_history_assessed_total_value,1,0)+ IF( SELF.Diff_history_market_total_value,1,0)+ IF( SELF.Diff_history_tax_assessment_valuation,1,0)+ IF( SELF.Diff_history_price_index_valuation,1,0)+ IF( SELF.Diff_history_hedonic_valuation,1,0)+ IF( SELF.Diff_history_automated_valuation,1,0)+ IF( SELF.Diff_history_confidence_score,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_history_date := COUNT(GROUP,%Closest%.Diff_history_date);
    Count_Diff_ln_fares_id_ta := COUNT(GROUP,%Closest%.Diff_ln_fares_id_ta);
    Count_Diff_ln_fares_id_pi := COUNT(GROUP,%Closest%.Diff_ln_fares_id_pi);
    Count_Diff_unformatted_apn := COUNT(GROUP,%Closest%.Diff_unformatted_apn);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_lat := COUNT(GROUP,%Closest%.Diff_lat);
    Count_Diff_long := COUNT(GROUP,%Closest%.Diff_long);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_fips_code := COUNT(GROUP,%Closest%.Diff_fips_code);
    Count_Diff_land_use := COUNT(GROUP,%Closest%.Diff_land_use);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_assessed_value_year := COUNT(GROUP,%Closest%.Diff_assessed_value_year);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_assessed_total_value := COUNT(GROUP,%Closest%.Diff_assessed_total_value);
    Count_Diff_market_total_value := COUNT(GROUP,%Closest%.Diff_market_total_value);
    Count_Diff_tax_assessment_valuation := COUNT(GROUP,%Closest%.Diff_tax_assessment_valuation);
    Count_Diff_price_index_valuation := COUNT(GROUP,%Closest%.Diff_price_index_valuation);
    Count_Diff_hedonic_valuation := COUNT(GROUP,%Closest%.Diff_hedonic_valuation);
    Count_Diff_automated_valuation := COUNT(GROUP,%Closest%.Diff_automated_valuation);
    Count_Diff_confidence_score := COUNT(GROUP,%Closest%.Diff_confidence_score);
    Count_Diff_comp1 := COUNT(GROUP,%Closest%.Diff_comp1);
    Count_Diff_comp2 := COUNT(GROUP,%Closest%.Diff_comp2);
    Count_Diff_comp3 := COUNT(GROUP,%Closest%.Diff_comp3);
    Count_Diff_comp4 := COUNT(GROUP,%Closest%.Diff_comp4);
    Count_Diff_comp5 := COUNT(GROUP,%Closest%.Diff_comp5);
    Count_Diff_nearby1 := COUNT(GROUP,%Closest%.Diff_nearby1);
    Count_Diff_nearby2 := COUNT(GROUP,%Closest%.Diff_nearby2);
    Count_Diff_nearby3 := COUNT(GROUP,%Closest%.Diff_nearby3);
    Count_Diff_nearby4 := COUNT(GROUP,%Closest%.Diff_nearby4);
    Count_Diff_nearby5 := COUNT(GROUP,%Closest%.Diff_nearby5);
    Count_Diff_history_history_date := COUNT(GROUP,%Closest%.Diff_history_history_date);
    Count_Diff_history_land_use := COUNT(GROUP,%Closest%.Diff_history_land_use);
    Count_Diff_history_recording_date := COUNT(GROUP,%Closest%.Diff_history_recording_date);
    Count_Diff_history_assessed_value_year := COUNT(GROUP,%Closest%.Diff_history_assessed_value_year);
    Count_Diff_history_sales_price := COUNT(GROUP,%Closest%.Diff_history_sales_price);
    Count_Diff_history_assessed_total_value := COUNT(GROUP,%Closest%.Diff_history_assessed_total_value);
    Count_Diff_history_market_total_value := COUNT(GROUP,%Closest%.Diff_history_market_total_value);
    Count_Diff_history_tax_assessment_valuation := COUNT(GROUP,%Closest%.Diff_history_tax_assessment_valuation);
    Count_Diff_history_price_index_valuation := COUNT(GROUP,%Closest%.Diff_history_price_index_valuation);
    Count_Diff_history_hedonic_valuation := COUNT(GROUP,%Closest%.Diff_history_hedonic_valuation);
    Count_Diff_history_automated_valuation := COUNT(GROUP,%Closest%.Diff_history_automated_valuation);
    Count_Diff_history_confidence_score := COUNT(GROUP,%Closest%.Diff_history_confidence_score);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
