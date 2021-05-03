IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Companies_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 59;
  EXPORT NumRulesFromFieldType := 59;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 58;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Companies_Layout_Sheila_Greco)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 rawfields_maincompanyid_Invalid;
    UNSIGNED1 rawfields_companyname_Invalid;
    UNSIGNED1 rawfields_ticker_Invalid;
    UNSIGNED1 rawfields_fortunerank_Invalid;
    UNSIGNED1 rawfields_primaryindustry_Invalid;
    UNSIGNED1 rawfields_address1_Invalid;
    UNSIGNED1 rawfields_address2_Invalid;
    UNSIGNED1 rawfields_city_Invalid;
    UNSIGNED1 rawfields_state_Invalid;
    UNSIGNED1 rawfields_zip_Invalid;
    UNSIGNED1 rawfields_country_Invalid;
    UNSIGNED1 rawfields_region_Invalid;
    UNSIGNED1 rawfields_phone_Invalid;
    UNSIGNED1 rawfields_extension_Invalid;
    UNSIGNED1 rawfields_weburl_Invalid;
    UNSIGNED1 rawfields_sales_Invalid;
    UNSIGNED1 rawfields_employees_Invalid;
    UNSIGNED1 rawfields_competitors_Invalid;
    UNSIGNED1 rawfields_divisionname_Invalid;
    UNSIGNED1 rawfields_siccode_Invalid;
    UNSIGNED1 rawfields_auditor_Invalid;
    UNSIGNED1 rawfields_entrydate_Invalid;
    UNSIGNED1 rawfields_lastupdate_Invalid;
    UNSIGNED1 rawfields_entrystaffid_Invalid;
    UNSIGNED1 clean_address_prim_range_Invalid;
    UNSIGNED1 clean_address_predir_Invalid;
    UNSIGNED1 clean_address_prim_name_Invalid;
    UNSIGNED1 clean_address_addr_suffix_Invalid;
    UNSIGNED1 clean_address_postdir_Invalid;
    UNSIGNED1 clean_address_unit_desig_Invalid;
    UNSIGNED1 clean_address_sec_range_Invalid;
    UNSIGNED1 clean_address_p_city_name_Invalid;
    UNSIGNED1 clean_address_v_city_name_Invalid;
    UNSIGNED1 clean_address_st_Invalid;
    UNSIGNED1 clean_address_zip_Invalid;
    UNSIGNED1 clean_address_zip4_Invalid;
    UNSIGNED1 clean_address_cart_Invalid;
    UNSIGNED1 clean_address_cr_sort_sz_Invalid;
    UNSIGNED1 clean_address_lot_Invalid;
    UNSIGNED1 clean_address_lot_order_Invalid;
    UNSIGNED1 clean_address_dbpc_Invalid;
    UNSIGNED1 clean_address_chk_digit_Invalid;
    UNSIGNED1 clean_address_rec_type_Invalid;
    UNSIGNED1 clean_address_fips_state_Invalid;
    UNSIGNED1 clean_address_fips_county_Invalid;
    UNSIGNED1 clean_address_geo_lat_Invalid;
    UNSIGNED1 clean_address_geo_long_Invalid;
    UNSIGNED1 clean_address_msa_Invalid;
    UNSIGNED1 clean_address_geo_blk_Invalid;
    UNSIGNED1 clean_address_geo_match_Invalid;
    UNSIGNED1 clean_address_err_stat_Invalid;
    UNSIGNED1 clean_dates_entrydate_Invalid;
    UNSIGNED1 clean_dates_lastupdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Companies_Layout_Sheila_Greco)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Companies_Layout_Sheila_Greco)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'record_type:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_maincompanyid:Invalid_No:ALLOW'
          ,'rawfields_companyname:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_ticker:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_fortunerank:Invalid_No:ALLOW'
          ,'rawfields_primaryindustry:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_address1:Invalid_AlphaNumChar:CUSTOM'
          ,'rawfields_address2:Invalid_AlphaNumChar:CUSTOM'
          ,'rawfields_city:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_state:Invalid_State:ALLOW','rawfields_state:Invalid_State:LENGTHS'
          ,'rawfields_zip:Invalid_Zip:LENGTHS'
          ,'rawfields_country:Invalid_Alpha:ALLOW'
          ,'rawfields_region:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_phone:Invalid_Float:CUSTOM'
          ,'rawfields_extension:Invalid_Float:CUSTOM'
          ,'rawfields_weburl:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_sales:Invalid_Float:CUSTOM'
          ,'rawfields_employees:Invalid_No:ALLOW'
          ,'rawfields_competitors:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_divisionname:Invalid_Alpha:ALLOW'
          ,'rawfields_siccode:Invalid_Float:CUSTOM'
          ,'rawfields_auditor:Invalid_AlphaChar:CUSTOM'
          ,'rawfields_entrydate:Invalid_Date:CUSTOM'
          ,'rawfields_lastupdate:Invalid_Date:CUSTOM'
          ,'rawfields_entrystaffid:Invalid_No:ALLOW'
          ,'clean_address_prim_range:Invalid_No:ALLOW'
          ,'clean_address_predir:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_prim_name:Invalid_AlphaNumChar:CUSTOM'
          ,'clean_address_addr_suffix:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_postdir:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_unit_desig:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_sec_range:Invalid_No:ALLOW'
          ,'clean_address_p_city_name:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_v_city_name:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_st:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_zip:Invalid_Zip:LENGTHS'
          ,'clean_address_zip4:Invalid_No:ALLOW'
          ,'clean_address_cart:Invalid_AlphaNum:ALLOW'
          ,'clean_address_cr_sort_sz:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_lot:Invalid_No:ALLOW'
          ,'clean_address_lot_order:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_dbpc:Invalid_No:ALLOW'
          ,'clean_address_chk_digit:Invalid_No:ALLOW'
          ,'clean_address_rec_type:Invalid_AlphaCaps:ALLOW'
          ,'clean_address_fips_state:Invalid_No:ALLOW'
          ,'clean_address_fips_county:Invalid_No:ALLOW'
          ,'clean_address_geo_lat:Invalid_Float:CUSTOM'
          ,'clean_address_geo_long:Invalid_Float:CUSTOM'
          ,'clean_address_msa:Invalid_No:ALLOW'
          ,'clean_address_geo_blk:Invalid_No:ALLOW'
          ,'clean_address_geo_match:Invalid_No:ALLOW'
          ,'clean_address_err_stat:Invalid_AlphaNum:ALLOW'
          ,'clean_dates_entrydate:Invalid_Date:CUSTOM'
          ,'clean_dates_lastupdate:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Companies_Fields.InvalidMessage_dt_first_seen(1)
          ,Companies_Fields.InvalidMessage_dt_last_seen(1)
          ,Companies_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Companies_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Companies_Fields.InvalidMessage_record_type(1)
          ,Companies_Fields.InvalidMessage_rawfields_maincompanyid(1)
          ,Companies_Fields.InvalidMessage_rawfields_companyname(1)
          ,Companies_Fields.InvalidMessage_rawfields_ticker(1)
          ,Companies_Fields.InvalidMessage_rawfields_fortunerank(1)
          ,Companies_Fields.InvalidMessage_rawfields_primaryindustry(1)
          ,Companies_Fields.InvalidMessage_rawfields_address1(1)
          ,Companies_Fields.InvalidMessage_rawfields_address2(1)
          ,Companies_Fields.InvalidMessage_rawfields_city(1)
          ,Companies_Fields.InvalidMessage_rawfields_state(1),Companies_Fields.InvalidMessage_rawfields_state(2)
          ,Companies_Fields.InvalidMessage_rawfields_zip(1)
          ,Companies_Fields.InvalidMessage_rawfields_country(1)
          ,Companies_Fields.InvalidMessage_rawfields_region(1)
          ,Companies_Fields.InvalidMessage_rawfields_phone(1)
          ,Companies_Fields.InvalidMessage_rawfields_extension(1)
          ,Companies_Fields.InvalidMessage_rawfields_weburl(1)
          ,Companies_Fields.InvalidMessage_rawfields_sales(1)
          ,Companies_Fields.InvalidMessage_rawfields_employees(1)
          ,Companies_Fields.InvalidMessage_rawfields_competitors(1)
          ,Companies_Fields.InvalidMessage_rawfields_divisionname(1)
          ,Companies_Fields.InvalidMessage_rawfields_siccode(1)
          ,Companies_Fields.InvalidMessage_rawfields_auditor(1)
          ,Companies_Fields.InvalidMessage_rawfields_entrydate(1)
          ,Companies_Fields.InvalidMessage_rawfields_lastupdate(1)
          ,Companies_Fields.InvalidMessage_rawfields_entrystaffid(1)
          ,Companies_Fields.InvalidMessage_clean_address_prim_range(1)
          ,Companies_Fields.InvalidMessage_clean_address_predir(1)
          ,Companies_Fields.InvalidMessage_clean_address_prim_name(1)
          ,Companies_Fields.InvalidMessage_clean_address_addr_suffix(1)
          ,Companies_Fields.InvalidMessage_clean_address_postdir(1)
          ,Companies_Fields.InvalidMessage_clean_address_unit_desig(1)
          ,Companies_Fields.InvalidMessage_clean_address_sec_range(1)
          ,Companies_Fields.InvalidMessage_clean_address_p_city_name(1)
          ,Companies_Fields.InvalidMessage_clean_address_v_city_name(1)
          ,Companies_Fields.InvalidMessage_clean_address_st(1)
          ,Companies_Fields.InvalidMessage_clean_address_zip(1)
          ,Companies_Fields.InvalidMessage_clean_address_zip4(1)
          ,Companies_Fields.InvalidMessage_clean_address_cart(1)
          ,Companies_Fields.InvalidMessage_clean_address_cr_sort_sz(1)
          ,Companies_Fields.InvalidMessage_clean_address_lot(1)
          ,Companies_Fields.InvalidMessage_clean_address_lot_order(1)
          ,Companies_Fields.InvalidMessage_clean_address_dbpc(1)
          ,Companies_Fields.InvalidMessage_clean_address_chk_digit(1)
          ,Companies_Fields.InvalidMessage_clean_address_rec_type(1)
          ,Companies_Fields.InvalidMessage_clean_address_fips_state(1)
          ,Companies_Fields.InvalidMessage_clean_address_fips_county(1)
          ,Companies_Fields.InvalidMessage_clean_address_geo_lat(1)
          ,Companies_Fields.InvalidMessage_clean_address_geo_long(1)
          ,Companies_Fields.InvalidMessage_clean_address_msa(1)
          ,Companies_Fields.InvalidMessage_clean_address_geo_blk(1)
          ,Companies_Fields.InvalidMessage_clean_address_geo_match(1)
          ,Companies_Fields.InvalidMessage_clean_address_err_stat(1)
          ,Companies_Fields.InvalidMessage_clean_dates_entrydate(1)
          ,Companies_Fields.InvalidMessage_clean_dates_lastupdate(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Companies_Layout_Sheila_Greco) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Companies_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Companies_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Companies_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Companies_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Companies_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.rawfields_maincompanyid_Invalid := Companies_Fields.InValid_rawfields_maincompanyid((SALT311.StrType)le.rawfields_maincompanyid);
    SELF.rawfields_companyname_Invalid := Companies_Fields.InValid_rawfields_companyname((SALT311.StrType)le.rawfields_companyname);
    SELF.rawfields_ticker_Invalid := Companies_Fields.InValid_rawfields_ticker((SALT311.StrType)le.rawfields_ticker);
    SELF.rawfields_fortunerank_Invalid := Companies_Fields.InValid_rawfields_fortunerank((SALT311.StrType)le.rawfields_fortunerank);
    SELF.rawfields_primaryindustry_Invalid := Companies_Fields.InValid_rawfields_primaryindustry((SALT311.StrType)le.rawfields_primaryindustry);
    SELF.rawfields_address1_Invalid := Companies_Fields.InValid_rawfields_address1((SALT311.StrType)le.rawfields_address1);
    SELF.rawfields_address2_Invalid := Companies_Fields.InValid_rawfields_address2((SALT311.StrType)le.rawfields_address2);
    SELF.rawfields_city_Invalid := Companies_Fields.InValid_rawfields_city((SALT311.StrType)le.rawfields_city);
    SELF.rawfields_state_Invalid := Companies_Fields.InValid_rawfields_state((SALT311.StrType)le.rawfields_state);
    SELF.rawfields_zip_Invalid := Companies_Fields.InValid_rawfields_zip((SALT311.StrType)le.rawfields_zip);
    SELF.rawfields_country_Invalid := Companies_Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country);
    SELF.rawfields_region_Invalid := Companies_Fields.InValid_rawfields_region((SALT311.StrType)le.rawfields_region);
    SELF.rawfields_phone_Invalid := Companies_Fields.InValid_rawfields_phone((SALT311.StrType)le.rawfields_phone);
    SELF.rawfields_extension_Invalid := Companies_Fields.InValid_rawfields_extension((SALT311.StrType)le.rawfields_extension);
    SELF.rawfields_weburl_Invalid := Companies_Fields.InValid_rawfields_weburl((SALT311.StrType)le.rawfields_weburl);
    SELF.rawfields_sales_Invalid := Companies_Fields.InValid_rawfields_sales((SALT311.StrType)le.rawfields_sales);
    SELF.rawfields_employees_Invalid := Companies_Fields.InValid_rawfields_employees((SALT311.StrType)le.rawfields_employees);
    SELF.rawfields_competitors_Invalid := Companies_Fields.InValid_rawfields_competitors((SALT311.StrType)le.rawfields_competitors);
    SELF.rawfields_divisionname_Invalid := Companies_Fields.InValid_rawfields_divisionname((SALT311.StrType)le.rawfields_divisionname);
    SELF.rawfields_siccode_Invalid := Companies_Fields.InValid_rawfields_siccode((SALT311.StrType)le.rawfields_siccode);
    SELF.rawfields_auditor_Invalid := Companies_Fields.InValid_rawfields_auditor((SALT311.StrType)le.rawfields_auditor);
    SELF.rawfields_entrydate_Invalid := Companies_Fields.InValid_rawfields_entrydate((SALT311.StrType)le.rawfields_entrydate);
    SELF.rawfields_lastupdate_Invalid := Companies_Fields.InValid_rawfields_lastupdate((SALT311.StrType)le.rawfields_lastupdate);
    SELF.rawfields_entrystaffid_Invalid := Companies_Fields.InValid_rawfields_entrystaffid((SALT311.StrType)le.rawfields_entrystaffid);
    SELF.clean_address_prim_range_Invalid := Companies_Fields.InValid_clean_address_prim_range((SALT311.StrType)le.clean_address_prim_range);
    SELF.clean_address_predir_Invalid := Companies_Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir);
    SELF.clean_address_prim_name_Invalid := Companies_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name);
    SELF.clean_address_addr_suffix_Invalid := Companies_Fields.InValid_clean_address_addr_suffix((SALT311.StrType)le.clean_address_addr_suffix);
    SELF.clean_address_postdir_Invalid := Companies_Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir);
    SELF.clean_address_unit_desig_Invalid := Companies_Fields.InValid_clean_address_unit_desig((SALT311.StrType)le.clean_address_unit_desig);
    SELF.clean_address_sec_range_Invalid := Companies_Fields.InValid_clean_address_sec_range((SALT311.StrType)le.clean_address_sec_range);
    SELF.clean_address_p_city_name_Invalid := Companies_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name);
    SELF.clean_address_v_city_name_Invalid := Companies_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name);
    SELF.clean_address_st_Invalid := Companies_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st);
    SELF.clean_address_zip_Invalid := Companies_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip);
    SELF.clean_address_zip4_Invalid := Companies_Fields.InValid_clean_address_zip4((SALT311.StrType)le.clean_address_zip4);
    SELF.clean_address_cart_Invalid := Companies_Fields.InValid_clean_address_cart((SALT311.StrType)le.clean_address_cart);
    SELF.clean_address_cr_sort_sz_Invalid := Companies_Fields.InValid_clean_address_cr_sort_sz((SALT311.StrType)le.clean_address_cr_sort_sz);
    SELF.clean_address_lot_Invalid := Companies_Fields.InValid_clean_address_lot((SALT311.StrType)le.clean_address_lot);
    SELF.clean_address_lot_order_Invalid := Companies_Fields.InValid_clean_address_lot_order((SALT311.StrType)le.clean_address_lot_order);
    SELF.clean_address_dbpc_Invalid := Companies_Fields.InValid_clean_address_dbpc((SALT311.StrType)le.clean_address_dbpc);
    SELF.clean_address_chk_digit_Invalid := Companies_Fields.InValid_clean_address_chk_digit((SALT311.StrType)le.clean_address_chk_digit);
    SELF.clean_address_rec_type_Invalid := Companies_Fields.InValid_clean_address_rec_type((SALT311.StrType)le.clean_address_rec_type);
    SELF.clean_address_fips_state_Invalid := Companies_Fields.InValid_clean_address_fips_state((SALT311.StrType)le.clean_address_fips_state);
    SELF.clean_address_fips_county_Invalid := Companies_Fields.InValid_clean_address_fips_county((SALT311.StrType)le.clean_address_fips_county);
    SELF.clean_address_geo_lat_Invalid := Companies_Fields.InValid_clean_address_geo_lat((SALT311.StrType)le.clean_address_geo_lat);
    SELF.clean_address_geo_long_Invalid := Companies_Fields.InValid_clean_address_geo_long((SALT311.StrType)le.clean_address_geo_long);
    SELF.clean_address_msa_Invalid := Companies_Fields.InValid_clean_address_msa((SALT311.StrType)le.clean_address_msa);
    SELF.clean_address_geo_blk_Invalid := Companies_Fields.InValid_clean_address_geo_blk((SALT311.StrType)le.clean_address_geo_blk);
    SELF.clean_address_geo_match_Invalid := Companies_Fields.InValid_clean_address_geo_match((SALT311.StrType)le.clean_address_geo_match);
    SELF.clean_address_err_stat_Invalid := Companies_Fields.InValid_clean_address_err_stat((SALT311.StrType)le.clean_address_err_stat);
    SELF.clean_dates_entrydate_Invalid := Companies_Fields.InValid_clean_dates_entrydate((SALT311.StrType)le.clean_dates_entrydate);
    SELF.clean_dates_lastupdate_Invalid := Companies_Fields.InValid_clean_dates_lastupdate((SALT311.StrType)le.clean_dates_lastupdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Companies_Layout_Sheila_Greco);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.record_type_Invalid << 4 ) + ( le.rawfields_maincompanyid_Invalid << 5 ) + ( le.rawfields_companyname_Invalid << 6 ) + ( le.rawfields_ticker_Invalid << 7 ) + ( le.rawfields_fortunerank_Invalid << 8 ) + ( le.rawfields_primaryindustry_Invalid << 9 ) + ( le.rawfields_address1_Invalid << 10 ) + ( le.rawfields_address2_Invalid << 11 ) + ( le.rawfields_city_Invalid << 12 ) + ( le.rawfields_state_Invalid << 13 ) + ( le.rawfields_zip_Invalid << 15 ) + ( le.rawfields_country_Invalid << 16 ) + ( le.rawfields_region_Invalid << 17 ) + ( le.rawfields_phone_Invalid << 18 ) + ( le.rawfields_extension_Invalid << 19 ) + ( le.rawfields_weburl_Invalid << 20 ) + ( le.rawfields_sales_Invalid << 21 ) + ( le.rawfields_employees_Invalid << 22 ) + ( le.rawfields_competitors_Invalid << 23 ) + ( le.rawfields_divisionname_Invalid << 24 ) + ( le.rawfields_siccode_Invalid << 25 ) + ( le.rawfields_auditor_Invalid << 26 ) + ( le.rawfields_entrydate_Invalid << 27 ) + ( le.rawfields_lastupdate_Invalid << 28 ) + ( le.rawfields_entrystaffid_Invalid << 29 ) + ( le.clean_address_prim_range_Invalid << 30 ) + ( le.clean_address_predir_Invalid << 31 ) + ( le.clean_address_prim_name_Invalid << 32 ) + ( le.clean_address_addr_suffix_Invalid << 33 ) + ( le.clean_address_postdir_Invalid << 34 ) + ( le.clean_address_unit_desig_Invalid << 35 ) + ( le.clean_address_sec_range_Invalid << 36 ) + ( le.clean_address_p_city_name_Invalid << 37 ) + ( le.clean_address_v_city_name_Invalid << 38 ) + ( le.clean_address_st_Invalid << 39 ) + ( le.clean_address_zip_Invalid << 40 ) + ( le.clean_address_zip4_Invalid << 41 ) + ( le.clean_address_cart_Invalid << 42 ) + ( le.clean_address_cr_sort_sz_Invalid << 43 ) + ( le.clean_address_lot_Invalid << 44 ) + ( le.clean_address_lot_order_Invalid << 45 ) + ( le.clean_address_dbpc_Invalid << 46 ) + ( le.clean_address_chk_digit_Invalid << 47 ) + ( le.clean_address_rec_type_Invalid << 48 ) + ( le.clean_address_fips_state_Invalid << 49 ) + ( le.clean_address_fips_county_Invalid << 50 ) + ( le.clean_address_geo_lat_Invalid << 51 ) + ( le.clean_address_geo_long_Invalid << 52 ) + ( le.clean_address_msa_Invalid << 53 ) + ( le.clean_address_geo_blk_Invalid << 54 ) + ( le.clean_address_geo_match_Invalid << 55 ) + ( le.clean_address_err_stat_Invalid << 56 ) + ( le.clean_dates_entrydate_Invalid << 57 ) + ( le.clean_dates_lastupdate_Invalid << 58 );
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
  EXPORT Infile := PROJECT(h,Companies_Layout_Sheila_Greco);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.rawfields_maincompanyid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.rawfields_companyname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.rawfields_ticker_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.rawfields_fortunerank_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.rawfields_primaryindustry_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.rawfields_address1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.rawfields_address2_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.rawfields_city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.rawfields_state_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.rawfields_zip_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.rawfields_country_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.rawfields_region_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.rawfields_phone_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.rawfields_extension_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.rawfields_weburl_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.rawfields_sales_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.rawfields_employees_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.rawfields_competitors_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rawfields_divisionname_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.rawfields_siccode_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.rawfields_auditor_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.rawfields_entrydate_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.rawfields_lastupdate_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.rawfields_entrystaffid_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.clean_address_prim_range_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.clean_address_predir_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.clean_address_prim_name_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.clean_address_addr_suffix_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.clean_address_postdir_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.clean_address_unit_desig_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.clean_address_sec_range_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.clean_address_p_city_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.clean_address_v_city_name_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.clean_address_st_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.clean_address_zip_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.clean_address_zip4_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.clean_address_cart_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.clean_address_cr_sort_sz_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.clean_address_lot_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.clean_address_lot_order_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.clean_address_dbpc_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.clean_address_chk_digit_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.clean_address_rec_type_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.clean_address_fips_state_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.clean_address_fips_county_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.clean_address_geo_lat_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_address_geo_long_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_address_msa_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.clean_address_geo_blk_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.clean_address_geo_match_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.clean_address_err_stat_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.clean_dates_entrydate_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.clean_dates_lastupdate_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    rawfields_maincompanyid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_maincompanyid_Invalid=1);
    rawfields_companyname_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_companyname_Invalid=1);
    rawfields_ticker_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_ticker_Invalid=1);
    rawfields_fortunerank_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_fortunerank_Invalid=1);
    rawfields_primaryindustry_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_primaryindustry_Invalid=1);
    rawfields_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_address1_Invalid=1);
    rawfields_address2_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_address2_Invalid=1);
    rawfields_city_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_city_Invalid=1);
    rawfields_state_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid=1);
    rawfields_state_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid=2);
    rawfields_state_Total_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid>0);
    rawfields_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_zip_Invalid=1);
    rawfields_country_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_country_Invalid=1);
    rawfields_region_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_region_Invalid=1);
    rawfields_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_phone_Invalid=1);
    rawfields_extension_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_extension_Invalid=1);
    rawfields_weburl_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_weburl_Invalid=1);
    rawfields_sales_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_sales_Invalid=1);
    rawfields_employees_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_employees_Invalid=1);
    rawfields_competitors_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_competitors_Invalid=1);
    rawfields_divisionname_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_divisionname_Invalid=1);
    rawfields_siccode_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_siccode_Invalid=1);
    rawfields_auditor_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_auditor_Invalid=1);
    rawfields_entrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_entrydate_Invalid=1);
    rawfields_lastupdate_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_lastupdate_Invalid=1);
    rawfields_entrystaffid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_entrystaffid_Invalid=1);
    clean_address_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_prim_range_Invalid=1);
    clean_address_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_predir_Invalid=1);
    clean_address_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_prim_name_Invalid=1);
    clean_address_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_addr_suffix_Invalid=1);
    clean_address_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_postdir_Invalid=1);
    clean_address_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_unit_desig_Invalid=1);
    clean_address_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_sec_range_Invalid=1);
    clean_address_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_p_city_name_Invalid=1);
    clean_address_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_v_city_name_Invalid=1);
    clean_address_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid=1);
    clean_address_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid=1);
    clean_address_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_zip4_Invalid=1);
    clean_address_cart_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_cart_Invalid=1);
    clean_address_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_cr_sort_sz_Invalid=1);
    clean_address_lot_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_lot_Invalid=1);
    clean_address_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_lot_order_Invalid=1);
    clean_address_dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_dbpc_Invalid=1);
    clean_address_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_chk_digit_Invalid=1);
    clean_address_rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_rec_type_Invalid=1);
    clean_address_fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_fips_state_Invalid=1);
    clean_address_fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_fips_county_Invalid=1);
    clean_address_geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_geo_lat_Invalid=1);
    clean_address_geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_geo_long_Invalid=1);
    clean_address_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_msa_Invalid=1);
    clean_address_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_blk_Invalid=1);
    clean_address_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_match_Invalid=1);
    clean_address_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_err_stat_Invalid=1);
    clean_dates_entrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dates_entrydate_Invalid=1);
    clean_dates_lastupdate_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dates_lastupdate_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.rawfields_maincompanyid_Invalid > 0 OR h.rawfields_companyname_Invalid > 0 OR h.rawfields_ticker_Invalid > 0 OR h.rawfields_fortunerank_Invalid > 0 OR h.rawfields_primaryindustry_Invalid > 0 OR h.rawfields_address1_Invalid > 0 OR h.rawfields_address2_Invalid > 0 OR h.rawfields_city_Invalid > 0 OR h.rawfields_state_Invalid > 0 OR h.rawfields_zip_Invalid > 0 OR h.rawfields_country_Invalid > 0 OR h.rawfields_region_Invalid > 0 OR h.rawfields_phone_Invalid > 0 OR h.rawfields_extension_Invalid > 0 OR h.rawfields_weburl_Invalid > 0 OR h.rawfields_sales_Invalid > 0 OR h.rawfields_employees_Invalid > 0 OR h.rawfields_competitors_Invalid > 0 OR h.rawfields_divisionname_Invalid > 0 OR h.rawfields_siccode_Invalid > 0 OR h.rawfields_auditor_Invalid > 0 OR h.rawfields_entrydate_Invalid > 0 OR h.rawfields_lastupdate_Invalid > 0 OR h.rawfields_entrystaffid_Invalid > 0 OR h.clean_address_prim_range_Invalid > 0 OR h.clean_address_predir_Invalid > 0 OR h.clean_address_prim_name_Invalid > 0 OR h.clean_address_addr_suffix_Invalid > 0 OR h.clean_address_postdir_Invalid > 0 OR h.clean_address_unit_desig_Invalid > 0 OR h.clean_address_sec_range_Invalid > 0 OR h.clean_address_p_city_name_Invalid > 0 OR h.clean_address_v_city_name_Invalid > 0 OR h.clean_address_st_Invalid > 0 OR h.clean_address_zip_Invalid > 0 OR h.clean_address_zip4_Invalid > 0 OR h.clean_address_cart_Invalid > 0 OR h.clean_address_cr_sort_sz_Invalid > 0 OR h.clean_address_lot_Invalid > 0 OR h.clean_address_lot_order_Invalid > 0 OR h.clean_address_dbpc_Invalid > 0 OR h.clean_address_chk_digit_Invalid > 0 OR h.clean_address_rec_type_Invalid > 0 OR h.clean_address_fips_state_Invalid > 0 OR h.clean_address_fips_county_Invalid > 0 OR h.clean_address_geo_lat_Invalid > 0 OR h.clean_address_geo_long_Invalid > 0 OR h.clean_address_msa_Invalid > 0 OR h.clean_address_geo_blk_Invalid > 0 OR h.clean_address_geo_match_Invalid > 0 OR h.clean_address_err_stat_Invalid > 0 OR h.clean_dates_entrydate_Invalid > 0 OR h.clean_dates_lastupdate_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_companyname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_ticker_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_fortunerank_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primaryindustry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_Total_ErrorCount > 0, 1, 0) + IF(le.rawfields_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_extension_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_weburl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_sales_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_employees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_competitors_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_divisionname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_siccode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_auditor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrystaffid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dates_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dates_lastupdate_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_companyname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_ticker_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_fortunerank_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primaryindustry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_extension_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_weburl_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_sales_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_employees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_competitors_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_divisionname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_siccode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_auditor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrystaffid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dates_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dates_lastupdate_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.rawfields_maincompanyid_Invalid,le.rawfields_companyname_Invalid,le.rawfields_ticker_Invalid,le.rawfields_fortunerank_Invalid,le.rawfields_primaryindustry_Invalid,le.rawfields_address1_Invalid,le.rawfields_address2_Invalid,le.rawfields_city_Invalid,le.rawfields_state_Invalid,le.rawfields_zip_Invalid,le.rawfields_country_Invalid,le.rawfields_region_Invalid,le.rawfields_phone_Invalid,le.rawfields_extension_Invalid,le.rawfields_weburl_Invalid,le.rawfields_sales_Invalid,le.rawfields_employees_Invalid,le.rawfields_competitors_Invalid,le.rawfields_divisionname_Invalid,le.rawfields_siccode_Invalid,le.rawfields_auditor_Invalid,le.rawfields_entrydate_Invalid,le.rawfields_lastupdate_Invalid,le.rawfields_entrystaffid_Invalid,le.clean_address_prim_range_Invalid,le.clean_address_predir_Invalid,le.clean_address_prim_name_Invalid,le.clean_address_addr_suffix_Invalid,le.clean_address_postdir_Invalid,le.clean_address_unit_desig_Invalid,le.clean_address_sec_range_Invalid,le.clean_address_p_city_name_Invalid,le.clean_address_v_city_name_Invalid,le.clean_address_st_Invalid,le.clean_address_zip_Invalid,le.clean_address_zip4_Invalid,le.clean_address_cart_Invalid,le.clean_address_cr_sort_sz_Invalid,le.clean_address_lot_Invalid,le.clean_address_lot_order_Invalid,le.clean_address_dbpc_Invalid,le.clean_address_chk_digit_Invalid,le.clean_address_rec_type_Invalid,le.clean_address_fips_state_Invalid,le.clean_address_fips_county_Invalid,le.clean_address_geo_lat_Invalid,le.clean_address_geo_long_Invalid,le.clean_address_msa_Invalid,le.clean_address_geo_blk_Invalid,le.clean_address_geo_match_Invalid,le.clean_address_err_stat_Invalid,le.clean_dates_entrydate_Invalid,le.clean_dates_lastupdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Companies_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Companies_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Companies_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Companies_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Companies_Fields.InvalidMessage_record_type(le.record_type_Invalid),Companies_Fields.InvalidMessage_rawfields_maincompanyid(le.rawfields_maincompanyid_Invalid),Companies_Fields.InvalidMessage_rawfields_companyname(le.rawfields_companyname_Invalid),Companies_Fields.InvalidMessage_rawfields_ticker(le.rawfields_ticker_Invalid),Companies_Fields.InvalidMessage_rawfields_fortunerank(le.rawfields_fortunerank_Invalid),Companies_Fields.InvalidMessage_rawfields_primaryindustry(le.rawfields_primaryindustry_Invalid),Companies_Fields.InvalidMessage_rawfields_address1(le.rawfields_address1_Invalid),Companies_Fields.InvalidMessage_rawfields_address2(le.rawfields_address2_Invalid),Companies_Fields.InvalidMessage_rawfields_city(le.rawfields_city_Invalid),Companies_Fields.InvalidMessage_rawfields_state(le.rawfields_state_Invalid),Companies_Fields.InvalidMessage_rawfields_zip(le.rawfields_zip_Invalid),Companies_Fields.InvalidMessage_rawfields_country(le.rawfields_country_Invalid),Companies_Fields.InvalidMessage_rawfields_region(le.rawfields_region_Invalid),Companies_Fields.InvalidMessage_rawfields_phone(le.rawfields_phone_Invalid),Companies_Fields.InvalidMessage_rawfields_extension(le.rawfields_extension_Invalid),Companies_Fields.InvalidMessage_rawfields_weburl(le.rawfields_weburl_Invalid),Companies_Fields.InvalidMessage_rawfields_sales(le.rawfields_sales_Invalid),Companies_Fields.InvalidMessage_rawfields_employees(le.rawfields_employees_Invalid),Companies_Fields.InvalidMessage_rawfields_competitors(le.rawfields_competitors_Invalid),Companies_Fields.InvalidMessage_rawfields_divisionname(le.rawfields_divisionname_Invalid),Companies_Fields.InvalidMessage_rawfields_siccode(le.rawfields_siccode_Invalid),Companies_Fields.InvalidMessage_rawfields_auditor(le.rawfields_auditor_Invalid),Companies_Fields.InvalidMessage_rawfields_entrydate(le.rawfields_entrydate_Invalid),Companies_Fields.InvalidMessage_rawfields_lastupdate(le.rawfields_lastupdate_Invalid),Companies_Fields.InvalidMessage_rawfields_entrystaffid(le.rawfields_entrystaffid_Invalid),Companies_Fields.InvalidMessage_clean_address_prim_range(le.clean_address_prim_range_Invalid),Companies_Fields.InvalidMessage_clean_address_predir(le.clean_address_predir_Invalid),Companies_Fields.InvalidMessage_clean_address_prim_name(le.clean_address_prim_name_Invalid),Companies_Fields.InvalidMessage_clean_address_addr_suffix(le.clean_address_addr_suffix_Invalid),Companies_Fields.InvalidMessage_clean_address_postdir(le.clean_address_postdir_Invalid),Companies_Fields.InvalidMessage_clean_address_unit_desig(le.clean_address_unit_desig_Invalid),Companies_Fields.InvalidMessage_clean_address_sec_range(le.clean_address_sec_range_Invalid),Companies_Fields.InvalidMessage_clean_address_p_city_name(le.clean_address_p_city_name_Invalid),Companies_Fields.InvalidMessage_clean_address_v_city_name(le.clean_address_v_city_name_Invalid),Companies_Fields.InvalidMessage_clean_address_st(le.clean_address_st_Invalid),Companies_Fields.InvalidMessage_clean_address_zip(le.clean_address_zip_Invalid),Companies_Fields.InvalidMessage_clean_address_zip4(le.clean_address_zip4_Invalid),Companies_Fields.InvalidMessage_clean_address_cart(le.clean_address_cart_Invalid),Companies_Fields.InvalidMessage_clean_address_cr_sort_sz(le.clean_address_cr_sort_sz_Invalid),Companies_Fields.InvalidMessage_clean_address_lot(le.clean_address_lot_Invalid),Companies_Fields.InvalidMessage_clean_address_lot_order(le.clean_address_lot_order_Invalid),Companies_Fields.InvalidMessage_clean_address_dbpc(le.clean_address_dbpc_Invalid),Companies_Fields.InvalidMessage_clean_address_chk_digit(le.clean_address_chk_digit_Invalid),Companies_Fields.InvalidMessage_clean_address_rec_type(le.clean_address_rec_type_Invalid),Companies_Fields.InvalidMessage_clean_address_fips_state(le.clean_address_fips_state_Invalid),Companies_Fields.InvalidMessage_clean_address_fips_county(le.clean_address_fips_county_Invalid),Companies_Fields.InvalidMessage_clean_address_geo_lat(le.clean_address_geo_lat_Invalid),Companies_Fields.InvalidMessage_clean_address_geo_long(le.clean_address_geo_long_Invalid),Companies_Fields.InvalidMessage_clean_address_msa(le.clean_address_msa_Invalid),Companies_Fields.InvalidMessage_clean_address_geo_blk(le.clean_address_geo_blk_Invalid),Companies_Fields.InvalidMessage_clean_address_geo_match(le.clean_address_geo_match_Invalid),Companies_Fields.InvalidMessage_clean_address_err_stat(le.clean_address_err_stat_Invalid),Companies_Fields.InvalidMessage_clean_dates_entrydate(le.clean_dates_entrydate_Invalid),Companies_Fields.InvalidMessage_clean_dates_lastupdate(le.clean_dates_lastupdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_maincompanyid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_companyname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_ticker_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_fortunerank_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_primaryindustry_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_address2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_zip_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_extension_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_weburl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_sales_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_employees_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_competitors_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_divisionname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_siccode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_auditor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_entrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_lastupdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_entrystaffid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_zip_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_dbpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_rec_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_fips_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dates_entrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_dates_lastupdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincompanyid','rawfields_companyname','rawfields_ticker','rawfields_fortunerank','rawfields_primaryindustry','rawfields_address1','rawfields_address2','rawfields_city','rawfields_state','rawfields_zip','rawfields_country','rawfields_region','rawfields_phone','rawfields_extension','rawfields_weburl','rawfields_sales','rawfields_employees','rawfields_competitors','rawfields_divisionname','rawfields_siccode','rawfields_auditor','rawfields_entrydate','rawfields_lastupdate','rawfields_entrystaffid','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaChar','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_AlphaCaps','Invalid_Float','Invalid_Float','Invalid_AlphaChar','Invalid_Float','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaNumChar','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_type,(SALT311.StrType)le.rawfields_maincompanyid,(SALT311.StrType)le.rawfields_companyname,(SALT311.StrType)le.rawfields_ticker,(SALT311.StrType)le.rawfields_fortunerank,(SALT311.StrType)le.rawfields_primaryindustry,(SALT311.StrType)le.rawfields_address1,(SALT311.StrType)le.rawfields_address2,(SALT311.StrType)le.rawfields_city,(SALT311.StrType)le.rawfields_state,(SALT311.StrType)le.rawfields_zip,(SALT311.StrType)le.rawfields_country,(SALT311.StrType)le.rawfields_region,(SALT311.StrType)le.rawfields_phone,(SALT311.StrType)le.rawfields_extension,(SALT311.StrType)le.rawfields_weburl,(SALT311.StrType)le.rawfields_sales,(SALT311.StrType)le.rawfields_employees,(SALT311.StrType)le.rawfields_competitors,(SALT311.StrType)le.rawfields_divisionname,(SALT311.StrType)le.rawfields_siccode,(SALT311.StrType)le.rawfields_auditor,(SALT311.StrType)le.rawfields_entrydate,(SALT311.StrType)le.rawfields_lastupdate,(SALT311.StrType)le.rawfields_entrystaffid,(SALT311.StrType)le.clean_address_prim_range,(SALT311.StrType)le.clean_address_predir,(SALT311.StrType)le.clean_address_prim_name,(SALT311.StrType)le.clean_address_addr_suffix,(SALT311.StrType)le.clean_address_postdir,(SALT311.StrType)le.clean_address_unit_desig,(SALT311.StrType)le.clean_address_sec_range,(SALT311.StrType)le.clean_address_p_city_name,(SALT311.StrType)le.clean_address_v_city_name,(SALT311.StrType)le.clean_address_st,(SALT311.StrType)le.clean_address_zip,(SALT311.StrType)le.clean_address_zip4,(SALT311.StrType)le.clean_address_cart,(SALT311.StrType)le.clean_address_cr_sort_sz,(SALT311.StrType)le.clean_address_lot,(SALT311.StrType)le.clean_address_lot_order,(SALT311.StrType)le.clean_address_dbpc,(SALT311.StrType)le.clean_address_chk_digit,(SALT311.StrType)le.clean_address_rec_type,(SALT311.StrType)le.clean_address_fips_state,(SALT311.StrType)le.clean_address_fips_county,(SALT311.StrType)le.clean_address_geo_lat,(SALT311.StrType)le.clean_address_geo_long,(SALT311.StrType)le.clean_address_msa,(SALT311.StrType)le.clean_address_geo_blk,(SALT311.StrType)le.clean_address_geo_match,(SALT311.StrType)le.clean_address_err_stat,(SALT311.StrType)le.clean_dates_entrydate,(SALT311.StrType)le.clean_dates_lastupdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,58,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Companies_Layout_Sheila_Greco) prevDS = DATASET([], Companies_Layout_Sheila_Greco), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_companyname_CUSTOM_ErrorCount
          ,le.rawfields_ticker_ALLOW_ErrorCount
          ,le.rawfields_fortunerank_ALLOW_ErrorCount
          ,le.rawfields_primaryindustry_CUSTOM_ErrorCount
          ,le.rawfields_address1_CUSTOM_ErrorCount
          ,le.rawfields_address2_CUSTOM_ErrorCount
          ,le.rawfields_city_CUSTOM_ErrorCount
          ,le.rawfields_state_ALLOW_ErrorCount,le.rawfields_state_LENGTHS_ErrorCount
          ,le.rawfields_zip_LENGTHS_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_region_ALLOW_ErrorCount
          ,le.rawfields_phone_CUSTOM_ErrorCount
          ,le.rawfields_extension_CUSTOM_ErrorCount
          ,le.rawfields_weburl_CUSTOM_ErrorCount
          ,le.rawfields_sales_CUSTOM_ErrorCount
          ,le.rawfields_employees_ALLOW_ErrorCount
          ,le.rawfields_competitors_CUSTOM_ErrorCount
          ,le.rawfields_divisionname_ALLOW_ErrorCount
          ,le.rawfields_siccode_CUSTOM_ErrorCount
          ,le.rawfields_auditor_CUSTOM_ErrorCount
          ,le.rawfields_entrydate_CUSTOM_ErrorCount
          ,le.rawfields_lastupdate_CUSTOM_ErrorCount
          ,le.rawfields_entrystaffid_ALLOW_ErrorCount
          ,le.clean_address_prim_range_ALLOW_ErrorCount
          ,le.clean_address_predir_ALLOW_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_address_postdir_ALLOW_ErrorCount
          ,le.clean_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_address_sec_range_ALLOW_ErrorCount
          ,le.clean_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_address_st_ALLOW_ErrorCount
          ,le.clean_address_zip_LENGTHS_ErrorCount
          ,le.clean_address_zip4_ALLOW_ErrorCount
          ,le.clean_address_cart_ALLOW_ErrorCount
          ,le.clean_address_cr_sort_sz_ALLOW_ErrorCount
          ,le.clean_address_lot_ALLOW_ErrorCount
          ,le.clean_address_lot_order_ALLOW_ErrorCount
          ,le.clean_address_dbpc_ALLOW_ErrorCount
          ,le.clean_address_chk_digit_ALLOW_ErrorCount
          ,le.clean_address_rec_type_ALLOW_ErrorCount
          ,le.clean_address_fips_state_ALLOW_ErrorCount
          ,le.clean_address_fips_county_ALLOW_ErrorCount
          ,le.clean_address_geo_lat_CUSTOM_ErrorCount
          ,le.clean_address_geo_long_CUSTOM_ErrorCount
          ,le.clean_address_msa_ALLOW_ErrorCount
          ,le.clean_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_address_geo_match_ALLOW_ErrorCount
          ,le.clean_address_err_stat_ALLOW_ErrorCount
          ,le.clean_dates_entrydate_CUSTOM_ErrorCount
          ,le.clean_dates_lastupdate_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_companyname_CUSTOM_ErrorCount
          ,le.rawfields_ticker_ALLOW_ErrorCount
          ,le.rawfields_fortunerank_ALLOW_ErrorCount
          ,le.rawfields_primaryindustry_CUSTOM_ErrorCount
          ,le.rawfields_address1_CUSTOM_ErrorCount
          ,le.rawfields_address2_CUSTOM_ErrorCount
          ,le.rawfields_city_CUSTOM_ErrorCount
          ,le.rawfields_state_ALLOW_ErrorCount,le.rawfields_state_LENGTHS_ErrorCount
          ,le.rawfields_zip_LENGTHS_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_region_ALLOW_ErrorCount
          ,le.rawfields_phone_CUSTOM_ErrorCount
          ,le.rawfields_extension_CUSTOM_ErrorCount
          ,le.rawfields_weburl_CUSTOM_ErrorCount
          ,le.rawfields_sales_CUSTOM_ErrorCount
          ,le.rawfields_employees_ALLOW_ErrorCount
          ,le.rawfields_competitors_CUSTOM_ErrorCount
          ,le.rawfields_divisionname_ALLOW_ErrorCount
          ,le.rawfields_siccode_CUSTOM_ErrorCount
          ,le.rawfields_auditor_CUSTOM_ErrorCount
          ,le.rawfields_entrydate_CUSTOM_ErrorCount
          ,le.rawfields_lastupdate_CUSTOM_ErrorCount
          ,le.rawfields_entrystaffid_ALLOW_ErrorCount
          ,le.clean_address_prim_range_ALLOW_ErrorCount
          ,le.clean_address_predir_ALLOW_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_address_postdir_ALLOW_ErrorCount
          ,le.clean_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_address_sec_range_ALLOW_ErrorCount
          ,le.clean_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_address_st_ALLOW_ErrorCount
          ,le.clean_address_zip_LENGTHS_ErrorCount
          ,le.clean_address_zip4_ALLOW_ErrorCount
          ,le.clean_address_cart_ALLOW_ErrorCount
          ,le.clean_address_cr_sort_sz_ALLOW_ErrorCount
          ,le.clean_address_lot_ALLOW_ErrorCount
          ,le.clean_address_lot_order_ALLOW_ErrorCount
          ,le.clean_address_dbpc_ALLOW_ErrorCount
          ,le.clean_address_chk_digit_ALLOW_ErrorCount
          ,le.clean_address_rec_type_ALLOW_ErrorCount
          ,le.clean_address_fips_state_ALLOW_ErrorCount
          ,le.clean_address_fips_county_ALLOW_ErrorCount
          ,le.clean_address_geo_lat_CUSTOM_ErrorCount
          ,le.clean_address_geo_long_CUSTOM_ErrorCount
          ,le.clean_address_msa_ALLOW_ErrorCount
          ,le.clean_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_address_geo_match_ALLOW_ErrorCount
          ,le.clean_address_err_stat_ALLOW_ErrorCount
          ,le.clean_dates_entrydate_CUSTOM_ErrorCount
          ,le.clean_dates_lastupdate_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Companies_hygiene(PROJECT(h, Companies_Layout_Sheila_Greco));
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
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_maincompanyid:' + getFieldTypeText(h.rawfields_maincompanyid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_companyname:' + getFieldTypeText(h.rawfields_companyname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_ticker:' + getFieldTypeText(h.rawfields_ticker) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_fortunerank:' + getFieldTypeText(h.rawfields_fortunerank) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_primaryindustry:' + getFieldTypeText(h.rawfields_primaryindustry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_address1:' + getFieldTypeText(h.rawfields_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_address2:' + getFieldTypeText(h.rawfields_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_city:' + getFieldTypeText(h.rawfields_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_state:' + getFieldTypeText(h.rawfields_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_zip:' + getFieldTypeText(h.rawfields_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_country:' + getFieldTypeText(h.rawfields_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_region:' + getFieldTypeText(h.rawfields_region) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_phone:' + getFieldTypeText(h.rawfields_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_extension:' + getFieldTypeText(h.rawfields_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_weburl:' + getFieldTypeText(h.rawfields_weburl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_sales:' + getFieldTypeText(h.rawfields_sales) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_employees:' + getFieldTypeText(h.rawfields_employees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_competitors:' + getFieldTypeText(h.rawfields_competitors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_divisionname:' + getFieldTypeText(h.rawfields_divisionname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_siccode:' + getFieldTypeText(h.rawfields_siccode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_auditor:' + getFieldTypeText(h.rawfields_auditor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_entrydate:' + getFieldTypeText(h.rawfields_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_lastupdate:' + getFieldTypeText(h.rawfields_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_entrystaffid:' + getFieldTypeText(h.rawfields_entrystaffid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_prim_range:' + getFieldTypeText(h.clean_address_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_predir:' + getFieldTypeText(h.clean_address_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_prim_name:' + getFieldTypeText(h.clean_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_addr_suffix:' + getFieldTypeText(h.clean_address_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_postdir:' + getFieldTypeText(h.clean_address_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_unit_desig:' + getFieldTypeText(h.clean_address_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_sec_range:' + getFieldTypeText(h.clean_address_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_p_city_name:' + getFieldTypeText(h.clean_address_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_v_city_name:' + getFieldTypeText(h.clean_address_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_st:' + getFieldTypeText(h.clean_address_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_zip:' + getFieldTypeText(h.clean_address_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_zip4:' + getFieldTypeText(h.clean_address_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_cart:' + getFieldTypeText(h.clean_address_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_cr_sort_sz:' + getFieldTypeText(h.clean_address_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_lot:' + getFieldTypeText(h.clean_address_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_lot_order:' + getFieldTypeText(h.clean_address_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_dbpc:' + getFieldTypeText(h.clean_address_dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_chk_digit:' + getFieldTypeText(h.clean_address_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_rec_type:' + getFieldTypeText(h.clean_address_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_fips_state:' + getFieldTypeText(h.clean_address_fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_fips_county:' + getFieldTypeText(h.clean_address_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_geo_lat:' + getFieldTypeText(h.clean_address_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_geo_long:' + getFieldTypeText(h.clean_address_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_msa:' + getFieldTypeText(h.clean_address_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_geo_blk:' + getFieldTypeText(h.clean_address_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_geo_match:' + getFieldTypeText(h.clean_address_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_address_err_stat:' + getFieldTypeText(h.clean_address_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_entrydate:' + getFieldTypeText(h.clean_dates_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_lastupdate:' + getFieldTypeText(h.clean_dates_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_phone:' + getFieldTypeText(h.clean_phones_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_rawfields_maincompanyid_cnt
          ,le.populated_rawfields_companyname_cnt
          ,le.populated_rawfields_ticker_cnt
          ,le.populated_rawfields_fortunerank_cnt
          ,le.populated_rawfields_primaryindustry_cnt
          ,le.populated_rawfields_address1_cnt
          ,le.populated_rawfields_address2_cnt
          ,le.populated_rawfields_city_cnt
          ,le.populated_rawfields_state_cnt
          ,le.populated_rawfields_zip_cnt
          ,le.populated_rawfields_country_cnt
          ,le.populated_rawfields_region_cnt
          ,le.populated_rawfields_phone_cnt
          ,le.populated_rawfields_extension_cnt
          ,le.populated_rawfields_weburl_cnt
          ,le.populated_rawfields_sales_cnt
          ,le.populated_rawfields_employees_cnt
          ,le.populated_rawfields_competitors_cnt
          ,le.populated_rawfields_divisionname_cnt
          ,le.populated_rawfields_siccode_cnt
          ,le.populated_rawfields_auditor_cnt
          ,le.populated_rawfields_entrydate_cnt
          ,le.populated_rawfields_lastupdate_cnt
          ,le.populated_rawfields_entrystaffid_cnt
          ,le.populated_clean_address_prim_range_cnt
          ,le.populated_clean_address_predir_cnt
          ,le.populated_clean_address_prim_name_cnt
          ,le.populated_clean_address_addr_suffix_cnt
          ,le.populated_clean_address_postdir_cnt
          ,le.populated_clean_address_unit_desig_cnt
          ,le.populated_clean_address_sec_range_cnt
          ,le.populated_clean_address_p_city_name_cnt
          ,le.populated_clean_address_v_city_name_cnt
          ,le.populated_clean_address_st_cnt
          ,le.populated_clean_address_zip_cnt
          ,le.populated_clean_address_zip4_cnt
          ,le.populated_clean_address_cart_cnt
          ,le.populated_clean_address_cr_sort_sz_cnt
          ,le.populated_clean_address_lot_cnt
          ,le.populated_clean_address_lot_order_cnt
          ,le.populated_clean_address_dbpc_cnt
          ,le.populated_clean_address_chk_digit_cnt
          ,le.populated_clean_address_rec_type_cnt
          ,le.populated_clean_address_fips_state_cnt
          ,le.populated_clean_address_fips_county_cnt
          ,le.populated_clean_address_geo_lat_cnt
          ,le.populated_clean_address_geo_long_cnt
          ,le.populated_clean_address_msa_cnt
          ,le.populated_clean_address_geo_blk_cnt
          ,le.populated_clean_address_geo_match_cnt
          ,le.populated_clean_address_err_stat_cnt
          ,le.populated_clean_dates_entrydate_cnt
          ,le.populated_clean_dates_lastupdate_cnt
          ,le.populated_clean_phones_phone_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_rawfields_maincompanyid_pcnt
          ,le.populated_rawfields_companyname_pcnt
          ,le.populated_rawfields_ticker_pcnt
          ,le.populated_rawfields_fortunerank_pcnt
          ,le.populated_rawfields_primaryindustry_pcnt
          ,le.populated_rawfields_address1_pcnt
          ,le.populated_rawfields_address2_pcnt
          ,le.populated_rawfields_city_pcnt
          ,le.populated_rawfields_state_pcnt
          ,le.populated_rawfields_zip_pcnt
          ,le.populated_rawfields_country_pcnt
          ,le.populated_rawfields_region_pcnt
          ,le.populated_rawfields_phone_pcnt
          ,le.populated_rawfields_extension_pcnt
          ,le.populated_rawfields_weburl_pcnt
          ,le.populated_rawfields_sales_pcnt
          ,le.populated_rawfields_employees_pcnt
          ,le.populated_rawfields_competitors_pcnt
          ,le.populated_rawfields_divisionname_pcnt
          ,le.populated_rawfields_siccode_pcnt
          ,le.populated_rawfields_auditor_pcnt
          ,le.populated_rawfields_entrydate_pcnt
          ,le.populated_rawfields_lastupdate_pcnt
          ,le.populated_rawfields_entrystaffid_pcnt
          ,le.populated_clean_address_prim_range_pcnt
          ,le.populated_clean_address_predir_pcnt
          ,le.populated_clean_address_prim_name_pcnt
          ,le.populated_clean_address_addr_suffix_pcnt
          ,le.populated_clean_address_postdir_pcnt
          ,le.populated_clean_address_unit_desig_pcnt
          ,le.populated_clean_address_sec_range_pcnt
          ,le.populated_clean_address_p_city_name_pcnt
          ,le.populated_clean_address_v_city_name_pcnt
          ,le.populated_clean_address_st_pcnt
          ,le.populated_clean_address_zip_pcnt
          ,le.populated_clean_address_zip4_pcnt
          ,le.populated_clean_address_cart_pcnt
          ,le.populated_clean_address_cr_sort_sz_pcnt
          ,le.populated_clean_address_lot_pcnt
          ,le.populated_clean_address_lot_order_pcnt
          ,le.populated_clean_address_dbpc_pcnt
          ,le.populated_clean_address_chk_digit_pcnt
          ,le.populated_clean_address_rec_type_pcnt
          ,le.populated_clean_address_fips_state_pcnt
          ,le.populated_clean_address_fips_county_pcnt
          ,le.populated_clean_address_geo_lat_pcnt
          ,le.populated_clean_address_geo_long_pcnt
          ,le.populated_clean_address_msa_pcnt
          ,le.populated_clean_address_geo_blk_pcnt
          ,le.populated_clean_address_geo_match_pcnt
          ,le.populated_clean_address_err_stat_pcnt
          ,le.populated_clean_dates_entrydate_pcnt
          ,le.populated_clean_dates_lastupdate_pcnt
          ,le.populated_clean_phones_phone_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,87,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Companies_Delta(prevDS, PROJECT(h, Companies_Layout_Sheila_Greco));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),87,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Companies_Layout_Sheila_Greco) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Sheila_Greco, Companies_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
