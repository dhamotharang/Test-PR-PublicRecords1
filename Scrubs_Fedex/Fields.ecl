IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 47;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_ID','Invalid_Dir','Invalid_Date','Invalid_Phone','Invalid_Zip','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaChar' => 4,'Invalid_AlphaNum' => 5,'Invalid_AlphaNumChar' => 6,'Invalid_ID' => 7,'Invalid_Dir' => 8,'Invalid_Date' => 9,'Invalid_Phone' => 10,'Invalid_Zip' => 11,'Invalid_State' => 12,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-.:'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-.:'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#\''))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:#\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ID(SALT311.StrType s) := WHICH(~fn_valid_id(s)>0);
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('fn_valid_id'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Dir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'NSEW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Dir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'NSEW'))));
EXPORT InValidMessageFT_Invalid_Dir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('NSEW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,10,11'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'file_date','record_id','record_type','first_name','middle_initial','last_name','full_name','company_name','address_line1','address_line2','city','state','zip','country','phone','append_prepaddr1','append_prepaddr2','append_rawaid','nametype','business_indicator','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip6','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'file_date','record_id','record_type','first_name','middle_initial','last_name','full_name','company_name','address_line1','address_line2','city','state','zip','country','phone','append_prepaddr1','append_prepaddr2','append_rawaid','nametype','business_indicator','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip6','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'file_date' => 0,'record_id' => 1,'record_type' => 2,'first_name' => 3,'middle_initial' => 4,'last_name' => 5,'full_name' => 6,'company_name' => 7,'address_line1' => 8,'address_line2' => 9,'city' => 10,'state' => 11,'zip' => 12,'country' => 13,'phone' => 14,'append_prepaddr1' => 15,'append_prepaddr2' => 16,'append_rawaid' => 17,'nametype' => 18,'business_indicator' => 19,'prim_range' => 20,'predir' => 21,'prim_name' => 22,'addr_suffix' => 23,'postdir' => 24,'unit_desig' => 25,'sec_range' => 26,'p_city_name' => 27,'v_city_name' => 28,'st' => 29,'zip5' => 30,'zip6' => 31,'zip4' => 32,'cart' => 33,'cr_sort_sz' => 34,'lot' => 35,'lot_order' => 36,'dbpc' => 37,'chk_digit' => 38,'rec_type' => 39,'county' => 40,'geo_lat' => 41,'geo_long' => 42,'msa' => 43,'geo_blk' => 44,'geo_match' => 45,'err_stat' => 46,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_file_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_file_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_file_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_record_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_record_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_middle_initial(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_middle_initial(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_middle_initial(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_full_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_full_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_address_line1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_address_line1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_address_line1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_address_line2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_address_line2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_address_line2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_append_prepaddr1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_append_prepaddr1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_append_prepaddr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_append_prepaddr2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_append_prepaddr2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_append_prepaddr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_append_rawaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_nametype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_nametype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_business_indicator(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_business_indicator(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_business_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_zip6(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip6(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip6(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Fedex;
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
    BOOLEAN Diff_file_date;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_initial;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_address_line1;
    BOOLEAN Diff_address_line2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_country;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_append_prepaddr1;
    BOOLEAN Diff_append_prepaddr2;
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_business_indicator;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip6;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_file_date := le.file_date <> ri.file_date;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_initial := le.middle_initial <> ri.middle_initial;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_address_line1 := le.address_line1 <> ri.address_line1;
    SELF.Diff_address_line2 := le.address_line2 <> ri.address_line2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_append_prepaddr1 := le.append_prepaddr1 <> ri.append_prepaddr1;
    SELF.Diff_append_prepaddr2 := le.append_prepaddr2 <> ri.append_prepaddr2;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_business_indicator := le.business_indicator <> ri.business_indicator;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip6 := le.zip6 <> ri.zip6;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_file_date,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_initial,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_address_line1,1,0)+ IF( SELF.Diff_address_line2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_append_prepaddr1,1,0)+ IF( SELF.Diff_append_prepaddr2,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_business_indicator,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip6,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_file_date := COUNT(GROUP,%Closest%.Diff_file_date);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_initial := COUNT(GROUP,%Closest%.Diff_middle_initial);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_address_line1 := COUNT(GROUP,%Closest%.Diff_address_line1);
    Count_Diff_address_line2 := COUNT(GROUP,%Closest%.Diff_address_line2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_append_prepaddr1 := COUNT(GROUP,%Closest%.Diff_append_prepaddr1);
    Count_Diff_append_prepaddr2 := COUNT(GROUP,%Closest%.Diff_append_prepaddr2);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_business_indicator := COUNT(GROUP,%Closest%.Diff_business_indicator);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip6 := COUNT(GROUP,%Closest%.Diff_zip6);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
