IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 53;
  EXPORT NumRulesFromFieldType := 53;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 47;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Fedex)
    UNSIGNED1 file_date_Invalid;
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_initial_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 full_name_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 address_line1_Invalid;
    UNSIGNED1 address_line2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 append_prepaddr1_Invalid;
    UNSIGNED1 append_prepaddr2_Invalid;
    UNSIGNED1 append_rawaid_Invalid;
    UNSIGNED1 nametype_Invalid;
    UNSIGNED1 business_indicator_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip6_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Fedex)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Fedex)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'file_date:Invalid_Date:CUSTOM'
          ,'record_id:Invalid_ID:CUSTOM'
          ,'record_type:Invalid_Alpha:ALLOW'
          ,'first_name:Invalid_AlphaChar:ALLOW'
          ,'middle_initial:Invalid_Alpha:ALLOW'
          ,'last_name:Invalid_AlphaChar:ALLOW'
          ,'full_name:Invalid_AlphaChar:ALLOW'
          ,'company_name:Invalid_AlphaChar:ALLOW'
          ,'address_line1:Invalid_AlphaNumChar:ALLOW'
          ,'address_line2:Invalid_AlphaNumChar:ALLOW'
          ,'city:Invalid_AlphaChar:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'country:Invalid_State:ALLOW','country:Invalid_State:LENGTHS'
          ,'phone:Invalid_Phone:ALLOW','phone:Invalid_Phone:LENGTHS'
          ,'append_prepaddr1:Invalid_AlphaNumChar:ALLOW'
          ,'append_prepaddr2:Invalid_AlphaNumChar:ALLOW'
          ,'append_rawaid:Invalid_No:ALLOW'
          ,'nametype:Invalid_Alpha:ALLOW'
          ,'business_indicator:Invalid_Alpha:ALLOW'
          ,'prim_range:Invalid_No:ALLOW'
          ,'predir:Invalid_Dir:ALLOW'
          ,'prim_name:Invalid_AlphaNum:ALLOW'
          ,'addr_suffix:Invalid_Alpha:ALLOW'
          ,'postdir:Invalid_Dir:ALLOW'
          ,'unit_desig:Invalid_Alpha:ALLOW'
          ,'sec_range:Invalid_AlphaNum:ALLOW'
          ,'p_city_name:Invalid_Alpha:ALLOW'
          ,'v_city_name:Invalid_Alpha:ALLOW'
          ,'st:Invalid_State:ALLOW','st:Invalid_State:LENGTHS'
          ,'zip5:Invalid_Zip:ALLOW','zip5:Invalid_Zip:LENGTHS'
          ,'zip6:Invalid_No:ALLOW'
          ,'zip4:Invalid_No:ALLOW'
          ,'cart:Invalid_AlphaNum:ALLOW'
          ,'cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'lot:Invalid_No:ALLOW'
          ,'lot_order:Invalid_Alpha:ALLOW'
          ,'dbpc:Invalid_No:ALLOW'
          ,'chk_digit:Invalid_No:ALLOW'
          ,'rec_type:Invalid_Alpha:ALLOW'
          ,'county:Invalid_No:ALLOW'
          ,'geo_lat:Invalid_Float:ALLOW'
          ,'geo_long:Invalid_Float:ALLOW'
          ,'msa:Invalid_No:ALLOW'
          ,'geo_blk:Invalid_No:ALLOW'
          ,'geo_match:Invalid_No:ALLOW'
          ,'err_stat:Invalid_AlphaNum:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_file_date(1)
          ,Fields.InvalidMessage_record_id(1)
          ,Fields.InvalidMessage_record_type(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_middle_initial(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_full_name(1)
          ,Fields.InvalidMessage_company_name(1)
          ,Fields.InvalidMessage_address_line1(1)
          ,Fields.InvalidMessage_address_line2(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_country(1),Fields.InvalidMessage_country(2)
          ,Fields.InvalidMessage_phone(1),Fields.InvalidMessage_phone(2)
          ,Fields.InvalidMessage_append_prepaddr1(1)
          ,Fields.InvalidMessage_append_prepaddr2(1)
          ,Fields.InvalidMessage_append_rawaid(1)
          ,Fields.InvalidMessage_nametype(1)
          ,Fields.InvalidMessage_business_indicator(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2)
          ,Fields.InvalidMessage_zip6(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_cart(1)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1)
          ,Fields.InvalidMessage_lot_order(1)
          ,Fields.InvalidMessage_dbpc(1)
          ,Fields.InvalidMessage_chk_digit(1)
          ,Fields.InvalidMessage_rec_type(1)
          ,Fields.InvalidMessage_county(1)
          ,Fields.InvalidMessage_geo_lat(1)
          ,Fields.InvalidMessage_geo_long(1)
          ,Fields.InvalidMessage_msa(1)
          ,Fields.InvalidMessage_geo_blk(1)
          ,Fields.InvalidMessage_geo_match(1)
          ,Fields.InvalidMessage_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Fedex) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.file_date_Invalid := Fields.InValid_file_date((SALT311.StrType)le.file_date);
    SELF.record_id_Invalid := Fields.InValid_record_id((SALT311.StrType)le.record_id);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.middle_initial_Invalid := Fields.InValid_middle_initial((SALT311.StrType)le.middle_initial);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.full_name_Invalid := Fields.InValid_full_name((SALT311.StrType)le.full_name);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.address_line1_Invalid := Fields.InValid_address_line1((SALT311.StrType)le.address_line1);
    SELF.address_line2_Invalid := Fields.InValid_address_line2((SALT311.StrType)le.address_line2);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.country_Invalid := Fields.InValid_country((SALT311.StrType)le.country);
    SELF.phone_Invalid := Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.append_prepaddr1_Invalid := Fields.InValid_append_prepaddr1((SALT311.StrType)le.append_prepaddr1);
    SELF.append_prepaddr2_Invalid := Fields.InValid_append_prepaddr2((SALT311.StrType)le.append_prepaddr2);
    SELF.append_rawaid_Invalid := Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid);
    SELF.nametype_Invalid := Fields.InValid_nametype((SALT311.StrType)le.nametype);
    SELF.business_indicator_Invalid := Fields.InValid_business_indicator((SALT311.StrType)le.business_indicator);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT311.StrType)le.zip5);
    SELF.zip6_Invalid := Fields.InValid_zip6((SALT311.StrType)le.zip6);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.county_Invalid := Fields.InValid_county((SALT311.StrType)le.county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Fedex);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.file_date_Invalid << 0 ) + ( le.record_id_Invalid << 1 ) + ( le.record_type_Invalid << 2 ) + ( le.first_name_Invalid << 3 ) + ( le.middle_initial_Invalid << 4 ) + ( le.last_name_Invalid << 5 ) + ( le.full_name_Invalid << 6 ) + ( le.company_name_Invalid << 7 ) + ( le.address_line1_Invalid << 8 ) + ( le.address_line2_Invalid << 9 ) + ( le.city_Invalid << 10 ) + ( le.state_Invalid << 11 ) + ( le.zip_Invalid << 13 ) + ( le.country_Invalid << 15 ) + ( le.phone_Invalid << 17 ) + ( le.append_prepaddr1_Invalid << 19 ) + ( le.append_prepaddr2_Invalid << 20 ) + ( le.append_rawaid_Invalid << 21 ) + ( le.nametype_Invalid << 22 ) + ( le.business_indicator_Invalid << 23 ) + ( le.prim_range_Invalid << 24 ) + ( le.predir_Invalid << 25 ) + ( le.prim_name_Invalid << 26 ) + ( le.addr_suffix_Invalid << 27 ) + ( le.postdir_Invalid << 28 ) + ( le.unit_desig_Invalid << 29 ) + ( le.sec_range_Invalid << 30 ) + ( le.p_city_name_Invalid << 31 ) + ( le.v_city_name_Invalid << 32 ) + ( le.st_Invalid << 33 ) + ( le.zip5_Invalid << 35 ) + ( le.zip6_Invalid << 37 ) + ( le.zip4_Invalid << 38 ) + ( le.cart_Invalid << 39 ) + ( le.cr_sort_sz_Invalid << 40 ) + ( le.lot_Invalid << 41 ) + ( le.lot_order_Invalid << 42 ) + ( le.dbpc_Invalid << 43 ) + ( le.chk_digit_Invalid << 44 ) + ( le.rec_type_Invalid << 45 ) + ( le.county_Invalid << 46 ) + ( le.geo_lat_Invalid << 47 ) + ( le.geo_long_Invalid << 48 ) + ( le.msa_Invalid << 49 ) + ( le.geo_blk_Invalid << 50 ) + ( le.geo_match_Invalid << 51 ) + ( le.err_stat_Invalid << 52 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Fedex);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.file_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.middle_initial_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.address_line1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.address_line2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.country_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.append_prepaddr1_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.append_prepaddr2_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.append_rawaid_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.nametype_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.business_indicator_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.zip6_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    file_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_date_Invalid=1);
    record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    full_name_ALLOW_ErrorCount := COUNT(GROUP,h.full_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    address_line1_ALLOW_ErrorCount := COUNT(GROUP,h.address_line1_Invalid=1);
    address_line2_ALLOW_ErrorCount := COUNT(GROUP,h.address_line2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    country_LENGTHS_ErrorCount := COUNT(GROUP,h.country_Invalid=2);
    country_Total_ErrorCount := COUNT(GROUP,h.country_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    append_prepaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.append_prepaddr1_Invalid=1);
    append_prepaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.append_prepaddr2_Invalid=1);
    append_rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.append_rawaid_Invalid=1);
    nametype_ALLOW_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    business_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.business_indicator_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTHS_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    zip6_ALLOW_ErrorCount := COUNT(GROUP,h.zip6_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.file_date_Invalid > 0 OR h.record_id_Invalid > 0 OR h.record_type_Invalid > 0 OR h.first_name_Invalid > 0 OR h.middle_initial_Invalid > 0 OR h.last_name_Invalid > 0 OR h.full_name_Invalid > 0 OR h.company_name_Invalid > 0 OR h.address_line1_Invalid > 0 OR h.address_line2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.country_Invalid > 0 OR h.phone_Invalid > 0 OR h.append_prepaddr1_Invalid > 0 OR h.append_prepaddr2_Invalid > 0 OR h.append_rawaid_Invalid > 0 OR h.nametype_Invalid > 0 OR h.business_indicator_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip6_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.file_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_initial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_line1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_line2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.country_Total_ErrorCount > 0, 1, 0) + IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nametype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip5_Total_ErrorCount > 0, 1, 0) + IF(le.zip6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.file_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_initial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_line1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_line2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nametype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.file_date_Invalid,le.record_id_Invalid,le.record_type_Invalid,le.first_name_Invalid,le.middle_initial_Invalid,le.last_name_Invalid,le.full_name_Invalid,le.company_name_Invalid,le.address_line1_Invalid,le.address_line2_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.country_Invalid,le.phone_Invalid,le.append_prepaddr1_Invalid,le.append_prepaddr2_Invalid,le.append_rawaid_Invalid,le.nametype_Invalid,le.business_indicator_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip5_Invalid,le.zip6_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_file_date(le.file_date_Invalid),Fields.InvalidMessage_record_id(le.record_id_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_initial(le.middle_initial_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_full_name(le.full_name_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_address_line1(le.address_line1_Invalid),Fields.InvalidMessage_address_line2(le.address_line2_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_country(le.country_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_append_prepaddr1(le.append_prepaddr1_Invalid),Fields.InvalidMessage_append_prepaddr2(le.append_prepaddr2_Invalid),Fields.InvalidMessage_append_rawaid(le.append_rawaid_Invalid),Fields.InvalidMessage_nametype(le.nametype_Invalid),Fields.InvalidMessage_business_indicator(le.business_indicator_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip6(le.zip6_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.file_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_initial_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.full_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_line1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_line2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.append_prepaddr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prepaddr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_rawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'file_date','record_id','record_type','first_name','middle_initial','last_name','full_name','company_name','address_line1','address_line2','city','state','zip','country','phone','append_prepaddr1','append_prepaddr2','append_rawaid','nametype','business_indicator','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip6','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_ID','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_State','Invalid_Phone','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Dir','Invalid_AlphaNum','Invalid_Alpha','Invalid_Dir','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.file_date,(SALT311.StrType)le.record_id,(SALT311.StrType)le.record_type,(SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_initial,(SALT311.StrType)le.last_name,(SALT311.StrType)le.full_name,(SALT311.StrType)le.company_name,(SALT311.StrType)le.address_line1,(SALT311.StrType)le.address_line2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.country,(SALT311.StrType)le.phone,(SALT311.StrType)le.append_prepaddr1,(SALT311.StrType)le.append_prepaddr2,(SALT311.StrType)le.append_rawaid,(SALT311.StrType)le.nametype,(SALT311.StrType)le.business_indicator,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip5,(SALT311.StrType)le.zip6,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,47,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Fedex) prevDS = DATASET([], Layout_Fedex), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.file_date_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.company_name_ALLOW_ErrorCount
          ,le.address_line1_ALLOW_ErrorCount
          ,le.address_line2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.country_ALLOW_ErrorCount,le.country_LENGTHS_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.append_prepaddr1_ALLOW_ErrorCount
          ,le.append_prepaddr2_ALLOW_ErrorCount
          ,le.append_rawaid_ALLOW_ErrorCount
          ,le.nametype_ALLOW_ErrorCount
          ,le.business_indicator_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip6_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.file_date_CUSTOM_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.company_name_ALLOW_ErrorCount
          ,le.address_line1_ALLOW_ErrorCount
          ,le.address_line2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.country_ALLOW_ErrorCount,le.country_LENGTHS_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.append_prepaddr1_ALLOW_ErrorCount
          ,le.append_prepaddr2_ALLOW_ErrorCount
          ,le.append_rawaid_ALLOW_ErrorCount
          ,le.nametype_ALLOW_ErrorCount
          ,le.business_indicator_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip6_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Fedex));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'file_date:' + getFieldTypeText(h.file_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_initial:' + getFieldTypeText(h.middle_initial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_line1:' + getFieldTypeText(h.address_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_line2:' + getFieldTypeText(h.address_line2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prepaddr1:' + getFieldTypeText(h.append_prepaddr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prepaddr2:' + getFieldTypeText(h.append_prepaddr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_rawaid:' + getFieldTypeText(h.append_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nametype:' + getFieldTypeText(h.nametype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_indicator:' + getFieldTypeText(h.business_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip6:' + getFieldTypeText(h.zip6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_file_date_cnt
          ,le.populated_record_id_cnt
          ,le.populated_record_type_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_initial_cnt
          ,le.populated_last_name_cnt
          ,le.populated_full_name_cnt
          ,le.populated_company_name_cnt
          ,le.populated_address_line1_cnt
          ,le.populated_address_line2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_country_cnt
          ,le.populated_phone_cnt
          ,le.populated_append_prepaddr1_cnt
          ,le.populated_append_prepaddr2_cnt
          ,le.populated_append_rawaid_cnt
          ,le.populated_nametype_cnt
          ,le.populated_business_indicator_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip6_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_file_date_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_initial_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_address_line1_pcnt
          ,le.populated_address_line2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_country_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_append_prepaddr1_pcnt
          ,le.populated_append_prepaddr2_pcnt
          ,le.populated_append_rawaid_pcnt
          ,le.populated_nametype_pcnt
          ,le.populated_business_indicator_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip6_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,47,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Fedex));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),47,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Fedex) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Fedex, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
