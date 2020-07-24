IMPORT SALT311,STD;
IMPORT Scrubs_SalesChannel,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 91;
  EXPORT NumRulesFromFieldType := 91;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 86;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_SalesChannel)
    UNSIGNED1 rid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 aceaid_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 rawfields_row_id_Invalid;
    UNSIGNED1 rawfields_company_name_Invalid;
    UNSIGNED1 rawfields_web_address_Invalid;
    UNSIGNED1 rawfields_prefix_Invalid;
    UNSIGNED1 rawfields_contact_name_Invalid;
    UNSIGNED1 rawfields_first_name_Invalid;
    UNSIGNED1 rawfields_middle_name_Invalid;
    UNSIGNED1 rawfields_last_name_Invalid;
    UNSIGNED1 rawfields_title_Invalid;
    UNSIGNED1 rawfields_address_Invalid;
    UNSIGNED1 rawfields_address1_Invalid;
    UNSIGNED1 rawfields_city_Invalid;
    UNSIGNED1 rawfields_state_Invalid;
    UNSIGNED1 rawfields_zip_code_Invalid;
    UNSIGNED1 rawfields_country_Invalid;
    UNSIGNED1 rawfields_phone_number_Invalid;
    UNSIGNED1 rawfields_email_Invalid;
    UNSIGNED1 clean_name_title_Invalid;
    UNSIGNED1 clean_name_fname_Invalid;
    UNSIGNED1 clean_name_mname_Invalid;
    UNSIGNED1 clean_name_lname_Invalid;
    UNSIGNED1 clean_name_name_suffix_Invalid;
    UNSIGNED1 clean_name_name_score_Invalid;
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
    UNSIGNED1 global_sid_Invalid;
    UNSIGNED1 record_sid_Invalid;
    UNSIGNED1 current_rec_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_SalesChannel)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_SalesChannel)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'rid:Invalid_No:ALLOW'
          ,'bdid:Invalid_No:ALLOW'
          ,'bdid_score:Invalid_No:ALLOW'
          ,'dotid:Invalid_No:ALLOW'
          ,'dotscore:Invalid_No:ALLOW'
          ,'dotweight:Invalid_No:ALLOW'
          ,'empid:Invalid_No:ALLOW'
          ,'empscore:Invalid_No:ALLOW'
          ,'empweight:Invalid_No:ALLOW'
          ,'powid:Invalid_No:ALLOW'
          ,'powscore:Invalid_No:ALLOW'
          ,'powweight:Invalid_No:ALLOW'
          ,'proxid:Invalid_No:ALLOW'
          ,'proxscore:Invalid_No:ALLOW'
          ,'proxweight:Invalid_No:ALLOW'
          ,'seleid:Invalid_No:ALLOW'
          ,'selescore:Invalid_No:ALLOW'
          ,'seleweight:Invalid_No:ALLOW'
          ,'orgid:Invalid_No:ALLOW'
          ,'orgscore:Invalid_No:ALLOW'
          ,'orgweight:Invalid_No:ALLOW'
          ,'ultid:Invalid_No:ALLOW'
          ,'ultscore:Invalid_No:ALLOW'
          ,'ultweight:Invalid_No:ALLOW'
          ,'did:Invalid_No:ALLOW'
          ,'did_score:Invalid_No:ALLOW'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'date_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'date_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'rawaid:Invalid_No:ALLOW'
          ,'aceaid:Invalid_No:ALLOW'
          ,'record_type:Invalid_No:ALLOW'
          ,'rawfields_row_id:Invalid_No:ALLOW'
          ,'rawfields_company_name:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_web_address:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_prefix:Invalid_AlphaChars:ALLOW'
          ,'rawfields_contact_name:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_first_name:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_middle_name:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_last_name:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_title:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_address:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_address1:Invalid_PrintableChar:CUSTOM'
          ,'rawfields_city:Invalid_Alpha:ALLOW'
          ,'rawfields_state:Invalid_State:ALLOW','rawfields_state:Invalid_State:LENGTHS'
          ,'rawfields_zip_code:Invalid_Zip:ALLOW','rawfields_zip_code:Invalid_Zip:LENGTHS'
          ,'rawfields_country:Invalid_Alpha:ALLOW'
          ,'rawfields_phone_number:Invalid_Float:ALLOW'
          ,'rawfields_email:Invalid_PrintableChar:CUSTOM'
          ,'clean_name_title:Invalid_AlphaNum:ALLOW'
          ,'clean_name_fname:Invalid_Alpha:ALLOW'
          ,'clean_name_mname:Invalid_Alpha:ALLOW'
          ,'clean_name_lname:Invalid_Alpha:ALLOW'
          ,'clean_name_name_suffix:Invalid_Alpha:ALLOW'
          ,'clean_name_name_score:Invalid_No:ALLOW'
          ,'clean_address_prim_range:Invalid_PrintableChar:CUSTOM'
          ,'clean_address_predir:Invalid_Alpha:ALLOW'
          ,'clean_address_prim_name:Invalid_PrintableChar:CUSTOM'
          ,'clean_address_addr_suffix:Invalid_Alpha:ALLOW'
          ,'clean_address_postdir:Invalid_Alpha:ALLOW'
          ,'clean_address_unit_desig:Invalid_AlphaChars:ALLOW'
          ,'clean_address_sec_range:Invalid_AlphaNum:ALLOW'
          ,'clean_address_p_city_name:Invalid_Alpha:ALLOW'
          ,'clean_address_v_city_name:Invalid_Alpha:ALLOW'
          ,'clean_address_st:Invalid_State:ALLOW','clean_address_st:Invalid_State:LENGTHS'
          ,'clean_address_zip:Invalid_Zip:ALLOW','clean_address_zip:Invalid_Zip:LENGTHS'
          ,'clean_address_zip4:Invalid_No:ALLOW'
          ,'clean_address_cart:Invalid_AlphaNum:ALLOW'
          ,'clean_address_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'clean_address_lot:Invalid_No:ALLOW'
          ,'clean_address_lot_order:Invalid_Alpha:ALLOW'
          ,'clean_address_dbpc:Invalid_No:ALLOW'
          ,'clean_address_chk_digit:Invalid_No:ALLOW'
          ,'clean_address_rec_type:Invalid_Alpha:ALLOW'
          ,'clean_address_fips_state:Invalid_No:ALLOW'
          ,'clean_address_fips_county:Invalid_No:ALLOW'
          ,'clean_address_geo_lat:Invalid_Float:ALLOW'
          ,'clean_address_geo_long:Invalid_Float:ALLOW'
          ,'clean_address_msa:Invalid_No:ALLOW'
          ,'clean_address_geo_blk:Invalid_No:ALLOW'
          ,'clean_address_geo_match:Invalid_No:ALLOW'
          ,'clean_address_err_stat:Invalid_AlphaNum:ALLOW'
          ,'global_sid:Invalid_Zip:ALLOW','global_sid:Invalid_Zip:LENGTHS'
          ,'record_sid:Invalid_No:ALLOW'
          ,'current_rec:Invalid_No:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_rid(1)
          ,Fields.InvalidMessage_bdid(1)
          ,Fields.InvalidMessage_bdid_score(1)
          ,Fields.InvalidMessage_dotid(1)
          ,Fields.InvalidMessage_dotscore(1)
          ,Fields.InvalidMessage_dotweight(1)
          ,Fields.InvalidMessage_empid(1)
          ,Fields.InvalidMessage_empscore(1)
          ,Fields.InvalidMessage_empweight(1)
          ,Fields.InvalidMessage_powid(1)
          ,Fields.InvalidMessage_powscore(1)
          ,Fields.InvalidMessage_powweight(1)
          ,Fields.InvalidMessage_proxid(1)
          ,Fields.InvalidMessage_proxscore(1)
          ,Fields.InvalidMessage_proxweight(1)
          ,Fields.InvalidMessage_seleid(1)
          ,Fields.InvalidMessage_selescore(1)
          ,Fields.InvalidMessage_seleweight(1)
          ,Fields.InvalidMessage_orgid(1)
          ,Fields.InvalidMessage_orgscore(1)
          ,Fields.InvalidMessage_orgweight(1)
          ,Fields.InvalidMessage_ultid(1)
          ,Fields.InvalidMessage_ultscore(1)
          ,Fields.InvalidMessage_ultweight(1)
          ,Fields.InvalidMessage_did(1)
          ,Fields.InvalidMessage_did_score(1)
          ,Fields.InvalidMessage_date_first_seen(1)
          ,Fields.InvalidMessage_date_last_seen(1)
          ,Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Fields.InvalidMessage_rawaid(1)
          ,Fields.InvalidMessage_aceaid(1)
          ,Fields.InvalidMessage_record_type(1)
          ,Fields.InvalidMessage_rawfields_row_id(1)
          ,Fields.InvalidMessage_rawfields_company_name(1)
          ,Fields.InvalidMessage_rawfields_web_address(1)
          ,Fields.InvalidMessage_rawfields_prefix(1)
          ,Fields.InvalidMessage_rawfields_contact_name(1)
          ,Fields.InvalidMessage_rawfields_first_name(1)
          ,Fields.InvalidMessage_rawfields_middle_name(1)
          ,Fields.InvalidMessage_rawfields_last_name(1)
          ,Fields.InvalidMessage_rawfields_title(1)
          ,Fields.InvalidMessage_rawfields_address(1)
          ,Fields.InvalidMessage_rawfields_address1(1)
          ,Fields.InvalidMessage_rawfields_city(1)
          ,Fields.InvalidMessage_rawfields_state(1),Fields.InvalidMessage_rawfields_state(2)
          ,Fields.InvalidMessage_rawfields_zip_code(1),Fields.InvalidMessage_rawfields_zip_code(2)
          ,Fields.InvalidMessage_rawfields_country(1)
          ,Fields.InvalidMessage_rawfields_phone_number(1)
          ,Fields.InvalidMessage_rawfields_email(1)
          ,Fields.InvalidMessage_clean_name_title(1)
          ,Fields.InvalidMessage_clean_name_fname(1)
          ,Fields.InvalidMessage_clean_name_mname(1)
          ,Fields.InvalidMessage_clean_name_lname(1)
          ,Fields.InvalidMessage_clean_name_name_suffix(1)
          ,Fields.InvalidMessage_clean_name_name_score(1)
          ,Fields.InvalidMessage_clean_address_prim_range(1)
          ,Fields.InvalidMessage_clean_address_predir(1)
          ,Fields.InvalidMessage_clean_address_prim_name(1)
          ,Fields.InvalidMessage_clean_address_addr_suffix(1)
          ,Fields.InvalidMessage_clean_address_postdir(1)
          ,Fields.InvalidMessage_clean_address_unit_desig(1)
          ,Fields.InvalidMessage_clean_address_sec_range(1)
          ,Fields.InvalidMessage_clean_address_p_city_name(1)
          ,Fields.InvalidMessage_clean_address_v_city_name(1)
          ,Fields.InvalidMessage_clean_address_st(1),Fields.InvalidMessage_clean_address_st(2)
          ,Fields.InvalidMessage_clean_address_zip(1),Fields.InvalidMessage_clean_address_zip(2)
          ,Fields.InvalidMessage_clean_address_zip4(1)
          ,Fields.InvalidMessage_clean_address_cart(1)
          ,Fields.InvalidMessage_clean_address_cr_sort_sz(1)
          ,Fields.InvalidMessage_clean_address_lot(1)
          ,Fields.InvalidMessage_clean_address_lot_order(1)
          ,Fields.InvalidMessage_clean_address_dbpc(1)
          ,Fields.InvalidMessage_clean_address_chk_digit(1)
          ,Fields.InvalidMessage_clean_address_rec_type(1)
          ,Fields.InvalidMessage_clean_address_fips_state(1)
          ,Fields.InvalidMessage_clean_address_fips_county(1)
          ,Fields.InvalidMessage_clean_address_geo_lat(1)
          ,Fields.InvalidMessage_clean_address_geo_long(1)
          ,Fields.InvalidMessage_clean_address_msa(1)
          ,Fields.InvalidMessage_clean_address_geo_blk(1)
          ,Fields.InvalidMessage_clean_address_geo_match(1)
          ,Fields.InvalidMessage_clean_address_err_stat(1)
          ,Fields.InvalidMessage_global_sid(1),Fields.InvalidMessage_global_sid(2)
          ,Fields.InvalidMessage_record_sid(1)
          ,Fields.InvalidMessage_current_rec(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_SalesChannel) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.rid_Invalid := Fields.InValid_rid((SALT311.StrType)le.rid);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.bdid_score_Invalid := Fields.InValid_bdid_score((SALT311.StrType)le.bdid_score);
    SELF.dotid_Invalid := Fields.InValid_dotid((SALT311.StrType)le.dotid);
    SELF.dotscore_Invalid := Fields.InValid_dotscore((SALT311.StrType)le.dotscore);
    SELF.dotweight_Invalid := Fields.InValid_dotweight((SALT311.StrType)le.dotweight);
    SELF.empid_Invalid := Fields.InValid_empid((SALT311.StrType)le.empid);
    SELF.empscore_Invalid := Fields.InValid_empscore((SALT311.StrType)le.empscore);
    SELF.empweight_Invalid := Fields.InValid_empweight((SALT311.StrType)le.empweight);
    SELF.powid_Invalid := Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.powscore_Invalid := Fields.InValid_powscore((SALT311.StrType)le.powscore);
    SELF.powweight_Invalid := Fields.InValid_powweight((SALT311.StrType)le.powweight);
    SELF.proxid_Invalid := Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.proxscore_Invalid := Fields.InValid_proxscore((SALT311.StrType)le.proxscore);
    SELF.proxweight_Invalid := Fields.InValid_proxweight((SALT311.StrType)le.proxweight);
    SELF.seleid_Invalid := Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.selescore_Invalid := Fields.InValid_selescore((SALT311.StrType)le.selescore);
    SELF.seleweight_Invalid := Fields.InValid_seleweight((SALT311.StrType)le.seleweight);
    SELF.orgid_Invalid := Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.orgscore_Invalid := Fields.InValid_orgscore((SALT311.StrType)le.orgscore);
    SELF.orgweight_Invalid := Fields.InValid_orgweight((SALT311.StrType)le.orgweight);
    SELF.ultid_Invalid := Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.ultscore_Invalid := Fields.InValid_ultscore((SALT311.StrType)le.ultscore);
    SELF.ultweight_Invalid := Fields.InValid_ultweight((SALT311.StrType)le.ultweight);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.did_score_Invalid := Fields.InValid_did_score((SALT311.StrType)le.did_score);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT311.StrType)le.rawaid);
    SELF.aceaid_Invalid := Fields.InValid_aceaid((SALT311.StrType)le.aceaid);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.rawfields_row_id_Invalid := Fields.InValid_rawfields_row_id((SALT311.StrType)le.rawfields_row_id);
    SELF.rawfields_company_name_Invalid := Fields.InValid_rawfields_company_name((SALT311.StrType)le.rawfields_company_name);
    SELF.rawfields_web_address_Invalid := Fields.InValid_rawfields_web_address((SALT311.StrType)le.rawfields_web_address);
    SELF.rawfields_prefix_Invalid := Fields.InValid_rawfields_prefix((SALT311.StrType)le.rawfields_prefix);
    SELF.rawfields_contact_name_Invalid := Fields.InValid_rawfields_contact_name((SALT311.StrType)le.rawfields_contact_name);
    SELF.rawfields_first_name_Invalid := Fields.InValid_rawfields_first_name((SALT311.StrType)le.rawfields_first_name);
    SELF.rawfields_middle_name_Invalid := Fields.InValid_rawfields_middle_name((SALT311.StrType)le.rawfields_middle_name);
    SELF.rawfields_last_name_Invalid := Fields.InValid_rawfields_last_name((SALT311.StrType)le.rawfields_last_name);
    SELF.rawfields_title_Invalid := Fields.InValid_rawfields_title((SALT311.StrType)le.rawfields_title);
    SELF.rawfields_address_Invalid := Fields.InValid_rawfields_address((SALT311.StrType)le.rawfields_address);
    SELF.rawfields_address1_Invalid := Fields.InValid_rawfields_address1((SALT311.StrType)le.rawfields_address1);
    SELF.rawfields_city_Invalid := Fields.InValid_rawfields_city((SALT311.StrType)le.rawfields_city);
    SELF.rawfields_state_Invalid := Fields.InValid_rawfields_state((SALT311.StrType)le.rawfields_state);
    SELF.rawfields_zip_code_Invalid := Fields.InValid_rawfields_zip_code((SALT311.StrType)le.rawfields_zip_code);
    SELF.rawfields_country_Invalid := Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country);
    SELF.rawfields_phone_number_Invalid := Fields.InValid_rawfields_phone_number((SALT311.StrType)le.rawfields_phone_number);
    SELF.rawfields_email_Invalid := Fields.InValid_rawfields_email((SALT311.StrType)le.rawfields_email);
    SELF.clean_name_title_Invalid := Fields.InValid_clean_name_title((SALT311.StrType)le.clean_name_title);
    SELF.clean_name_fname_Invalid := Fields.InValid_clean_name_fname((SALT311.StrType)le.clean_name_fname);
    SELF.clean_name_mname_Invalid := Fields.InValid_clean_name_mname((SALT311.StrType)le.clean_name_mname);
    SELF.clean_name_lname_Invalid := Fields.InValid_clean_name_lname((SALT311.StrType)le.clean_name_lname);
    SELF.clean_name_name_suffix_Invalid := Fields.InValid_clean_name_name_suffix((SALT311.StrType)le.clean_name_name_suffix);
    SELF.clean_name_name_score_Invalid := Fields.InValid_clean_name_name_score((SALT311.StrType)le.clean_name_name_score);
    SELF.clean_address_prim_range_Invalid := Fields.InValid_clean_address_prim_range((SALT311.StrType)le.clean_address_prim_range);
    SELF.clean_address_predir_Invalid := Fields.InValid_clean_address_predir((SALT311.StrType)le.clean_address_predir);
    SELF.clean_address_prim_name_Invalid := Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name);
    SELF.clean_address_addr_suffix_Invalid := Fields.InValid_clean_address_addr_suffix((SALT311.StrType)le.clean_address_addr_suffix);
    SELF.clean_address_postdir_Invalid := Fields.InValid_clean_address_postdir((SALT311.StrType)le.clean_address_postdir);
    SELF.clean_address_unit_desig_Invalid := Fields.InValid_clean_address_unit_desig((SALT311.StrType)le.clean_address_unit_desig);
    SELF.clean_address_sec_range_Invalid := Fields.InValid_clean_address_sec_range((SALT311.StrType)le.clean_address_sec_range);
    SELF.clean_address_p_city_name_Invalid := Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name);
    SELF.clean_address_v_city_name_Invalid := Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name);
    SELF.clean_address_st_Invalid := Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st);
    SELF.clean_address_zip_Invalid := Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip);
    SELF.clean_address_zip4_Invalid := Fields.InValid_clean_address_zip4((SALT311.StrType)le.clean_address_zip4);
    SELF.clean_address_cart_Invalid := Fields.InValid_clean_address_cart((SALT311.StrType)le.clean_address_cart);
    SELF.clean_address_cr_sort_sz_Invalid := Fields.InValid_clean_address_cr_sort_sz((SALT311.StrType)le.clean_address_cr_sort_sz);
    SELF.clean_address_lot_Invalid := Fields.InValid_clean_address_lot((SALT311.StrType)le.clean_address_lot);
    SELF.clean_address_lot_order_Invalid := Fields.InValid_clean_address_lot_order((SALT311.StrType)le.clean_address_lot_order);
    SELF.clean_address_dbpc_Invalid := Fields.InValid_clean_address_dbpc((SALT311.StrType)le.clean_address_dbpc);
    SELF.clean_address_chk_digit_Invalid := Fields.InValid_clean_address_chk_digit((SALT311.StrType)le.clean_address_chk_digit);
    SELF.clean_address_rec_type_Invalid := Fields.InValid_clean_address_rec_type((SALT311.StrType)le.clean_address_rec_type);
    SELF.clean_address_fips_state_Invalid := Fields.InValid_clean_address_fips_state((SALT311.StrType)le.clean_address_fips_state);
    SELF.clean_address_fips_county_Invalid := Fields.InValid_clean_address_fips_county((SALT311.StrType)le.clean_address_fips_county);
    SELF.clean_address_geo_lat_Invalid := Fields.InValid_clean_address_geo_lat((SALT311.StrType)le.clean_address_geo_lat);
    SELF.clean_address_geo_long_Invalid := Fields.InValid_clean_address_geo_long((SALT311.StrType)le.clean_address_geo_long);
    SELF.clean_address_msa_Invalid := Fields.InValid_clean_address_msa((SALT311.StrType)le.clean_address_msa);
    SELF.clean_address_geo_blk_Invalid := Fields.InValid_clean_address_geo_blk((SALT311.StrType)le.clean_address_geo_blk);
    SELF.clean_address_geo_match_Invalid := Fields.InValid_clean_address_geo_match((SALT311.StrType)le.clean_address_geo_match);
    SELF.clean_address_err_stat_Invalid := Fields.InValid_clean_address_err_stat((SALT311.StrType)le.clean_address_err_stat);
    SELF.global_sid_Invalid := Fields.InValid_global_sid((SALT311.StrType)le.global_sid);
    SELF.record_sid_Invalid := Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF.current_rec_Invalid := Fields.InValid_current_rec((SALT311.StrType)le.current_rec);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_SalesChannel);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.rid_Invalid << 0 ) + ( le.bdid_Invalid << 1 ) + ( le.bdid_score_Invalid << 2 ) + ( le.dotid_Invalid << 3 ) + ( le.dotscore_Invalid << 4 ) + ( le.dotweight_Invalid << 5 ) + ( le.empid_Invalid << 6 ) + ( le.empscore_Invalid << 7 ) + ( le.empweight_Invalid << 8 ) + ( le.powid_Invalid << 9 ) + ( le.powscore_Invalid << 10 ) + ( le.powweight_Invalid << 11 ) + ( le.proxid_Invalid << 12 ) + ( le.proxscore_Invalid << 13 ) + ( le.proxweight_Invalid << 14 ) + ( le.seleid_Invalid << 15 ) + ( le.selescore_Invalid << 16 ) + ( le.seleweight_Invalid << 17 ) + ( le.orgid_Invalid << 18 ) + ( le.orgscore_Invalid << 19 ) + ( le.orgweight_Invalid << 20 ) + ( le.ultid_Invalid << 21 ) + ( le.ultscore_Invalid << 22 ) + ( le.ultweight_Invalid << 23 ) + ( le.did_Invalid << 24 ) + ( le.did_score_Invalid << 25 ) + ( le.date_first_seen_Invalid << 26 ) + ( le.date_last_seen_Invalid << 27 ) + ( le.date_vendor_first_reported_Invalid << 28 ) + ( le.date_vendor_last_reported_Invalid << 29 ) + ( le.rawaid_Invalid << 30 ) + ( le.aceaid_Invalid << 31 ) + ( le.record_type_Invalid << 32 ) + ( le.rawfields_row_id_Invalid << 33 ) + ( le.rawfields_company_name_Invalid << 34 ) + ( le.rawfields_web_address_Invalid << 35 ) + ( le.rawfields_prefix_Invalid << 36 ) + ( le.rawfields_contact_name_Invalid << 37 ) + ( le.rawfields_first_name_Invalid << 38 ) + ( le.rawfields_middle_name_Invalid << 39 ) + ( le.rawfields_last_name_Invalid << 40 ) + ( le.rawfields_title_Invalid << 41 ) + ( le.rawfields_address_Invalid << 42 ) + ( le.rawfields_address1_Invalid << 43 ) + ( le.rawfields_city_Invalid << 44 ) + ( le.rawfields_state_Invalid << 45 ) + ( le.rawfields_zip_code_Invalid << 47 ) + ( le.rawfields_country_Invalid << 49 ) + ( le.rawfields_phone_number_Invalid << 50 ) + ( le.rawfields_email_Invalid << 51 ) + ( le.clean_name_title_Invalid << 52 ) + ( le.clean_name_fname_Invalid << 53 ) + ( le.clean_name_mname_Invalid << 54 ) + ( le.clean_name_lname_Invalid << 55 ) + ( le.clean_name_name_suffix_Invalid << 56 ) + ( le.clean_name_name_score_Invalid << 57 ) + ( le.clean_address_prim_range_Invalid << 58 ) + ( le.clean_address_predir_Invalid << 59 ) + ( le.clean_address_prim_name_Invalid << 60 ) + ( le.clean_address_addr_suffix_Invalid << 61 ) + ( le.clean_address_postdir_Invalid << 62 ) + ( le.clean_address_unit_desig_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.clean_address_sec_range_Invalid << 0 ) + ( le.clean_address_p_city_name_Invalid << 1 ) + ( le.clean_address_v_city_name_Invalid << 2 ) + ( le.clean_address_st_Invalid << 3 ) + ( le.clean_address_zip_Invalid << 5 ) + ( le.clean_address_zip4_Invalid << 7 ) + ( le.clean_address_cart_Invalid << 8 ) + ( le.clean_address_cr_sort_sz_Invalid << 9 ) + ( le.clean_address_lot_Invalid << 10 ) + ( le.clean_address_lot_order_Invalid << 11 ) + ( le.clean_address_dbpc_Invalid << 12 ) + ( le.clean_address_chk_digit_Invalid << 13 ) + ( le.clean_address_rec_type_Invalid << 14 ) + ( le.clean_address_fips_state_Invalid << 15 ) + ( le.clean_address_fips_county_Invalid << 16 ) + ( le.clean_address_geo_lat_Invalid << 17 ) + ( le.clean_address_geo_long_Invalid << 18 ) + ( le.clean_address_msa_Invalid << 19 ) + ( le.clean_address_geo_blk_Invalid << 20 ) + ( le.clean_address_geo_match_Invalid << 21 ) + ( le.clean_address_err_stat_Invalid << 22 ) + ( le.global_sid_Invalid << 23 ) + ( le.record_sid_Invalid << 25 ) + ( le.current_rec_Invalid << 26 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Layout_SalesChannel);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.rid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.rawaid_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.aceaid_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.rawfields_row_id_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.rawfields_company_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.rawfields_web_address_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.rawfields_prefix_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.rawfields_contact_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.rawfields_first_name_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.rawfields_middle_name_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.rawfields_last_name_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.rawfields_title_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.rawfields_address_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.rawfields_address1_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.rawfields_city_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.rawfields_state_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.rawfields_zip_code_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.rawfields_country_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.rawfields_phone_number_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.rawfields_email_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_name_title_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_name_fname_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.clean_name_mname_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.clean_name_lname_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.clean_name_name_suffix_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.clean_name_name_score_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.clean_address_prim_range_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.clean_address_predir_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.clean_address_prim_name_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.clean_address_addr_suffix_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.clean_address_postdir_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.clean_address_unit_desig_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.clean_address_sec_range_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.clean_address_p_city_name_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.clean_address_v_city_name_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.clean_address_st_Invalid := (le.ScrubsBits2 >> 3) & 3;
    SELF.clean_address_zip_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.clean_address_zip4_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.clean_address_cart_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.clean_address_cr_sort_sz_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.clean_address_lot_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.clean_address_lot_order_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.clean_address_dbpc_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.clean_address_chk_digit_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.clean_address_rec_type_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.clean_address_fips_state_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.clean_address_fips_county_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.clean_address_geo_lat_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.clean_address_geo_long_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.clean_address_msa_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.clean_address_geo_blk_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.clean_address_geo_match_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.clean_address_err_stat_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.global_sid_Invalid := (le.ScrubsBits2 >> 23) & 3;
    SELF.record_sid_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.current_rec_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    rid_ALLOW_ErrorCount := COUNT(GROUP,h.rid_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    dotid_ALLOW_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ALLOW_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ALLOW_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ALLOW_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ALLOW_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ALLOW_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_ALLOW_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_ALLOW_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_ALLOW_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_ALLOW_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_ALLOW_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_ALLOW_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_ALLOW_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_ALLOW_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_ALLOW_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_ALLOW_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_ALLOW_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_ALLOW_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    aceaid_ALLOW_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    rawfields_row_id_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_row_id_Invalid=1);
    rawfields_company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_company_name_Invalid=1);
    rawfields_web_address_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_web_address_Invalid=1);
    rawfields_prefix_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_prefix_Invalid=1);
    rawfields_contact_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_contact_name_Invalid=1);
    rawfields_first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_first_name_Invalid=1);
    rawfields_middle_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_middle_name_Invalid=1);
    rawfields_last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_last_name_Invalid=1);
    rawfields_title_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_title_Invalid=1);
    rawfields_address_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_address_Invalid=1);
    rawfields_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_address1_Invalid=1);
    rawfields_city_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_city_Invalid=1);
    rawfields_state_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid=1);
    rawfields_state_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid=2);
    rawfields_state_Total_ErrorCount := COUNT(GROUP,h.rawfields_state_Invalid>0);
    rawfields_zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_zip_code_Invalid=1);
    rawfields_zip_code_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_zip_code_Invalid=2);
    rawfields_zip_code_Total_ErrorCount := COUNT(GROUP,h.rawfields_zip_code_Invalid>0);
    rawfields_country_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_country_Invalid=1);
    rawfields_phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_phone_number_Invalid=1);
    rawfields_email_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_email_Invalid=1);
    clean_name_title_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_title_Invalid=1);
    clean_name_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_fname_Invalid=1);
    clean_name_mname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_mname_Invalid=1);
    clean_name_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_lname_Invalid=1);
    clean_name_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_name_suffix_Invalid=1);
    clean_name_name_score_ALLOW_ErrorCount := COUNT(GROUP,h.clean_name_name_score_Invalid=1);
    clean_address_prim_range_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_prim_range_Invalid=1);
    clean_address_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_predir_Invalid=1);
    clean_address_prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_address_prim_name_Invalid=1);
    clean_address_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_addr_suffix_Invalid=1);
    clean_address_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_postdir_Invalid=1);
    clean_address_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_unit_desig_Invalid=1);
    clean_address_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_sec_range_Invalid=1);
    clean_address_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_p_city_name_Invalid=1);
    clean_address_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_v_city_name_Invalid=1);
    clean_address_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid=1);
    clean_address_st_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid=2);
    clean_address_st_Total_ErrorCount := COUNT(GROUP,h.clean_address_st_Invalid>0);
    clean_address_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid=1);
    clean_address_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid=2);
    clean_address_zip_Total_ErrorCount := COUNT(GROUP,h.clean_address_zip_Invalid>0);
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
    clean_address_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_lat_Invalid=1);
    clean_address_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_long_Invalid=1);
    clean_address_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_msa_Invalid=1);
    clean_address_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_blk_Invalid=1);
    clean_address_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_geo_match_Invalid=1);
    clean_address_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_address_err_stat_Invalid=1);
    global_sid_ALLOW_ErrorCount := COUNT(GROUP,h.global_sid_Invalid=1);
    global_sid_LENGTHS_ErrorCount := COUNT(GROUP,h.global_sid_Invalid=2);
    global_sid_Total_ErrorCount := COUNT(GROUP,h.global_sid_Invalid>0);
    record_sid_ALLOW_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    current_rec_ALLOW_ErrorCount := COUNT(GROUP,h.current_rec_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.rid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.bdid_score_Invalid > 0 OR h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.rawaid_Invalid > 0 OR h.aceaid_Invalid > 0 OR h.record_type_Invalid > 0 OR h.rawfields_row_id_Invalid > 0 OR h.rawfields_company_name_Invalid > 0 OR h.rawfields_web_address_Invalid > 0 OR h.rawfields_prefix_Invalid > 0 OR h.rawfields_contact_name_Invalid > 0 OR h.rawfields_first_name_Invalid > 0 OR h.rawfields_middle_name_Invalid > 0 OR h.rawfields_last_name_Invalid > 0 OR h.rawfields_title_Invalid > 0 OR h.rawfields_address_Invalid > 0 OR h.rawfields_address1_Invalid > 0 OR h.rawfields_city_Invalid > 0 OR h.rawfields_state_Invalid > 0 OR h.rawfields_zip_code_Invalid > 0 OR h.rawfields_country_Invalid > 0 OR h.rawfields_phone_number_Invalid > 0 OR h.rawfields_email_Invalid > 0 OR h.clean_name_title_Invalid > 0 OR h.clean_name_fname_Invalid > 0 OR h.clean_name_mname_Invalid > 0 OR h.clean_name_lname_Invalid > 0 OR h.clean_name_name_suffix_Invalid > 0 OR h.clean_name_name_score_Invalid > 0 OR h.clean_address_prim_range_Invalid > 0 OR h.clean_address_predir_Invalid > 0 OR h.clean_address_prim_name_Invalid > 0 OR h.clean_address_addr_suffix_Invalid > 0 OR h.clean_address_postdir_Invalid > 0 OR h.clean_address_unit_desig_Invalid > 0 OR h.clean_address_sec_range_Invalid > 0 OR h.clean_address_p_city_name_Invalid > 0 OR h.clean_address_v_city_name_Invalid > 0 OR h.clean_address_st_Invalid > 0 OR h.clean_address_zip_Invalid > 0 OR h.clean_address_zip4_Invalid > 0 OR h.clean_address_cart_Invalid > 0 OR h.clean_address_cr_sort_sz_Invalid > 0 OR h.clean_address_lot_Invalid > 0 OR h.clean_address_lot_order_Invalid > 0 OR h.clean_address_dbpc_Invalid > 0 OR h.clean_address_chk_digit_Invalid > 0 OR h.clean_address_rec_type_Invalid > 0 OR h.clean_address_fips_state_Invalid > 0 OR h.clean_address_fips_county_Invalid > 0 OR h.clean_address_geo_lat_Invalid > 0 OR h.clean_address_geo_long_Invalid > 0 OR h.clean_address_msa_Invalid > 0 OR h.clean_address_geo_blk_Invalid > 0 OR h.clean_address_geo_match_Invalid > 0 OR h.clean_address_err_stat_Invalid > 0 OR h.global_sid_Invalid > 0 OR h.record_sid_Invalid > 0 OR h.current_rec_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.rid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selescore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aceaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_row_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_web_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_prefix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_contact_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_middle_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_Total_ErrorCount > 0, 1, 0) + IF(le.rawfields_zip_code_Total_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_Total_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_Total_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_Total_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_rec_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.rid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dotweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.empweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.powweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proxweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selescore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seleweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orgweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultscore_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ultweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aceaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_row_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_web_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_prefix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_contact_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_middle_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_zip_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_name_name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.global_sid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.record_sid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_rec_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.rid_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.did_Invalid,le.did_score_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.record_type_Invalid,le.rawfields_row_id_Invalid,le.rawfields_company_name_Invalid,le.rawfields_web_address_Invalid,le.rawfields_prefix_Invalid,le.rawfields_contact_name_Invalid,le.rawfields_first_name_Invalid,le.rawfields_middle_name_Invalid,le.rawfields_last_name_Invalid,le.rawfields_title_Invalid,le.rawfields_address_Invalid,le.rawfields_address1_Invalid,le.rawfields_city_Invalid,le.rawfields_state_Invalid,le.rawfields_zip_code_Invalid,le.rawfields_country_Invalid,le.rawfields_phone_number_Invalid,le.rawfields_email_Invalid,le.clean_name_title_Invalid,le.clean_name_fname_Invalid,le.clean_name_mname_Invalid,le.clean_name_lname_Invalid,le.clean_name_name_suffix_Invalid,le.clean_name_name_score_Invalid,le.clean_address_prim_range_Invalid,le.clean_address_predir_Invalid,le.clean_address_prim_name_Invalid,le.clean_address_addr_suffix_Invalid,le.clean_address_postdir_Invalid,le.clean_address_unit_desig_Invalid,le.clean_address_sec_range_Invalid,le.clean_address_p_city_name_Invalid,le.clean_address_v_city_name_Invalid,le.clean_address_st_Invalid,le.clean_address_zip_Invalid,le.clean_address_zip4_Invalid,le.clean_address_cart_Invalid,le.clean_address_cr_sort_sz_Invalid,le.clean_address_lot_Invalid,le.clean_address_lot_order_Invalid,le.clean_address_dbpc_Invalid,le.clean_address_chk_digit_Invalid,le.clean_address_rec_type_Invalid,le.clean_address_fips_state_Invalid,le.clean_address_fips_county_Invalid,le.clean_address_geo_lat_Invalid,le.clean_address_geo_long_Invalid,le.clean_address_msa_Invalid,le.clean_address_geo_blk_Invalid,le.clean_address_geo_match_Invalid,le.clean_address_err_stat_Invalid,le.global_sid_Invalid,le.record_sid_Invalid,le.current_rec_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_rid(le.rid_Invalid),Fields.InvalidMessage_bdid(le.bdid_Invalid),Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),Fields.InvalidMessage_dotid(le.dotid_Invalid),Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Fields.InvalidMessage_empid(le.empid_Invalid),Fields.InvalidMessage_empscore(le.empscore_Invalid),Fields.InvalidMessage_empweight(le.empweight_Invalid),Fields.InvalidMessage_powid(le.powid_Invalid),Fields.InvalidMessage_powscore(le.powscore_Invalid),Fields.InvalidMessage_powweight(le.powweight_Invalid),Fields.InvalidMessage_proxid(le.proxid_Invalid),Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Fields.InvalidMessage_seleid(le.seleid_Invalid),Fields.InvalidMessage_selescore(le.selescore_Invalid),Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Fields.InvalidMessage_orgid(le.orgid_Invalid),Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Fields.InvalidMessage_ultid(le.ultid_Invalid),Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Fields.InvalidMessage_ultweight(le.ultweight_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score(le.did_score_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_aceaid(le.aceaid_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_rawfields_row_id(le.rawfields_row_id_Invalid),Fields.InvalidMessage_rawfields_company_name(le.rawfields_company_name_Invalid),Fields.InvalidMessage_rawfields_web_address(le.rawfields_web_address_Invalid),Fields.InvalidMessage_rawfields_prefix(le.rawfields_prefix_Invalid),Fields.InvalidMessage_rawfields_contact_name(le.rawfields_contact_name_Invalid),Fields.InvalidMessage_rawfields_first_name(le.rawfields_first_name_Invalid),Fields.InvalidMessage_rawfields_middle_name(le.rawfields_middle_name_Invalid),Fields.InvalidMessage_rawfields_last_name(le.rawfields_last_name_Invalid),Fields.InvalidMessage_rawfields_title(le.rawfields_title_Invalid),Fields.InvalidMessage_rawfields_address(le.rawfields_address_Invalid),Fields.InvalidMessage_rawfields_address1(le.rawfields_address1_Invalid),Fields.InvalidMessage_rawfields_city(le.rawfields_city_Invalid),Fields.InvalidMessage_rawfields_state(le.rawfields_state_Invalid),Fields.InvalidMessage_rawfields_zip_code(le.rawfields_zip_code_Invalid),Fields.InvalidMessage_rawfields_country(le.rawfields_country_Invalid),Fields.InvalidMessage_rawfields_phone_number(le.rawfields_phone_number_Invalid),Fields.InvalidMessage_rawfields_email(le.rawfields_email_Invalid),Fields.InvalidMessage_clean_name_title(le.clean_name_title_Invalid),Fields.InvalidMessage_clean_name_fname(le.clean_name_fname_Invalid),Fields.InvalidMessage_clean_name_mname(le.clean_name_mname_Invalid),Fields.InvalidMessage_clean_name_lname(le.clean_name_lname_Invalid),Fields.InvalidMessage_clean_name_name_suffix(le.clean_name_name_suffix_Invalid),Fields.InvalidMessage_clean_name_name_score(le.clean_name_name_score_Invalid),Fields.InvalidMessage_clean_address_prim_range(le.clean_address_prim_range_Invalid),Fields.InvalidMessage_clean_address_predir(le.clean_address_predir_Invalid),Fields.InvalidMessage_clean_address_prim_name(le.clean_address_prim_name_Invalid),Fields.InvalidMessage_clean_address_addr_suffix(le.clean_address_addr_suffix_Invalid),Fields.InvalidMessage_clean_address_postdir(le.clean_address_postdir_Invalid),Fields.InvalidMessage_clean_address_unit_desig(le.clean_address_unit_desig_Invalid),Fields.InvalidMessage_clean_address_sec_range(le.clean_address_sec_range_Invalid),Fields.InvalidMessage_clean_address_p_city_name(le.clean_address_p_city_name_Invalid),Fields.InvalidMessage_clean_address_v_city_name(le.clean_address_v_city_name_Invalid),Fields.InvalidMessage_clean_address_st(le.clean_address_st_Invalid),Fields.InvalidMessage_clean_address_zip(le.clean_address_zip_Invalid),Fields.InvalidMessage_clean_address_zip4(le.clean_address_zip4_Invalid),Fields.InvalidMessage_clean_address_cart(le.clean_address_cart_Invalid),Fields.InvalidMessage_clean_address_cr_sort_sz(le.clean_address_cr_sort_sz_Invalid),Fields.InvalidMessage_clean_address_lot(le.clean_address_lot_Invalid),Fields.InvalidMessage_clean_address_lot_order(le.clean_address_lot_order_Invalid),Fields.InvalidMessage_clean_address_dbpc(le.clean_address_dbpc_Invalid),Fields.InvalidMessage_clean_address_chk_digit(le.clean_address_chk_digit_Invalid),Fields.InvalidMessage_clean_address_rec_type(le.clean_address_rec_type_Invalid),Fields.InvalidMessage_clean_address_fips_state(le.clean_address_fips_state_Invalid),Fields.InvalidMessage_clean_address_fips_county(le.clean_address_fips_county_Invalid),Fields.InvalidMessage_clean_address_geo_lat(le.clean_address_geo_lat_Invalid),Fields.InvalidMessage_clean_address_geo_long(le.clean_address_geo_long_Invalid),Fields.InvalidMessage_clean_address_msa(le.clean_address_msa_Invalid),Fields.InvalidMessage_clean_address_geo_blk(le.clean_address_geo_blk_Invalid),Fields.InvalidMessage_clean_address_geo_match(le.clean_address_geo_match_Invalid),Fields.InvalidMessage_clean_address_err_stat(le.clean_address_err_stat_Invalid),Fields.InvalidMessage_global_sid(le.global_sid_Invalid),Fields.InvalidMessage_record_sid(le.record_sid_Invalid),Fields.InvalidMessage_current_rec(le.current_rec_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.rid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aceaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_row_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_web_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_prefix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_contact_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_middle_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_zip_code_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_email_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_name_name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_address_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_address_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
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
          ,CHOOSE(le.clean_address_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_address_err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.global_sid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.record_sid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.current_rec_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'rid','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rawaid','aceaid','record_type','rawfields_row_id','rawfields_company_name','rawfields_web_address','rawfields_prefix','rawfields_contact_name','rawfields_first_name','rawfields_middle_name','rawfields_last_name','rawfields_title','rawfields_address','rawfields_address1','rawfields_city','rawfields_state','rawfields_zip_code','rawfields_country','rawfields_phone_number','rawfields_email','clean_name_title','clean_name_fname','clean_name_mname','clean_name_lname','clean_name_name_suffix','clean_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','global_sid','record_sid','current_rec','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_AlphaChars','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_PrintableChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_Float','Invalid_PrintableChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_PrintableChar','Invalid_Alpha','Invalid_PrintableChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChars','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Zip','Invalid_No','Invalid_No','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.rid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.bdid_score,(SALT311.StrType)le.dotid,(SALT311.StrType)le.dotscore,(SALT311.StrType)le.dotweight,(SALT311.StrType)le.empid,(SALT311.StrType)le.empscore,(SALT311.StrType)le.empweight,(SALT311.StrType)le.powid,(SALT311.StrType)le.powscore,(SALT311.StrType)le.powweight,(SALT311.StrType)le.proxid,(SALT311.StrType)le.proxscore,(SALT311.StrType)le.proxweight,(SALT311.StrType)le.seleid,(SALT311.StrType)le.selescore,(SALT311.StrType)le.seleweight,(SALT311.StrType)le.orgid,(SALT311.StrType)le.orgscore,(SALT311.StrType)le.orgweight,(SALT311.StrType)le.ultid,(SALT311.StrType)le.ultscore,(SALT311.StrType)le.ultweight,(SALT311.StrType)le.did,(SALT311.StrType)le.did_score,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.aceaid,(SALT311.StrType)le.record_type,(SALT311.StrType)le.rawfields_row_id,(SALT311.StrType)le.rawfields_company_name,(SALT311.StrType)le.rawfields_web_address,(SALT311.StrType)le.rawfields_prefix,(SALT311.StrType)le.rawfields_contact_name,(SALT311.StrType)le.rawfields_first_name,(SALT311.StrType)le.rawfields_middle_name,(SALT311.StrType)le.rawfields_last_name,(SALT311.StrType)le.rawfields_title,(SALT311.StrType)le.rawfields_address,(SALT311.StrType)le.rawfields_address1,(SALT311.StrType)le.rawfields_city,(SALT311.StrType)le.rawfields_state,(SALT311.StrType)le.rawfields_zip_code,(SALT311.StrType)le.rawfields_country,(SALT311.StrType)le.rawfields_phone_number,(SALT311.StrType)le.rawfields_email,(SALT311.StrType)le.clean_name_title,(SALT311.StrType)le.clean_name_fname,(SALT311.StrType)le.clean_name_mname,(SALT311.StrType)le.clean_name_lname,(SALT311.StrType)le.clean_name_name_suffix,(SALT311.StrType)le.clean_name_name_score,(SALT311.StrType)le.clean_address_prim_range,(SALT311.StrType)le.clean_address_predir,(SALT311.StrType)le.clean_address_prim_name,(SALT311.StrType)le.clean_address_addr_suffix,(SALT311.StrType)le.clean_address_postdir,(SALT311.StrType)le.clean_address_unit_desig,(SALT311.StrType)le.clean_address_sec_range,(SALT311.StrType)le.clean_address_p_city_name,(SALT311.StrType)le.clean_address_v_city_name,(SALT311.StrType)le.clean_address_st,(SALT311.StrType)le.clean_address_zip,(SALT311.StrType)le.clean_address_zip4,(SALT311.StrType)le.clean_address_cart,(SALT311.StrType)le.clean_address_cr_sort_sz,(SALT311.StrType)le.clean_address_lot,(SALT311.StrType)le.clean_address_lot_order,(SALT311.StrType)le.clean_address_dbpc,(SALT311.StrType)le.clean_address_chk_digit,(SALT311.StrType)le.clean_address_rec_type,(SALT311.StrType)le.clean_address_fips_state,(SALT311.StrType)le.clean_address_fips_county,(SALT311.StrType)le.clean_address_geo_lat,(SALT311.StrType)le.clean_address_geo_long,(SALT311.StrType)le.clean_address_msa,(SALT311.StrType)le.clean_address_geo_blk,(SALT311.StrType)le.clean_address_geo_match,(SALT311.StrType)le.clean_address_err_stat,(SALT311.StrType)le.global_sid,(SALT311.StrType)le.record_sid,(SALT311.StrType)le.current_rec,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,86,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_SalesChannel) prevDS = DATASET([], Layout_SalesChannel), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.rid_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount
          ,le.aceaid_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_row_id_ALLOW_ErrorCount
          ,le.rawfields_company_name_CUSTOM_ErrorCount
          ,le.rawfields_web_address_CUSTOM_ErrorCount
          ,le.rawfields_prefix_ALLOW_ErrorCount
          ,le.rawfields_contact_name_CUSTOM_ErrorCount
          ,le.rawfields_first_name_CUSTOM_ErrorCount
          ,le.rawfields_middle_name_CUSTOM_ErrorCount
          ,le.rawfields_last_name_CUSTOM_ErrorCount
          ,le.rawfields_title_CUSTOM_ErrorCount
          ,le.rawfields_address_CUSTOM_ErrorCount
          ,le.rawfields_address1_CUSTOM_ErrorCount
          ,le.rawfields_city_ALLOW_ErrorCount
          ,le.rawfields_state_ALLOW_ErrorCount,le.rawfields_state_LENGTHS_ErrorCount
          ,le.rawfields_zip_code_ALLOW_ErrorCount,le.rawfields_zip_code_LENGTHS_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_phone_number_ALLOW_ErrorCount
          ,le.rawfields_email_CUSTOM_ErrorCount
          ,le.clean_name_title_ALLOW_ErrorCount
          ,le.clean_name_fname_ALLOW_ErrorCount
          ,le.clean_name_mname_ALLOW_ErrorCount
          ,le.clean_name_lname_ALLOW_ErrorCount
          ,le.clean_name_name_suffix_ALLOW_ErrorCount
          ,le.clean_name_name_score_ALLOW_ErrorCount
          ,le.clean_address_prim_range_CUSTOM_ErrorCount
          ,le.clean_address_predir_ALLOW_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_address_postdir_ALLOW_ErrorCount
          ,le.clean_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_address_sec_range_ALLOW_ErrorCount
          ,le.clean_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_address_st_ALLOW_ErrorCount,le.clean_address_st_LENGTHS_ErrorCount
          ,le.clean_address_zip_ALLOW_ErrorCount,le.clean_address_zip_LENGTHS_ErrorCount
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
          ,le.clean_address_geo_lat_ALLOW_ErrorCount
          ,le.clean_address_geo_long_ALLOW_ErrorCount
          ,le.clean_address_msa_ALLOW_ErrorCount
          ,le.clean_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_address_geo_match_ALLOW_ErrorCount
          ,le.clean_address_err_stat_ALLOW_ErrorCount
          ,le.global_sid_ALLOW_ErrorCount,le.global_sid_LENGTHS_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount
          ,le.current_rec_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.rid_ALLOW_ErrorCount
          ,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_ALLOW_ErrorCount
          ,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_ALLOW_ErrorCount
          ,le.empid_ALLOW_ErrorCount
          ,le.empscore_ALLOW_ErrorCount
          ,le.empweight_ALLOW_ErrorCount
          ,le.powid_ALLOW_ErrorCount
          ,le.powscore_ALLOW_ErrorCount
          ,le.powweight_ALLOW_ErrorCount
          ,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_ALLOW_ErrorCount
          ,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount
          ,le.aceaid_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_row_id_ALLOW_ErrorCount
          ,le.rawfields_company_name_CUSTOM_ErrorCount
          ,le.rawfields_web_address_CUSTOM_ErrorCount
          ,le.rawfields_prefix_ALLOW_ErrorCount
          ,le.rawfields_contact_name_CUSTOM_ErrorCount
          ,le.rawfields_first_name_CUSTOM_ErrorCount
          ,le.rawfields_middle_name_CUSTOM_ErrorCount
          ,le.rawfields_last_name_CUSTOM_ErrorCount
          ,le.rawfields_title_CUSTOM_ErrorCount
          ,le.rawfields_address_CUSTOM_ErrorCount
          ,le.rawfields_address1_CUSTOM_ErrorCount
          ,le.rawfields_city_ALLOW_ErrorCount
          ,le.rawfields_state_ALLOW_ErrorCount,le.rawfields_state_LENGTHS_ErrorCount
          ,le.rawfields_zip_code_ALLOW_ErrorCount,le.rawfields_zip_code_LENGTHS_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_phone_number_ALLOW_ErrorCount
          ,le.rawfields_email_CUSTOM_ErrorCount
          ,le.clean_name_title_ALLOW_ErrorCount
          ,le.clean_name_fname_ALLOW_ErrorCount
          ,le.clean_name_mname_ALLOW_ErrorCount
          ,le.clean_name_lname_ALLOW_ErrorCount
          ,le.clean_name_name_suffix_ALLOW_ErrorCount
          ,le.clean_name_name_score_ALLOW_ErrorCount
          ,le.clean_address_prim_range_CUSTOM_ErrorCount
          ,le.clean_address_predir_ALLOW_ErrorCount
          ,le.clean_address_prim_name_CUSTOM_ErrorCount
          ,le.clean_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_address_postdir_ALLOW_ErrorCount
          ,le.clean_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_address_sec_range_ALLOW_ErrorCount
          ,le.clean_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_address_st_ALLOW_ErrorCount,le.clean_address_st_LENGTHS_ErrorCount
          ,le.clean_address_zip_ALLOW_ErrorCount,le.clean_address_zip_LENGTHS_ErrorCount
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
          ,le.clean_address_geo_lat_ALLOW_ErrorCount
          ,le.clean_address_geo_long_ALLOW_ErrorCount
          ,le.clean_address_msa_ALLOW_ErrorCount
          ,le.clean_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_address_geo_match_ALLOW_ErrorCount
          ,le.clean_address_err_stat_ALLOW_ErrorCount
          ,le.global_sid_ALLOW_ErrorCount,le.global_sid_LENGTHS_ErrorCount
          ,le.record_sid_ALLOW_ErrorCount
          ,le.current_rec_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_SalesChannel));
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
          ,'rid:' + getFieldTypeText(h.rid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aceaid:' + getFieldTypeText(h.aceaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_row_id:' + getFieldTypeText(h.rawfields_row_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_company_name:' + getFieldTypeText(h.rawfields_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_web_address:' + getFieldTypeText(h.rawfields_web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_prefix:' + getFieldTypeText(h.rawfields_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_contact_name:' + getFieldTypeText(h.rawfields_contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_first_name:' + getFieldTypeText(h.rawfields_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_middle_name:' + getFieldTypeText(h.rawfields_middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_last_name:' + getFieldTypeText(h.rawfields_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_title:' + getFieldTypeText(h.rawfields_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_address:' + getFieldTypeText(h.rawfields_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_address1:' + getFieldTypeText(h.rawfields_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_city:' + getFieldTypeText(h.rawfields_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_state:' + getFieldTypeText(h.rawfields_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_zip_code:' + getFieldTypeText(h.rawfields_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_country:' + getFieldTypeText(h.rawfields_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_phone_number:' + getFieldTypeText(h.rawfields_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_email:' + getFieldTypeText(h.rawfields_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_title:' + getFieldTypeText(h.clean_name_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_fname:' + getFieldTypeText(h.clean_name_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_mname:' + getFieldTypeText(h.clean_name_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_lname:' + getFieldTypeText(h.clean_name_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_name_suffix:' + getFieldTypeText(h.clean_name_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_name_score:' + getFieldTypeText(h.clean_name_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_rec:' + getFieldTypeText(h.current_rec) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_rid_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
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
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_aceaid_cnt
          ,le.populated_record_type_cnt
          ,le.populated_rawfields_row_id_cnt
          ,le.populated_rawfields_company_name_cnt
          ,le.populated_rawfields_web_address_cnt
          ,le.populated_rawfields_prefix_cnt
          ,le.populated_rawfields_contact_name_cnt
          ,le.populated_rawfields_first_name_cnt
          ,le.populated_rawfields_middle_name_cnt
          ,le.populated_rawfields_last_name_cnt
          ,le.populated_rawfields_title_cnt
          ,le.populated_rawfields_address_cnt
          ,le.populated_rawfields_address1_cnt
          ,le.populated_rawfields_city_cnt
          ,le.populated_rawfields_state_cnt
          ,le.populated_rawfields_zip_code_cnt
          ,le.populated_rawfields_country_cnt
          ,le.populated_rawfields_phone_number_cnt
          ,le.populated_rawfields_email_cnt
          ,le.populated_clean_name_title_cnt
          ,le.populated_clean_name_fname_cnt
          ,le.populated_clean_name_mname_cnt
          ,le.populated_clean_name_lname_cnt
          ,le.populated_clean_name_name_suffix_cnt
          ,le.populated_clean_name_name_score_cnt
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
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt
          ,le.populated_current_rec_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_rid_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
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
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_aceaid_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_rawfields_row_id_pcnt
          ,le.populated_rawfields_company_name_pcnt
          ,le.populated_rawfields_web_address_pcnt
          ,le.populated_rawfields_prefix_pcnt
          ,le.populated_rawfields_contact_name_pcnt
          ,le.populated_rawfields_first_name_pcnt
          ,le.populated_rawfields_middle_name_pcnt
          ,le.populated_rawfields_last_name_pcnt
          ,le.populated_rawfields_title_pcnt
          ,le.populated_rawfields_address_pcnt
          ,le.populated_rawfields_address1_pcnt
          ,le.populated_rawfields_city_pcnt
          ,le.populated_rawfields_state_pcnt
          ,le.populated_rawfields_zip_code_pcnt
          ,le.populated_rawfields_country_pcnt
          ,le.populated_rawfields_phone_number_pcnt
          ,le.populated_rawfields_email_pcnt
          ,le.populated_clean_name_title_pcnt
          ,le.populated_clean_name_fname_pcnt
          ,le.populated_clean_name_mname_pcnt
          ,le.populated_clean_name_lname_pcnt
          ,le.populated_clean_name_name_suffix_pcnt
          ,le.populated_clean_name_name_score_pcnt
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
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt
          ,le.populated_current_rec_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,86,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_SalesChannel));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),86,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_SalesChannel) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SalesChannel, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
