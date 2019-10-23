IMPORT SALT311;
IMPORT Scrubs_BIPV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Ingest_Fields := MODULE
 
EXPORT NumFields := 127;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_mandatory_numeric','invalid_empty','invalid_boolean','invalid_boolean_1','invalid_numeric','invalid_percentage','invalid_pastdate8','invalid_opt_pastdate8','invalid_source','invalid_dt_first_seen','invalid_dt_vendor_first_reported','invalid_company_name_type_raw','invalid_company_rawaid','invalid_direction','invalid_company_address_p_city_name','invalid_company_address_v_city_name','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_company_address_type_raw','invalid_company_fein','invalid_best_fein_indicator','invalid_company_phone','invalid_phone_type','invalid_company_org_structure_raw','invalid_sic','invalid_naics','invalid_company_ticker','invalid_company_ticker_exchange','invalid_company_foreign_domestic','invalid_company_url','invalid_company_inc_state','invalid_company_name_status_raw','invalid_company_status_raw','invalid_duns_number','invalid_is_contact','invalid_contact_did','invalid_contact_name_fname','invalid_contact_name_lname','invalid_contact_type_raw','invalid_contact_job_title_raw','invalid_contact_ssn','invalid_contact_dob','invalid_contact_status_raw','invalid_contact_phone','invalid_company_name_type_derived','invalid_company_address_type_derived','invalid_company_org_structure_derived','invalid_company_name_status_derived','invalid_company_status_derived','invalid_contact_type_derived','invalid_contact_job_title_derived','invalid_contact_status_derived');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_mandatory_numeric' => 2,'invalid_empty' => 3,'invalid_boolean' => 4,'invalid_boolean_1' => 5,'invalid_numeric' => 6,'invalid_percentage' => 7,'invalid_pastdate8' => 8,'invalid_opt_pastdate8' => 9,'invalid_source' => 10,'invalid_dt_first_seen' => 11,'invalid_dt_vendor_first_reported' => 12,'invalid_company_name_type_raw' => 13,'invalid_company_rawaid' => 14,'invalid_direction' => 15,'invalid_company_address_p_city_name' => 16,'invalid_company_address_v_city_name' => 17,'invalid_st' => 18,'invalid_zip5' => 19,'invalid_zip4' => 20,'invalid_cart' => 21,'invalid_cr_sort_sz' => 22,'invalid_lot' => 23,'invalid_lot_order' => 24,'invalid_dpbc' => 25,'invalid_chk_digit' => 26,'invalid_rec_type' => 27,'invalid_fips_state' => 28,'invalid_fips_county' => 29,'invalid_geo' => 30,'invalid_msa' => 31,'invalid_geo_blk' => 32,'invalid_geo_match' => 33,'invalid_err_stat' => 34,'invalid_company_address_type_raw' => 35,'invalid_company_fein' => 36,'invalid_best_fein_indicator' => 37,'invalid_company_phone' => 38,'invalid_phone_type' => 39,'invalid_company_org_structure_raw' => 40,'invalid_sic' => 41,'invalid_naics' => 42,'invalid_company_ticker' => 43,'invalid_company_ticker_exchange' => 44,'invalid_company_foreign_domestic' => 45,'invalid_company_url' => 46,'invalid_company_inc_state' => 47,'invalid_company_name_status_raw' => 48,'invalid_company_status_raw' => 49,'invalid_duns_number' => 50,'invalid_is_contact' => 51,'invalid_contact_did' => 52,'invalid_contact_name_fname' => 53,'invalid_contact_name_lname' => 54,'invalid_contact_type_raw' => 55,'invalid_contact_job_title_raw' => 56,'invalid_contact_ssn' => 57,'invalid_contact_dob' => 58,'invalid_contact_status_raw' => 59,'invalid_contact_phone' => 60,'invalid_company_name_type_derived' => 61,'invalid_company_address_type_derived' => 62,'invalid_company_org_structure_derived' => 63,'invalid_company_name_status_derived' => 64,'invalid_company_status_derived' => 65,'invalid_contact_type_derived' => 66,'invalid_contact_job_title_derived' => 67,'invalid_contact_status_derived' => 68,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory_numeric(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_mandatory_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_1(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_1(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','']);
EXPORT InValidMessageFT_invalid_boolean_1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_range_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_opt_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_opt_pastdate8(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_opt_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_source(s)>0);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_source'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_first_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT311.StrType s,SALT311.StrType dt_last_seen) := WHICH(~Scrubs_BIPV2.Functions.fn_is_valid_opt_earlier_date(s,dt_last_seen)>0);
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_is_valid_opt_earlier_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_vendor_first_reported(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_vendor_first_reported(SALT311.StrType s,SALT311.StrType dt_vendor_last_reported) := WHICH(~Scrubs_BIPV2.Functions.fn_is_valid_earlier_date(s,dt_vendor_last_reported)>0);
EXPORT InValidMessageFT_invalid_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_is_valid_earlier_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name_type_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name_type_raw(SALT311.StrType s,SALT311.StrType company_name_type_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,company_name_type_derived)>0);
EXPORT InValidMessageFT_invalid_company_name_type_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_rawaid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_rawaid(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,13)>0);
EXPORT InValidMessageFT_invalid_company_rawaid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENSW'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_address_p_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_address_p_city_name(SALT311.StrType s,SALT311.StrType company_address_v_city_name) := WHICH(~Scrubs_BIPV2.Functions.fn_populated_strings(s,company_address_v_city_name)>0);
EXPORT InValidMessageFT_invalid_company_address_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_address_v_city_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_address_v_city_name(SALT311.StrType s,SALT311.StrType company_address_p_city_name) := WHICH(~Scrubs_BIPV2.Functions.fn_populated_strings(s,company_address_p_city_name)>0);
EXPORT InValidMessageFT_invalid_company_address_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,4)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_verify_cart(s)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_verify_cart'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','N','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|D|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dpbc(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,2)>0);
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_addr_rec_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_geo_coord'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_alphanum_opt_size(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_alphanum_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_address_type_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_address_type_raw(SALT311.StrType s,SALT311.StrType company_address_type_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,company_address_type_derived)>0);
EXPORT InValidMessageFT_invalid_company_address_type_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_fein(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_fein(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,9)>0);
EXPORT InValidMessageFT_invalid_company_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_best_fein_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_best_fein_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','']);
EXPORT InValidMessageFT_invalid_best_fein_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_phone(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_alphanum_opt_size(s,10)>0);
EXPORT InValidMessageFT_invalid_company_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_alphanum_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','T','']);
EXPORT InValidMessageFT_invalid_phone_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|T|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_org_structure_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_org_structure_raw(SALT311.StrType s,SALT311.StrType company_org_structure_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,company_org_structure_derived)>0);
EXPORT InValidMessageFT_invalid_company_org_structure_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_sic'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_naics(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_naics'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_ticker(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_ticker(SALT311.StrType s,SALT311.StrType company_ticker_exchange) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_xor_str2(s,company_ticker_exchange)>0);
EXPORT InValidMessageFT_invalid_company_ticker(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_ticker_exchange(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_ticker_exchange(SALT311.StrType s,SALT311.StrType company_ticker) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_xor_str2(s,company_ticker)>0);
EXPORT InValidMessageFT_invalid_company_ticker_exchange(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_foreign_domestic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_foreign_domestic(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','F','']);
EXPORT InValidMessageFT_invalid_company_foreign_domestic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|F|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_url(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_company_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_inc_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_inc_state(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_verify_opt_state(s)>0);
EXPORT InValidMessageFT_invalid_company_inc_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_verify_opt_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name_status_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name_status_raw(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_comp_name_status(s)>0);
EXPORT InValidMessageFT_invalid_company_name_status_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_comp_name_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_status_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_status_raw(SALT311.StrType s,SALT311.StrType company_status_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,company_status_derived)>0);
EXPORT InValidMessageFT_invalid_company_status_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_duns_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_duns_number(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,9)>0);
EXPORT InValidMessageFT_invalid_duns_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_is_contact(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_is_contact(SALT311.StrType s,SALT311.StrType contact_name_fname,SALT311.StrType contact_name_lname) := WHICH(~Scrubs_BIPV2.Functions.fn_contact(s,contact_name_fname,contact_name_lname)>0);
EXPORT InValidMessageFT_invalid_is_contact(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_contact'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_did(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_did(SALT311.StrType s,SALT311.StrType contact_name_fname,SALT311.StrType contact_name_lname) := WHICH(~Scrubs_BIPV2.Functions.fn_contact_did(s,contact_name_fname,contact_name_lname)>0);
EXPORT InValidMessageFT_invalid_contact_did(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_contact_did'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_name_fname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_name_fname(SALT311.StrType s,SALT311.StrType contact_name_lname) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_xor_str2(s,contact_name_lname)>0);
EXPORT InValidMessageFT_invalid_contact_name_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_name_lname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_name_lname(SALT311.StrType s,SALT311.StrType contact_name_fname) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_xor_str2(s,contact_name_fname)>0);
EXPORT InValidMessageFT_invalid_contact_name_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_type_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_type_raw(SALT311.StrType s,SALT311.StrType contact_type_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,contact_type_derived)>0);
EXPORT InValidMessageFT_invalid_contact_type_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_job_title_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_job_title_raw(SALT311.StrType s,SALT311.StrType contact_job_title_derived) := WHICH(~Scrubs_BIPV2.Functions.fn_str2_only_if_str1(s,contact_job_title_derived)>0);
EXPORT InValidMessageFT_invalid_contact_job_title_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str2_only_if_str1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_ssn(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_ssn(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_numeric_opt_size(s,9)>0);
EXPORT InValidMessageFT_invalid_contact_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_numeric_opt_size'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_dob(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_dob(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_dob(s)>0);
EXPORT InValidMessageFT_invalid_contact_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_dob'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_status_raw(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_status_raw(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_status(s)>0);
EXPORT InValidMessageFT_invalid_contact_status_raw(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_phone(SALT311.StrType s) := WHICH(~Scrubs_BIPV2.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_contact_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name_type_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name_type_derived(SALT311.StrType s,SALT311.StrType company_name_type_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,company_name_type_raw)>0);
EXPORT InValidMessageFT_invalid_company_name_type_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_address_type_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_address_type_derived(SALT311.StrType s,SALT311.StrType company_address_type_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_xor_str2(s,company_address_type_raw)>0);
EXPORT InValidMessageFT_invalid_company_address_type_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_xor_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_org_structure_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_org_structure_derived(SALT311.StrType s,SALT311.StrType company_org_structure_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,company_org_structure_raw)>0);
EXPORT InValidMessageFT_invalid_company_org_structure_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name_status_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name_status_derived(SALT311.StrType s,SALT311.StrType company_name_status_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,company_name_status_raw)>0);
EXPORT InValidMessageFT_invalid_company_name_status_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_status_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_status_derived(SALT311.StrType s,SALT311.StrType company_status_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,company_status_raw)>0);
EXPORT InValidMessageFT_invalid_company_status_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_type_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_type_derived(SALT311.StrType s,SALT311.StrType contact_type_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,contact_type_raw)>0);
EXPORT InValidMessageFT_invalid_contact_type_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_job_title_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_job_title_derived(SALT311.StrType s,SALT311.StrType contact_job_title_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,contact_job_title_raw)>0);
EXPORT InValidMessageFT_invalid_contact_job_title_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_contact_status_derived(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_contact_status_derived(SALT311.StrType s,SALT311.StrType contact_status_raw) := WHICH(~Scrubs_BIPV2.Functions.fn_str1_only_if_str2(s,contact_status_raw)>0);
EXPORT InValidMessageFT_invalid_contact_status_derived(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BIPV2.Functions.fn_str1_only_if_str2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'source_expanded','source','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','rcid','company_bdid','company_name','company_name_type_raw','company_rawaid','company_address_prim_range','company_address_predir','company_address_prim_name','company_address_addr_suffix','company_address_postdir','company_address_unit_desig','company_address_sec_range','company_address_p_city_name','company_address_v_city_name','company_address_st','company_address_zip','company_address_zip4','company_address_cart','company_address_cr_sort_sz','company_address_lot','company_address_lot_order','company_address_dbpc','company_address_chk_digit','company_address_rec_type','company_address_fips_state','company_address_fips_county','company_address_geo_lat','company_address_geo_long','company_address_msa','company_address_geo_blk','company_address_geo_match','company_address_err_stat','company_address_type_raw','company_address_category','company_address_country_code','company_fein','best_fein_indicator','company_phone','phone_type','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_charter_number','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','vl_id','current','source_record_id','glb','dppa','phone_score','match_company_name','match_branch_city','match_geo_city','duns_number','source_docid','is_contact','dt_first_seen_contact','dt_last_seen_contact','contact_did','contact_name_title','contact_name_fname','contact_name_lname','contact_name_name_suffix','contact_name_name_score','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_email','contact_email_username','contact_email_domain','contact_phone','cid','contact_score','from_hdr','company_department','company_aceaid','company_name_type_derived','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','proxid_status_private','powid_status_private','seleid_status_private','orgid_status_private','ultid_status_private','proxid_status_public','powid_status_public','seleid_status_public','orgid_status_public','ultid_status_public','contact_type_derived','contact_job_title_derived','contact_status_derived','address_type_derived','is_vanity_name_derived');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'source_expanded','source','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','rcid','company_bdid','company_name','company_name_type_raw','company_rawaid','company_address_prim_range','company_address_predir','company_address_prim_name','company_address_addr_suffix','company_address_postdir','company_address_unit_desig','company_address_sec_range','company_address_p_city_name','company_address_v_city_name','company_address_st','company_address_zip','company_address_zip4','company_address_cart','company_address_cr_sort_sz','company_address_lot','company_address_lot_order','company_address_dbpc','company_address_chk_digit','company_address_rec_type','company_address_fips_state','company_address_fips_county','company_address_geo_lat','company_address_geo_long','company_address_msa','company_address_geo_blk','company_address_geo_match','company_address_err_stat','company_address_type_raw','company_address_category','company_address_country_code','company_fein','best_fein_indicator','company_phone','phone_type','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_charter_number','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','vl_id','current','source_record_id','glb','dppa','phone_score','match_company_name','match_branch_city','match_geo_city','duns_number','source_docid','is_contact','dt_first_seen_contact','dt_last_seen_contact','contact_did','contact_name_title','contact_name_fname','contact_name_lname','contact_name_name_suffix','contact_name_name_score','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_email','contact_email_username','contact_email_domain','contact_phone','cid','contact_score','from_hdr','company_department','company_aceaid','company_name_type_derived','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','proxid_status_private','powid_status_private','seleid_status_private','orgid_status_private','ultid_status_private','proxid_status_public','powid_status_public','seleid_status_public','orgid_status_public','ultid_status_public','contact_type_derived','contact_job_title_derived','contact_status_derived','address_type_derived','is_vanity_name_derived');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'source_expanded' => 0,'source' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'rcid' => 6,'company_bdid' => 7,'company_name' => 8,'company_name_type_raw' => 9,'company_rawaid' => 10,'company_address_prim_range' => 11,'company_address_predir' => 12,'company_address_prim_name' => 13,'company_address_addr_suffix' => 14,'company_address_postdir' => 15,'company_address_unit_desig' => 16,'company_address_sec_range' => 17,'company_address_p_city_name' => 18,'company_address_v_city_name' => 19,'company_address_st' => 20,'company_address_zip' => 21,'company_address_zip4' => 22,'company_address_cart' => 23,'company_address_cr_sort_sz' => 24,'company_address_lot' => 25,'company_address_lot_order' => 26,'company_address_dbpc' => 27,'company_address_chk_digit' => 28,'company_address_rec_type' => 29,'company_address_fips_state' => 30,'company_address_fips_county' => 31,'company_address_geo_lat' => 32,'company_address_geo_long' => 33,'company_address_msa' => 34,'company_address_geo_blk' => 35,'company_address_geo_match' => 36,'company_address_err_stat' => 37,'company_address_type_raw' => 38,'company_address_category' => 39,'company_address_country_code' => 40,'company_fein' => 41,'best_fein_indicator' => 42,'company_phone' => 43,'phone_type' => 44,'company_org_structure_raw' => 45,'company_incorporation_date' => 46,'company_sic_code1' => 47,'company_sic_code2' => 48,'company_sic_code3' => 49,'company_sic_code4' => 50,'company_sic_code5' => 51,'company_naics_code1' => 52,'company_naics_code2' => 53,'company_naics_code3' => 54,'company_naics_code4' => 55,'company_naics_code5' => 56,'company_ticker' => 57,'company_ticker_exchange' => 58,'company_foreign_domestic' => 59,'company_url' => 60,'company_inc_state' => 61,'company_charter_number' => 62,'company_filing_date' => 63,'company_status_date' => 64,'company_foreign_date' => 65,'event_filing_date' => 66,'company_name_status_raw' => 67,'company_status_raw' => 68,'dt_first_seen_company_name' => 69,'dt_last_seen_company_name' => 70,'dt_first_seen_company_address' => 71,'dt_last_seen_company_address' => 72,'vl_id' => 73,'current' => 74,'source_record_id' => 75,'glb' => 76,'dppa' => 77,'phone_score' => 78,'match_company_name' => 79,'match_branch_city' => 80,'match_geo_city' => 81,'duns_number' => 82,'source_docid' => 83,'is_contact' => 84,'dt_first_seen_contact' => 85,'dt_last_seen_contact' => 86,'contact_did' => 87,'contact_name_title' => 88,'contact_name_fname' => 89,'contact_name_lname' => 90,'contact_name_name_suffix' => 91,'contact_name_name_score' => 92,'contact_type_raw' => 93,'contact_job_title_raw' => 94,'contact_ssn' => 95,'contact_dob' => 96,'contact_status_raw' => 97,'contact_email' => 98,'contact_email_username' => 99,'contact_email_domain' => 100,'contact_phone' => 101,'cid' => 102,'contact_score' => 103,'from_hdr' => 104,'company_department' => 105,'company_aceaid' => 106,'company_name_type_derived' => 107,'company_address_type_derived' => 108,'company_org_structure_derived' => 109,'company_name_status_derived' => 110,'company_status_derived' => 111,'proxid_status_private' => 112,'powid_status_private' => 113,'seleid_status_private' => 114,'orgid_status_private' => 115,'ultid_status_private' => 116,'proxid_status_public' => 117,'powid_status_public' => 118,'seleid_status_public' => 119,'orgid_status_public' => 120,'ultid_status_public' => 121,'contact_type_derived' => 122,'contact_job_title_derived' => 123,'contact_status_derived' => 124,'address_type_derived' => 125,'is_vanity_name_derived' => 126,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],['CUSTOM'],[],[],['ENUM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_source_expanded(SALT311.StrType s0) := s0;
EXPORT InValid_source_expanded(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_expanded(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s,SALT311.StrType dt_last_seen) := InValidFT_invalid_dt_first_seen(s,dt_last_seen);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_first_seen(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s,SALT311.StrType dt_vendor_last_reported) := InValidFT_invalid_dt_vendor_first_reported(s,dt_vendor_last_reported);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_vendor_first_reported(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_rcid(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_rcid(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_rcid(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_company_bdid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_bdid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_company_name_type_raw(SALT311.StrType s0) := MakeFT_invalid_company_name_type_raw(s0);
EXPORT InValid_company_name_type_raw(SALT311.StrType s,SALT311.StrType company_name_type_derived) := InValidFT_invalid_company_name_type_raw(s,company_name_type_derived);
EXPORT InValidMessage_company_name_type_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name_type_raw(wh);
 
EXPORT Make_company_rawaid(SALT311.StrType s0) := MakeFT_invalid_company_rawaid(s0);
EXPORT InValid_company_rawaid(SALT311.StrType s) := InValidFT_invalid_company_rawaid(s);
EXPORT InValidMessage_company_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_company_rawaid(wh);
 
EXPORT Make_company_address_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_company_address_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_company_address_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_company_address_prim_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_address_prim_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_company_address_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_company_address_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_company_address_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_company_address_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_p_city_name(SALT311.StrType s0) := MakeFT_invalid_company_address_p_city_name(s0);
EXPORT InValid_company_address_p_city_name(SALT311.StrType s,SALT311.StrType company_address_v_city_name) := InValidFT_invalid_company_address_p_city_name(s,company_address_v_city_name);
EXPORT InValidMessage_company_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_address_p_city_name(wh);
 
EXPORT Make_company_address_v_city_name(SALT311.StrType s0) := MakeFT_invalid_company_address_v_city_name(s0);
EXPORT InValid_company_address_v_city_name(SALT311.StrType s,SALT311.StrType company_address_p_city_name) := InValidFT_invalid_company_address_v_city_name(s,company_address_p_city_name);
EXPORT InValidMessage_company_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_address_v_city_name(wh);
 
EXPORT Make_company_address_st(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_company_address_st(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_company_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_company_address_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_company_address_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_company_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_company_address_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_company_address_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_company_address_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_company_address_cart(SALT311.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_company_address_cart(SALT311.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_company_address_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_company_address_cr_sort_sz(SALT311.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_company_address_cr_sort_sz(SALT311.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_company_address_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_company_address_lot(SALT311.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_company_address_lot(SALT311.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_company_address_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_company_address_lot_order(SALT311.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_company_address_lot_order(SALT311.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_company_address_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_company_address_dbpc(SALT311.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_company_address_dbpc(SALT311.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_company_address_dbpc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_company_address_chk_digit(SALT311.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_company_address_chk_digit(SALT311.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_company_address_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_company_address_rec_type(SALT311.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_company_address_rec_type(SALT311.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_company_address_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
 
EXPORT Make_company_address_fips_state(SALT311.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_company_address_fips_state(SALT311.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_company_address_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_company_address_fips_county(SALT311.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_company_address_fips_county(SALT311.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_company_address_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_company_address_geo_lat(SALT311.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_company_address_geo_lat(SALT311.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_company_address_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_company_address_geo_long(SALT311.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_company_address_geo_long(SALT311.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_company_address_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_company_address_msa(SALT311.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_company_address_msa(SALT311.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_company_address_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_company_address_geo_blk(SALT311.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_company_address_geo_blk(SALT311.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_company_address_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_company_address_geo_match(SALT311.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_company_address_geo_match(SALT311.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_company_address_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_company_address_err_stat(SALT311.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_company_address_err_stat(SALT311.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_company_address_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_company_address_type_raw(SALT311.StrType s0) := MakeFT_invalid_company_address_type_raw(s0);
EXPORT InValid_company_address_type_raw(SALT311.StrType s,SALT311.StrType company_address_type_derived) := InValidFT_invalid_company_address_type_raw(s,company_address_type_derived);
EXPORT InValidMessage_company_address_type_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_company_address_type_raw(wh);
 
EXPORT Make_company_address_category(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_category(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_category(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_country_code(SALT311.StrType s0) := s0;
EXPORT InValid_company_address_country_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_address_country_code(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT311.StrType s0) := MakeFT_invalid_company_fein(s0);
EXPORT InValid_company_fein(SALT311.StrType s) := InValidFT_invalid_company_fein(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_invalid_company_fein(wh);
 
EXPORT Make_best_fein_indicator(SALT311.StrType s0) := MakeFT_invalid_best_fein_indicator(s0);
EXPORT InValid_best_fein_indicator(SALT311.StrType s) := InValidFT_invalid_best_fein_indicator(s);
EXPORT InValidMessage_best_fein_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_best_fein_indicator(wh);
 
EXPORT Make_company_phone(SALT311.StrType s0) := MakeFT_invalid_company_phone(s0);
EXPORT InValid_company_phone(SALT311.StrType s) := InValidFT_invalid_company_phone(s);
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_company_phone(wh);
 
EXPORT Make_phone_type(SALT311.StrType s0) := MakeFT_invalid_phone_type(s0);
EXPORT InValid_phone_type(SALT311.StrType s) := InValidFT_invalid_phone_type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_type(wh);
 
EXPORT Make_company_org_structure_raw(SALT311.StrType s0) := MakeFT_invalid_company_org_structure_raw(s0);
EXPORT InValid_company_org_structure_raw(SALT311.StrType s,SALT311.StrType company_org_structure_derived) := InValidFT_invalid_company_org_structure_raw(s,company_org_structure_derived);
EXPORT InValidMessage_company_org_structure_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_company_org_structure_raw(wh);
 
EXPORT Make_company_incorporation_date(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_company_incorporation_date(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_company_incorporation_date(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_company_sic_code1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_company_sic_code1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_company_sic_code1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_company_sic_code2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_company_sic_code2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_company_sic_code2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_company_sic_code3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_company_sic_code3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_company_sic_code3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_company_sic_code4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_company_sic_code4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_company_sic_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_company_sic_code5(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_company_sic_code5(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_company_sic_code5(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_company_naics_code1(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_company_naics_code1(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_company_naics_code1(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_company_naics_code2(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_company_naics_code2(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_company_naics_code2(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_company_naics_code3(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_company_naics_code3(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_company_naics_code3(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_company_naics_code4(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_company_naics_code4(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_company_naics_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_company_naics_code5(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_company_naics_code5(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_company_naics_code5(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_company_ticker(SALT311.StrType s0) := MakeFT_invalid_company_ticker(s0);
EXPORT InValid_company_ticker(SALT311.StrType s,SALT311.StrType company_ticker_exchange) := InValidFT_invalid_company_ticker(s,company_ticker_exchange);
EXPORT InValidMessage_company_ticker(UNSIGNED1 wh) := InValidMessageFT_invalid_company_ticker(wh);
 
EXPORT Make_company_ticker_exchange(SALT311.StrType s0) := MakeFT_invalid_company_ticker_exchange(s0);
EXPORT InValid_company_ticker_exchange(SALT311.StrType s,SALT311.StrType company_ticker) := InValidFT_invalid_company_ticker_exchange(s,company_ticker);
EXPORT InValidMessage_company_ticker_exchange(UNSIGNED1 wh) := InValidMessageFT_invalid_company_ticker_exchange(wh);
 
EXPORT Make_company_foreign_domestic(SALT311.StrType s0) := MakeFT_invalid_company_foreign_domestic(s0);
EXPORT InValid_company_foreign_domestic(SALT311.StrType s) := InValidFT_invalid_company_foreign_domestic(s);
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := InValidMessageFT_invalid_company_foreign_domestic(wh);
 
EXPORT Make_company_url(SALT311.StrType s0) := MakeFT_invalid_company_url(s0);
EXPORT InValid_company_url(SALT311.StrType s) := InValidFT_invalid_company_url(s);
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := InValidMessageFT_invalid_company_url(wh);
 
EXPORT Make_company_inc_state(SALT311.StrType s0) := MakeFT_invalid_company_inc_state(s0);
EXPORT InValid_company_inc_state(SALT311.StrType s) := InValidFT_invalid_company_inc_state(s);
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_company_inc_state(wh);
 
EXPORT Make_company_charter_number(SALT311.StrType s0) := s0;
EXPORT InValid_company_charter_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := '';
 
EXPORT Make_company_filing_date(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_company_filing_date(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_company_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_company_status_date(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_company_status_date(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_company_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_company_foreign_date(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_company_foreign_date(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_company_foreign_date(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_event_filing_date(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_event_filing_date(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_event_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_company_name_status_raw(SALT311.StrType s0) := MakeFT_invalid_company_name_status_raw(s0);
EXPORT InValid_company_name_status_raw(SALT311.StrType s) := InValidFT_invalid_company_name_status_raw(s);
EXPORT InValidMessage_company_name_status_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name_status_raw(wh);
 
EXPORT Make_company_status_raw(SALT311.StrType s0) := MakeFT_invalid_company_status_raw(s0);
EXPORT InValid_company_status_raw(SALT311.StrType s,SALT311.StrType company_status_derived) := InValidFT_invalid_company_status_raw(s,company_status_derived);
EXPORT InValidMessage_company_status_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_company_status_raw(wh);
 
EXPORT Make_dt_first_seen_company_name(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_first_seen_company_name(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_first_seen_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_dt_last_seen_company_name(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_last_seen_company_name(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_last_seen_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_dt_first_seen_company_address(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_first_seen_company_address(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_first_seen_company_address(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_dt_last_seen_company_address(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_last_seen_company_address(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_last_seen_company_address(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_vl_id(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_vl_id(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_vl_id(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_current(SALT311.StrType s0) := MakeFT_invalid_boolean_1(s0);
EXPORT InValid_current(SALT311.StrType s) := InValidFT_invalid_boolean_1(s);
EXPORT InValidMessage_current(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_1(wh);
 
EXPORT Make_source_record_id(SALT311.StrType s0) := MakeFT_invalid_mandatory_numeric(s0);
EXPORT InValid_source_record_id(SALT311.StrType s) := InValidFT_invalid_mandatory_numeric(s);
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory_numeric(wh);
 
EXPORT Make_glb(SALT311.StrType s0) := MakeFT_invalid_boolean_1(s0);
EXPORT InValid_glb(SALT311.StrType s) := InValidFT_invalid_boolean_1(s);
EXPORT InValidMessage_glb(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_1(wh);
 
EXPORT Make_dppa(SALT311.StrType s0) := MakeFT_invalid_boolean_1(s0);
EXPORT InValid_dppa(SALT311.StrType s) := InValidFT_invalid_boolean_1(s);
EXPORT InValidMessage_dppa(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_1(wh);
 
EXPORT Make_phone_score(SALT311.StrType s0) := s0;
EXPORT InValid_phone_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone_score(UNSIGNED1 wh) := '';
 
EXPORT Make_match_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_match_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_match_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_match_branch_city(SALT311.StrType s0) := s0;
EXPORT InValid_match_branch_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_match_branch_city(UNSIGNED1 wh) := '';
 
EXPORT Make_match_geo_city(SALT311.StrType s0) := s0;
EXPORT InValid_match_geo_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_match_geo_city(UNSIGNED1 wh) := '';
 
EXPORT Make_duns_number(SALT311.StrType s0) := MakeFT_invalid_duns_number(s0);
EXPORT InValid_duns_number(SALT311.StrType s) := InValidFT_invalid_duns_number(s);
EXPORT InValidMessage_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_duns_number(wh);
 
EXPORT Make_source_docid(SALT311.StrType s0) := s0;
EXPORT InValid_source_docid(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_docid(UNSIGNED1 wh) := '';
 
EXPORT Make_is_contact(SALT311.StrType s0) := MakeFT_invalid_is_contact(s0);
EXPORT InValid_is_contact(SALT311.StrType s,SALT311.StrType contact_name_fname,SALT311.StrType contact_name_lname) := InValidFT_invalid_is_contact(s,contact_name_fname,contact_name_lname);
EXPORT InValidMessage_is_contact(UNSIGNED1 wh) := InValidMessageFT_invalid_is_contact(wh);
 
EXPORT Make_dt_first_seen_contact(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_first_seen_contact(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_first_seen_contact(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_dt_last_seen_contact(SALT311.StrType s0) := MakeFT_invalid_opt_pastdate8(s0);
EXPORT InValid_dt_last_seen_contact(SALT311.StrType s) := InValidFT_invalid_opt_pastdate8(s);
EXPORT InValidMessage_dt_last_seen_contact(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_pastdate8(wh);
 
EXPORT Make_contact_did(SALT311.StrType s0) := MakeFT_invalid_contact_did(s0);
EXPORT InValid_contact_did(SALT311.StrType s,SALT311.StrType contact_name_fname,SALT311.StrType contact_name_lname) := InValidFT_invalid_contact_did(s,contact_name_fname,contact_name_lname);
EXPORT InValidMessage_contact_did(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_did(wh);
 
EXPORT Make_contact_name_title(SALT311.StrType s0) := s0;
EXPORT InValid_contact_name_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_name_title(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_name_fname(SALT311.StrType s0) := MakeFT_invalid_contact_name_fname(s0);
EXPORT InValid_contact_name_fname(SALT311.StrType s,SALT311.StrType contact_name_lname) := InValidFT_invalid_contact_name_fname(s,contact_name_lname);
EXPORT InValidMessage_contact_name_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_name_fname(wh);
 
EXPORT Make_contact_name_lname(SALT311.StrType s0) := MakeFT_invalid_contact_name_lname(s0);
EXPORT InValid_contact_name_lname(SALT311.StrType s,SALT311.StrType contact_name_fname) := InValidFT_invalid_contact_name_lname(s,contact_name_fname);
EXPORT InValidMessage_contact_name_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_name_lname(wh);
 
EXPORT Make_contact_name_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_contact_name_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_name_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_name_name_score(SALT311.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_contact_name_name_score(SALT311.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_contact_name_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_contact_type_raw(SALT311.StrType s0) := MakeFT_invalid_contact_type_raw(s0);
EXPORT InValid_contact_type_raw(SALT311.StrType s,SALT311.StrType contact_type_derived) := InValidFT_invalid_contact_type_raw(s,contact_type_derived);
EXPORT InValidMessage_contact_type_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_type_raw(wh);
 
EXPORT Make_contact_job_title_raw(SALT311.StrType s0) := MakeFT_invalid_contact_job_title_raw(s0);
EXPORT InValid_contact_job_title_raw(SALT311.StrType s,SALT311.StrType contact_job_title_derived) := InValidFT_invalid_contact_job_title_raw(s,contact_job_title_derived);
EXPORT InValidMessage_contact_job_title_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_job_title_raw(wh);
 
EXPORT Make_contact_ssn(SALT311.StrType s0) := MakeFT_invalid_contact_ssn(s0);
EXPORT InValid_contact_ssn(SALT311.StrType s) := InValidFT_invalid_contact_ssn(s);
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_ssn(wh);
 
EXPORT Make_contact_dob(SALT311.StrType s0) := MakeFT_invalid_contact_dob(s0);
EXPORT InValid_contact_dob(SALT311.StrType s) := InValidFT_invalid_contact_dob(s);
EXPORT InValidMessage_contact_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_dob(wh);
 
EXPORT Make_contact_status_raw(SALT311.StrType s0) := MakeFT_invalid_contact_status_raw(s0);
EXPORT InValid_contact_status_raw(SALT311.StrType s) := InValidFT_invalid_contact_status_raw(s);
EXPORT InValidMessage_contact_status_raw(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_status_raw(wh);
 
EXPORT Make_contact_email(SALT311.StrType s0) := s0;
EXPORT InValid_contact_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email_username(SALT311.StrType s0) := s0;
EXPORT InValid_contact_email_username(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_email_username(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email_domain(SALT311.StrType s0) := s0;
EXPORT InValid_contact_email_domain(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_email_domain(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_phone(SALT311.StrType s0) := MakeFT_invalid_contact_phone(s0);
EXPORT InValid_contact_phone(SALT311.StrType s) := InValidFT_invalid_contact_phone(s);
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_phone(wh);
 
EXPORT Make_cid(SALT311.StrType s0) := s0;
EXPORT InValid_cid(SALT311.StrType s) := 0;
EXPORT InValidMessage_cid(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_score(SALT311.StrType s0) := s0;
EXPORT InValid_contact_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_score(UNSIGNED1 wh) := '';
 
EXPORT Make_from_hdr(SALT311.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_from_hdr(SALT311.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_from_hdr(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_company_department(SALT311.StrType s0) := s0;
EXPORT InValid_company_department(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
 
EXPORT Make_company_aceaid(SALT311.StrType s0) := s0;
EXPORT InValid_company_aceaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT311.StrType s0) := MakeFT_invalid_company_name_type_derived(s0);
EXPORT InValid_company_name_type_derived(SALT311.StrType s,SALT311.StrType company_name_type_raw) := InValidFT_invalid_company_name_type_derived(s,company_name_type_raw);
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name_type_derived(wh);
 
EXPORT Make_company_address_type_derived(SALT311.StrType s0) := MakeFT_invalid_company_address_type_derived(s0);
EXPORT InValid_company_address_type_derived(SALT311.StrType s,SALT311.StrType company_address_type_raw) := InValidFT_invalid_company_address_type_derived(s,company_address_type_raw);
EXPORT InValidMessage_company_address_type_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_company_address_type_derived(wh);
 
EXPORT Make_company_org_structure_derived(SALT311.StrType s0) := MakeFT_invalid_company_org_structure_derived(s0);
EXPORT InValid_company_org_structure_derived(SALT311.StrType s,SALT311.StrType company_org_structure_raw) := InValidFT_invalid_company_org_structure_derived(s,company_org_structure_raw);
EXPORT InValidMessage_company_org_structure_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_company_org_structure_derived(wh);
 
EXPORT Make_company_name_status_derived(SALT311.StrType s0) := MakeFT_invalid_company_name_status_derived(s0);
EXPORT InValid_company_name_status_derived(SALT311.StrType s,SALT311.StrType company_name_status_raw) := InValidFT_invalid_company_name_status_derived(s,company_name_status_raw);
EXPORT InValidMessage_company_name_status_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name_status_derived(wh);
 
EXPORT Make_company_status_derived(SALT311.StrType s0) := MakeFT_invalid_company_status_derived(s0);
EXPORT InValid_company_status_derived(SALT311.StrType s,SALT311.StrType company_status_raw) := InValidFT_invalid_company_status_derived(s,company_status_raw);
EXPORT InValidMessage_company_status_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_company_status_derived(wh);
 
EXPORT Make_proxid_status_private(SALT311.StrType s0) := s0;
EXPORT InValid_proxid_status_private(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid_status_private(UNSIGNED1 wh) := '';
 
EXPORT Make_powid_status_private(SALT311.StrType s0) := s0;
EXPORT InValid_powid_status_private(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid_status_private(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid_status_private(SALT311.StrType s0) := s0;
EXPORT InValid_seleid_status_private(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid_status_private(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid_status_private(SALT311.StrType s0) := s0;
EXPORT InValid_orgid_status_private(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid_status_private(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid_status_private(SALT311.StrType s0) := s0;
EXPORT InValid_ultid_status_private(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid_status_private(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid_status_public(SALT311.StrType s0) := s0;
EXPORT InValid_proxid_status_public(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid_status_public(UNSIGNED1 wh) := '';
 
EXPORT Make_powid_status_public(SALT311.StrType s0) := s0;
EXPORT InValid_powid_status_public(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid_status_public(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid_status_public(SALT311.StrType s0) := s0;
EXPORT InValid_seleid_status_public(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid_status_public(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid_status_public(SALT311.StrType s0) := s0;
EXPORT InValid_orgid_status_public(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid_status_public(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid_status_public(SALT311.StrType s0) := s0;
EXPORT InValid_ultid_status_public(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid_status_public(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_type_derived(SALT311.StrType s0) := MakeFT_invalid_contact_type_derived(s0);
EXPORT InValid_contact_type_derived(SALT311.StrType s,SALT311.StrType contact_type_raw) := InValidFT_invalid_contact_type_derived(s,contact_type_raw);
EXPORT InValidMessage_contact_type_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_type_derived(wh);
 
EXPORT Make_contact_job_title_derived(SALT311.StrType s0) := MakeFT_invalid_contact_job_title_derived(s0);
EXPORT InValid_contact_job_title_derived(SALT311.StrType s,SALT311.StrType contact_job_title_raw) := InValidFT_invalid_contact_job_title_derived(s,contact_job_title_raw);
EXPORT InValidMessage_contact_job_title_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_job_title_derived(wh);
 
EXPORT Make_contact_status_derived(SALT311.StrType s0) := MakeFT_invalid_contact_status_derived(s0);
EXPORT InValid_contact_status_derived(SALT311.StrType s,SALT311.StrType contact_status_raw) := InValidFT_invalid_contact_status_derived(s,contact_status_raw);
EXPORT InValidMessage_contact_status_derived(UNSIGNED1 wh) := InValidMessageFT_invalid_contact_status_derived(wh);
 
EXPORT Make_address_type_derived(SALT311.StrType s0) := s0;
EXPORT InValid_address_type_derived(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_is_vanity_name_derived(SALT311.StrType s0) := s0;
EXPORT InValid_is_vanity_name_derived(SALT311.StrType s) := 0;
EXPORT InValidMessage_is_vanity_name_derived(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BIPV2;
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
    BOOLEAN Diff_source_expanded;
    BOOLEAN Diff_source;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_rcid;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_name_type_raw;
    BOOLEAN Diff_company_rawaid;
    BOOLEAN Diff_company_address_prim_range;
    BOOLEAN Diff_company_address_predir;
    BOOLEAN Diff_company_address_prim_name;
    BOOLEAN Diff_company_address_addr_suffix;
    BOOLEAN Diff_company_address_postdir;
    BOOLEAN Diff_company_address_unit_desig;
    BOOLEAN Diff_company_address_sec_range;
    BOOLEAN Diff_company_address_p_city_name;
    BOOLEAN Diff_company_address_v_city_name;
    BOOLEAN Diff_company_address_st;
    BOOLEAN Diff_company_address_zip;
    BOOLEAN Diff_company_address_zip4;
    BOOLEAN Diff_company_address_cart;
    BOOLEAN Diff_company_address_cr_sort_sz;
    BOOLEAN Diff_company_address_lot;
    BOOLEAN Diff_company_address_lot_order;
    BOOLEAN Diff_company_address_dbpc;
    BOOLEAN Diff_company_address_chk_digit;
    BOOLEAN Diff_company_address_rec_type;
    BOOLEAN Diff_company_address_fips_state;
    BOOLEAN Diff_company_address_fips_county;
    BOOLEAN Diff_company_address_geo_lat;
    BOOLEAN Diff_company_address_geo_long;
    BOOLEAN Diff_company_address_msa;
    BOOLEAN Diff_company_address_geo_blk;
    BOOLEAN Diff_company_address_geo_match;
    BOOLEAN Diff_company_address_err_stat;
    BOOLEAN Diff_company_address_type_raw;
    BOOLEAN Diff_company_address_category;
    BOOLEAN Diff_company_address_country_code;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_best_fein_indicator;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_company_org_structure_raw;
    BOOLEAN Diff_company_incorporation_date;
    BOOLEAN Diff_company_sic_code1;
    BOOLEAN Diff_company_sic_code2;
    BOOLEAN Diff_company_sic_code3;
    BOOLEAN Diff_company_sic_code4;
    BOOLEAN Diff_company_sic_code5;
    BOOLEAN Diff_company_naics_code1;
    BOOLEAN Diff_company_naics_code2;
    BOOLEAN Diff_company_naics_code3;
    BOOLEAN Diff_company_naics_code4;
    BOOLEAN Diff_company_naics_code5;
    BOOLEAN Diff_company_ticker;
    BOOLEAN Diff_company_ticker_exchange;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_company_filing_date;
    BOOLEAN Diff_company_status_date;
    BOOLEAN Diff_company_foreign_date;
    BOOLEAN Diff_event_filing_date;
    BOOLEAN Diff_company_name_status_raw;
    BOOLEAN Diff_company_status_raw;
    BOOLEAN Diff_dt_first_seen_company_name;
    BOOLEAN Diff_dt_last_seen_company_name;
    BOOLEAN Diff_dt_first_seen_company_address;
    BOOLEAN Diff_dt_last_seen_company_address;
    BOOLEAN Diff_vl_id;
    BOOLEAN Diff_current;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_glb;
    BOOLEAN Diff_dppa;
    BOOLEAN Diff_phone_score;
    BOOLEAN Diff_match_company_name;
    BOOLEAN Diff_match_branch_city;
    BOOLEAN Diff_match_geo_city;
    BOOLEAN Diff_duns_number;
    BOOLEAN Diff_source_docid;
    BOOLEAN Diff_is_contact;
    BOOLEAN Diff_dt_first_seen_contact;
    BOOLEAN Diff_dt_last_seen_contact;
    BOOLEAN Diff_contact_did;
    BOOLEAN Diff_contact_name_title;
    BOOLEAN Diff_contact_name_fname;
    BOOLEAN Diff_contact_name_lname;
    BOOLEAN Diff_contact_name_name_suffix;
    BOOLEAN Diff_contact_name_name_score;
    BOOLEAN Diff_contact_type_raw;
    BOOLEAN Diff_contact_job_title_raw;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_dob;
    BOOLEAN Diff_contact_status_raw;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_email_username;
    BOOLEAN Diff_contact_email_domain;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_cid;
    BOOLEAN Diff_contact_score;
    BOOLEAN Diff_from_hdr;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_company_aceaid;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_company_address_type_derived;
    BOOLEAN Diff_company_org_structure_derived;
    BOOLEAN Diff_company_name_status_derived;
    BOOLEAN Diff_company_status_derived;
    BOOLEAN Diff_proxid_status_private;
    BOOLEAN Diff_powid_status_private;
    BOOLEAN Diff_seleid_status_private;
    BOOLEAN Diff_orgid_status_private;
    BOOLEAN Diff_ultid_status_private;
    BOOLEAN Diff_proxid_status_public;
    BOOLEAN Diff_powid_status_public;
    BOOLEAN Diff_seleid_status_public;
    BOOLEAN Diff_orgid_status_public;
    BOOLEAN Diff_ultid_status_public;
    BOOLEAN Diff_contact_type_derived;
    BOOLEAN Diff_contact_job_title_derived;
    BOOLEAN Diff_contact_status_derived;
    BOOLEAN Diff_address_type_derived;
    BOOLEAN Diff_is_vanity_name_derived;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_source_expanded := le.source_expanded <> ri.source_expanded;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_rcid := le.rcid <> ri.rcid;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_name_type_raw := le.company_name_type_raw <> ri.company_name_type_raw;
    SELF.Diff_company_rawaid := le.company_rawaid <> ri.company_rawaid;
    SELF.Diff_company_address_prim_range := le.company_address_prim_range <> ri.company_address_prim_range;
    SELF.Diff_company_address_predir := le.company_address_predir <> ri.company_address_predir;
    SELF.Diff_company_address_prim_name := le.company_address_prim_name <> ri.company_address_prim_name;
    SELF.Diff_company_address_addr_suffix := le.company_address_addr_suffix <> ri.company_address_addr_suffix;
    SELF.Diff_company_address_postdir := le.company_address_postdir <> ri.company_address_postdir;
    SELF.Diff_company_address_unit_desig := le.company_address_unit_desig <> ri.company_address_unit_desig;
    SELF.Diff_company_address_sec_range := le.company_address_sec_range <> ri.company_address_sec_range;
    SELF.Diff_company_address_p_city_name := le.company_address_p_city_name <> ri.company_address_p_city_name;
    SELF.Diff_company_address_v_city_name := le.company_address_v_city_name <> ri.company_address_v_city_name;
    SELF.Diff_company_address_st := le.company_address_st <> ri.company_address_st;
    SELF.Diff_company_address_zip := le.company_address_zip <> ri.company_address_zip;
    SELF.Diff_company_address_zip4 := le.company_address_zip4 <> ri.company_address_zip4;
    SELF.Diff_company_address_cart := le.company_address_cart <> ri.company_address_cart;
    SELF.Diff_company_address_cr_sort_sz := le.company_address_cr_sort_sz <> ri.company_address_cr_sort_sz;
    SELF.Diff_company_address_lot := le.company_address_lot <> ri.company_address_lot;
    SELF.Diff_company_address_lot_order := le.company_address_lot_order <> ri.company_address_lot_order;
    SELF.Diff_company_address_dbpc := le.company_address_dbpc <> ri.company_address_dbpc;
    SELF.Diff_company_address_chk_digit := le.company_address_chk_digit <> ri.company_address_chk_digit;
    SELF.Diff_company_address_rec_type := le.company_address_rec_type <> ri.company_address_rec_type;
    SELF.Diff_company_address_fips_state := le.company_address_fips_state <> ri.company_address_fips_state;
    SELF.Diff_company_address_fips_county := le.company_address_fips_county <> ri.company_address_fips_county;
    SELF.Diff_company_address_geo_lat := le.company_address_geo_lat <> ri.company_address_geo_lat;
    SELF.Diff_company_address_geo_long := le.company_address_geo_long <> ri.company_address_geo_long;
    SELF.Diff_company_address_msa := le.company_address_msa <> ri.company_address_msa;
    SELF.Diff_company_address_geo_blk := le.company_address_geo_blk <> ri.company_address_geo_blk;
    SELF.Diff_company_address_geo_match := le.company_address_geo_match <> ri.company_address_geo_match;
    SELF.Diff_company_address_err_stat := le.company_address_err_stat <> ri.company_address_err_stat;
    SELF.Diff_company_address_type_raw := le.company_address_type_raw <> ri.company_address_type_raw;
    SELF.Diff_company_address_category := le.company_address_category <> ri.company_address_category;
    SELF.Diff_company_address_country_code := le.company_address_country_code <> ri.company_address_country_code;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_best_fein_indicator := le.best_fein_indicator <> ri.best_fein_indicator;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_company_org_structure_raw := le.company_org_structure_raw <> ri.company_org_structure_raw;
    SELF.Diff_company_incorporation_date := le.company_incorporation_date <> ri.company_incorporation_date;
    SELF.Diff_company_sic_code1 := le.company_sic_code1 <> ri.company_sic_code1;
    SELF.Diff_company_sic_code2 := le.company_sic_code2 <> ri.company_sic_code2;
    SELF.Diff_company_sic_code3 := le.company_sic_code3 <> ri.company_sic_code3;
    SELF.Diff_company_sic_code4 := le.company_sic_code4 <> ri.company_sic_code4;
    SELF.Diff_company_sic_code5 := le.company_sic_code5 <> ri.company_sic_code5;
    SELF.Diff_company_naics_code1 := le.company_naics_code1 <> ri.company_naics_code1;
    SELF.Diff_company_naics_code2 := le.company_naics_code2 <> ri.company_naics_code2;
    SELF.Diff_company_naics_code3 := le.company_naics_code3 <> ri.company_naics_code3;
    SELF.Diff_company_naics_code4 := le.company_naics_code4 <> ri.company_naics_code4;
    SELF.Diff_company_naics_code5 := le.company_naics_code5 <> ri.company_naics_code5;
    SELF.Diff_company_ticker := le.company_ticker <> ri.company_ticker;
    SELF.Diff_company_ticker_exchange := le.company_ticker_exchange <> ri.company_ticker_exchange;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_company_filing_date := le.company_filing_date <> ri.company_filing_date;
    SELF.Diff_company_status_date := le.company_status_date <> ri.company_status_date;
    SELF.Diff_company_foreign_date := le.company_foreign_date <> ri.company_foreign_date;
    SELF.Diff_event_filing_date := le.event_filing_date <> ri.event_filing_date;
    SELF.Diff_company_name_status_raw := le.company_name_status_raw <> ri.company_name_status_raw;
    SELF.Diff_company_status_raw := le.company_status_raw <> ri.company_status_raw;
    SELF.Diff_dt_first_seen_company_name := le.dt_first_seen_company_name <> ri.dt_first_seen_company_name;
    SELF.Diff_dt_last_seen_company_name := le.dt_last_seen_company_name <> ri.dt_last_seen_company_name;
    SELF.Diff_dt_first_seen_company_address := le.dt_first_seen_company_address <> ri.dt_first_seen_company_address;
    SELF.Diff_dt_last_seen_company_address := le.dt_last_seen_company_address <> ri.dt_last_seen_company_address;
    SELF.Diff_vl_id := le.vl_id <> ri.vl_id;
    SELF.Diff_current := le.current <> ri.current;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_glb := le.glb <> ri.glb;
    SELF.Diff_dppa := le.dppa <> ri.dppa;
    SELF.Diff_phone_score := le.phone_score <> ri.phone_score;
    SELF.Diff_match_company_name := le.match_company_name <> ri.match_company_name;
    SELF.Diff_match_branch_city := le.match_branch_city <> ri.match_branch_city;
    SELF.Diff_match_geo_city := le.match_geo_city <> ri.match_geo_city;
    SELF.Diff_duns_number := le.duns_number <> ri.duns_number;
    SELF.Diff_source_docid := le.source_docid <> ri.source_docid;
    SELF.Diff_is_contact := le.is_contact <> ri.is_contact;
    SELF.Diff_dt_first_seen_contact := le.dt_first_seen_contact <> ri.dt_first_seen_contact;
    SELF.Diff_dt_last_seen_contact := le.dt_last_seen_contact <> ri.dt_last_seen_contact;
    SELF.Diff_contact_did := le.contact_did <> ri.contact_did;
    SELF.Diff_contact_name_title := le.contact_name_title <> ri.contact_name_title;
    SELF.Diff_contact_name_fname := le.contact_name_fname <> ri.contact_name_fname;
    SELF.Diff_contact_name_lname := le.contact_name_lname <> ri.contact_name_lname;
    SELF.Diff_contact_name_name_suffix := le.contact_name_name_suffix <> ri.contact_name_name_suffix;
    SELF.Diff_contact_name_name_score := le.contact_name_name_score <> ri.contact_name_name_score;
    SELF.Diff_contact_type_raw := le.contact_type_raw <> ri.contact_type_raw;
    SELF.Diff_contact_job_title_raw := le.contact_job_title_raw <> ri.contact_job_title_raw;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_dob := le.contact_dob <> ri.contact_dob;
    SELF.Diff_contact_status_raw := le.contact_status_raw <> ri.contact_status_raw;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_email_username := le.contact_email_username <> ri.contact_email_username;
    SELF.Diff_contact_email_domain := le.contact_email_domain <> ri.contact_email_domain;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_cid := le.cid <> ri.cid;
    SELF.Diff_contact_score := le.contact_score <> ri.contact_score;
    SELF.Diff_from_hdr := le.from_hdr <> ri.from_hdr;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_company_aceaid := le.company_aceaid <> ri.company_aceaid;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_company_address_type_derived := le.company_address_type_derived <> ri.company_address_type_derived;
    SELF.Diff_company_org_structure_derived := le.company_org_structure_derived <> ri.company_org_structure_derived;
    SELF.Diff_company_name_status_derived := le.company_name_status_derived <> ri.company_name_status_derived;
    SELF.Diff_company_status_derived := le.company_status_derived <> ri.company_status_derived;
    SELF.Diff_proxid_status_private := le.proxid_status_private <> ri.proxid_status_private;
    SELF.Diff_powid_status_private := le.powid_status_private <> ri.powid_status_private;
    SELF.Diff_seleid_status_private := le.seleid_status_private <> ri.seleid_status_private;
    SELF.Diff_orgid_status_private := le.orgid_status_private <> ri.orgid_status_private;
    SELF.Diff_ultid_status_private := le.ultid_status_private <> ri.ultid_status_private;
    SELF.Diff_proxid_status_public := le.proxid_status_public <> ri.proxid_status_public;
    SELF.Diff_powid_status_public := le.powid_status_public <> ri.powid_status_public;
    SELF.Diff_seleid_status_public := le.seleid_status_public <> ri.seleid_status_public;
    SELF.Diff_orgid_status_public := le.orgid_status_public <> ri.orgid_status_public;
    SELF.Diff_ultid_status_public := le.ultid_status_public <> ri.ultid_status_public;
    SELF.Diff_contact_type_derived := le.contact_type_derived <> ri.contact_type_derived;
    SELF.Diff_contact_job_title_derived := le.contact_job_title_derived <> ri.contact_job_title_derived;
    SELF.Diff_contact_status_derived := le.contact_status_derived <> ri.contact_status_derived;
    SELF.Diff_address_type_derived := le.address_type_derived <> ri.address_type_derived;
    SELF.Diff_is_vanity_name_derived := le.is_vanity_name_derived <> ri.is_vanity_name_derived;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_expanded;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_source_expanded,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_name_type_raw,1,0)+ IF( SELF.Diff_company_rawaid,1,0)+ IF( SELF.Diff_company_address_prim_range,1,0)+ IF( SELF.Diff_company_address_predir,1,0)+ IF( SELF.Diff_company_address_prim_name,1,0)+ IF( SELF.Diff_company_address_addr_suffix,1,0)+ IF( SELF.Diff_company_address_postdir,1,0)+ IF( SELF.Diff_company_address_unit_desig,1,0)+ IF( SELF.Diff_company_address_sec_range,1,0)+ IF( SELF.Diff_company_address_p_city_name,1,0)+ IF( SELF.Diff_company_address_v_city_name,1,0)+ IF( SELF.Diff_company_address_st,1,0)+ IF( SELF.Diff_company_address_zip,1,0)+ IF( SELF.Diff_company_address_zip4,1,0)+ IF( SELF.Diff_company_address_cart,1,0)+ IF( SELF.Diff_company_address_cr_sort_sz,1,0)+ IF( SELF.Diff_company_address_lot,1,0)+ IF( SELF.Diff_company_address_lot_order,1,0)+ IF( SELF.Diff_company_address_dbpc,1,0)+ IF( SELF.Diff_company_address_chk_digit,1,0)+ IF( SELF.Diff_company_address_rec_type,1,0)+ IF( SELF.Diff_company_address_fips_state,1,0)+ IF( SELF.Diff_company_address_fips_county,1,0)+ IF( SELF.Diff_company_address_geo_lat,1,0)+ IF( SELF.Diff_company_address_geo_long,1,0)+ IF( SELF.Diff_company_address_msa,1,0)+ IF( SELF.Diff_company_address_geo_blk,1,0)+ IF( SELF.Diff_company_address_geo_match,1,0)+ IF( SELF.Diff_company_address_err_stat,1,0)+ IF( SELF.Diff_company_address_type_raw,1,0)+ IF( SELF.Diff_company_address_category,1,0)+ IF( SELF.Diff_company_address_country_code,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_best_fein_indicator,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_company_org_structure_raw,1,0)+ IF( SELF.Diff_company_incorporation_date,1,0)+ IF( SELF.Diff_company_sic_code1,1,0)+ IF( SELF.Diff_company_sic_code2,1,0)+ IF( SELF.Diff_company_sic_code3,1,0)+ IF( SELF.Diff_company_sic_code4,1,0)+ IF( SELF.Diff_company_sic_code5,1,0)+ IF( SELF.Diff_company_naics_code1,1,0)+ IF( SELF.Diff_company_naics_code2,1,0)+ IF( SELF.Diff_company_naics_code3,1,0)+ IF( SELF.Diff_company_naics_code4,1,0)+ IF( SELF.Diff_company_naics_code5,1,0)+ IF( SELF.Diff_company_ticker,1,0)+ IF( SELF.Diff_company_ticker_exchange,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_company_filing_date,1,0)+ IF( SELF.Diff_company_status_date,1,0)+ IF( SELF.Diff_company_foreign_date,1,0)+ IF( SELF.Diff_event_filing_date,1,0)+ IF( SELF.Diff_company_name_status_raw,1,0)+ IF( SELF.Diff_company_status_raw,1,0)+ IF( SELF.Diff_dt_first_seen_company_name,1,0)+ IF( SELF.Diff_dt_last_seen_company_name,1,0)+ IF( SELF.Diff_dt_first_seen_company_address,1,0)+ IF( SELF.Diff_dt_last_seen_company_address,1,0)+ IF( SELF.Diff_vl_id,1,0)+ IF( SELF.Diff_current,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_glb,1,0)+ IF( SELF.Diff_dppa,1,0)+ IF( SELF.Diff_phone_score,1,0)+ IF( SELF.Diff_match_company_name,1,0)+ IF( SELF.Diff_match_branch_city,1,0)+ IF( SELF.Diff_match_geo_city,1,0)+ IF( SELF.Diff_duns_number,1,0)+ IF( SELF.Diff_source_docid,1,0)+ IF( SELF.Diff_is_contact,1,0)+ IF( SELF.Diff_dt_first_seen_contact,1,0)+ IF( SELF.Diff_dt_last_seen_contact,1,0)+ IF( SELF.Diff_contact_did,1,0)+ IF( SELF.Diff_contact_name_title,1,0)+ IF( SELF.Diff_contact_name_fname,1,0)+ IF( SELF.Diff_contact_name_lname,1,0)+ IF( SELF.Diff_contact_name_name_suffix,1,0)+ IF( SELF.Diff_contact_name_name_score,1,0)+ IF( SELF.Diff_contact_type_raw,1,0)+ IF( SELF.Diff_contact_job_title_raw,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_dob,1,0)+ IF( SELF.Diff_contact_status_raw,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_email_username,1,0)+ IF( SELF.Diff_contact_email_domain,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_cid,1,0)+ IF( SELF.Diff_contact_score,1,0)+ IF( SELF.Diff_from_hdr,1,0)+ IF( SELF.Diff_company_department,1,0)+ IF( SELF.Diff_company_aceaid,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_company_address_type_derived,1,0)+ IF( SELF.Diff_company_org_structure_derived,1,0)+ IF( SELF.Diff_company_name_status_derived,1,0)+ IF( SELF.Diff_company_status_derived,1,0)+ IF( SELF.Diff_proxid_status_private,1,0)+ IF( SELF.Diff_powid_status_private,1,0)+ IF( SELF.Diff_seleid_status_private,1,0)+ IF( SELF.Diff_orgid_status_private,1,0)+ IF( SELF.Diff_ultid_status_private,1,0)+ IF( SELF.Diff_proxid_status_public,1,0)+ IF( SELF.Diff_powid_status_public,1,0)+ IF( SELF.Diff_seleid_status_public,1,0)+ IF( SELF.Diff_orgid_status_public,1,0)+ IF( SELF.Diff_ultid_status_public,1,0)+ IF( SELF.Diff_contact_type_derived,1,0)+ IF( SELF.Diff_contact_job_title_derived,1,0)+ IF( SELF.Diff_contact_status_derived,1,0)+ IF( SELF.Diff_address_type_derived,1,0)+ IF( SELF.Diff_is_vanity_name_derived,1,0);
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
    Count_Diff_source_expanded := COUNT(GROUP,%Closest%.Diff_source_expanded);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_name_type_raw := COUNT(GROUP,%Closest%.Diff_company_name_type_raw);
    Count_Diff_company_rawaid := COUNT(GROUP,%Closest%.Diff_company_rawaid);
    Count_Diff_company_address_prim_range := COUNT(GROUP,%Closest%.Diff_company_address_prim_range);
    Count_Diff_company_address_predir := COUNT(GROUP,%Closest%.Diff_company_address_predir);
    Count_Diff_company_address_prim_name := COUNT(GROUP,%Closest%.Diff_company_address_prim_name);
    Count_Diff_company_address_addr_suffix := COUNT(GROUP,%Closest%.Diff_company_address_addr_suffix);
    Count_Diff_company_address_postdir := COUNT(GROUP,%Closest%.Diff_company_address_postdir);
    Count_Diff_company_address_unit_desig := COUNT(GROUP,%Closest%.Diff_company_address_unit_desig);
    Count_Diff_company_address_sec_range := COUNT(GROUP,%Closest%.Diff_company_address_sec_range);
    Count_Diff_company_address_p_city_name := COUNT(GROUP,%Closest%.Diff_company_address_p_city_name);
    Count_Diff_company_address_v_city_name := COUNT(GROUP,%Closest%.Diff_company_address_v_city_name);
    Count_Diff_company_address_st := COUNT(GROUP,%Closest%.Diff_company_address_st);
    Count_Diff_company_address_zip := COUNT(GROUP,%Closest%.Diff_company_address_zip);
    Count_Diff_company_address_zip4 := COUNT(GROUP,%Closest%.Diff_company_address_zip4);
    Count_Diff_company_address_cart := COUNT(GROUP,%Closest%.Diff_company_address_cart);
    Count_Diff_company_address_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_company_address_cr_sort_sz);
    Count_Diff_company_address_lot := COUNT(GROUP,%Closest%.Diff_company_address_lot);
    Count_Diff_company_address_lot_order := COUNT(GROUP,%Closest%.Diff_company_address_lot_order);
    Count_Diff_company_address_dbpc := COUNT(GROUP,%Closest%.Diff_company_address_dbpc);
    Count_Diff_company_address_chk_digit := COUNT(GROUP,%Closest%.Diff_company_address_chk_digit);
    Count_Diff_company_address_rec_type := COUNT(GROUP,%Closest%.Diff_company_address_rec_type);
    Count_Diff_company_address_fips_state := COUNT(GROUP,%Closest%.Diff_company_address_fips_state);
    Count_Diff_company_address_fips_county := COUNT(GROUP,%Closest%.Diff_company_address_fips_county);
    Count_Diff_company_address_geo_lat := COUNT(GROUP,%Closest%.Diff_company_address_geo_lat);
    Count_Diff_company_address_geo_long := COUNT(GROUP,%Closest%.Diff_company_address_geo_long);
    Count_Diff_company_address_msa := COUNT(GROUP,%Closest%.Diff_company_address_msa);
    Count_Diff_company_address_geo_blk := COUNT(GROUP,%Closest%.Diff_company_address_geo_blk);
    Count_Diff_company_address_geo_match := COUNT(GROUP,%Closest%.Diff_company_address_geo_match);
    Count_Diff_company_address_err_stat := COUNT(GROUP,%Closest%.Diff_company_address_err_stat);
    Count_Diff_company_address_type_raw := COUNT(GROUP,%Closest%.Diff_company_address_type_raw);
    Count_Diff_company_address_category := COUNT(GROUP,%Closest%.Diff_company_address_category);
    Count_Diff_company_address_country_code := COUNT(GROUP,%Closest%.Diff_company_address_country_code);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_best_fein_indicator := COUNT(GROUP,%Closest%.Diff_best_fein_indicator);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_company_org_structure_raw := COUNT(GROUP,%Closest%.Diff_company_org_structure_raw);
    Count_Diff_company_incorporation_date := COUNT(GROUP,%Closest%.Diff_company_incorporation_date);
    Count_Diff_company_sic_code1 := COUNT(GROUP,%Closest%.Diff_company_sic_code1);
    Count_Diff_company_sic_code2 := COUNT(GROUP,%Closest%.Diff_company_sic_code2);
    Count_Diff_company_sic_code3 := COUNT(GROUP,%Closest%.Diff_company_sic_code3);
    Count_Diff_company_sic_code4 := COUNT(GROUP,%Closest%.Diff_company_sic_code4);
    Count_Diff_company_sic_code5 := COUNT(GROUP,%Closest%.Diff_company_sic_code5);
    Count_Diff_company_naics_code1 := COUNT(GROUP,%Closest%.Diff_company_naics_code1);
    Count_Diff_company_naics_code2 := COUNT(GROUP,%Closest%.Diff_company_naics_code2);
    Count_Diff_company_naics_code3 := COUNT(GROUP,%Closest%.Diff_company_naics_code3);
    Count_Diff_company_naics_code4 := COUNT(GROUP,%Closest%.Diff_company_naics_code4);
    Count_Diff_company_naics_code5 := COUNT(GROUP,%Closest%.Diff_company_naics_code5);
    Count_Diff_company_ticker := COUNT(GROUP,%Closest%.Diff_company_ticker);
    Count_Diff_company_ticker_exchange := COUNT(GROUP,%Closest%.Diff_company_ticker_exchange);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_company_filing_date := COUNT(GROUP,%Closest%.Diff_company_filing_date);
    Count_Diff_company_status_date := COUNT(GROUP,%Closest%.Diff_company_status_date);
    Count_Diff_company_foreign_date := COUNT(GROUP,%Closest%.Diff_company_foreign_date);
    Count_Diff_event_filing_date := COUNT(GROUP,%Closest%.Diff_event_filing_date);
    Count_Diff_company_name_status_raw := COUNT(GROUP,%Closest%.Diff_company_name_status_raw);
    Count_Diff_company_status_raw := COUNT(GROUP,%Closest%.Diff_company_status_raw);
    Count_Diff_dt_first_seen_company_name := COUNT(GROUP,%Closest%.Diff_dt_first_seen_company_name);
    Count_Diff_dt_last_seen_company_name := COUNT(GROUP,%Closest%.Diff_dt_last_seen_company_name);
    Count_Diff_dt_first_seen_company_address := COUNT(GROUP,%Closest%.Diff_dt_first_seen_company_address);
    Count_Diff_dt_last_seen_company_address := COUNT(GROUP,%Closest%.Diff_dt_last_seen_company_address);
    Count_Diff_vl_id := COUNT(GROUP,%Closest%.Diff_vl_id);
    Count_Diff_current := COUNT(GROUP,%Closest%.Diff_current);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_glb := COUNT(GROUP,%Closest%.Diff_glb);
    Count_Diff_dppa := COUNT(GROUP,%Closest%.Diff_dppa);
    Count_Diff_phone_score := COUNT(GROUP,%Closest%.Diff_phone_score);
    Count_Diff_match_company_name := COUNT(GROUP,%Closest%.Diff_match_company_name);
    Count_Diff_match_branch_city := COUNT(GROUP,%Closest%.Diff_match_branch_city);
    Count_Diff_match_geo_city := COUNT(GROUP,%Closest%.Diff_match_geo_city);
    Count_Diff_duns_number := COUNT(GROUP,%Closest%.Diff_duns_number);
    Count_Diff_source_docid := COUNT(GROUP,%Closest%.Diff_source_docid);
    Count_Diff_is_contact := COUNT(GROUP,%Closest%.Diff_is_contact);
    Count_Diff_dt_first_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_first_seen_contact);
    Count_Diff_dt_last_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_last_seen_contact);
    Count_Diff_contact_did := COUNT(GROUP,%Closest%.Diff_contact_did);
    Count_Diff_contact_name_title := COUNT(GROUP,%Closest%.Diff_contact_name_title);
    Count_Diff_contact_name_fname := COUNT(GROUP,%Closest%.Diff_contact_name_fname);
    Count_Diff_contact_name_lname := COUNT(GROUP,%Closest%.Diff_contact_name_lname);
    Count_Diff_contact_name_name_suffix := COUNT(GROUP,%Closest%.Diff_contact_name_name_suffix);
    Count_Diff_contact_name_name_score := COUNT(GROUP,%Closest%.Diff_contact_name_name_score);
    Count_Diff_contact_type_raw := COUNT(GROUP,%Closest%.Diff_contact_type_raw);
    Count_Diff_contact_job_title_raw := COUNT(GROUP,%Closest%.Diff_contact_job_title_raw);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_dob := COUNT(GROUP,%Closest%.Diff_contact_dob);
    Count_Diff_contact_status_raw := COUNT(GROUP,%Closest%.Diff_contact_status_raw);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_contact_email_username := COUNT(GROUP,%Closest%.Diff_contact_email_username);
    Count_Diff_contact_email_domain := COUNT(GROUP,%Closest%.Diff_contact_email_domain);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_cid := COUNT(GROUP,%Closest%.Diff_cid);
    Count_Diff_contact_score := COUNT(GROUP,%Closest%.Diff_contact_score);
    Count_Diff_from_hdr := COUNT(GROUP,%Closest%.Diff_from_hdr);
    Count_Diff_company_department := COUNT(GROUP,%Closest%.Diff_company_department);
    Count_Diff_company_aceaid := COUNT(GROUP,%Closest%.Diff_company_aceaid);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_company_address_type_derived := COUNT(GROUP,%Closest%.Diff_company_address_type_derived);
    Count_Diff_company_org_structure_derived := COUNT(GROUP,%Closest%.Diff_company_org_structure_derived);
    Count_Diff_company_name_status_derived := COUNT(GROUP,%Closest%.Diff_company_name_status_derived);
    Count_Diff_company_status_derived := COUNT(GROUP,%Closest%.Diff_company_status_derived);
    Count_Diff_proxid_status_private := COUNT(GROUP,%Closest%.Diff_proxid_status_private);
    Count_Diff_powid_status_private := COUNT(GROUP,%Closest%.Diff_powid_status_private);
    Count_Diff_seleid_status_private := COUNT(GROUP,%Closest%.Diff_seleid_status_private);
    Count_Diff_orgid_status_private := COUNT(GROUP,%Closest%.Diff_orgid_status_private);
    Count_Diff_ultid_status_private := COUNT(GROUP,%Closest%.Diff_ultid_status_private);
    Count_Diff_proxid_status_public := COUNT(GROUP,%Closest%.Diff_proxid_status_public);
    Count_Diff_powid_status_public := COUNT(GROUP,%Closest%.Diff_powid_status_public);
    Count_Diff_seleid_status_public := COUNT(GROUP,%Closest%.Diff_seleid_status_public);
    Count_Diff_orgid_status_public := COUNT(GROUP,%Closest%.Diff_orgid_status_public);
    Count_Diff_ultid_status_public := COUNT(GROUP,%Closest%.Diff_ultid_status_public);
    Count_Diff_contact_type_derived := COUNT(GROUP,%Closest%.Diff_contact_type_derived);
    Count_Diff_contact_job_title_derived := COUNT(GROUP,%Closest%.Diff_contact_job_title_derived);
    Count_Diff_contact_status_derived := COUNT(GROUP,%Closest%.Diff_contact_status_derived);
    Count_Diff_address_type_derived := COUNT(GROUP,%Closest%.Diff_address_type_derived);
    Count_Diff_is_vanity_name_derived := COUNT(GROUP,%Closest%.Diff_is_vanity_name_derived);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
