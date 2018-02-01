IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 32;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_AlphaNum','Invalid_Chars','Invalid_Alpha','Invalid_Num','Invalid_Comps','Invalid_SalesPriceCode','Invalid_LandUseCode');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_AlphaNum' => 2,'Invalid_Chars' => 3,'Invalid_Alpha' => 4,'Invalid_Num' => 5,'Invalid_Comps' => 6,'Invalid_SalesPriceCode' => 7,'Invalid_LandUseCode' => 8,0);
 
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
 
EXPORT MakeFT_Invalid_Chars(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Chars(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'))));
EXPORT InValidMessageFT_Invalid_Chars(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+'),SALT38.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_Invalid_SalesPriceCode(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_SalesPriceCode(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','Q','U','F','Z','D','C','P','X','']);
EXPORT InValidMessageFT_Invalid_SalesPriceCode(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|Q|U|F|Z|D|C|P|X|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LandUseCode(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LandUseCode(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2','']);
EXPORT InValidMessageFT_Invalid_LandUseCode(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2|'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'seq','ln_fares_id','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use_code','sales_price','sales_price_code','recording_date','assessed_value_year','assessed_total_value','market_total_value','lot_size','building_area','year_built','no_of_stories','no_of_rooms','no_of_bedrooms','no_of_baths');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'seq','ln_fares_id','unformatted_apn','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','st','zip','zip4','lat','long','geo_blk','fips_code','land_use_code','sales_price','sales_price_code','recording_date','assessed_value_year','assessed_total_value','market_total_value','lot_size','building_area','year_built','no_of_stories','no_of_rooms','no_of_bedrooms','no_of_baths');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'seq' => 0,'ln_fares_id' => 1,'unformatted_apn' => 2,'prim_range' => 3,'predir' => 4,'prim_name' => 5,'suffix' => 6,'postdir' => 7,'unit_desig' => 8,'sec_range' => 9,'p_city_name' => 10,'st' => 11,'zip' => 12,'zip4' => 13,'lat' => 14,'long' => 15,'geo_blk' => 16,'fips_code' => 17,'land_use_code' => 18,'sales_price' => 19,'sales_price_code' => 20,'recording_date' => 21,'assessed_value_year' => 22,'assessed_total_value' => 23,'market_total_value' => 24,'lot_size' => 25,'building_area' => 26,'year_built' => 27,'no_of_stories' => 28,'no_of_rooms' => 29,'no_of_bedrooms' => 30,'no_of_baths' => 31,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_seq(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_seq(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_seq(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ln_fares_id(SALT38.StrType s0) := MakeFT_Invalid_Comps(s0);
EXPORT InValid_ln_fares_id(SALT38.StrType s) := InValidFT_Invalid_Comps(s);
EXPORT InValidMessage_ln_fares_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Comps(wh);
 
EXPORT Make_unformatted_apn(SALT38.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_unformatted_apn(SALT38.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_unformatted_apn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_land_use_code(SALT38.StrType s0) := MakeFT_Invalid_LandUseCode(s0);
EXPORT InValid_land_use_code(SALT38.StrType s) := InValidFT_Invalid_LandUseCode(s);
EXPORT InValidMessage_land_use_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_LandUseCode(wh);
 
EXPORT Make_sales_price(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sales_price(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_sales_price_code(SALT38.StrType s0) := MakeFT_Invalid_SalesPriceCode(s0);
EXPORT InValid_sales_price_code(SALT38.StrType s) := InValidFT_Invalid_SalesPriceCode(s);
EXPORT InValidMessage_sales_price_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_SalesPriceCode(wh);
 
EXPORT Make_recording_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_recording_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_assessed_value_year(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_assessed_value_year(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_assessed_value_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_assessed_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_assessed_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_assessed_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_market_total_value(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_market_total_value(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_market_total_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lot_size(SALT38.StrType s0) := MakeFT_Invalid_Chars(s0);
EXPORT InValid_lot_size(SALT38.StrType s) := InValidFT_Invalid_Chars(s);
EXPORT InValidMessage_lot_size(UNSIGNED1 wh) := InValidMessageFT_Invalid_Chars(wh);
 
EXPORT Make_building_area(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_building_area(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_building_area(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_year_built(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_year_built(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_year_built(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_no_of_stories(SALT38.StrType s0) := MakeFT_Invalid_Chars(s0);
EXPORT InValid_no_of_stories(SALT38.StrType s) := InValidFT_Invalid_Chars(s);
EXPORT InValidMessage_no_of_stories(UNSIGNED1 wh) := InValidMessageFT_Invalid_Chars(wh);
 
EXPORT Make_no_of_rooms(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_no_of_rooms(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_no_of_rooms(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_no_of_bedrooms(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_no_of_bedrooms(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_no_of_bedrooms(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_no_of_baths(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_no_of_baths(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_no_of_baths(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
    BOOLEAN Diff_seq;
    BOOLEAN Diff_ln_fares_id;
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
    BOOLEAN Diff_land_use_code;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_sales_price_code;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_assessed_value_year;
    BOOLEAN Diff_assessed_total_value;
    BOOLEAN Diff_market_total_value;
    BOOLEAN Diff_lot_size;
    BOOLEAN Diff_building_area;
    BOOLEAN Diff_year_built;
    BOOLEAN Diff_no_of_stories;
    BOOLEAN Diff_no_of_rooms;
    BOOLEAN Diff_no_of_bedrooms;
    BOOLEAN Diff_no_of_baths;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_seq := le.seq <> ri.seq;
    SELF.Diff_ln_fares_id := le.ln_fares_id <> ri.ln_fares_id;
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
    SELF.Diff_land_use_code := le.land_use_code <> ri.land_use_code;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_sales_price_code := le.sales_price_code <> ri.sales_price_code;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_assessed_value_year := le.assessed_value_year <> ri.assessed_value_year;
    SELF.Diff_assessed_total_value := le.assessed_total_value <> ri.assessed_total_value;
    SELF.Diff_market_total_value := le.market_total_value <> ri.market_total_value;
    SELF.Diff_lot_size := le.lot_size <> ri.lot_size;
    SELF.Diff_building_area := le.building_area <> ri.building_area;
    SELF.Diff_year_built := le.year_built <> ri.year_built;
    SELF.Diff_no_of_stories := le.no_of_stories <> ri.no_of_stories;
    SELF.Diff_no_of_rooms := le.no_of_rooms <> ri.no_of_rooms;
    SELF.Diff_no_of_bedrooms := le.no_of_bedrooms <> ri.no_of_bedrooms;
    SELF.Diff_no_of_baths := le.no_of_baths <> ri.no_of_baths;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_seq,1,0)+ IF( SELF.Diff_ln_fares_id,1,0)+ IF( SELF.Diff_unformatted_apn,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_lat,1,0)+ IF( SELF.Diff_long,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_land_use_code,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_sales_price_code,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_assessed_value_year,1,0)+ IF( SELF.Diff_assessed_total_value,1,0)+ IF( SELF.Diff_market_total_value,1,0)+ IF( SELF.Diff_lot_size,1,0)+ IF( SELF.Diff_building_area,1,0)+ IF( SELF.Diff_year_built,1,0)+ IF( SELF.Diff_no_of_stories,1,0)+ IF( SELF.Diff_no_of_rooms,1,0)+ IF( SELF.Diff_no_of_bedrooms,1,0)+ IF( SELF.Diff_no_of_baths,1,0);
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
    Count_Diff_seq := COUNT(GROUP,%Closest%.Diff_seq);
    Count_Diff_ln_fares_id := COUNT(GROUP,%Closest%.Diff_ln_fares_id);
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
    Count_Diff_land_use_code := COUNT(GROUP,%Closest%.Diff_land_use_code);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_sales_price_code := COUNT(GROUP,%Closest%.Diff_sales_price_code);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_assessed_value_year := COUNT(GROUP,%Closest%.Diff_assessed_value_year);
    Count_Diff_assessed_total_value := COUNT(GROUP,%Closest%.Diff_assessed_total_value);
    Count_Diff_market_total_value := COUNT(GROUP,%Closest%.Diff_market_total_value);
    Count_Diff_lot_size := COUNT(GROUP,%Closest%.Diff_lot_size);
    Count_Diff_building_area := COUNT(GROUP,%Closest%.Diff_building_area);
    Count_Diff_year_built := COUNT(GROUP,%Closest%.Diff_year_built);
    Count_Diff_no_of_stories := COUNT(GROUP,%Closest%.Diff_no_of_stories);
    Count_Diff_no_of_rooms := COUNT(GROUP,%Closest%.Diff_no_of_rooms);
    Count_Diff_no_of_bedrooms := COUNT(GROUP,%Closest%.Diff_no_of_bedrooms);
    Count_Diff_no_of_baths := COUNT(GROUP,%Closest%.Diff_no_of_baths);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
